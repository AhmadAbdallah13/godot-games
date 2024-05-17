extends ParallaxLayer


func _process(delta):
	self.motion_offset.x += -15 * delta
