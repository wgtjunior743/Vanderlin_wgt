GLOBAL_VAR_INIT(adventurer_hugbox_duration, 30 SECONDS)
GLOBAL_VAR_INIT(adventurer_hugbox_duration_still, 3 MINUTES)

/datum/job/adventurer
	title = "Adventurer"
	tutorial = "Hero of nothing, adventurer by trade. \
	Whatever led you to this fate is up to the wind to decide, \
	and you've never fancied yourself for much other than the thrill. \
	Someday your pride is going to catch up to you, \
	and you're going to find out why most men don't end up in the annals of history."
	department_flag = OUTSIDERS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK)
	display_order = JDO_ADVENTURER
	faction = FACTION_FOREIGNERS
	total_positions = 14
	spawn_positions = 14
	min_pq = 2
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL

	outfit = null
	outfit_female = null
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 15 MINUTES
	advclass_cat_rolls = list(CTAG_ADVENTURER = 15)
	is_foreigner = TRUE
	can_have_apprentices = FALSE
	scales = TRUE

/datum/outfit/adventurer // Reminder message
	var/merc_ad = "<br><font color='#855b14'><span class='bold'>If I wanted to make mammons by selling my services, or completing quests, the Mercenary guild would be a good place to start.</span></font><br>"

/datum/outfit/adventurer/post_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, merc_ad)

/datum/job/adventurer/set_spawn_and_total_positions(count)
	// Calculate the potential new spawn positions
	var/new_spawn = adventurer_slot_formula(count)

	// Never reduce spawn_positions
	spawn_positions = new_spawn
	total_positions_so_far = new_spawn
	total_positions = new_spawn

	return spawn_positions

/datum/job/adventurer/get_total_positions()
	var/slots = adventurer_slot_formula(get_total_town_members())

	if(slots <= total_positions_so_far)
		slots = total_positions_so_far
	else
		total_positions_so_far = slots

	return slots
