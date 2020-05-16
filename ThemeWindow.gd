extends WindowDialog


onready var main = $"/root/Main"
onready var options = $PanelContainer/CenterContainer/VBoxContainer/OptionButton
onready var left_theme = $PanelContainer/CenterContainer/VBoxContainer/HBoxContainer/Left/MarginContainer/Label
onready var right_theme = $PanelContainer/CenterContainer/VBoxContainer/HBoxContainer/Right/MarginContainer/Label

var side_to_set = ""
var selected_item = ""


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_ThemeWindow_about_to_show() -> void:
	options.clear()
	main.themes.clear()
	
	var dir = Directory.new()
	if not dir.dir_exists(main.external_theme_path):
		dir.make_dir(main.external_theme_path)
	
	main.themes = Utils.merge_dictionary(Utils.find_themes_in_directory(main.internal_theme_path), Utils.find_themes_in_directory(main.external_theme_path))
	
	if main.themes.size() != 0:
		for i in main.themes.size():
			var theme_name = main.themes.keys()[i]
			options.add_item(theme_name)
	
	left_theme.text = main.left_current_theme
	right_theme.text = main.right_current_theme
	
	var sel = options.get_selected_id()
	selected_item = options.get_item_text(sel)


func _on_OptionButton_item_selected(id: int) -> void:
	selected_item = options.get_item_text(id)


func _on_AcceptButton_pressed() -> void:
	main.set_new_theme(side_to_set, selected_item)
	self.hide()


func _on_CancelButton_pressed() -> void:
	self.hide()
