/datum/objective/personal/steal_items
	name = "Steal Items"
	category = "Matthios' Chosen"
	triumph_count = 2
	rewards = list("2 Triumphs", "Matthios grows stronger", "Pickpocketing knowledge")
	var/stolen_count = 0
	var/required_count = 3

/datum/objective/personal/steal_items/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ITEM_STOLEN, PROC_REF(on_item_stolen))
	update_explanation_text()

/datum/objective/personal/steal_items/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ITEM_STOLEN)
	return ..()

/datum/objective/personal/steal_items/proc/on_item_stolen(datum/source, mob/living/victim)
	SIGNAL_HANDLER
	if(completed)
		return

	stolen_count++
	if(stolen_count >= required_count)
		to_chat(owner.current, span_greentext("You have stolen enough items to complete Matthios' objective!"))
		owner.current.adjust_triumphs(triumph_count)
		completed = TRUE
		adjust_storyteller_influence(MATTHIOS, 20)
		owner.current.adjust_skillrank(/datum/skill/misc/stealing, 1)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_ITEM_STOLEN)
	else
		to_chat(owner.current, span_notice("Item stolen! Steal [required_count - stolen_count] more to complete Matthios' objective."))

/datum/objective/personal/steal_items/update_explanation_text()
	explanation_text = "Steal [required_count] item\s from others to prove your cunning to Matthios!"
