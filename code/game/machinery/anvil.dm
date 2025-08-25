
/obj/machinery/anvil
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "anvil"
	icon_state = "anvil"
	var/hott = 0
	var/obj/item/ingot/hingot
	max_integrity = 2000
	density = TRUE
	damage_deflection = 25
	climbable = TRUE
	var/previous_material_quality = 0
	var/cool_time = 10 SECONDS

/obj/machinery/anvil/crafted
	icon_state = "caveanvil"

/obj/machinery/anvil/examine(mob/user)
	. = ..()
	if(hingot && hott)
		. += "<span class='warning'>[hingot] is too hot to touch.</span>"

/obj/machinery/anvil/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/weapon/tongs))
		var/obj/item/weapon/tongs/T = W
		if(hingot)
			if(T.held_item && istype(T.held_item, /obj/item/ingot))
				if(hingot.currecipe && hingot.currecipe.needed_item && istype(T.held_item, hingot.currecipe.needed_item))
					hingot.currecipe.item_added(user)
					qdel(T.held_item)
					T.held_item = null
					T.update_appearance(UPDATE_ICON_STATE)
					update_appearance(UPDATE_OVERLAYS)
				return
			else
				hingot.forceMove(T)
				T.held_item = hingot
				hingot = null
				T.update_appearance(UPDATE_ICON_STATE)
				update_appearance(UPDATE_OVERLAYS)
				return
		else
			if(T.held_item && istype(T.held_item, /obj/item/ingot))
				T.held_item.forceMove(src)
				hingot = T.held_item
				T.held_item = null
				hott = T.hott
				if(hott)
					START_PROCESSING(SSmachines, src)
				T.update_appearance(UPDATE_ICON_STATE)
				update_appearance(UPDATE_OVERLAYS)
				return

	if(istype(W, /obj/item/ingot))
		if(!hingot)
			W.forceMove(src)
			hingot = W
			hott = 0
			update_appearance(UPDATE_OVERLAYS)
			return

	if(istype(W, /obj/item/weapon/hammer))
		var/obj/item/weapon/hammer/hammer = W
		user.changeNext_move(CLICK_CD_MELEE)
		if(!hingot)
			return
		if(!hott)
			to_chat(user, "<span class='warning'>The bar has gone too cold to continue working on it.</span>")
			return
		if(!hingot.currecipe)
			if(!choose_recipe(user))
				return
			user.flash_fullscreen("whiteflash")
			shake_camera(user, 1, 1)
			playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
		if(has_world_trait(/datum/world_trait/delver))
			if(!has_recipe_unlocked(user.key, hingot.currecipe.type))
				return
		var/used_str = user.STASTR
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			if(C.domhand)
				used_str = C.get_str_arms(C.used_hand)
			C.adjust_stamina(max(30 - (used_str * 3), 0))
		var/total_chance = 7 * user.get_skill_level(hingot.currecipe.appro_skill)
		var/breakthrough = 0
		if(prob(1 + total_chance))
			user.flash_fullscreen("whiteflash")
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_turf(src)
			S.set_up(1, 1, front)
			S.start()
			breakthrough = 1
			hingot.currecipe.numberofbreakthroughs++

		if(!hingot.currecipe.advance(user, breakthrough))
			shake_camera(user, 1, 1)
			playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)

		playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

		for(var/mob/M in GLOB.player_list)
			if(!is_in_zweb(M.z,src.z))
				continue
			var/turf/M_turf = get_turf(M)
			var/far_smith_sound = sound(pick('sound/items/smithdist1.ogg','sound/items/smithdist2.ogg','sound/items/smithdist3.ogg'))
			if(M_turf)
				var/dist = get_dist(M_turf, loc)
				if(dist < 7)
					continue
				M.playsound_local(M_turf, null, 100, 1, get_rand_frequency(), falloff_exponent = 5, S = far_smith_sound)

		if(istype(hammer, /obj/item/weapon/hammer/wood))
			hammer.take_damage(hammer.max_integrity * 0.03, BRUTE, "blunt")
		return

	if(hingot && hingot.currecipe && hingot.currecipe.needed_item && istype(W, hingot.currecipe.needed_item))
		hingot.currecipe.item_added(user)
		if(istype(W, /obj/item/ingot))
			var/obj/item/ingot/I = W
			hingot.currecipe.material_quality += I.quality
			previous_material_quality = I.quality
		else
			hingot.currecipe.material_quality += previous_material_quality
		hingot.currecipe.num_of_materials += 1
		qdel(W)
		return

	if(W.anvilrepair)
		user.visible_message("<span class='info'>[user] places \a [W] on the anvil.</span>")
		W.forceMove(src.loc)
		return
	..()

/obj/machinery/anvil/proc/choose_recipe(mob/user)
	if(!hingot || !hott)
		return

	var/list/valid_types = list()
	for(var/datum/anvil_recipe/R in GLOB.anvil_recipes)
		if(is_abstract(R.type)) //these recipes are initialized
			continue

		if(has_world_trait(/datum/world_trait/delver))
			if(!has_recipe_unlocked(user.key, R.type))
				continue

		if(istype(hingot, R.req_bar))
			if(!valid_types.Find(R.i_type))
				valid_types += R.i_type

	if(!valid_types.len)
		return

	var/i_type_choice = browser_input_list(user, "Choose a category", "Anvil", valid_types)
	if(!i_type_choice)
		return

	var/list/appro_recipe = list()
	for(var/datum/anvil_recipe/R in GLOB.anvil_recipes)
		if(is_abstract(R.type))
			continue
		if(R.i_type == i_type_choice && istype(hingot, R.req_bar))
			appro_recipe += R

	for(var/I in appro_recipe)
		var/datum/anvil_recipe/R = I
		if(!R.req_bar)
			appro_recipe -= R
		if(!istype(hingot, R.req_bar))
			appro_recipe -= R

	if(appro_recipe.len)
		var/datum/chosen_recipe = browser_input_list(user, "Choose what to start working on:", "Anvil", sortNames(appro_recipe.Copy()))
		if(!hingot.currecipe && chosen_recipe)
			hingot.currecipe = new chosen_recipe.type(hingot)
			hingot.currecipe.material_quality += hingot.quality
			previous_material_quality = hingot.quality
			return TRUE

	return FALSE

/obj/machinery/anvil/attack_hand(mob/user, params)
	if(hingot)
		if(hott)
			to_chat(user, "<span class='warning'>It's too hot to handle with your hands.</span>")
			return
		else
			var/obj/item/I = hingot
			hingot = null
			I.loc = user.loc
			user.put_in_active_hand(I)
			update_appearance(UPDATE_OVERLAYS)

/obj/machinery/anvil/process()
	if(hott)
		if(world.time > hott + cool_time)
			hott = 0
			STOP_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSmachines, src)
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/anvil/update_overlays()
	. = ..()
	if(!hingot)
		return
	var/obj/item/I = hingot
	I.pixel_x = I.base_pixel_x
	I.pixel_y = I.base_pixel_y
	var/mutable_appearance/M = new /mutable_appearance(I)
	if(hott)
		M.filters += filter(type="color", color = list(3,0,0,1, 0,2.7,0,0.4, 0,0,1,0, 0,0,0,1))
	M.transform *= 0.5
	M.pixel_y = 5
	M.pixel_x = 3
	. += M
