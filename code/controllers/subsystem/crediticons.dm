GLOBAL_LIST_EMPTY(credits_icons)

SUBSYSTEM_DEF(crediticons)
	name = "crediticons"
	wait = 60
	flags = SS_NO_INIT
	priority = 1
	var/list/processing_mob = list()
	var/list/processing_client = list()
	var/list/currentrun_mob = list()
	var/list/currentrun_client = list()

/datum/controller/subsystem/crediticons/fire(resumed = 0)
	if(!resumed)
		src.currentrun_mob = processing_mob.Copy()
		src.currentrun_client = processing_client.Copy()

	var/list/currentrun_mob = src.currentrun_mob
	var/list/currentrun_client = src.currentrun_client

	while(length(currentrun_mob))
		var/mob/living/carbon/human/thing = currentrun_mob[length(currentrun_mob)]
		var/client/mob_client = currentrun_client[length(currentrun_client)]

		currentrun_mob.len--
		currentrun_client.len--

		if(QDELETED(thing))
			var/index = processing_mob.Find(thing)
			if(index)
				processing_mob.Cut(index, index + 1)
				processing_client.Cut(index, index + 1)
			if(MC_TICK_CHECK)
				return
			continue

		add_credit(thing, mob_client)
		var/index = processing_mob.Find(thing)
		if(index)
			processing_mob.Cut(index, index + 1)
			processing_client.Cut(index, index + 1)
		if(MC_TICK_CHECK)
			return
/datum/controller/subsystem/crediticons/proc/add_credit(mob/living/carbon/human/actor, client/mob_client)
	if(!actor.mind || !mob_client)
		return
	var/datum/mind/actor_mind = actor.mind
	var/datum/job/job = actor_mind.assigned_role
	var/datum/preferences/preferences = mob_client.prefs
	if(!preferences)
		return

	var/thename = "[actor.real_name]"
	var/used_title = job.get_informed_title(actor)
	if(used_title)
		thename = "[thename]\nthe [used_title]"

	GLOB.credits_icons[thename] = list()
	var/icon/rendered_icon = get_flat_human_icon(null, job, preferences, DUMMY_HUMAN_SLOT_MANIFEST, list(SOUTH))
	if(rendered_icon)
		var/icon/female_s = icon("icon"='icons/mob/clothing/under/masking_helpers.dmi', "icon_state"="credits")
		rendered_icon.Blend(female_s, ICON_MULTIPLY)
		rendered_icon.Scale(96,96)
		GLOB.credits_icons[thename]["icon"] = rendered_icon
		GLOB.credits_icons[thename]["vc"] = actor.voice_color

/datum/controller/subsystem/crediticons/proc/get_credit_icon(mob/living/carbon/human/target, crop_to_upper_half = FALSE)
	if(!target || !istype(target) || !target.mind || !target.client)
		return null

	var/credit_name = "[target.real_name]"
	if(target.original_name)
		credit_name = "[target.original_name]"
	if(target.mind.assigned_role)
		var/datum/job/job = target.mind.assigned_role
		var/used_title = job.get_informed_title(target)
		if(job.parent_job)
			used_title = job.parent_job.get_informed_title(target)
		if(used_title)
			credit_name = "[credit_name]\nthe [used_title]"

	if(!GLOB.credits_icons[credit_name]?["icon"])
		return null

	var/icon/credit_icon = GLOB.credits_icons[credit_name]["icon"]

	if(crop_to_upper_half)
		var/icon/cropped_icon = icon(credit_icon)
		cropped_icon.Crop(1, 49, 96, 96)
		return cropped_icon

	return credit_icon
