GLOBAL_LIST_INIT(mined_resource_loc, list())

/datum/round_event_control/collapsing_earth
	name = "Collapsing Earth"
	track = EVENT_TRACK_MODERATE
	typepath = /datum/round_event/collapsing_earth
	weight = 5
	max_occurrences = 8
	min_players = 0
	earliest_start = 25 MINUTES

	tags = list(
		TAG_NATURE,
		TAG_WORK,
	)

/datum/round_event_control/collapsing_earth/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE
	if(!LAZYLEN(GLOB.mined_resource_loc))
		return FALSE

/datum/round_event/collapsing_earth
	var/static/list/weighted_rocks = list(
		/turf/closed/mineral/random/high_nonval = 5,
		/turf/closed/mineral/random/med_nonval = 10,
		/turf/closed/mineral/random/low_nonval = 15,

		/turf/closed/mineral/random/low_valuable = 7,
		/turf/closed/mineral/random/med_valuable = 4,
	)

/datum/round_event/collapsing_earth/start()
	. = ..()
	for(var/i = 1 to rand(1, 25))
		var/turf/open/turf = pick(GLOB.mined_resource_loc)
		turf.try_respawn_mined_chunks(150, weighted_rocks)
