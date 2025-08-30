/datum/component/generic_mob_hunger
	var/current_hunger
	var/max_hunger
	///this is the rate at which our hunger passively drains
	var/hunger_drain
	var/hunger_paused = FALSE
	var/feed_pause_time
	var/feed_pause_end
	var/remove_overfed_timer

/datum/component/generic_mob_hunger/Initialize(max_hunger = 250, hunger_drain = 0.1, feed_pause_time = 1 MINUTES, starting_hunger)
	. = ..()
	src.hunger_drain = hunger_drain
	src.max_hunger = max_hunger
	src.feed_pause_time = feed_pause_time
	src.current_hunger = starting_hunger || max_hunger
	START_PROCESSING(SSmob_functions, src)

/datum/component/generic_mob_hunger/Destroy(force)
	STOP_PROCESSING(SSmob_functions, src)
	if(remove_overfed_timer)
		deltimer(remove_overfed_timer)
	return ..()

/datum/component/generic_mob_hunger/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_STOP_HUNGER, PROC_REF(stop_hunger))
	RegisterSignal(parent, COMSIG_MOB_START_HUNGER, PROC_REF(start_hunger))
	RegisterSignal(parent, COMSIG_MOB_DRAIN_HUNGER, PROC_REF(on_drain_hunger))
	RegisterSignal(parent, COMSIG_MOB_FEED, PROC_REF(on_feed))
	RegisterSignal(parent, COMSIG_MOB_FILL_HUNGER, PROC_REF(on_fill_hunger))
	RegisterSignal(parent, COMSIG_MOB_RETURN_HUNGER, PROC_REF(return_hunger))
	RegisterSignal(parent, COMSIG_MOB_ADJUST_HUNGER, PROC_REF(adjust_hunger))
	RegisterSignal(parent, COMSIG_ATOM_MOUSE_ENTERED, PROC_REF(view_hunger))

/datum/component/generic_mob_hunger/UnregisterFromParent()
	if(remove_overfed_timer)
		deltimer(remove_overfed_timer)
	REMOVE_TRAIT(parent, TRAIT_OVERFED, REF(src))
	UnregisterSignal(parent, list(
		COMSIG_MOB_STOP_HUNGER,
		COMSIG_MOB_START_HUNGER,
		COMSIG_MOB_FEED,
		COMSIG_MOB_RETURN_HUNGER,
		COMSIG_MOB_ADJUST_HUNGER,
		COMSIG_ATOM_MOUSE_ENTERED,
		COMSIG_MOB_START_HUNGER,
		COMSIG_MOB_FILL_HUNGER
	))

/datum/component/generic_mob_hunger/proc/stop_hunger()
	hunger_paused = TRUE

/datum/component/generic_mob_hunger/proc/start_hunger()
	hunger_paused = FALSE

/datum/component/generic_mob_hunger/proc/on_fill_hunger()
	current_hunger = max_hunger

/datum/component/generic_mob_hunger/proc/on_drain_hunger(precent)
	if(!precent)
		return
	current_hunger = max(current_hunger - (max_hunger * precent), 0)

/datum/component/generic_mob_hunger/proc/on_feed(datum/source, atom/target, feed_amount)
	SIGNAL_HANDLER
	if(current_hunger > max_hunger)
		SEND_SIGNAL(parent, COMSIG_MOB_REFUSED_EAT)
		return

	SEND_SIGNAL(parent, COMSIG_HUNGER_UPDATED, current_hunger + feed_amount, max_hunger)
	if(current_hunger + feed_amount > max_hunger)
		var/temp = (current_hunger + feed_amount) / max_hunger
		SEND_SIGNAL(parent, COMSIG_MOB_OVERATE, temp)
		ADD_TRAIT(parent, TRAIT_OVERFED, REF(src))
		remove_overfed_timer = addtimer(TRAIT_CALLBACK_REMOVE(parent, TRAIT_OVERFED, REF(src)), 5 MINUTES, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE)
		current_hunger += feed_amount
		if(feed_pause_time)
			feed_pause_end = world.time + feed_pause_time
		return

	current_hunger += feed_amount
	SEND_SIGNAL(parent, COMSIG_MOB_EAT_NORMAL, current_hunger)
	if(feed_pause_time)
		feed_pause_end = world.time + feed_pause_time

/datum/component/generic_mob_hunger/proc/return_hunger()
	SIGNAL_HANDLER
	return current_hunger / max_hunger

/datum/component/generic_mob_hunger/process(seconds_per_tick)
	if(hunger_paused || !hunger_drain || (feed_pause_end > world.time))
		return

	if(isliving(parent))
		var/mob/living/living = parent
		if(living.stat == DEAD)
			return

	if(current_hunger >= hunger_drain)
		current_hunger -= hunger_drain
		SEND_SIGNAL(parent, COMSIG_HUNGER_UPDATED, current_hunger, max_hunger)

		var/hunger_precent = current_hunger / max_hunger

		if(hunger_precent <= 0.25)
			SEND_SIGNAL(parent, COMSIG_MOB_STARVING, hunger_precent)
	else
		current_hunger = 0
		SEND_SIGNAL(parent, COMSIG_HUNGER_UPDATED, current_hunger, max_hunger)
		SEND_SIGNAL(parent, COMSIG_MOB_FULLY_STARVING)

/datum/component/generic_mob_hunger/proc/adjust_hunger(datum/source, amount)
	current_hunger += amount

/datum/component/generic_mob_hunger/proc/view_hunger(mob/living/source, mob/living/clicker)
	if(!istype(clicker) || !clicker.client)
		return
	if(!SEND_SIGNAL(parent, COMSIG_FRIENDSHIP_CHECK_LEVEL, clicker, "friend"))
		return

	var/alist/offset_to_add = get_icon_dimensions(source.icon)
	var/y_position = offset_to_add["height"] + 8 // this renders above any health ones
	var/obj/effect/overlay/happiness_overlay/hunger/hearts = new(null, clicker)
	hearts.pixel_y = y_position
	hearts.set_hearts(current_hunger / max_hunger)
	var/image/new_image = new(source)
	new_image.appearance = hearts.appearance
	if(!isturf(source.loc))
		new_image.loc = source.loc
	else
		new_image.loc = source
	clicker.client.images += new_image
	hearts.image = new_image

/obj/effect/overlay/happiness_overlay/hunger
	full_icon = "full_hunger"
	empty_icon = "empty_hunger"
