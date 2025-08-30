
/obj/item/reagent_containers/glass
	name = "glass"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	reagent_flags = OPENCONTAINER
	spillable = TRUE
	possible_item_intents = list(INTENT_POUR, /datum/intent/fill, INTENT_SPLASH, INTENT_GENERIC)
	resistance_flags = ACID_PROOF

/obj/item/reagent_containers/glass/Initialize(mapload, vol)
	. = ..()
	AddComponent(/datum/component/liquids_interaction, TYPE_PROC_REF(/obj/item/reagent_containers/glass, attack_on_liquids_turf))

/obj/item/reagent_containers/glass/proc/attack_on_liquids_turf(obj/item/reagent_containers/my_beaker, turf/T, mob/living/user, obj/effect/abstract/liquid_turf/liquids)
	if(user.used_intent != /datum/intent/fill)
		return
	if(!user.Adjacent(T))
		return FALSE
	if(!my_beaker.spillable)
		return FALSE
	if(!user.Adjacent(T))
		return FALSE
	if((user.cmode))
		return FALSE
	if(liquids.fire_state) //Use an extinguisher first
		to_chat(user, span_danger("You can't scoop up anything while it's on fire!"))
		return TRUE
	if(liquids.liquid_group.expected_turf_height == 1)
		to_chat(user, span_danger("The puddle is too shallow to scoop anything up!"))
		return TRUE
	var/free_space = my_beaker.reagents.maximum_volume - my_beaker.reagents.total_volume
	if(free_space <= 0)
		to_chat(user, span_danger("You can't fit any more liquids inside [my_beaker]!"))
		return TRUE
	var/desired_transfer = my_beaker.amount_per_transfer_from_this
	if(desired_transfer > free_space)
		desired_transfer = free_space
	if(desired_transfer > liquids.liquid_group.reagents_per_turf)
		desired_transfer = liquids.liquid_group.reagents_per_turf
	liquids.liquid_group.trans_to_seperate_group(my_beaker.reagents, desired_transfer, liquids)
	to_chat(user, span_notice("You scoop up around [round(desired_transfer) / 3] oz of liquids with [my_beaker]."))
	user.changeNext_move(CLICK_CD_MELEE)
	return TRUE

/datum/intent/fill
	name = "fill"
	icon_state = "infill"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0

/datum/intent/pour
	name = "feed"
	icon_state = "infeed"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0

/datum/intent/splash
	name = "splash"
	icon_state = "insplash"
	chargetime = 0
	noaa = TRUE
	candodge = TRUE
	misscost = 0
	reach = 2

/datum/intent/soak
	name = "soak"
	icon_state = "insoak"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0

/datum/intent/wring
	name = "wring"
	icon_state = "inwring"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0

/obj/item/reagent_containers/glass/attack(mob/living/M, mob/living/user, zone)
	if(!user.used_intent)
		return
	if(user.used_intent.type == INTENT_GENERIC)
		return ..()
	if(!spillable)
		return
	if(!reagents?.total_volume)
		to_chat(user, span_danger("[src] is empty!"))
		return
	if(user.used_intent.type == INTENT_SPLASH)
		var/R
		M.visible_message(span_danger("[user] splashes the contents of [src] onto [M]!"), \
						span_danger("[user] splashes the contents of [src] onto you!"))
		if(reagents)
			for(var/datum/reagent/A as anything in reagents.reagent_list)
				R += "[A] ([num2text(A.volume)]),"

		if(reagents?.reagent_list && user)
			log_combat(user, M, "splashed (thrown) [english_list(reagents.reagent_list)]")
			message_admins("[ADMIN_LOOKUPFLW(user)] splashed (thrown) [english_list(reagents.reagent_list)] on [M] at [ADMIN_VERBOSEJMP(M)].")

		SEND_SIGNAL(user, COMSIG_SPLASHED_MOB, M, reagents.reagent_list)
		reagents.reaction(M, TOUCH)
		chem_splash(M.loc, 2, list(reagents))
		playsound(M.loc, pick('sound/foley/water_land1.ogg','sound/foley/water_land2.ogg', 'sound/foley/water_land3.ogg'), 100, FALSE)
		log_combat(user, M, "splashed", R)
		return
	if(user.used_intent.type == INTENT_POUR)
		if(!canconsume(M, user))
			return
		if(M != user)
			M.visible_message(span_danger("[user] attempts to feed [M] something."), \
						span_danger("[user] attempts to feed you something."))
			if(!do_after(user, 3 SECONDS, M))
				return
			if(!reagents?.total_volume)
				return // The drink might be empty after the delay, such as by spam-feeding
			M.visible_message(span_danger("[user] feeds [M] something."), \
						span_danger("[user] feeds you something."))
			log_combat(user, M, "fed", reagents.log_list())
		else
			// check to see if we're a noble drinking soup
			if(ishuman(user) && istype(src, /obj/item/reagent_containers/glass/bowl))
				var/mob/living/carbon/human/human_user = user
				if(human_user.is_noble()) // egads we're an unmannered SLOB
					human_user.add_stress(/datum/stressevent/noble_bad_manners)
					if(prob(25))
						to_chat(human_user, span_red("I've got better manners than this..."))
			to_chat(user, span_notice("I swallow a gulp of [src]."))
		addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, trans_to), M, min(amount_per_transfer_from_this,5), TRUE, TRUE, FALSE, user, FALSE, INGEST), 5)
		playsound(M.loc, pick(drinksounds), 100, TRUE)

