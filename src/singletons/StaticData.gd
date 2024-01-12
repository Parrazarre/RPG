extends Node

var itemData = {}

var data_file_path = "res://assets/Dialog/testScene.json"

func _ready():
	itemData = load_json_file(data_file_path) #Loads the dialog file on start


func load_json_file(filePath : String):
	if FileAccess.file_exists(filePath): #Checks for errors
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary: #Checks for errors
			return parsedResult
		else:
			print("Error reading file")
	
	else:
		print("File does not exist")
