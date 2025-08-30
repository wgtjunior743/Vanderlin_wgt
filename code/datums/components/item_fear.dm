/datum/component/scared_of_item // this runs independantly of ai_controller so we aren't wasting ai process time on this as its a passive check.
	var/range
	var/was_scared = FALSE
	var/mob/last_scared_by

/datum/component/scared_of_item/Initialize(range)
	src.range = range
	START_PROCESSING(SSobj, src)

/datum/component/scared_of_item/Destroy(force)
	STOP_PROCESSING(SSobj, src)
	return ..()

/datum/component/scared_of_item/process(seconds_per_tick)
	var/mob/living/simple_animal/basic_mob = parent

	if(isliving(parent))
		var/mob/living/living = parent
		if(living.stat == DEAD)
			return

	for(var/mob/living/carbon/human/human in oview(range, basic_mob))
		for(var/obj/item/item as anything in human.held_items)
			if(QDELETED(item))
				continue
			if(!istype(item, basic_mob.ai_controller?.blackboard[BB_BASIC_MOB_SCARED_ITEM]))
				continue
			basic_mob.ai_controller?.set_blackboard_key(BB_BASIC_MOB_STOP_FLEEING, FALSE)

			if(!was_scared)
				SEND_SIGNAL(basic_mob, COMSIG_EMOTION_STORE, human, EMOTION_SCARED, "chased me with a whip.", 1)
				last_scared_by = human
				was_scared = TRUE
			return
	basic_mob.ai_controller?.set_blackboard_key(BB_BASIC_MOB_STOP_FLEEING, TRUE)
	if(was_scared)
		SEND_SIGNAL(basic_mob, COMSIG_EMOTION_STORE, last_scared_by, EMOTION_HAPPY, "stopped chasing me with a whip.", 0)
		was_scared = FALSE
		last_scared_by = null