/obj/item/reagent_containers/glass/attack_atom(atom/attacked_atom, mob/living/user)
	if(user.used_intent.type == INTENT_GENERIC)
		return ..()

	if(!spillable)
		return ..()

	var/stealthy = (user.m_intent == MOVE_INTENT_SNEAK)
	if(attacked_atom.is_refillable() && (user.used_intent.type == INTENT_POUR)) //Something like a glass. Player probably wants to transfer TO it.
		if(!reagents.total_volume)
			to_chat(user, span_danger("[src] is empty!"))
			return

		if(attacked_atom.reagents.holder_full())
			to_chat(user, span_danger("[attacked_atom] is full."))
			return
		if(stealthy)
			to_chat(user, span_notice("I pour [src] into [attacked_atom]."))
		else
			user.visible_message(span_notice("[user] pours [src] into [attacked_atom]."), \
							span_notice("I pour [src] into [attacked_atom]."))
		if(!stealthy && poursounds)
			playsound(user, pick(poursounds), 100, TRUE)
		for(var/i in 1 to 22)
			if(do_after(user, 8 DECISECONDS, attacked_atom, hidden = stealthy))
				if(!reagents.total_volume)
					break
				if(attacked_atom.reagents.holder_full())
					break
				if(!reagents.trans_to(attacked_atom, amount_per_transfer_from_this, transfered_by = user))
					reagents.reaction(attacked_atom, TOUCH, amount_per_transfer_from_this)
			else
				break
		return

	if(attacked_atom.is_drainable() && (user.used_intent.type == INTENT_FILL)) //A dispenser. Transfer FROM it TO us.
		if(!attacked_atom.reagents.total_volume)
			to_chat(user, span_danger("[attacked_atom] is empty!"))
			return

		if(reagents.holder_full())
			to_chat(user, span_danger("[src] is full."))
			return
		if(stealthy)
			to_chat(user, span_notice("I fill [src] with [attacked_atom]."))
		else
			user.visible_message(span_notice("[user] fills [src] with [attacked_atom]."), \
						span_notice("I fill [src] with [attacked_atom]."))
		if(!stealthy && fillsounds)
			playsound(user, pick(fillsounds), 100, TRUE)
		for(var/i in 1 to 22)
			if(do_after(user, 8 DECISECONDS, attacked_atom, hidden = stealthy))
				if(reagents.holder_full())
					break
				if(!attacked_atom.reagents.total_volume)
					break
				attacked_atom.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user)
			else
				break
		return

	if(reagents.total_volume && user.used_intent.type == INTENT_SPLASH)
		var/turf/newT = get_turf(attacked_atom)
		while(istype(newT, /turf/closed) && newT != user.loc) //catch for walls
			newT = get_step(newT, get_dir(newT, user.loc))
		reagents.reaction(newT, TOUCH)
		chem_splash(newT, 2, list(reagents))
		playsound(newT, pick('sound/foley/water_land1.ogg','sound/foley/water_land2.ogg', 'sound/foley/water_land3.ogg'), 100, FALSE)
		if(stealthy)
			to_chat(user, span_notice("I splash the contents of [src] onto \the [newT]."))
		else
			user.visible_message(span_notice("[user] splashes the contents of [src] onto \the [newT]!"), \
									span_notice("I splash the contents of [src] onto \the [newT]."))

