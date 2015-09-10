client
	var tmp
		mouse_dx // the 'd' stands for 'delta'
		mouse_dy

		mouse_distance
		mouse_angle

	MouseMoved()
		UpdateMouseDelta(view_width_tiles * TILE_WIDTH / 2, view_height_tiles * TILE_HEIGHT / 2)
		
		mouse_distance = hypot(mouse_dx, mouse_dy)
		mouse_angle = atan2(mouse_dx, mouse_dy)

	proc
		UpdateMouseDelta(FromX, FromY)
			mouse_dx = mouse_x - FromX
			mouse_dy = mouse_y - FromY
