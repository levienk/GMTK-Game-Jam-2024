extends TextureButton


func _pressed() -> void:
	SignalBus.shop_clicked.emit()
