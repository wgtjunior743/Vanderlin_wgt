/datum/examine_effect/proc/trigger(mob/user)
	return

/datum/examine_effect/proc/get_examine_line(mob/user)
	return

/obj/item/examine(mob/user) //This might be spammy. Remove?
	. = ..()
	var/price_text = get_displayed_price(user)
	if(uses_integrity)
		if(atom_integrity < max_integrity)
			var/meme = round(((atom_integrity / max_integrity) * 100), 1)
			switch(meme)
				if(0 to 1)
					. += "<span class='warning'>It's broken.</span>"
				if(1 to 10)
					. += "<span class='warning'>It's nearly broken.</span>"
				if(10 to 30)
					. += "<span class='warning'>It's severely damaged.</span>"
				if(30 to 80)
					. += "<span class='warning'>It's damaged.</span>"
				if(80 to 99)
					. += "<span class='warning'>It's a little damaged.</span>"

//	if(has_inspect_verb || (obj_integrity < max_integrity))
//		. += "<span class='notice'><a href='byond://?src=[REF(src)];inspect=1'>Inspect</a></span>"

	if(price_text)
		. += price_text

// Only show if it's actually useable as bait, so that it doesn't show up on every single item of the game.
	if(isbait)
		var/baitquality = ""
		switch(baitpenalty)
			if(0)
				baitquality = "excellent"
			if(5)
				baitquality = "good"
			if(10)
				baitquality = "passable"
		. += "<span class='info'>It is \a [baitquality] bait for fish.</span>"

	for(var/datum/examine_effect/E in examine_effects)
		E.trigger(user)

	if(item_weight || get_stored_weight())
		. += "It weighs around [round(item_weight + get_stored_weight(), 0.1)]KG."
