extends CanvasLayer

signal dialogue_finished
signal line_started(line: Dictionary)
signal line_completed(line: Dictionary)
signal choice_selected(line: Dictionary, choice: Dictionary)

@export_range(1.0, 120.0, 1.0) var typing_speed: float = 45.0
@export var overlay_visible: bool = true
@export var advance_actions: Array[StringName] = [&"ui_accept", &"ui_select"]

var _queue: Array[Dictionary] = []
var _active_line: Dictionary = {}
var _is_typing := false
var _awaiting_choice := false
var _char_index := 0
var _time_accum := 0.0
var _current_speed: float = typing_speed
var _current_text: String = ""
var _total_characters: int = 0

@onready var _ui_root: Control = %UIRoot
@onready var _overlay: ColorRect = %Overlay
@onready var _controls_row: Control = %ControlsRow
@onready var _choices_container: VBoxContainer = %ChoicesContainer
@onready var _portrait: TextureRect = %Portrait
@onready var _speaker_name: Label = %SpeakerName
@onready var _story_text: RichTextLabel = %StoryText
@onready var _next_hint: Label = %NextHint

func _ready() -> void:
	_hide_all()
	_overlay.visible = overlay_visible

func show_dialogue(lines: Array, reset_queue: bool = false) -> void:
	var start_new := reset_queue or not is_active()
	if start_new:
		_queue.clear()
		_hide_choices()
		_ui_root.visible = true
		_overlay.visible = overlay_visible
	else:
		_overlay.visible = overlay_visible
	queue_lines(lines)
	if start_new and not _is_typing and not _awaiting_choice:
		_advance_dialogue()

func queue_lines(lines: Array) -> void:
	for line in lines:
		if line is Dictionary:
			_queue.append(line.duplicate())
		else:
			_queue.append({"text": str(line)})
	if is_active() and not _is_typing and not _awaiting_choice and _queue.size() > 0 and _story_text.visible_characters == -1:
		_advance_dialogue()

func skip_dialogue() -> void:
	_queue.clear()
	_awaiting_choice = false
	_hide_choices()
	_conclude_dialogue()

func is_active() -> bool:
	return _ui_root.visible

func _advance_dialogue() -> void:
	if _awaiting_choice:
		return
	if _is_typing:
		_skip_typing()
		return
	if _queue.is_empty():
		_conclude_dialogue()
		return
	_active_line = _queue.pop_front()
	emit_signal("line_started", _active_line)
	_current_speed = float(_active_line.get("speed", typing_speed))
	_apply_line_visuals()
	_start_typing(str(_active_line.get("text", "")))

func _apply_line_visuals() -> void:
	var speaker := str(_active_line.get("speaker", ""))
	_speaker_name.text = speaker
	_speaker_name.visible = speaker != ""
	var portrait: Texture2D = _active_line.get("portrait", null)
	_portrait.texture = portrait
	_portrait.visible = portrait != null
	_controls_row.visible = true
	_next_hint.visible = false
	_hide_choices()

func _start_typing(text: String) -> void:
	_current_text = text
	_story_text.bbcode_text = text
	_story_text.visible_characters = 0
	_total_characters = _story_text.get_total_character_count()
	if _total_characters == 0:
		_total_characters = text.length()
	_is_typing = true
	_char_index = 0
	_time_accum = 0.0
	set_process(true)

func _skip_typing() -> void:
	_story_text.visible_characters = -1
	_finish_line()

func _process(delta: float) -> void:
	if not _is_typing:
		return
	_time_accum += delta
	var speed: float = max(_current_speed, 1.0)
	var chars_to_add := int(_time_accum * speed)
	if chars_to_add <= 0:
		return
	_time_accum -= float(chars_to_add) / speed
	_char_index = min(_char_index + chars_to_add, _total_characters)
	_story_text.visible_characters = _char_index
	if _char_index >= _total_characters:
		_finish_line()

func _finish_line() -> void:
	_is_typing = false
	set_process(false)
	_story_text.visible_characters = -1
	var choices = _active_line.get("choices", null)
	var has_choices:bool = choices is Array and choices.size() > 0
	_awaiting_choice = has_choices
	_controls_row.visible = not has_choices
	_next_hint.visible = not has_choices
	if has_choices:
		_show_choices(choices)
	emit_signal("line_completed", _active_line)

func _show_choices(choices: Array) -> void:
	_hide_choices()
	_choices_container.visible = true
	for choice in choices:
		var entry: Dictionary
		if choice is Dictionary:
			entry = choice.duplicate()
		else:
			entry = {"text": str(choice)}
		if not entry.has("callback"):
			push_warning("Choice missing callback: %s" % [entry])
		var button := Button.new()
		button.text = str(entry.get("text", "Choice"))
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.focus_mode = Control.FOCUS_ALL
		button.pressed.connect(Callable(self, "_on_choice_pressed").bind(entry))
		_choices_container.add_child(button)

func _on_choice_pressed(choice: Dictionary) -> void:
	emit_signal("choice_selected", _active_line, choice)
	_awaiting_choice = false
	_hide_choices()
	_controls_row.visible = true
	_next_hint.visible = false
	var callback_value = choice.get("callback", null)
	if callback_value is Callable and callback_value.is_valid():
		callback_value.call()
	else:
		push_warning("Choice missing valid callback: %s" % [choice])
	_advance_dialogue()


func _conclude_dialogue() -> void:
	_active_line = {}
	_hide_all()
	emit_signal("dialogue_finished")

func _hide_all() -> void:
	_ui_root.visible = false
	_overlay.visible = false
	_story_text.visible_characters = -1
	_next_hint.visible = false
	_is_typing = false
	_awaiting_choice = false
	_hide_choices()
	_controls_row.visible = true
	set_process(false)

func _hide_choices() -> void:
	for child in _choices_container.get_children():
		child.queue_free()
	_choices_container.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if not is_active():
		return
	if _awaiting_choice:
		return
	for action in advance_actions:
		if event.is_action_pressed(action):
			_advance_dialogue()
			return
	if event is InputEventMouseButton and event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		_advance_dialogue()

func _on_overlay_gui_input(event: InputEvent) -> void:
	if _awaiting_choice:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		_advance_dialogue()
		get_viewport().set_input_as_handled()

func _on_next_button_pressed() -> void:
	if _awaiting_choice:
		return
	_advance_dialogue()
