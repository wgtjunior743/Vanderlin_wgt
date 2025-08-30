// Basic ladder. By default links to the z-level above/below.
/obj/structure/ladder
	name = "ladder"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "ladder01"
	anchored = TRUE
	var/obj/structure/ladder/down   //the ladder below this one
	var/obj/structure/ladder/up     //the ladder above this one
	obj_flags = BLOCK_Z_OUT_DOWN
	resistance_flags = INDESTRUCTIBLE

/obj/structure/ladder/Initialize(mapload, obj/structure/ladder/up, obj/structure/ladder/down)
	..()
	if (up)
		src.up = up
		up.down = src
		up.update_appearance()
	if (down)
		src.down = down
		down.up = src
		down.update_appearance()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/ladder/Destroy(force)
	if ((resistance_flags & INDESTRUCTIBLE) && !force)
		return QDEL_HINT_LETMELIVE
	disconnect()
	return ..()

/obj/structure/ladder/LateInitialize()
	// By default, discover ladders above and below us vertically
	var/turf/T = get_turf(src)
	var/obj/structure/ladder/L

	if (!down)
		L = locate() in GET_TURF_BELOW(T)
		if (L)
			down = L
			L.up = src  // Don't waste effort looping the other way
			L.update_appearance()
	if (!up)
		L = locate() in GET_TURF_ABOVE(T)
		if (L)
			up = L
			L.down = src  // Don't waste effort looping the other way
			L.update_appearance()

	update_appearance(UPDATE_ICON_STATE)

/obj/structure/ladder/proc/disconnect()
	if(up && up.down == src)
		up.down = null
		up.update_appearance()
	if(down && down.up == src)
		down.up = null
		down.update_appearance()
	up = down = null

/obj/structure/ladder/update_icon_state()
	. = ..()
	if(up && down)
		icon_state = "ladder11"
	else if(up)
		icon_state = "ladder10"
	else if(down)
		icon_state = initial(icon_state)
	else
		icon_state = "ladder00"

/obj/structure/ladder/proc/travel(going_up, mob/user, is_ghost, obj/structure/ladder/ladder)
	if(is_ghost)
		return

	if(!is_ghost)
		playsound(src, 'sound/foley/ladder.ogg', 100, FALSE)
		if(!do_after(user, 3 SECONDS, src))
			return

	if(!is_ghost)
		show_fluff_message(going_up, user)
		ladder.add_fingerprint(user)
	var/turf/T = get_turf(ladder)
	if(isliving(user))
		movable_travel_z_level(user, T)
	else
		user.forceMove(T)

/obj/structure/ladder/proc/use(mob/user, is_ghost=FALSE)
	if(!in_range(src, user))
		return

	if(user.buckled)
		return

	if (up && down)
		var/result = alert("Go up or down [src]?", "Ladder", "Up", "Down", "Cancel")
		if (!in_range(src, user))
			return  // nice try
		switch(result)
			if("Up")
				travel(TRUE, user, is_ghost, up)
			if("Down")
				travel(FALSE, user, is_ghost, down)
			if("Cancel")
				return
	else if(up)
		travel(TRUE, user, is_ghost, up)
	else if(down)
		travel(FALSE, user, is_ghost, down)
	else
		to_chat(user, "<span class='warning'>[src] doesn't seem to lead anywhere!</span>")

	if(!is_ghost)
		add_fingerprint(user)

/obj/structure/ladder/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	use(user)

/obj/structure/ladder/attack_paw(mob/user)
	return use(user)

/obj/structure/ladder/attackby(obj/item/W, mob/user, params)
	return use(user)

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/structure/ladder/attack_ghost(mob/dead/observer/user)
	use(user, TRUE)
	return ..()

/obj/structure/ladder/proc/show_fluff_message(going_up, mob/user)
	if(going_up)
		user.visible_message("<span class='notice'>[user] climbs up [src].</span>", "<span class='notice'>I climb up [src].</span>")
	else
		user.visible_message("<span class='notice'>[user] climbs down [src].</span>", "<span class='notice'>I climb down [src].</span>")


// Indestructible away mission ladders which link based on a mapped ID and height value rather than X/Y/Z.
/obj/structure/ladder/unbreakable
	name = "sturdy ladder"
	desc = ""
	resistance_flags = INDESTRUCTIBLE
	var/id
	var/height = 0  // higher numbers are considered physically higher

/obj/structure/ladder/unbreakable/Initialize()
	GLOB.ladders += src
	return ..()

/obj/structure/ladder/unbreakable/Destroy()
	. = ..()
	if (. != QDEL_HINT_LETMELIVE)
		GLOB.ladders -= src

/obj/structure/ladder/unbreakable/LateInitialize()
	// Override the parent to find ladders based on being height-linked
	if (!id || (up && down))
		update_appearance(UPDATE_ICON_STATE)
		return

	for(var/obj/structure/ladder/unbreakable/L as anything in GLOB.ladders)
		if (L.id != id)
			continue  // not one of our pals
		if (!down && L.height == height - 1)
			down = L
			L.up = src
			L.update_appearance(UPDATE_ICON_STATE)
			if (up)
				break  // break if both our connections are filled
		else if (!up && L.height == height + 1)
			up = L
			L.down = src
			L.update_appearance(UPDATE_ICON_STATE)
			if (down)
				break  // break if both our connections are filled

	update_appearance(UPDATE_ICON_STATE)

/obj/structure/ladder/earth
	icon_state = "ladderearth"

/obj/structure/wallladder
	name = "wall ladder"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "ladderwall"
	anchored = TRUE
	var/obj/structure/ladder/down   //the ladder below this one
	var/obj/structure/ladder/up     //the ladder above this one
	obj_flags = BLOCK_Z_OUT_DOWN
	max_integrity = 200
	blade_dulling = DULLING_BASHCHOP

/obj/structure/wallladder/OnCrafted(dirin, mob/user)
	dir = dirin
	layer = BELOW_MOB_LAYER
	switch(dir)
		if(NORTH)
			pixel_y = base_pixel_y + 16
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
		if(WEST)
			pixel_x = base_pixel_x - 4
		if(EAST)
			pixel_x = base_pixel_x + 4
	return ..()
