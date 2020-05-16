extends Control


onready var internal_theme_path = str("res://themes/")
onready var external_theme_path = str(OS.get_executable_path().get_base_dir(),"/","themes")

onready var left_theme = $HBoxContainer/LeftTheme
onready var left_theme_title = $HBoxContainer/LeftTheme/PanelContainer/HBoxContainer/ScrollContainer/Control/MarginContainer/VBoxContainer/HBoxContainer/ThemeTitle
onready var left_theme_control = $HBoxContainer/LeftTheme/PanelContainer/HBoxContainer/ScrollContainer/Control
onready var left_theme_margin = $HBoxContainer/LeftTheme/PanelContainer/HBoxContainer/ScrollContainer/Control/MarginContainer
onready var left_theme_tabs = $HBoxContainer/LeftTheme/PanelContainer/HBoxContainer/ScrollContainer/Control/MarginContainer/VBoxContainer/Tabs/PanelContainer/TabContainer
onready var left_theme_load_button = $HBoxContainer/LeftTheme/PanelContainer/HBoxContainer/ScrollContainer/Control/MarginContainer/VBoxContainer/HBoxContainer/LoadTheme

onready var right_theme = $HBoxContainer/RightTheme
onready var right_theme_title = $HBoxContainer/RightTheme/PanelContainer/HBoxContainer/ScrollContainer/Control/MarginContainer/VBoxContainer/HBoxContainer/ThemeTitle
onready var right_theme_control = $HBoxContainer/RightTheme/PanelContainer/HBoxContainer/ScrollContainer/Control
onready var right_theme_margin = $HBoxContainer/RightTheme/PanelContainer/HBoxContainer/ScrollContainer/Control/MarginContainer
onready var right_theme_tabs = $HBoxContainer/RightTheme/PanelContainer/HBoxContainer/ScrollContainer/Control/MarginContainer/VBoxContainer/Tabs/PanelContainer/TabContainer
onready var right_theme_load_button = $HBoxContainer/RightTheme/PanelContainer/HBoxContainer/ScrollContainer/Control/MarginContainer/VBoxContainer/HBoxContainer/LoadTheme

onready var theme_window = $ThemeWindow

var themes = {}

var left_title = "Light Theme"
var left_current_theme = "Light Theme"

var right_title = "Dark Theme"
var right_current_theme = "Dark Theme"


# Called when the node enters the scene tree for the first time.
func _ready():
	left_theme_title.text = left_title
	left_theme_control.rect_min_size = left_theme_margin.rect_size
	left_theme_tabs.set_tab_disabled(1, true)
	
	right_theme_title.text = right_title
	right_theme_control.rect_min_size = right_theme_margin.rect_size
	right_theme_tabs.set_tab_disabled(1, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_new_theme(theme_side:String, theme_name:String) -> void:
	match theme_side:
		"left":
			left_title = theme_name
			left_theme_title.text = left_title
			left_theme.theme = load(str(themes[theme_name]))
		"right":
			right_title = theme_name
			right_theme_title.text = right_title
			right_theme.theme = load(str(themes[theme_name]))


func _on_Left_LoadTheme_pressed() -> void:
	theme_window.side_to_set = "left"
	theme_window.popup_centered()


func _on_Right_LoadTheme_pressed() -> void:
	theme_window.side_to_set = "right"
	theme_window.popup_centered()


func _on_ThemeWindow_popup_hide() -> void:
	self.grab_focus()
