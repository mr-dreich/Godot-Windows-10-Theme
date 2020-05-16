extends Node


func find_themes_in_directory(scan_dir:String) -> Dictionary:
	var files:Dictionary = {}
	var dir := Directory.new()
	if dir.open(scan_dir) != OK:
		printerr("Warning: could not open directory: ", scan_dir)
		return {}
	
	if dir.list_dir_begin(true, true) != OK:
		printerr("Warning: could not list contents of: ", scan_dir)
		return {}
	
	var file_name := dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			files = find_themes_in_directory(dir.get_current_dir() + "/" + file_name)
			
		else:
			if not file_name.begins_with(".") and file_name.get_extension() == "tres":
				var names = file_name.replace("_", " ").replace(".tres", "").capitalize()
				files[names] = str(scan_dir, "/", file_name)
	
		file_name = dir.get_next()
	
	return files


func merge_dictionary(dict_1, dict_2) -> Dictionary:
	for key in dict_2:
		dict_1[key] = dict_2[key]
	
	return dict_1
