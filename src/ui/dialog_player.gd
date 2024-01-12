extends CanvasLayer

var scene_text = {}
var selected_text = []
var in_progress = false

func _ready():
	$Background.visible = false
	scene_text = StaticData.itemData
	SignalBus.connect("display_dialog", on_display_dialog)

func show_text():
	$TextLabel.text = selected_text.pop_front()

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	$TextLabel.text = ""
	$Background.visible = false
	in_progress = false
	get_tree().paused = false

func on_display_dialog(text_key):
	if in_progress:
		next_line()
	else:
		get_tree().paused = true
		$Background.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()
