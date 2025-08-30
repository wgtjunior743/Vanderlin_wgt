/datum/anvil_recipe
	abstract_type = /datum/anvil_recipe
	var/name
	var/category = "Misc"
	var/list/additional_items = list() // List of the object(s) we need to complete this recipe.
	var/material_quality = 0 // Quality of the bar(s) used. Accumulated per added ingot.
	var/num_of_materials = 1 // Total number of materials used. Quality divided among them.
	var/skill_quality = 0 // Accumulated per hit based on calculations, will decide final result.
	var/appro_skill = /datum/skill/craft/blacksmithing // The skill that will be taken into account when crafting.
	var/atom/req_bar // The material of the ingot we need to craft.
	var/atom/created_item // The item created when the recipe is fulfilled. Takes an object path as argument, NEVER USE A LIST.
	var/createditem_extra = 0 // How many EXTRA units this recipe will create. At 1, this creates 2 copies.
	var/craftdiff = 0 // Difficulty of craft. Affects final item quality and chance to advance steps.
	var/needed_item // What item(s) we need to add to proceed to the next step. Draws from the list on var/additional_items.
	var/needed_item_text // Name of the object we need to slap on the anvil to proceed to the next step.
	var/progress = 0 // 0 to 100%, percentage of completion on this step of crafting (or overall if no extra items required)
	var/i_type // Category of crafted item. Will determine how it shows on the crafting menu window.
	var/recipe_name // This is what will be shown when you
	var/bar_health = 100 // Current material bar health, reduced by failures. At 0 HP it is deleted.
	var/numberofhits = 0 // Increased every time you hit the bar, the more you have to hit the bar the less quality of the product.
	var/numberofbreakthroughs = 0 // How many good hits we got on the metal, advances recipes 50% faster, reduces number of hits total, and restores bar_health
	var/datum/parent // The ingot we're currently working on.
	var/rotations_required = 1

/datum/anvil_recipe/New(datum/P, ...)
	parent = P
	. = ..()

/datum/anvil_recipe/Destroy(force, ...)
	additional_items.Cut()
	parent = null
	req_bar = null
	created_item = null
	return ..()

/datum/anvil_recipe/proc/advance(mob/user, breakthrough = FALSE)
	var/moveup = 1
	var/proab = 0 // Probability to not spoil the bar
	var/skill_level	= user.get_skill_level(appro_skill)
	if(progress == 100)
		to_chat(user, "<span class='info'>It's ready.</span>")
		user.visible_message("<span class='warning'>[user] strikes the bar!</span>")
		return FALSE
	if(needed_item)
		to_chat(user, "<span class='info'>Now it's time to add a [needed_item_text].</span>")
		user.visible_message("<span class='warning'>[user] strikes the bar!</span>")
		return FALSE
	// Calculate probability of fucking up, based on smith's skill level
	if(!skill_level)
		proab = 25
	else if(skill_level < 4)
		proab = 33 * skill_level
	else // No good smith start with skill levels lower than 3
		proab = 100
	proab -= craftdiff // Crafting difficulty substracts from your chance to advance
	if(has_world_trait(/datum/world_trait/delver))
		proab = 100
	// Roll the dice to see if the hit actually causes to accumulate progress
	if(prob(proab))
		moveup += round((skill_level * 6) * (breakthrough == 1 ? 1.5 : 1))
		moveup -= craftdiff
		progress = min(progress + moveup, 100)
		numberofhits++
	else
		moveup = 0
		numberofhits++ // Increase regardless of success

	// This step is finished, check if more items are needed and restart the process
	if(progress == 100 && additional_items.len)
		needed_item = pick(additional_items)
		var/obj/item/I = new needed_item()
		needed_item_text = I.name
		qdel(I)
		additional_items -= needed_item
		progress = 0

	if(!moveup)
		if(!prob(proab)) // Roll again, this time negatively, for consequences.
			user.visible_message("<span class='warning'>[user] strikes poorly!</span>")
			skill_quality -= 0.5
			bar_health -= craftdiff / 1.2
			if(parent)
				var/obj/item/P = parent
				switch(skill_level)
					if(0)
						bar_health -= 20 // 5 bad hits and ruined.
					if(1 to 3)
						bar_health -= floor(20 / skill_level)
					if(4)
						bar_health -= 5
					if(5 to 6)
						var/mob/living/L = user
						if(L.stat_roll(STATKEY_LCK,4,10,TRUE)) // Unlucky, not unskilled.
							bar_health -= craftdiff / 1.2
				if(bar_health <= 0)
					user.visible_message("<span class='danger'>[user] destroys the bar!</span>")
					qdel(P)
			return FALSE
		else
			user.visible_message("<span class='warning'>[user] almost fumbles but recovers!</span>")
			return FALSE

	else
		if(user.mind && isliving(user))
			var/mob/living/L = user
			var/amt2raise = L.STAINT // It would be impossible to level up otherwise
			var/boon = user.get_learning_boon(appro_skill)
			if(amt2raise > 0)
				if(!HAS_TRAIT(user, TRAIT_MALUMFIRE))
					skill_quality += (rand(skill_level*6, skill_level*15) * moveup) // Lesser quality for self-learned non-professional smiths by trade
					if(skill_level < 3) // Non-blacksmith jobs can't level past 3. Ever.
						user.mind.add_sleep_experience(appro_skill, floor(amt2raise * boon), FALSE)
				else
					skill_quality += (rand(skill_level*8, skill_level*17) * moveup)
					if(skill_level < 3)
						amt2raise /= 2 // Let's not get out of hand it's for lower levels with high chances of failure
						user.mind.add_sleep_experience(appro_skill, amt2raise * boon, FALSE)
					else // Sanity, no expert blacksmith has lower skill than 3, for if admins manually add the trait or blacksmith vampire thralls
						user.mind.add_sleep_experience(appro_skill, amt2raise, FALSE)

		if(breakthrough)
			user.visible_message("<span class='deadsay'>[user] deftly strikes the bar!</span>")
			if(bar_health < 100)
				bar_health += 20 // Correcting the mistakes, ironing the kinks. Low chance, so rewarding.
		else
			user.visible_message("<span class='info'>[user] strikes the bar!</span>")
		return TRUE

