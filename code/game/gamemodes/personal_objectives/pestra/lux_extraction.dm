/datum/objective/personal/lux_extraction
	name = "Extract Lux"
	category = "Pestra's Chosen"
	triumph_count = 2
	rewards = list("2 Triumphs", "Pestra grows stronger", "Medicine knowledge")

/datum/objective/personal/lux_extraction/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_LUX_EXTRACTED, PROC_REF(on_lux_extracted))
	update_explanation_text()

/datum/objective/personal/lux_extraction/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_LUX_EXTRACTED)
	return ..()

/datum/objective/personal/lux_extraction/proc/on_lux_extracted(datum/source, mob/living/target)
	SIGNAL_HANDLER
	if(completed)
		return

	to_chat(owner.current, span_greentext("You have extracted lux and completed Pestra's objective!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence(PESTRA, 20)
	owner.current.adjust_skillrank(/datum/skill/misc/medicine, 1)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_LUX_EXTRACTED)

/datum/objective/personal/lux_extraction/update_explanation_text()
	explanation_text = "Extract lux from a living being to sate Pestra's curiosity!"
