extends Resource
class_name FileManipulator

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files

func load_item_list (path):
	var particleShortList = list_files_in_directory (path)
	var particleList = []
	for i in particleShortList:
		particleList.append(load(path + i))
	return particleList
