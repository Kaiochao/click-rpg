world
	maxx = 100
	maxy = 100
	view = 10

	area = /area/default
	turf = /turf/default
	mob = /entity/player/knight

area/default
	invisibility = 101

turf/default
	icon_state = "rect"
	New()
		color = rgb(0, 120 + rand(3), 0)
		if(prob(1))
			new /entity/enemy (src)

atom
	mouse_over_pointer = MOUSE_ACTIVE_POINTER

entity
	Login()
		SetCenter(world.maxx * TILE_WIDTH/2, world.maxy * TILE_HEIGHT/2, 1)
		..()

	Logout()
		..()
		del src

	Update()
		..()
		if(client)
			winset(src, ":window", "title=\"[world.name] ([world.cpu]%)\"")
