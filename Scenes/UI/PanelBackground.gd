extends Panel
onready var contentBox = get_node ("$../ContentBox")

func _ready():
	_on_ContentBox_item_rect_changed ()

func _on_ContentBox_item_rect_changed():
	
