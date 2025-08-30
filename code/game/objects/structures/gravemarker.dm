/obj/structure/gravemarker
	name = "grave marker"
	icon = 'icons/turf/floors.dmi'
	icon_state = "gravemarker1"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE
	static_debris = list(/obj/item/grown/log/tree/stick = 1)
	anchored = TRUE
	layer = 2.91

/obj/structure/gravemarker/Destroy()
	var/turf/T = get_turf(src)
	if(T)
		new /obj/item/grown/log/tree/stick(T)
	return ..()

/obj/structure/gravemarker/OnCrafted(dir, mob/user)
	icon_state = "gravemarker[rand(1,3)]"
	for(var/obj/structure/closet/dirthole/hole in loc)
		if(pacify_coffin(hole, user))
			user.visible_message(span_rose("[user] consecrates [hole]."), span_rose("I consecrate [hole]."))
			SEND_SIGNAL(user, COMSIG_GRAVE_CONSECRATED, hole)
			record_round_statistic(STATS_GRAVES_CONSECRATED)
	return ..()
