client
	var tmp
		#if FULLSCREEN
		view_width_tiles
		view_height_tiles
		#else
		view_width_tiles = 20
		view_height_tiles = 15
		#endif

		// size of the map control
		map_width
		map_height
		map_zoom = 2

		last_map_size

	Update()
		..()
		UpdateCamera()

	proc
		UpdateCamera()
			var size = winget(src, ":map", "size")
			if(size != last_map_size)
				MapResized(size)
				last_map_size = size

		MapResized(Size)
			var width = text2num(Size)
			var height = text2num(copytext(Size, length("[width]")+2))

			map_width = width
			map_height = height

			#if FULLSCREEN
			view_width_tiles = 3 + round(map_width / map_zoom / TILE_WIDTH, 2)
			view_height_tiles = 3 + round(map_height / map_zoom / TILE_HEIGHT, 2)
			winset(src, ":map", "zoom=[map_zoom]")
			#else
			view_width_tiles = 20
			view_height_tiles = 15
			pixel_x = 16
			#endif
			view = "[view_width_tiles]x[view_height_tiles]"
