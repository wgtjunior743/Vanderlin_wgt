
/obj/structure/closet/dirthole
	name = "hole"
	icon_state = "hole1"
	icon = 'icons/turf/floors.dmi'
	mob_storage_capacity = 3
	allow_dense = TRUE
	opened = TRUE
	density = FALSE
	anchored = TRUE
	can_buckle = FALSE
	resistance_flags = INDESTRUCTIBLE
	buckle_lying = 90
	layer = 2.8
	lock = null
	can_add_lock = FALSE
	alternative_icon_handling = TRUE
	var/stage = 1
	var/faildirt = 0

/obj/structure/closet/dirthole/Initialize()
	var/turf/open/floor/dirt/T = loc
	if(!istype(T))
		return INITIALIZE_HINT_QDEL
	if(T.muddy)
		if(!(locate(/obj/item/natural/worms) in T))
			if(prob(40))
				if(prob(10))
					new /obj/item/natural/worms/grub_silk(T)
				else
					new /obj/item/natural/worms/leech(T)
			else
				new /obj/item/natural/worms(T)
		if(!(locate(/obj/item/natural/clay) in T))
			if(prob(25))
				new /obj/item/natural/clay(T)
	else
		if(!(locate(/obj/item/natural/stone) in T))
			if(prob(23))
				new /obj/item/natural/stone(T)
	return ..()

/obj/structure/closet/dirthole/grave
	stage = 3
	faildirt = 3
	icon_state = "grave"

/obj/structure/closet/dirthole/closed
	stage = 4
	faildirt = 3
	climb_offset = 10
	icon_state = "gravecovered"
	opened = FALSE

/obj/structure/closet/dirthole/closed/loot/Initialize()
	. = ..()
	lootroll = rand(1,4)

/obj/structure/closet/dirthole/closed/loot
	var/looted = FALSE
	var/lootroll = 0

/obj/structure/closet/dirthole/closed/loot/open()
	if(!looted)
		looted = TRUE
		switch(lootroll)
			if(1)
				new /mob/living/carbon/human/species/skeleton/npc(get_turf(src))
				new /obj/structure/closet/crate/chest/lootbox(get_turf(src))
			if(2)
				new /obj/structure/closet/crate/chest/lootbox(get_turf(src))
	..()

/obj/structure/closet/dirthole/closed/loot/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_SOUL_EXAMINE))
		if(lootroll == 1)
			. += "<span class='warning'>Better let this one sleep.</span>"

/obj/structure/closet/dirthole/insertion_allowed(atom/movable/AM)
	if(istype(AM, /obj/structure/closet/crate/chest) || istype(AM, /obj/structure/closet/burial_shroud) || istype(AM, /obj/structure/closet/crate/coffin))
		for(var/mob/living/M in contents)
			return FALSE
		for(var/obj/structure/closet/C in contents)
			return FALSE
		return TRUE
	. = ..()

/obj/structure/closet/dirthole/toggle(mob/living/user)
	return

/obj/structure/closet/dirthole/proc/attemptwatermake(mob/living/user, obj/item/reagent_containers/bucket)
	if(user.used_intent.type == /datum/intent/splash)
		if(bucket.reagents)
			var/datum/reagent/master_reagent = bucket.reagents.get_master_reagent()
			var/reagent_volume = master_reagent.volume
			if(do_after(user, 10 SECONDS, src))
				if(bucket.reagents.remove_reagent(master_reagent.type, clamp(master_reagent.volume, 1, 100)))
					var/turf/structure_turf = get_turf(src)
					var/turf/open/water/W = structure_turf.PlaceOnTop(/turf/open/water/river/creatable)
					if(!W) // how did this happen
						return
					W.water_reagent = master_reagent.type
					W.water_volume = clamp(reagent_volume, 1, 100)
					W.handle_water()
					playsound(W, 'sound/foley/waterenter.ogg', 100, FALSE)
					QDEL_NULL(src)

