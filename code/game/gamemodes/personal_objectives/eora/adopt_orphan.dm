/datum/objective/personal/adopt_orphan
	name = "Adopt Orphan"
	category = "Eora's Chosen"
	triumph_count = 3
	immediate_effects = list("Gained an ability to adopt children")
	rewards = list("3 Triumphs", "Eora grows stronger")

/datum/objective/personal/adopt_orphan/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ORPHAN_ADOPTED, PROC_REF(on_orphan_adopted))
	update_explanation_text()

/datum/objective/personal/adopt_orphan/Destroy()
	UnregisterSignal(owner.current, COMSIG_ORPHAN_ADOPTED)
	return ..()

/datum/objective/personal/adopt_orphan/proc/on_orphan_adopted(datum/source, mob/new_child)
	SIGNAL_HANDLER
	if(completed)
		return

	to_chat(owner.current, span_greentext("You've adopted a child, completing Eora's objective!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence(EORA, 20)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_ORPHAN_ADOPTED)

/datum/objective/personal/adopt_orphan/update_explanation_text()
	explanation_text = "Adopt an orphan as your own child and provide them a loving home! Eora is counting on you!"
