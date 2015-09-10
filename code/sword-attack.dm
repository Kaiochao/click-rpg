obj/sword
	icon = 'sword.png'
	bounds = "15,15 to 16,16"
	layer = FLY_LAYER

	var tmp
		entity/owner

	New(Owner)
		owner = Owner

	Cross(atom/movable/O)
		return O == owner || ..()

obj/projectile
	bounds = "15,15 to 16,16"

	var
		crossed[]

	proc
		OnCrossed(entity/E)
			crossed = crossed ? crossed | E : list(E)

entity
	Crossed(obj/projectile/P)
		istype(P) && P.OnCrossed(src)
		..()

	proc
		Die()

entity/enemy/Die()
	loc = locate(rand(1, world.maxx), rand(1, world.maxy), 1)
	target = null

entity/player/knight
	icon = 'knight.png'

	bounds = "16,16"
	bound_x = (32 - 16) / 2
	bound_y = (32 - 16) / 2

	var tmp
		attacking = FALSE
		attack_start_time = -1#INF
		tried_attacking = FALSE
		attack_duration = 3
		angle
		obj/sword/sword

	New()
		..()
		sword = new (src)

	Update()
		..()
		if(!attacking)
			angle = lerp_angle(angle, GetMouseAngle(), 0.8)
			if(tried_attacking)
				Attack()
		else
			angle= lerp_angle(angle, GetMouseAngle(), 0.1)
		transform = matrix(angle,  MATRIX_ROTATE)

	LMB()
		set waitfor = FALSE

		if(attacking)
			if(world.time > attack_start_time + attack_duration - 1)
				tried_attacking = TRUE
			
		else Attack()

	proc
		Attack()
			attacking = TRUE
			tried_attacking = FALSE
			attack_start_time = world.time

			var hits[0]
			var trails[0]
			var angle = GetMouseAngle()
			var obj/projectile/p = new

			for(var/t in 0 to attack_duration step TICK_LAG)

				// appearance
				angle = lerp_angle(angle, GetMouseAngle(), 0.2)
				sword.transform = turn(initial(sword.transform), angle) * ( 0.6 + 0.4 * sin(t / attack_duration * 180) )

				var distance = 32 + 32 * sin(t / attack_duration * 180)
				var dx = distance * sin(angle)
				var dy = distance * cos(angle)
				sword.SetLoc(loc, step_x, step_y)
				sword.pixel_x = dx
				sword.pixel_y = dy

				var obj/trail = new
				trails += trail
				trail.SetLoc(loc, step_x, step_y)
				trail.appearance = sword
				trail.alpha = 200
				animate(trail, time = 1, alpha = 0)

				// physics
				p.crossed = null
				p.SetLoc(loc, step_x, step_y)
				p.Translate(dx, dy)
				p.loc = null

				if(p.crossed)
					var new_hits[] = p.crossed.Copy()
					new_hits.Remove(src,  hits)
					hits += new_hits

					for(var/entity/e in new_hits)
						e.color = "white"
						spawn(1)
							e.color = initial(e.color)
							e.Die()

				sleep TICK_LAG

			sword.SetLoc()

			sleep 2

			attacking = FALSE

			for(var/obj/trail in trails)
				trail.loc = null
