entity/player
	MouseEntered()
		usr != src && usr.client.Nametag(src)
		..()

	MouseExited()
		usr.client.Nametag()
		..()

client
	var
		image/nametag
		image/nametag_shadow

	proc
		Nametag(atom/Object)
			if(!nametag)
				nametag = new
				nametag.layer = 100 + EFFECTS_LAYER
				nametag.maptext_width = 300
				nametag.maptext_x = (34-300)/2
				nametag.maptext_y = -16

				nametag_shadow = new
				nametag_shadow.layer = 99 + EFFECTS_LAYER
				nametag_shadow.maptext_width = nametag.maptext_width
				nametag_shadow.maptext_x = nametag.maptext_x - 1
				nametag_shadow.maptext_y = nametag.maptext_y - 1
				nametag_shadow.color = "black"

				images.Add(nametag_shadow, nametag)

			if(Object)
				nametag.loc = Object
				nametag.maptext = "<text align=center><font size=1 face='trebuchet ms'>[Object.name]"
				nametag.alpha = 0
				animate(nametag, time = 2, alpha = 200)

				nametag_shadow.loc = Object
				nametag_shadow.maptext = nametag.maptext
				nametag_shadow.alpha = 0
				animate(nametag_shadow, time = 2, alpha = 200)

			else
				animate(nametag, time = 2, alpha = 0)
				animate(nametag_shadow, time = 2, alpha = 0)
