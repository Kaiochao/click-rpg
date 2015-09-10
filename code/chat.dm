client/KeyDown(Key)
	if(Key == "return")
		player.Chat()

entity/player
	var
		tmp
			chat_message/chat_message

	proc
		Chat()
			var t = input(src, "", "Chat")
			if(t)
				t = html_encode(t)

				del chat_message
				chat_message = new (src, t)

chat_message
	var
		image/text
		image/shadow

	New(mob/Sender, Message)
		// split the message into lines
		var text_start = 1
		var text_length = length(Message)
		var line_length = 100
		var lines[0]
		while(text_start <= text_length)
			// todo: search backwards for a space
			var text_end = text_start + line_length
			var line = copytext(Message, text_start, text_end)
			if(text_start > 1) line = "... [line]"
			if(text_end < text_length) line = "[line] ... "
			text_start = text_end
			lines += line

		// show the text as an image on the speaker
		text = new
		text.loc = Sender
		text.layer = 100 + EFFECTS_LAYER
		text.maptext_width = 150
		text.maptext_height = 200
		text.maptext_x = (32-150)/2
		text.maptext_y = 32

		animate(text, time = 1, alpha = 255)
		for(var/line in lines)
			animate(time = 0, alpha = 255, 
				maptext = "\
					<text align=center valign=bottom>\
					<font face='trebuchet ms' size=1>\
					[line]")
			animate(time = 50, alpha = 255)
			animate(time = 10, alpha = 0)

		// text shadow
		shadow = new
		shadow.loc = Sender
		shadow.layer = 99 + EFFECTS_LAYER
		shadow.maptext_width = 150
		shadow.maptext_height = 200
		shadow.maptext_x = (32-150)/2 - 1
		shadow.maptext_y = 32 - 1
		shadow.color = "black"

		animate(shadow, time = 1, alpha = 255)
		for(var/line in lines)
			animate(time = 0, alpha = 255, 
				maptext = "\
					<text align=center valign=bottom>\
					<font face='trebuchet ms' size=1>\
					[line]")
			animate(time = 50, alpha = 255)
			animate(time = 10, alpha = 0)

		for(var/mob/m in view(Sender))
			if(m.client)
				m.client.images.Add(shadow, text)

	Del()
		del text
		del shadow
		..()
