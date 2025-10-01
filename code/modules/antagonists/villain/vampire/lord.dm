/datum/antagonist/vampire/lord
	name = "Vampire Lord"
	antag_hud_type = ANTAG_HUD_VAMPIRE
	antag_hud_name = "vamplord"
	confess_lines = list(
		"I AM ANCIENT!",
		"I AM THE LAND!",
		"FIRSTBORNE CHILD OF KAIN!",
	)

	var/ascended = FALSE

/datum/antagonist/vampire/lord/on_gain()
	var/mob/living/carbon/vampire = owner.current
	remove_job()
	owner.current?.roll_mob_stats()
	owner.current?.purge_combat_knowledge()
	. = ..()
	addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "[name]"), 5 SECONDS)
	vampire.grant_undead_eyes()

/datum/antagonist/vampire/lord/greet()
	to_chat(owner.current, span_userdanger("I am ancient. I am the Land. And I am now awoken to trespassers upon my domain."))
	. = ..()

/datum/antagonist/vampire/lord/equip()
	. = ..()

	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Vampire Spawn"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)
	for(var/datum/mind/MF in get_minds("Death Knight"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

	var/mob/living/carbon/human/H = owner.current
	H.equipOutfit(/datum/outfit/vamplord)
	H.set_patron(/datum/patron/godless/autotheist)

	return TRUE

/datum/antagonist/vampire/lord/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.vlord_starts))

/datum/outfit/vamplord/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/magic/blood, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
	H.clamped_adjust_skillrank(/datum/skill/combat/unarmed, 4, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	pants = /obj/item/clothing/pants/tights/colored/black
	shirt = /obj/item/clothing/shirt/vampire
	belt = /obj/item/storage/belt/leather/plaquegold
	head  = /obj/item/clothing/head/vampire
	beltl = /obj/item/key/vampire
	cloak = /obj/item/clothing/cloak/cape/puritan
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel/black
	if(!(HAS_TRAIT(H, TRAIT_FOREIGNER)))
		ADD_TRAIT(H, TRAIT_FOREIGNER, TRAIT_GENERIC)
/*------VERBS-----*/

// NEW VERBS
/mob/living/carbon/human/proc/demand_submission()
	set name = "Demand Submission"
	set category = "VAMPIRE"
	if(SSmapping.retainer.king_submitted)
		to_chat(src, span_warning("I am already the Master of [SSmapping.config.map_name]."))
		return

	var/mob/living/carbon/ruler = SSticker.rulermob

	if(!ruler || (get_dist(src, ruler) > 1))
		to_chat(src, span_warning("The Master of [SSmapping.config.map_name] is not beside me."))
		return

	if(ruler.stat <= CONSCIOUS)
		to_chat(src, span_warning("[ruler] is still conscious."))
		return

	switch(alert(ruler, "Submit and Pledge Allegiance to [name]?", "SUBMISSION", "Yes", "No"))
		if("Yes")
			SSmapping.retainer.king_submitted = TRUE
		if("No")
			to_chat(ruler, span_boldnotice("I refuse!"))
			to_chat(src, span_boldnotice("[p_they(TRUE)] refuse[ruler.p_s()]!"))

/mob/living/carbon/human/proc/punish_spawn()
	set name = "Punish Minion"
	set category = "VAMPIRE"

	var/list/possible = list()
	for(var/datum/mind/V in SSmapping.retainer.vampires)
		if(V.special_role == "Vampire Spawn")
			possible[V.current.real_name] = V.current
	for(var/datum/mind/D in SSmapping.retainer.death_knights)
		possible[D.current.real_name] = D.current
	var/name_choice = input(src, "Who to punish?", "PUNISHMENT") as null|anything in possible
	if(!name_choice)
		return
	var/mob/living/carbon/human/choice = possible[name_choice]
	if(!choice || QDELETED(choice))
		return
	var/punishmentlevels = list("Pause", "Pain", "DESTROY")
	var/punishment = input(src, "Severity?", "PUNISHMENT") as null|anything in punishmentlevels
	if(!punishment)
		return
	switch(punishment)
		if("Pain")
			to_chat(choice, span_boldnotice("You are wracked with pain as your master punishes you!"))
			choice.apply_damage(30, BRUTE)
			choice.emote_scream()
			playsound(choice, 'sound/misc/obey.ogg', 100, FALSE, pressure_affected = FALSE)
		if("Pause")
			to_chat(choice, span_boldnotice("Your body is frozen in place as your master punishes you!"))
			choice.Paralyze(300)
			choice.emote_scream()
			playsound(choice, 'sound/misc/obey.ogg', 100, FALSE, pressure_affected = FALSE)
		if("DESTROY")
			to_chat(choice, span_boldnotice("You feel only darkness. Your master no longer has use of you."))
			addtimer(CALLBACK(choice, TYPE_PROC_REF(/mob/living, dust)), 10 SECONDS)
	visible_message(span_danger("[src] reaches out, gripping [choice]'s soul, inflicting punishment!"), ignored_mobs = list(choice))

/mob/proc/death_knight_spawn()
	SEND_SOUND(src, sound('sound/misc/notice (2).ogg'))
	if(alert(src, "A Vampire Lord is summoning you from the Underworld.", "Be Risen?", "Yes", "No") == "Yes")
		if(!has_world_trait(/datum/world_trait/death_knight))
			to_chat(src, span_warning("Another soul was chosen."))
		returntolobby()
