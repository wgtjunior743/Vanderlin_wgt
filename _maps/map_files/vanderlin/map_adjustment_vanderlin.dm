/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

/datum/map_adjustment/vanderlin
	map_file_name = "vanderlin.dmm"
	blacklist = list(
		/datum/job/advclass/royalknight/arcane,
	)
