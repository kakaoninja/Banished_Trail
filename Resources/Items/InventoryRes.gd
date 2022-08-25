extends Resource
class_name Inventory

export var inventorySize = 8

signal items_changed

export (Array, Resource) var ItemsList = []

func tmi (idx):
	if idx > inventorySize:
		remove_item (inventorySize)

func set_item (idx, item):
	tmi (idx)
	var previousItem = ItemsList [idx]
	ItemsList [idx] = item
	emit_signal ("items_changed", [idx])
	return previousItem

func remove_item (idx):
	var previousItem = ItemsList [idx]
	ItemsList [idx] = null
	emit_signal ("items_changed", [idx])
	return previousItem

func swap_item (idx, targetIdx):
	var targetItem = ItemsList [targetIdx]
	var item = ItemsList [idx]
	ItemsList [targetIdx] = item
	ItemsList [idx] = targetItem
	emit_signal ("items_changed", [idx], [targetIdx])
