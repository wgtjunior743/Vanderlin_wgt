/obj/item/needle
	name = "needle"
	desc = "A firm needle affixed with a simple thread, Pestra's most favored tool."
	icon_state = "needle"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_TINY
	force = 0
	throwforce = 0
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	anvilrepair = /datum/skill/craft/blacksmithing
	tool_behaviour = TOOL_SUTURE

	grid_width = 32
	grid_height = 32
	/// Amount of uses left
	var/stringamt = 20
	var/maxstring = 20
	/// If this needle is infinite
	var/infinite = FALSE
	/// If this needle can be used to repair items
	var/can_repair = TRUE

/obj/item/needle/examine()
	. = ..()
	if(!infinite)
		if(stringamt > 0)
			. += span_bold("It has [stringamt] uses left.")
		else
			. += span_bold("It has no uses left.")
	else
		. += span_bold("Can be used indefinitely.")

/obj/item/needle/Initialize()
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/needle/update_overlays()
	. = ..()
	if(stringamt <= 0)
		return
	. += "[icon_state]string"

/obj/item/needle/use(used)
	if(infinite)
		return TRUE
	stringamt = stringamt - used
	update_appearance(UPDATE_OVERLAYS)
//	if(stringamt <= 0)
//		qdel(src)

/obj/item/needle/attack(mob/living/M, mob/user)
	sew(M, user)

/obj/item/needle/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/natural/fibers))
		if(maxstring - stringamt < 5)
			to_chat(user, span_warning("Not enough room for more thread!"))
			return
		else
			to_chat(user, "I begin threading the needle with additional fibers...")
			if(do_after(user, 6 SECONDS - user.get_skill_level(/datum/skill/misc/sewing), I))
				stringamt += 5
				to_chat(user, "I replenish the needle's thread!")
				qdel(I)
				update_appearance(UPDATE_OVERLAYS)
			return
	return ..()

