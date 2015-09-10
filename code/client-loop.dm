#define CLIENT_UPDATE_PERIOD 1

world
	New()
		..()
		ClientLoop()

	proc
		ClientLoop()
			set waitfor = FALSE, background = TRUE
			for()
				sleep CLIENT_UPDATE_PERIOD
				for(var/client/c) if(c.key)
					c.Update()

client
	proc
		Update()
			set waitfor = FALSE
