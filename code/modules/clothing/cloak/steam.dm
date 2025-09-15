/obj/item/clothing/cloak/boiler
	name = "steamknight boiler"
	desc = "The backpack-sized power center of the steamknight armor. Requires knowledge in engineering to operate."

	icon_state = "boiler"
	item_state = "boiler"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/steamknight_onmob.dmi'
	icon = 'icons/roguetown/clothing/steamknight.dmi'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK

	//you can't unsmelt your boiler Sir Steam Knightus
	smeltresult = /obj/item/ingot/bronze

	var/active = FALSE

/obj/item/clothing/cloak/boiler/Initialize()
	. = ..()
	AddComponent(/datum/component/steam_storage, 1000, 0.5, "steam_armor")

/obj/item/clothing/cloak/boiler/dropped(mob/living/user)
	power_off(user)
	. = ..()

/obj/item/clothing/cloak/boiler/attack_hand_secondary(mob/living/user, params)
	..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	//Engineering skill check
	var/skill_level = user.get_skill_level(/datum/skill/craft/engineering)
	if(skill_level <= 2)
		to_chat(user, span_warning("I don't know how to operate [src]!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	//Full steam armor check
	var/list/equipped_types = list()
	var/list/equipped_items = list()
	for(var/obj/item/clothing/V as anything in user.get_equipped_items(FALSE))
		if(!is_type_in_list(V, GLOB.steam_armor))
			continue
		equipped_types |= V.type
		equipped_items |= V

	if(length(equipped_types) != length(GLOB.steam_armor))
		to_chat(user, span_warning("You must be wearing the full steam armor set to operate the [src]..."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(src.obj_broken)
		to_chat(user, span_warning("The [src.name] is broken!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	//Toggle on/off
	var/windtime = 5
	windtime = max(0, windtime - skill_level)   //Higher engineering = faster activation/deactivation

	var/toggling_on = !active

	if(do_after(user, windtime SECONDS, src))
		if(toggling_on)
			if(!SEND_SIGNAL(user, COMSIG_ATOM_PROXY_STEAM_USE, src, 0.5, "steam_armor", FALSE, TRUE))
				to_chat(user, span_warning("The [src.name] is out of steam!"))
				return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
			active = TRUE
			power_on(user)
			apply_status_effect(user)
			to_chat(user, span_info("You activate [src], steam hisses as the armor comes to life!"))
			user.audible_message(span_info("The [src.name] rumbles and lets out a hiss of pressurized steam!"), runechat_message = TRUE)
		else
			active = FALSE
			power_off(user)
			to_chat(user, span_info("You power down [src], the steam quiets."))
			user.audible_message(span_info("The [src.name] sputters and hisses, coming to a stop."), runechat_message = TRUE)


/obj/item/clothing/cloak/boiler/proc/power_on(mob/living/carbon/user)
	var/obj/item/clothing/shoes/boots/armor/steam/boots = locate() in list(user.shoes)
	//Stops the speed debuff from the boots
	if(boots)
		boots.power_on(user)

	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(try_steam_usage), override = TRUE)
	return

/obj/item/clothing/cloak/boiler/proc/power_off(mob/living/carbon/user, var/disable = FALSE, var/broken = FALSE)
	var/obj/item/clothing/shoes/boots/armor/steam/boots = locate() in list(user.shoes)

	if(boots)
		boots.power_off(user)

	remove_status_effect(user)
	UnregisterSignal(user, COMSIG_MOVABLE_MOVED) // stop burning steam
	//Triggers when the player removes the boiler or any steamknight armor without turning the boiler off, penalizes them.
	if(active && !disable && !broken)
		active = FALSE
		to_chat(user, span_warning("The [src.name] sputters violently and shuts down forcibly, steam dissipating..."))
		user.audible_message(span_warning("The [src.name] sputters violently before stopping."), runechat_message = TRUE)
		var/random_loss = rand(100, 200)
		//If they can reduce the steam, do it, if it can't it will be set to zero.
		if(!SEND_SIGNAL(user, COMSIG_ATOM_PROXY_STEAM_USE, src, random_loss, "steam_armor"))
			SEND_SIGNAL(user, COMSIG_ATOM_PROXY_STEAM_USE, src, random_loss, "steam_armor", TRUE)
		else
			SEND_SIGNAL(user, COMSIG_ATOM_PROXY_STEAM_USE, src, random_loss, "steam_armor")

	//Triggers when the steamknight boiler runs out of steam.
	if(disable)
		active = FALSE
		user.audible_message(span_warning("The [src.name] hisses and sputters, running completely out of steam!"), runechat_message = TRUE)

	//Triggers when steamknight boiler breaks while active.
	if(broken)
		active = FALSE
		to_chat(user, span_warning("The [src.name] breaks!"))
		user.audible_message(span_warning("The [src.name] sputters violently as you hear a loud crack!"), runechat_message = TRUE)
		SEND_SIGNAL(user, COMSIG_ATOM_PROXY_STEAM_USE, src, 0.5, "steam_armor", TRUE)

	return

/obj/item/clothing/cloak/boiler/proc/try_steam_usage(mob/living/source)
	//Only trigger if the boiler is active
	if(!active)
		return FALSE
	//If the boiler breaks while it is active, forcibly shut it down and remove all the steam inside.
	if(src.obj_broken)
		power_off(source, FALSE, TRUE)
		return FALSE

	if(!SEND_SIGNAL(source, COMSIG_ATOM_PROXY_STEAM_USE, src, 0.5, "steam_armor"))
		//Out of steam, shut down the boiler forcibly
		power_off(source, TRUE)
		return FALSE

	return TRUE


/obj/item/clothing/cloak/boiler/proc/apply_status_effect(mob/living/user)
	user.apply_status_effect(/datum/status_effect/buff/powered_steam_armor)

/obj/item/clothing/cloak/boiler/proc/remove_status_effect(mob/living/user)
	user.remove_status_effect(/datum/status_effect/buff/powered_steam_armor)