/datum/anvil_recipe/proc/item_added(mob/user)
	needed_item = null
	user.visible_message("<span class='info'>[user] adds a [needed_item_text].</span>")
	needed_item_text = null


/datum/anvil_recipe/proc/handle_creation(obj/item/I)
	var/datum/quality_calculator/blacksmithing/quality_calc = new(
		base_qual = 0,
		mat_qual = material_quality,
		skill_qual = skill_quality,
		perf_qual = numberofhits,
		diff_mod = craftdiff,
		components = num_of_materials
	)
	if(numberofbreakthroughs)
		quality_calc.performance_quality -= numberofbreakthroughs
	quality_calc.apply_quality_to_item(I, TRUE) // TRUE enables masterwork tracking
	qdel(quality_calc)

/datum/anvil_recipe/proc/show_menu(mob/user)
	user << browse(generate_html(user),"window=recipe;size=500x810")

/datum/anvil_recipe/proc/generate_html(mob/user)
	var/client/client = user
	if(!istype(client))
		client = user.client
	SSassets.transport.send_assets(client, list("try4_border.png", "try4.png", "slop_menustyle2.css"))
	user << browse_rsc('html/book.png')
	var/html = {"
		<!DOCTYPE html>
		<html lang="en">
		<meta charset='UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>

		<style>
			@import url('https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap');
			body {
				font-family: "Charm", cursive;
				font-size: 1.2em;
				text-align: center;
				margin: 20px;
				background-color: #f4efe6;
				color: #3e2723;
				background-color: rgb(31, 20, 24);
				background:
					url('[SSassets.transport.get_asset_url("try4_border.png")]'),
					url('book.png');
				background-repeat: no-repeat;
				background-attachment: fixed;
				background-size: 100% 100%;

			}
			h1 {
				text-align: center;
				font-size: 2em;
				border-bottom: 2px solid #3e2723;
				padding-bottom: 10px;
				margin-bottom: 10px;
			}
			.icon {
				width: 64px;
				height: 64px;
				vertical-align: middle;
				margin-right: 10px;
			}
		</style>
		<body>
		  <div>
		    <h1>[name]</h1>
		    <div>
		      <h1>Steps</h1>
		"}
	html += "[icon2html(new req_bar, user)] Start with [initial(req_bar.name)] on an anvil.<br>"
	html += "Hammer the material.<br>"
	for(var/atom/path as anything in additional_items)
		html += "[icon2html(new path, user)] then add [initial(path.name)]<br>"
		html += "Hammer the material.<br>"
	html += "<br>"

	html += {"
		</div>
		<div>
		"}

	html += "<strong class=class='scroll'>and then you get</strong> <br> [icon2html(new created_item, user)] <br> [createditem_extra + 1] [initial(created_item.name)]\s<br>"

	html += {"
		</div>
		</div>
	</body>
	</html>
	"}
	return html
