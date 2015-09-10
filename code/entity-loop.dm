world
	New()
		..()
		EntityLoop()

	proc
		EntityLoop()
			set waitfor = FALSE, background = TRUE
			for()
				sleep TICK_LAG
				for(var/entity/e)
					e.Update()

entity
	proc
		Update()
			set waitfor = FALSE
