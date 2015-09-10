entity/player
	var tmp
		max_speed = 5
		mouse_move_radius = 64

	proc
		LMB()
		RMB()
		MMB()
		GetMouseDelta() return client && list(client.mouse_dx, client.mouse_dy)
		GetMouseDistance() return client && client.mouse_distance
		GetMouseAngle() return client && client.mouse_angle

	Update()
		client && client.mouse_on_map && Movement()
		..()

	proc
		Movement()
			var mouse_delta[] = GetMouseDelta()
			if(mouse_delta)
				var mouse_distance = GetMouseDistance()
				if(mouse_distance)
					var speed = clamp((mouse_distance - 64) / mouse_move_radius, 0, 1) * max_speed
					var s = speed / mouse_distance
					var move_x = mouse_delta[1] * s
					var move_y = mouse_delta[2] * s
					move_x && Translate(move_x, 0)
					move_y && Translate(0, move_y)

	Login()
		..()
		ShowMovementCircle()

	var tmp
		image
			move_circle_min
			move_circle_max

	proc
		ShowMovementCircle()
			if(!move_circle_min)
				move_circle_min = image(
					icon = 'circle.png', 
					loc = src, 
					icon_state = "oval", 
					layer = TURF_LAYER + 0.1)
				move_circle_min.mouse_opacity = FALSE
				move_circle_min.transform = ~transform * (64 * 2 / 128)
				move_circle_min.pixel_x = (32 - 128) / 2
				move_circle_min.pixel_y = (32 - 128) / 2
				move_circle_min.alpha = 8
				move_circle_min.color = "gray"
				move_circle_min.blend_mode = BLEND_ADD

				move_circle_max = image(
					icon = 'circle.png', 
					loc = src, 
					icon_state = "oval", 
					layer = TURF_LAYER + 0.2)
				move_circle_max.mouse_opacity = FALSE
				move_circle_max.transform = ~transform * ((64 + mouse_move_radius) * 2 / 128)
				move_circle_max.pixel_x = (32 - 128) / 2
				move_circle_max.pixel_y = (32 - 128) / 2
				move_circle_max.alpha = 8
				move_circle_max.color = "gray"
				move_circle_max.blend_mode = BLEND_ADD

				client.images.Add(move_circle_min, move_circle_max)

client
	show_popup_menus = FALSE
	show_verb_panel = FALSE

	Move()

	MouseDown(object, location, control, params)
		..()
		var p[] = params2list(params)
		p["left"] && player.LMB()
		p["right"] && player.RMB()
		p["middle"] && player.MMB()