/obj/item/reagent_containers/glass/afterattack(obj/target, mob/user, proximity)
	SEND_SIGNAL(src, COMSIG_ITEM_AFTERATTACK, target, user)
	if(user.used_intent.type == INTENT_GENERIC)
		return ..()

	if((!proximity) || !check_allowed_items(target,target_self=1))
		return ..()

	if(!spillable)
		return

/obj/item/reagent_containers/glass/attackby(obj/item/I, mob/user, params)
	var/hotness = I.get_temperature()
	if(hotness && reagents)
		reagents.expose_temperature(hotness)
		to_chat(user, span_notice("I heat [name] with [I]!"))

	if(istype(I, /obj/item/reagent_containers/food/snacks/egg)) //breaking eggs
		var/obj/item/reagent_containers/food/snacks/egg/E = I
		if(reagents)
			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_notice("[src] is full."))
			else
				to_chat(user, span_notice("I break [E] in [src]."))
				E.reagents.trans_to(src, E.reagents.total_volume, transfered_by = user)
				qdel(E)
			return
	..()

/obj/item/reagent_containers/glass/bucket
	name = "bugged bucket please report to mappers"
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	icon_state = "woodbucket"
	item_state = "woodbucket"
	fill_icon_thresholds = list(0, 50, 100)
	reagent_flags = TRANSFERABLE | AMOUNT_VISIBLE
	max_integrity = 300
	w_class = WEIGHT_CLASS_BULKY
	amount_per_transfer_from_this = 9
	possible_transfer_amounts = list(9)
	volume = 99
	flags_inv = HIDEHAIR
	obj_flags = CAN_BE_HIT
	resistance_flags = NONE

/obj/item/reagent_containers/glass/bucket/dropped(mob/user)
	. = ..()
	reagents.flags = initial(reagent_flags)

/obj/item/reagent_containers/glass/bucket/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/reagent_containers/powder/salt))
		if(!reagents.has_reagent(/datum/reagent/consumable/milk, 15) && !reagents.has_reagent(/datum/reagent/consumable/milk/gote, 15))
			to_chat(user, span_danger("Not enough milk."))
			return
		to_chat(user, span_danger("Adding salt to the milk."))
		playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)
		if(do_after(user,2 SECONDS, src))
			if(reagents.has_reagent(/datum/reagent/consumable/milk, 15))
				reagents.remove_reagent(/datum/reagent/consumable/milk, 15)
				reagents.add_reagent(/datum/reagent/consumable/milk/salted, 15)
			if(reagents.has_reagent(/datum/reagent/consumable/milk/gote, 15))
				reagents.remove_reagent(/datum/reagent/consumable/milk/gote, 15)
				reagents.add_reagent(/datum/reagent/consumable/milk/salted_gote, 15)
			qdel(I)

/obj/item/reagent_containers/glass/bucket/wooden
	name = "bucket"
	fill_icon_state = "bucket"
	force = 5
	throwforce = 10
	armor = list("blunt" = 10, "slash" = 10, "stab" = 10,  "piercing" = 0, "fire" = 0, "acid" = 50)
	resistance_flags = FLAMMABLE
	dropshrink = 0.8
	slot_flags = null
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'

/obj/item/reagent_containers/glass/bucket/wooden/alter // just new look, trying it on for size
	icon = 'icons/roguetown/items/cooking.dmi'

/obj/item/reagent_containers/glass/bucket/wooden/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -5,"sy" = -8,"nx" = 7,"ny" = -9,"wx" = -1,"wy" = -8,"ex" = -1,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
