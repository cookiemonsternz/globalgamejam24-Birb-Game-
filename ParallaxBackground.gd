extends ParallaxBackground

func _process(_delta):
	scroll_base_offset.x = scroll_base_offset.x + 1
	#print(scroll_offset)