/obj/structure/closet/dirthole/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/grown/log/tree/stick))
		if(locate(/obj/structure/gravemarker) in get_turf(src))
			to_chat(user, "<span class='warning'>This grave is already hallowed.</span>")
		if(stage != 4)
			to_chat(user, "<span class='warning'>I can't tie a grave marker on an open grave.</span>")

		if(!do_after(user, 10 SECONDS, src))
			return

		var/obj/structure/gravemarker/marker = new /obj/structure/gravemarker(get_turf(src))
		marker.OnCrafted(dir, user)
		qdel(attacking_item)
		return

	if(!istype(attacking_item, /obj/item/weapon/shovel))
		if(istype(attacking_item, /obj/item/reagent_containers/glass/bucket))
			attemptwatermake(user, attacking_item)
			return
		return ..()
	var/obj/item/weapon/shovel/attacking_shovel = attacking_item
	if(user.used_intent.type != /datum/intent/shovelscoop)
		return

	if(attacking_shovel.heldclod)
		playsound(loc,'sound/items/empty_shovel.ogg', 100, TRUE)
		if(stage == 3) //close grave
			if(!do_after(user, 5 SECONDS * attacking_shovel.time_multiplier, src)) //can't have nice things can we
				return
			stage = 4
			climb_offset = 10
			close()
			var/founds
			for(var/atom/A in contents)
				founds = TRUE
				break
			if(!founds)
				stage = 2
				climb_offset = 0
				open()
			stage_update()
		else if(stage < 4)
			stage--
			climb_offset = 0
			stage_update()
			if(stage == 0)
				qdel(src)
		QDEL_NULL(attacking_shovel.heldclod)
		attacking_shovel.update_appearance(UPDATE_ICON_STATE)
		return
	else
		if(stage == 3)
			var/turf/under_turf = get_step_multiz(src, DOWN)
			var/turf/our_turf = get_turf(src)
			if(under_turf && our_turf && isopenturf(under_turf))
				playsound(loc,'sound/items/dig_shovel.ogg', 100, TRUE)
				user.visible_message("[user] starts digging out the bottom of [src]", "I start digging out the bottom of [src].")
				if(!do_after(user, 10 SECONDS * attacking_shovel.time_multiplier, src))
					return TRUE
				attacking_shovel.heldclod = new(attacking_shovel)
				attacking_shovel.update_appearance(UPDATE_ICON_STATE)
				playsound(our_turf,'sound/items/dig_shovel.ogg', 100, TRUE)
				our_turf.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
				qdel(src)
				return
			to_chat(user, "<span class='warning'>I think that's deep enough.</span>")
			return
		playsound(loc,'sound/items/dig_shovel.ogg', 100, TRUE)
		var/used_str = 10
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			if(C.domhand)
				used_str = C.get_str_arms(C.used_hand)
			C.adjust_stamina(max(60 - (used_str * 5), 1))
		if(stage < 3)
			if(faildirt < 2)
				if(prob(used_str * 5))
					stage++
				else
					faildirt++
			else
				stage++
		if(stage == 4)
			if(!do_after(user, 5 SECONDS * attacking_shovel.time_multiplier, src)) // WE CANT HAVE NICE THINGS CAN WE
				return
			stage = 3
			climb_offset = 0
			open()
			for(var/obj/structure/gravemarker/G in loc)
				record_featured_stat(FEATURED_STATS_CRIMINALS, user)
				record_round_statistic(STATS_GRAVES_ROBBED)
				qdel(G)
				if(isliving(user))
					var/mob/living/L = user
					if(HAS_TRAIT(L, TRAIT_GRAVEROBBER))
						to_chat(user, "<span class='warning'>Necra turns a blind eye to my deeds.</span>")
					else
						to_chat(user, "<span class='warning'>Necra shuns my blasphemous deeds, I am cursed!</span>")
						L.apply_status_effect(/datum/status_effect/debuff/cursed)
				SEND_SIGNAL(user, COMSIG_GRAVE_ROBBED, user)
		stage_update()
		attacking_shovel.heldclod = new(attacking_shovel)
		attacking_shovel.update_appearance(UPDATE_ICON_STATE)

/datum/status_effect/debuff/cursed
	id = "cursed"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/cursed
	effectedstats = list(STATKEY_LCK = -5) // More severe so that the permanent debuff from having the perk makes it actually worth it.
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/debuff/cursed
	name = "Cursed"
	desc = "Necra has punished me by my blasphemous deeds with terribly bad luck."
	icon_state = "debuff"

