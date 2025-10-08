/datum/objective/personal/torture
	name = "Extract Truth Through Pain"
	category = "Zizo's Chosen"
	triumph_count = 3
	immediate_effects = list("Gained an ability to torture others for information")
	rewards = list("3 Triumphs", "Zizo grows stronger")
	var/torture_count = 0
	var/required_count = 1

/datum/objective/personal/torture/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_TORTURE_PERFORMED, PROC_REF(on_torture_performed))
	update_explanation_text()

/datum/objective/personal/torture/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_TORTURE_PERFORMED)
	return ..()

/datum/objective/personal/torture/proc/on_torture_performed(datum/source, mob/living/victim)
	SIGNAL_HANDLER
	if(completed)
		return

	torture_count++
	if(torture_count >= required_count)
		complete_objective(victim)

/datum/objective/personal/torture/proc/complete_objective(mob/living/victim)
	to_chat(owner.current, span_greentext("You have extracted the truth through pain, satisfying Zizo!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence(ZIZO, 20)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_TORTURE_PERFORMED)

/datum/objective/personal/torture/update_explanation_text()
	explanation_text = "Torture someone until they beg for mercy to please Zizo!"
