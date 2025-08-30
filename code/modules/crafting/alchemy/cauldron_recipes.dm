/datum/alch_cauldron_recipe
	abstract_type = /datum/alch_cauldron_recipe
	var/category = "Potions"
	var/recipe_name = ""
	var/smells_like = "nothing"
	var/list/output_reagents = list()
	var/list/output_items = list()
	var/list/required_essences = list()

/datum/alch_cauldron_recipe/proc/generate_html(mob/user)
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
			.requirements {
				margin-bottom: 20px;
			}
			.category {
				font-style: italic;
				color: #8d6e63;
				margin-bottom: 10px;
			}
			.smells {
				margin-top: 15px;
				font-style: italic;
				color: #5d4037;
			}
		</style>
		<body>
		  <div>
			<h1>[recipe_name]</h1>
			<div class="category">[category]</div>
			<div class="requirements">
			  <h2>Required Essences</h2>
	"}

	// Add required essences
	if(length(required_essences))
		for(var/datum/thaumaturgical_essence/essence_type as anything in required_essences)
			var/essence_amount = required_essences[essence_type]
			html += "[essence_amount] parts [essence_type.name]<br>"
	else
		html += "No essences required<br>"

	html += {"
		</div>
		<div>
			<h2>Requires 10oz Water</h2>
			<h2>Creates</h2>
	"}

	// Add output reagents
	if(length(output_reagents))
		html += "<strong>Reagents:</strong><br>"
		for(var/reagent_type in output_reagents)
			var/reagent_amount = output_reagents[reagent_type]
			var/datum/reagent/R = new reagent_type
			html += "[CEILING(reagent_amount / 3, 1)] oz of [initial(R.name)]<br>"
			qdel(R)

	// Add output items
	if(length(output_items))
		html += "<strong>Items:</strong><br>"
		for(var/atom/item_type as anything in output_items)
			var/item_amount = output_items[item_type]
			html += "[icon2html(new item_type, user)] [item_amount] [initial(item_type.name)]<br>"

	if(smells_like != "nothing")
		html += "<div class='smells'><strong>Smells like:</strong> [smells_like]</div>"

	html += {"
		</div>
		</div>
	</body>
	</html>
	"}

	return html

/datum/alch_cauldron_recipe/proc/show_menu(mob/user)
	user << browse(generate_html(user), "window=alch_cauldron_recipe;size=500x810")


/datum/alch_cauldron_recipe/proc/matches_essences(list/available_essences)
	for(var/essence_type in required_essences)
		var/required_amount = required_essences[essence_type]
		var/available_amount = available_essences[essence_type]

		if(!available_amount || available_amount < required_amount)
			return FALSE

	for(var/essence_type in available_essences)
		if(!(essence_type in required_essences))
			return FALSE // Recipe doesn't allow this essence

	return TRUE

/datum/alch_cauldron_recipe/disease_cure
	recipe_name = "Disease Cure"
	smells_like = "purity"
	output_reagents = list(/datum/reagent/medicine/diseasecure = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/order = 3,
		/datum/thaumaturgical_essence/life = 2,
		/datum/thaumaturgical_essence/earth = 1
	)

/datum/alch_cauldron_recipe/antidote
	recipe_name = "Antidote"
	smells_like = "wet moss"
	output_reagents = list(/datum/reagent/medicine/antidote = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 3,
		/datum/thaumaturgical_essence/water = 2
	)

/datum/alch_cauldron_recipe/berrypoison
	recipe_name = "Poison"
	smells_like = "death"
	output_reagents = list(/datum/reagent/berrypoison = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/poison = 4,
		/datum/thaumaturgical_essence/chaos = 1
	)

/datum/alch_cauldron_recipe/doompoison
	recipe_name = "Doom Poison"
	smells_like = "doom"
	output_reagents = list(/datum/reagent/strongpoison = 6, /datum/reagent/additive = 6)
	required_essences = list(
		/datum/thaumaturgical_essence/poison = 6,
		/datum/thaumaturgical_essence/void = 3,
		/datum/thaumaturgical_essence/chaos = 2
	)

/datum/alch_cauldron_recipe/stam_poison
	recipe_name = "Stamina Poison"
	smells_like = "a slow breeze"
	output_reagents = list(/datum/reagent/stampoison = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/poison = 3,
		/datum/thaumaturgical_essence/void = 2
	)

/datum/alch_cauldron_recipe/big_stam_poison
	recipe_name = "Strong Stamina Poison"
	smells_like = "stagnant air"
	output_reagents = list(/datum/reagent/stampoison = 18, /datum/reagent/additive = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/poison = 5,
		/datum/thaumaturgical_essence/void = 4,
		/datum/thaumaturgical_essence/chaos = 1
	)

/datum/alch_cauldron_recipe/gender_potion
	recipe_name = "Gender Potion"
	smells_like = "living beings"
	output_reagents = list(/datum/reagent/medicine/gender_potion = 9)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 4,
		/datum/thaumaturgical_essence/chaos = 3,
		/datum/thaumaturgical_essence/cycle = 2
	)

// Healing potions
/datum/alch_cauldron_recipe/health_potion
	recipe_name = "Elixir of Health"
	smells_like = "sweet berries"
	output_reagents = list(/datum/reagent/medicine/healthpot = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 4,
		/datum/thaumaturgical_essence/order = 1
	)

/datum/alch_cauldron_recipe/big_health_potion
	recipe_name = "Strong Elixir of Health"
	smells_like = "berry pie"
	output_reagents = list(/datum/reagent/medicine/healthpot = 18, /datum/reagent/additive = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 6,
		/datum/thaumaturgical_essence/order = 3,
		/datum/thaumaturgical_essence/energia = 1
	)

/datum/alch_cauldron_recipe/rosawater_potion
	recipe_name = "Rose Water"
	smells_like = "roses"
	output_reagents = list(/datum/reagent/medicine/rosawater = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 3,
		/datum/thaumaturgical_essence/water = 2,
		/datum/thaumaturgical_essence/order = 1
	)

/datum/alch_cauldron_recipe/mana_potion
	recipe_name = "Arcane Elixir"
	smells_like = "power"
	output_reagents = list(/datum/reagent/medicine/manapot = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/magic = 3,
		/datum/thaumaturgical_essence/energia = 2
	)

/datum/alch_cauldron_recipe/big_mana_potion
	recipe_name = "Powerful Arcane Elixir"
	smells_like = "fear"
	output_reagents = list(/datum/reagent/medicine/manapot = 18, /datum/reagent/additive = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/magic = 5,
		/datum/thaumaturgical_essence/energia = 4,
		/datum/thaumaturgical_essence/chaos = 1
	)

/datum/alch_cauldron_recipe/stamina_potion
	recipe_name = "Stamina Elixir"
	smells_like = "fresh air"
	output_reagents = list(/datum/reagent/medicine/stampot = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/air = 3,
		/datum/thaumaturgical_essence/motion = 2
	)

/datum/alch_cauldron_recipe/big_stamina_potion
	recipe_name = "Powerful Stamina Elixir"
	smells_like = "clean winds"
	output_reagents = list(/datum/reagent/medicine/stampot = 18, /datum/reagent/additive = 18)
	required_essences = list(
		/datum/thaumaturgical_essence/air = 5,
		/datum/thaumaturgical_essence/motion = 4,
		/datum/thaumaturgical_essence/energia = 1
	)

// S.P.E.C.I.A.L. potions
/datum/alch_cauldron_recipe/str_potion
	recipe_name = "Potion of Mountain Muscles"
	smells_like = "petrichor"
	output_reagents = list(/datum/reagent/buff/strength = 9)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 4,
		/datum/thaumaturgical_essence/order = 2,
		/datum/thaumaturgical_essence/crystal = 1
	)

