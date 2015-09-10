entity/enemy
	icon_state = "oval"
	color = "maroon"

	var tmp
		move_speed = 4
		entity/target

		next_target_position_update
		target_position_update_period = 1

		velocity_x
		velocity_y

	Update()
		if(target && target.loc)
			if(world.time >= next_target_position_update)
				next_target_position_update = world.time + target_position_update_period

				var dx = target.Cx() - Cx()
				var dy = target.Cy() - Cy()
				if(dx || dy)
					var d = hypot(dx, dy)
					var speed = move_speed * clamp(d / 64, 0, 1)
					var s
					if(d < 32)
						s = -speed / d
					else if(d > 48)
						s = speed / d
					else
						s = 0
					velocity_x = dx * s
					velocity_y = dy * s

			velocity_x && Translate(velocity_x, 0)
			velocity_y && Translate(0, velocity_y)

entity/player
	Move()
		var pre_loc = loc
		. = ..()
		if(loc != pre_loc)
			for(var/entity/enemy/enemy in range(client))
				if(!(enemy.target && enemy.target.loc))
					enemy.target = src
