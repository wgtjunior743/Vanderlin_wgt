/datum/round_event_control/xylix_fortune
	name = "Xylix's Fortune"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/xylix_fortune
	weight = 8
	earliest_start = 15 MINUTES
	max_occurrences = 1
	min_players = 30
	dedicated_storytellers = list(/datum/storyteller/xylix)
	allowed_storytellers = DIVINE_STORYTELLERS

	tags = list(
		TAG_XYLIX,
	)

/datum/round_event_control/xylix_fortune/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE
	if(GLOB.patron_follower_counts["Xylix"] < 2)
		return FALSE

/datum/round_event/xylix_fortune/start()
	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue

		if(!human_mob.patron || (!is_ascendant(XYLIX) && !istype(human_mob.patron, /datum/patron/divine/xylix)))
			continue

		var/luck_roll = rand(-2, 4)
		human_mob.set_stat_modifier("xylix_fortune", STATKEY_LCK, luck_roll)

		bordered_message(human_mob, list(
			span_biginfo("You have caught Xylix's attention and you can feel your fortune changing... Whether you'll laugh or weep about it later... well, that's part of the fun!")
		))
		human_mob.playsound_local(human_mob, 'sound/misc/gods/xylix_omen_male_female.ogg', 100)