/obj/structure/closet/dirthole/MouseDrop_T(atom/movable/O, mob/living/user)
	var/turf/T = get_turf(src)
	if(istype(O, /obj/structure/closet/crate/coffin))
		O.forceMove(T)
	if(!istype(O) || O.anchored || istype(O, /atom/movable/screen))
		return
	if(!istype(user) || user.incapacitated() || user.body_position == LYING_DOWN)
		return
	if(!Adjacent(user) || !user.Adjacent(O))
		return
	if(user == O) //try to climb onto it
		return ..()
	if(!opened)
		return
	if(!isturf(O.loc))
		return

	var/actuallyismob = 0
	if(isliving(O))
		actuallyismob = 1
	else if(!isitem(O))
		return
	add_fingerprint(user)
	user.visible_message("<span class='warning'>[user] [actuallyismob ? "tries to ":""]stuff [O] into [src].</span>", \
						"<span class='warning'>I [actuallyismob ? "try to ":""]stuff [O] into [src].</span>", \
						"<span class='hear'>I hear clanging.</span>")
	if(actuallyismob)
		if(do_after(user, 4 SECONDS, O))
			user.visible_message("<span class='notice'>[user] stuffs [O] into [src].</span>", \
								"<span class='notice'>I stuff [O] into [src].</span>", \
								"<span class='hear'>I hear a loud bang.</span>")
			O.forceMove(T)
			user_buckle_mob(O, user)
	else
		O.forceMove(T)
	return 1

/obj/structure/closet/dirthole/take_contents()
	var/atom/L = drop_location()
	..()
	for(var/obj/structure/closet/crate/coffin/C in L)
		if(C != src && insert(C) == -1)
			break


/obj/structure/closet/dirthole/close(mob/living/user)
	if(!opened || !can_close(user))
		return FALSE
	take_contents()
	for(var/mob/A in contents)
		if((A.stat) && (istype(A, /mob/living/carbon/human)))
			var/mob/living/carbon/human/B = A
			B.buried = TRUE
	for(var/obj/structure/closet/crate/coffin/C in contents)
		for(var/mob/living/carbon/human/D in C.contents)
			D.buried = TRUE
	opened = FALSE
	return TRUE

/obj/structure/closet/dirthole/dump_contents()
	for(var/mob/A in contents)
		if((!A.stat) && (istype(A, /mob/living/carbon/human)))
			var/mob/living/carbon/human/B = A
			B.buried = FALSE
	..()

/obj/structure/closet/dirthole/open(mob/living/user)
	if(opened)
		return
	if(stage == 4)
		stage = 3
		climb_offset = 0
	opened = TRUE
	dump_contents()
	stage_update()
	return 1

/obj/structure/closet/dirthole/proc/stage_update()
	switch(stage)
		if(1, 2, 4)
			can_buckle = FALSE
		if(3)
			can_buckle = TRUE
	update_appearance(UPDATE_ICON | UPDATE_NAME)

/obj/structure/closet/dirthole/update_icon_state()
	. = ..()
	switch(stage)
		if(1)
			icon_state = "hole1"
		if(2)
			icon_state = "hole2"
		if(3)
			icon_state = "grave"
		if(4)
			icon_state = "gravecovered"

/obj/structure/closet/dirthole/update_overlays()
	. = ..()
	if(!has_buckled_mobs() || stage != 3)
		return
	var/mutable_appearance/abovemob = mutable_appearance('icons/turf/floors.dmi', "grave_above", ABOVE_MOB_LAYER)
	. += abovemob

/obj/structure/closet/dirthole/update_name(updates)
	. = ..()
	switch(stage)
		if(1, 2)
			name = "hole"
		if(3)
			name = "pit"
		if(4)
			name = "grave"

/obj/structure/closet/dirthole/post_buckle_mob(mob/living/M)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/closet/dirthole/post_unbuckle_mob()
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/structure/closet/dirthole/relaymove(mob/user)
	if(user.stat || !isturf(loc) || !isliving(user))
		return
	if(!user.mind?.has_antag_datum(/datum/antagonist/zombie))
		if(message_cooldown <= world.time)
			message_cooldown = world.time + 50
			to_chat(user, "<span class='warning'>I'm trapped!</span>")
		return
	container_resist(user)