/obj/item/needle/pre_attack(atom/A, mob/living/user, params)
	if(isitem(A) && !can_repair)
		to_chat(user, span_warning("[src] cannot be used to repair [A]!"))
		return TRUE
	if(isitem(A) && can_repair)
		var/obj/item/I = A
		if(!(I.obj_flags & CAN_BE_HIT) && !istype(A, /obj/item/storage)) // to preserve old attack_obj behavior
			return ..()
		if(!I.ontable() || !I.sewrepair)
			return ..()
		if(!I.uses_integrity || I.obj_broken)
			to_chat(user, span_warning("[I] can't be repaired!"))
			return ..()
		if(I.get_integrity() >= I.max_integrity)
			return ..()
		if(stringamt < 1)
			to_chat(user, span_warning("[src] has no thread left!"))
			return TRUE
		var/armor_value = 0
		var/skill_level = user.get_skill_level(/datum/skill/misc/sewing)
		for(var/key in I.armor.getList()) // Here we are checking if the armor value of the item is 0 so we can know if the item is armor without having to make a snowflake var
			armor_value += I.armor.getRating(key)
		if((armor_value == 0 && skill_level < 1) || (armor_value > 0 && skill_level < 2))
			to_chat(user, span_warning("I should probably not be doing this..."))
		playsound(loc, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
		var/skill_multiplied = (skill_level * 10)
		var/sewtime = (6 SECONDS - skill_multiplied)
		if(!do_after(user, sewtime, I))
			return TRUE
		if((armor_value == 0 && skill_level > 0) || (armor_value > 0 && skill_level > 1)) //If not armor but skill level at least 1 or Armor and skill level at least 2
			user.visible_message(span_info("[user] repairs [I]!"))
			I.repair_damage(skill_multiplied)
		else
			if(prob(20 - user.STALUC)) //Unlucky here!
				I.take_damage(150, BRUTE, "slash")
				user.visible_message(span_warning("[user] was extremely unlucky and ruined [I] while futilely trying to repair it!"))
				playsound(src, 'sound/foley/cloth_rip.ogg', 50, TRUE)
			else if(prob(user.STALUC)) //Lucky here!
				I.repair_damage(50)
				playsound(src, 'sound/magic/ahh2.ogg', 50, TRUE)
				user.visible_message(span_info("A miracle! [user] somehow managed to repair [I] while not having a single clue what [user.p_they()] [user.p_were()] doing!"))
			else
				I.take_damage(50, BRUTE, "slash")
				user.visible_message(span_warning("[user] damaged [I] due to a lack of skill!"))
				playsound(src, 'sound/foley/cloth_rip.ogg', 50, TRUE)
			user.mind.add_sleep_experience(/datum/skill/misc/sewing, (user.STAINT) / 2) // Only failing if we have no idea what we're doing
		return TRUE
	return ..()

/obj/item/needle/proc/sew(mob/living/target, mob/living/user)
	if(!istype(user))
		return FALSE
	var/mob/living/doctor = user
	var/mob/living/carbon/human/patient = target
	var/boon = doctor?.get_learning_boon(/datum/skill/misc/medicine)
	if(stringamt < 1)
		to_chat(user, "<span class='warning'>The needle has no thread left!</span>")
		return
	if(!get_location_accessible(patient, check_zone(doctor.zone_selected)))
		to_chat(doctor, "<span class='warning'>Something in the way.</span>")
		return FALSE
	var/list/sewable
	var/obj/item/bodypart/affecting
	if(iscarbon(patient))
		affecting = patient.get_bodypart(check_zone(doctor.zone_selected))
		if(!affecting)
			to_chat(doctor, "<span class='warning'>That limb is missing.</span>")
			return FALSE
		if(affecting.bandage)
			to_chat(doctor, "<span class='warning'>There is a bandage in the way.</span>")
			return FALSE
		sewable = affecting.get_sewable_wounds()
	else
		sewable = patient.get_sewable_wounds()
	if(!length(sewable))
		to_chat(doctor, "<span class='warning'>There aren't any wounds to be sewn.</span>")
		return FALSE
	var/datum/wound/target_wound = input(doctor, "Which wound?", "[src]") as null|anything in sewable
	if(!target_wound)
		return FALSE

	playsound(loc, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
	var/moveup = 10
	if(doctor.mind)
		moveup = ((doctor.get_skill_level(/datum/skill/misc/medicine)+1) * 5)
	while(!QDELETED(target_wound) && !QDELETED(src) && \
		!QDELETED(user) && (target_wound.sew_progress < target_wound.sew_threshold) && \
		stringamt >= 1)
		if(!do_after(doctor, 2 SECONDS, patient))
			break
		playsound(loc, 'sound/foley/sewflesh.ogg', 100, TRUE, -2)
		target_wound.sew_progress = min(target_wound.sew_progress + moveup, target_wound.sew_threshold)
		if(target_wound.sew_progress < target_wound.sew_threshold)
			continue
		if(doctor.mind)
			var/amt2raise = doctor.STAINT * 2
			doctor.adjust_experience(/datum/skill/misc/medicine, amt2raise * boon)
		use(1)
		target_wound.sew_wound()
		if(patient == doctor)
			doctor.visible_message("<span class='notice'>[doctor] sews \a [target_wound.name] on [doctor.p_them()]self.</span>", "<span class='notice'>I stitch \a [target_wound.name] on my [affecting].</span>")
		else
			if(affecting)
				doctor.visible_message("<span class='notice'>[doctor] sews \a [target_wound.name] on [patient]'s [affecting].</span>", "<span class='notice'>I stitch \a [target_wound.name] on [patient]'s [affecting].</span>")
			else
				doctor.visible_message("<span class='notice'>[doctor] sews \a [target_wound.name] on [patient].</span>", "<span class='notice'>I stitch \a [target_wound.name] on [patient].</span>")
		log_combat(doctor, patient, "sew", "needle")
		return TRUE
	return FALSE

/obj/item/needle/thorn
	name = "needle"
	icon_state = "thornneedle"
	desc = "This rough needle can be used to sew cloth and wounds."
	stringamt = 5
	maxstring = 5
	anvilrepair = null

/obj/item/needle/blessed
	name = "blessed needle"
	desc = "<span class='hierophant'>A needle blessed by the ordained Pestrans of the Church. A coveted item, for its thread will never end.</span>"
	infinite = TRUE
	can_repair = TRUE
