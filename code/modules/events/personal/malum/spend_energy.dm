/datum/round_event_control/spend_energy
	name = "Work Hard"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/spend_energy
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 15

	tags = list(
		TAG_WORK,
	)

/datum/round_event_control/spend_energy/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/malum))
			continue
		return TRUE

	return FALSE

/datum/round_event/spend_energy/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/malum))
			continue
		valid_targets += human_mob

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/personal/energy_expenditure/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE MALUM'S CHOSEN!"))
	to_chat(chosen_one, span_notice("There is an honor in hard toil! Spend enough energy working to earn Malum's approval!"))
	chosen_one.playsound_local(chosen_one, 'sound/magic/dwarf_chant01.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
