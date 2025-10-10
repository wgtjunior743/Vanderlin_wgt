
/datum/bar_item
	var/name = "Beer"
	var/stamina_restore = 10
	var/joy = 5
	var/created_amount = 1

	var/list/requirements = list(
		MAT_GRAIN = 0,
		MAT_FRUIT = 0,
		MAT_VEG  = 0,
		MAT_MEAT = 0,
	)

/datum/bar_item/beer
	name = "Beer"
	stamina_restore = 10
	joy = 10

	requirements = list(
		MAT_GRAIN = 2
	)

/obj/effect/building_node/bar
	name = "Bar"
	icon = 'icons/roguetown/misc/lighting.dmi'
	icon_state = "hearth1"

	work_template = "bar"

	persistant_nodes = list(
		/datum/persistant_workorder/make_drink/beer,
	)

	var/list/stored_foods = list(

	)

	var/list/eating_spots = list(

	)


/obj/effect/building_node/bar/after_construction(list/turfs)
	. = ..()
	for(var/turf/turf as anything in turfs)
		for(var/obj/effect/foodspot/spot in turf.contents)
			eating_spots |= spot

/obj/effect/building_node/bar/proc/try_feed(mob/living/hungry_worker)
	if(!length(stored_foods))
		var/list/turfs = view(6, hungry_worker)
		shuffle_inplace(turfs)
		for(var/turf/open/open in turfs)
			hungry_worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
			break
		return
	hungry_worker.controller_mind.set_current_task(/datum/work_order/eat_drink, pick(eating_spots), pick(stored_foods), src)

/obj/effect/building_node/bar/proc/consume_drink(datum/food_item/food_to_consume, mob/living/hungry_worker)
	hungry_worker.controller_mind.current_stamina = min(hungry_worker.controller_mind.maximum_stamina, hungry_worker.controller_mind.current_stamina + (initial(food_to_consume.stamina_restore)))

/obj/effect/building_node/bar/proc/add_drink(datum/bar_item/incoming_food)
	stored_foods |= incoming_food
	stored_foods[incoming_food] += initial(incoming_food.created_amount)

	var/datum/bar_item/food = new incoming_food
	for(var/material in food.requirements)
		work_materials[material] -= food.requirements[material]
		work_materials[material] = max(0, work_materials[material])
	qdel(food)
