extends WindowDialog


onready var main = $"/root/Main"
onready var options = $PanelContainer/CenterContainer/VBoxContainer/HBoxContainer3/OptionButton
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
	self.window_title = str("Change ", side_to_set, " side Theme")
	
	main.themes.clear()
	options.clear()
	
	var get_internal_themes = Utils.find_themes_in_directory(main.internal_theme_path)
	var get_external_themes = Utils.find_themes_in_directory(main.external_theme_path)
	var themes_list = get_internal_themes + get_external_themes
	
	for i in themes_list.size():
		if ".tres" in themes_list[i]:
			var theme_name = themes_list[i].get_file().replace(".tres", "").capitalize()
			main.themes[theme_name] = themes_list[i]
	
	if main.themes.size() != 0:
		for i in main.themes.size():
			var theme_name = main.themes.keys()[i]
			options.add_item(theme_name)
	
	left_theme.text = main.left_theme_title.text
	right_theme.text = main.right_theme_title.text
	
	var sel = options.get_selected_id()
	selected_item = options.get_item_text(sel)


func _on_OptionButton_item_selected(id: int) -> void:
	selected_item = options.get_item_text(id)


func _on_AcceptButton_pressed() -> void:
	main.set_new_theme(side_to_set, selected_item)
	self.hide()


func _on_CancelButton_pressed() -> void:
	self.hide()


func _on_OpenFolderButton_pressed() -> void:
	OS.shell_open(main.external_theme_path)
