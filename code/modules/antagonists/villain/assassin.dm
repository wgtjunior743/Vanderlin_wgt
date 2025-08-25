// Assassin, cultist of graggar. Normally found as a drifter.
/datum/antagonist/assassin
	name = "Assassin"
	roundend_category = "assassins"
	antagpanel_category = "Assassin"
	antag_hud_type = ANTAG_HUD_ASSASSIN
	antag_hud_name = "assassin"
	show_name_in_check_antagonists = TRUE
	confess_lines = list(
		"MY CREED IS BLOOD!",
		"THE DAGGER TOLD ME WHO TO CUT!",
		"DEATH IS MY DEVOTION!",
		"THE DARK SUN GUIDES MY HAND!",
	)
	antag_flags = FLAG_FAKE_ANTAG

	innate_traits = list(
		TRAIT_ASSASSIN,
		TRAIT_NOSTINK,
		TRAIT_VILLAIN,
		TRAIT_DODGEEXPERT,
		TRAIT_STEELHEARTED,
		TRAIT_STRONG_GRABBER,
	)

/datum/antagonist/assassin/on_gain()
	owner.current.cmode_music = list('sound/music/cmode/antag/CombatAssassin.ogg')
	if(owner.current.job != "Drifter") // This code only runs if the assassin is assigned midround and is not a drifter.
		owner.current.set_patron(/datum/patron/inhumen/graggar, TRUE)
		var/old_knife_skill = owner.current.get_skill_level(/datum/skill/combat/knives)
		var/old_sneak_skill = owner.current.get_skill_level(/datum/skill/misc/sneaking)
		if(old_knife_skill < 4) // If the assassined player has less than 4 knife skill, get them to 4.
			owner.current.adjust_skillrank(/datum/skill/combat/knives, 4 - old_knife_skill, TRUE)
		if(old_sneak_skill < 5) // If the assassined player has less than 5 sneak skill, get them to 5.
			owner.current.adjust_skillrank(/datum/skill/misc/sneaking, 5 - old_sneak_skill, TRUE)
		var/yea = /obj/item/weapon/knife/dagger/steel/profane
		owner.special_items["Profane Dagger"] = yea // Assigned assassins can get their special dagger from right clicking certain objects.
		to_chat(owner.current, "<span class='danger'>I've blended in well up until this point, but it's time for the Hunted of Graggar to perish. I must get my dagger from where I hid it.</span>")
	return ..()

/mob/living/carbon/human/proc/who_targets() // Verb for the assassin to remember their targets.
	set name = "Remember Targets"
	set category = "Graggar"
	if(!mind)
		return
	mind.recall_targets(src)

/datum/antagonist/assassin/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current,"<span class='danger'>The red fog in my mind is fading. I am no longer an [name]!</span>")
	return ..()

/datum/antagonist/assassin/on_life(mob/user)
	if(!user)
		return
	var/mob/living/carbon/human/H = user
	H.verbs |= /mob/living/carbon/human/proc/who_targets

/datum/antagonist/assassin/roundend_report()
	var/traitorwin = FALSE
	for(var/obj/item/I in owner.current) // Check to see if the Assassin has their profane dagger on them, and then check the souls contained therein.
		if(istype(I, /obj/item/weapon/knife/dagger/steel/profane))
			for(var/mob/dead/observer/profane/A in I) // Each trapped soul is announced to the server
				if(A)
					to_chat(world, "The [A.name] has been stolen for Graggar by [owner.name].<span class='greentext'>DAMNATION!</span>")
					traitorwin = TRUE

	if(!considered_alive(owner))
		traitorwin = FALSE

	if(traitorwin)
		to_chat(world, "<span class='greentext'>The [name] [owner.name] has TRIUMPHED!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, "<span class='redtext'>The [name] [owner.name] has FAILED!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)