/datum/alch_cauldron_recipe/per_potion
	recipe_name = "Potion of Keen Eye"
	smells_like = "fire"
	output_reagents = list(/datum/reagent/buff/perception = 9)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 3,
		/datum/thaumaturgical_essence/light = 3,
		/datum/thaumaturgical_essence/order = 1
	)

/datum/alch_cauldron_recipe/end_potion
	recipe_name = "Potion of Enduring Fortitude"
	smells_like = "mountain air"
	output_reagents = list(/datum/reagent/buff/endurance = 9)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 3,
		/datum/thaumaturgical_essence/air = 2,
		/datum/thaumaturgical_essence/crystal = 2
	)

/datum/alch_cauldron_recipe/con_potion
	recipe_name = "Potion of Stone Flesh"
	smells_like = "earth"
	output_reagents = list(/datum/reagent/buff/constitution = 9)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 5,
		/datum/thaumaturgical_essence/crystal = 2
	)

/datum/alch_cauldron_recipe/int_potion
	recipe_name = "Potion of Keen Mind"
	smells_like = "water"
	output_reagents = list(/datum/reagent/buff/intelligence = 9)
	required_essences = list(
		/datum/thaumaturgical_essence/water = 3,
		/datum/thaumaturgical_essence/magic = 2,
		/datum/thaumaturgical_essence/order = 2
	)

/datum/alch_cauldron_recipe/spd_potion
	recipe_name = "Potion of Fleet Foot"
	smells_like = "clean air"
	output_reagents = list(/datum/reagent/buff/speed = 9)
	required_essences = list(
		/datum/thaumaturgical_essence/air = 4,
		/datum/thaumaturgical_essence/motion = 3
	)

/datum/alch_cauldron_recipe/lck_potion
	recipe_name = "Potion of Seven Clovers"
	smells_like = "calming"
	output_reagents = list(/datum/reagent/buff/fortune = 9)
	required_essences = list(
		/datum/thaumaturgical_essence/chaos = 3,
		/datum/thaumaturgical_essence/cycle = 2,
		/datum/thaumaturgical_essence/magic = 2
	)
