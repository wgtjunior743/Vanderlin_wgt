/datum/objective/personal/hug_beggar
	name = "Hug a Beggar"
	category = "Eora's Chosen"
	triumph_count = 2
	rewards = list("2 Triumphs", "Eora grows stronger", "Become more empathetic")

/datum/objective/personal/hug_beggar/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_MOB_HUGGED, PROC_REF(on_hug))
	update_explanation_text()

/datum/objective/personal/hug_beggar/Destroy()
	UnregisterSignal(owner.current, COMSIG_MOB_HUGGED)
	return ..()

/datum/objective/personal/hug_beggar/proc/on_hug(datum/source, mob/living/target)
	SIGNAL_HANDLER
	if(completed)
		return

	if(target.job == "Beggar" || istype(target.mind?.assigned_role, /datum/job/vagrant))
		to_chat(owner.current, span_greentext("You've hugged a beggar, completing Eora's objective!"))
		owner.current.adjust_triumphs(triumph_count)
		completed = TRUE
		adjust_storyteller_influence(EORA, 20)
		ADD_TRAIT(owner.current, TRAIT_EMPATH, TRAIT_GENERIC)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_MOB_HUGGED)

/datum/objective/personal/hug_beggar/update_explanation_text()
	explanation_text = "Everyone deserves love! Hug a beggar to please Eora!"
