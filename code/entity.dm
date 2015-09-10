world
	mob = /entity

client
	var
		entity/player/player

	New()
		. = ..()
		player = mob

entity
	parent_type = /mob
