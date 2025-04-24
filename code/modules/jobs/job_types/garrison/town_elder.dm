/datum/job/town_elder
	title = "Town Elder"

	tutorial = "You were once a wanderer, an unremarkable soul who, alongside your old adventuring party, carved your name into history.\
	Now, the days of adventure are long past. You sit as the town's beloved elder; while the crown may rule from afar, the people\
	look to you to settle disputes, mend rifts, and keep the true peace in town. Not every conflict must end in bloodshed,\
	but when it must, you will do what is necessary, as you always have."
	flag = TOWN_ELDER
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CHIEF
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = 10 // Requires knowledge and good rp for the classes.
	bypass_lastclass = TRUE
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/town_militia)
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	advclass_cat_rolls = list(CTAG_TOWN_ELDER = 20)
	give_bank_account = 50
	can_have_apprentices = FALSE


/mob/living/carbon/human/proc/townannouncement()
	set name = "Announcement"
	set category = "Town Elder"
	if(stat)
		return

	var/static/last_announcement_time = 0

	if(world.time < last_announcement_time + 1200)
		var/time_left = round((last_announcement_time + 1200 - world.time) / 10)
		to_chat(src, "<span class='warning'>You must wait [time_left] more seconds before making another announcement.</span>")
		return

	var/inputty = input("Make an announcement", "VANDERLIN") as text|null
	if(inputty)
		if(!istype(get_area(src), /area/rogue/indoors/town/tavern))
			to_chat(src, "<span class='warning'>I need to do this from the drunken saiga tavern.</span>")
			return FALSE
		priority_announce("[inputty]", title = "[src.real_name], The Town Elder Speaks", sound = 'sound/misc/bell.ogg')
		src.log_talk("[TIMETOTEXT4LOGS] [inputty]", LOG_SAY, tag="Town Elder announcement")

		last_announcement_time = world.time

datum/job/town_elder/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/mob/living/carbon/human/H = spawned
	ADD_TRAIT(H, TRAIT_OLDPARTY, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/townannouncement

/obj/effect/proc_holder/spell/self/convertrole/town_militia
	name = "Recruit Militia"
	new_role = "Town Militiaman"
	overlay_state = "recruit_guard"
	recruitment_faction = "Garrison"
	recruitment_message = "Join the Town Militia, %RECRUIT!"
	accept_message = "I swear fealty to protect the town!"
	refuse_message = "I refuse."

/datum/job/militia //just used to change the title
	title = "Town Militiaman"
	f_title = "Town Militiawoman"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_CITYWATCHMEN

/datum/advclass/town_elder/mayor
	name = "Mayor"

	tutorial = "Before politics, you were a bard, your voice stirred hearts, your tales traveled farther than your feet ever could. You carved your name in history not with steel, but with stories that moved kings and commoners alike. In time, your charisma became counsel, your songs gave way to speeches. Decades later, your skill in diplomacy and trade earned you nobility, and with it, the title of Mayor. Now, you lead not from a stage, but from the heart of the people you once sang for."
	outfit = /datum/outfit/job/town_elder/mayor

	category_tags = list(CTAG_TOWN_ELDER)

// Mayor start with slightly changes, they were turned noble and got more money, also highly skilled in merchant skills.



/datum/outfit/job/town_elder/mayor/pre_equip(mob/living/carbon/human/H)

	pants = /obj/item/clothing/pants/trou/leather
	head = /obj/item/clothing/head/tophat
	armor = /obj/item/clothing/armor/leather/vest/winterjacket
	shirt = /obj/item/clothing/shirt/undershirt/fancy
	shoes = /obj/item/clothing/shoes/boots
	gloves = /obj/item/clothing/gloves/leather/black
	ring = /obj/item/clothing/ring/gold/toper
	backl = /obj/item/storage/backpack/satchel
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/black
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltr = /obj/item/storage/keyring/elder
	beltl = /obj/item/flashlight/flare/torch/lantern
	r_hand = /obj/item/weapon/polearm/woodstaff/quarterstaff
	if(H.mind)

		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, 5, TRUE)
		
		H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)

		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_INT, 2)

		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
			H.change_stat(STATKEY_STR, -1)
			H.change_stat(STATKEY_PER, 1)
			H.change_stat(STATKEY_INT, 1)

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BARDIC_TRAINING, TRAIT_GENERIC)




/datum/outfit/job/town_elder/mayor/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.advsetup = 1
	H.invisibility = INVISIBILITY_MAXIMUM
	H.become_blind("bard_select")
	var/instruments = list(
		"Harp" = /obj/item/instrument/harp,
		"Lute" = /obj/item/instrument/lute,
		"Accordion" = /obj/item/instrument/accord,
		"Guitar" = /obj/item/instrument/guitar,
		"Flute" = /obj/item/instrument/flute,
		"Drum" = /obj/item/instrument/drum,
		"Hurdy-Gurdy" = /obj/item/instrument/hurdygurdy,
		"Viola" = /obj/item/instrument/viola)
	var/instrument_choice = input(usr, "Choose your instrument.", "XYLIX") as anything in instruments
	var/spawn_instrument = instruments[instrument_choice]
	if(!spawn_instrument)
		spawn_instrument = /obj/item/instrument/lute
	H.equip_to_slot_or_del(new spawn_instrument(H),SLOT_BACK_R, TRUE)
	H.advsetup = 0
	H.invisibility = initial(H.invisibility)
	H.cure_blind("bard_select")
	var/atom/movable/screen/advsetup/GET_IT_OUT = locate() in H.hud_used?.static_inventory 
	qdel(GET_IT_OUT)



/datum/advclass/town_elder/master_of_crafts_and_labor
	name = "Master of Crafts and Labor"

	tutorial = "You were one of the hardest-working individuals in the city, there isn’t a single job you haven’t done. From farming and butchery to alchemy, blacksmithing, cooking, and even medicine, your vast knowledge has made you a guiding light for the people. Recognizing your wisdom and experience, the townsfolk turned to you for guidance. Now, as the Master of Crafts and Labor, you oversee and aid all who contribute to the city's survival. Lead them well."
	outfit = /datum/outfit/job/town_elder/master_of_crafts_and_labor

	//A Job meant to guide and help new players in multiple areas heavy RNG so it can range from Average to Master.

	category_tags = list(CTAG_TOWN_ELDER)


/datum/outfit/job/town_elder/master_of_crafts_and_labor/pre_equip(mob/living/carbon/human/H)

	head = /obj/item/clothing/head/hatblu
	armor = /obj/item/clothing/armor/leather/vest/random
	pants = /obj/item/clothing/pants/trou
	shirt = /obj/item/clothing/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/hammer/steel
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/weapon/pick/paxe
	backl = /obj/item/storage/backpack/backpack
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid = 1, /obj/item/weapon/knife/hunting = 1, /obj/item/storage/keyring/master_of_crafts_and_labor = 1)

	if(H.mind)

		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Heavy worker
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)

		H.mind?.adjust_skillrank(/datum/skill/labor/mining, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking,pick(2,3,4),TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/masonry, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(2,3,4) ,TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(2,3,4) ,TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, pick(2,3,4), TRUE)

		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_INT, 2)

		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/labor/mining, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking,pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/masonry, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/engineering, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/smelting, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/farming, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/butchering, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/taming, pick(0,0,1),TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, pick(0,0,1), TRUE)

			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_INT, 1)

		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)


/datum/advclass/town_elder/hearth_acolyte
	name = "Hearth Acolyte"

	tutorial = "As an Acolyte, you dedicated your life to faith and service, expecting nothing in return. When you saved a noble, they repaid you with a home and gold, but you saw it as the will of the Ten. Stepping away from the Church, you found a new purpose, not in a grand temple, but among the people. Whether offering healing, wisdom, or guidance, your faith remains strong. Only now, your congregation is the town itself."
	outfit = /datum/outfit/job/town_elder/hearth_acolyte

	//An acolyte that left the church and now serve and help the town people.

	category_tags = list(CTAG_TOWN_ELDER)

/datum/outfit/job/town_elder/hearth_acolyte
	allowed_patrons = ALL_TEMPLE_PATRONS

/datum/outfit/job/town_elder/hearth_acolyte/pre_equip(mob/living/carbon/human/H)

	head = /obj/item/clothing/head/roguehood/random
	armor = /obj/item/clothing/shirt/robe
	shoes = /obj/item/clothing/shoes/sandals
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/keyring/elder
	beltl = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid = 1, /obj/item/needle = 1 )

	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			neck = /obj/item/clothing/neck/psycross/silver/astrata
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/necra)
			neck = /obj/item/clothing/neck/psycross/silver/necra
			H.cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
		if(/datum/patron/divine/eora)
			neck = /obj/item/clothing/neck/psycross/silver/eora
			H.cmode_music = 'sound/music/cmode/church/CombatEora.ogg'
			ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
		if(/datum/patron/divine/noc)
			neck = /obj/item/clothing/neck/psycross/noc
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/pestra)
			neck = /obj/item/clothing/neck/psycross/silver/pestra
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/dendor)
			neck = /obj/item/clothing/neck/psycross/silver/dendor
			H.cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'
		if(/datum/patron/divine/abyssor)
			neck = /obj/item/clothing/neck/psycross/silver/abyssor
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
		if(/datum/patron/divine/ravox)
			neck = /obj/item/clothing/neck/psycross/silver/ravox
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if(/datum/patron/divine/xylix)
			neck = /obj/item/clothing/neck/psycross/silver/xylix
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		if(/datum/patron/divine/malum)
			neck = /obj/item/clothing/neck/psycross/silver/malum
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		else // Failsafe
			neck = /obj/item/clothing/neck/psycross/silver
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)

		// More hand to hand focused
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)

		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			H.change_stat(STATKEY_END, 1)

		if(!H.has_language(/datum/language/celestial))
			H.grant_language(/datum/language/celestial)
			to_chat(H, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")
	

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	C.grant_spells(H)



/datum/advclass/town_elder/lorekeeper 
	name = "Lorekeeper"

	tutorial = "Your tales once lit up taverns, your ballads echoed through cities, and your curiosity led you across kingdoms. But the stage grows quiet, and your thirst for stories has shifted. Now, you collect history instead of applause, recording the town’s past, preserving its legends, and guiding the present with the wisdom of ages. In a world where memory is power, you are its guardian."
	outfit = /datum/outfit/job/town_elder/lorekeeper

	category_tags = list(CTAG_TOWN_ELDER)

/datum/outfit/job/town_elder/lorekeeper/pre_equip(mob/living/carbon/human/H)

	head = /obj/item/clothing/head/bardhat
	shoes = /obj/item/clothing/shoes/boots
	pants = /obj/item/clothing/pants/trou/leather
	shirt = /obj/item/clothing/shirt/tunic/noblecoat
	gloves = /obj/item/clothing/gloves/leather
	wrists = /obj/item/clothing/wrists/bracers/leather
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/leather/jacket/silk_coat
	cloak = /obj/item/clothing/cloak/half
	backl = /obj/item/storage/backpack/satchel
	beltr = /obj/item/weapon/sword/arming
	beltl = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid = 1, /obj/item/storage/keyring/elder = 1, /obj/item/paper/scroll = 5, /obj/item/natural/feather = 1)
	
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	
	
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_STR, 1)
	
	if(H.age == AGE_OLD)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_INT, 1)
	
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BARDIC_TRAINING, TRAIT_GENERIC)

	
	

/datum/outfit/job/town_elder/lorekeeper/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.advsetup = 1
	H.invisibility = INVISIBILITY_MAXIMUM
	H.become_blind("bard_select")
	var/instruments = list(
		"Harp" = /obj/item/instrument/harp,
		"Lute" = /obj/item/instrument/lute,
		"Accordion" = /obj/item/instrument/accord,
		"Guitar" = /obj/item/instrument/guitar,
		"Flute" = /obj/item/instrument/flute,
		"Drum" = /obj/item/instrument/drum,
		"Hurdy-Gurdy" = /obj/item/instrument/hurdygurdy,
		"Viola" = /obj/item/instrument/viola)
	var/instrument_choice = input(usr, "Choose your instrument.", "XYLIX") as anything in instruments
	var/spawn_instrument = instruments[instrument_choice]
	if(!spawn_instrument)
		spawn_instrument = /obj/item/instrument/lute
	H.equip_to_slot_or_del(new spawn_instrument(H),SLOT_BACK_R, TRUE)
	H.advsetup = 0
	H.invisibility = initial(H.invisibility)
	H.cure_blind("bard_select")
	var/atom/movable/screen/advsetup/GET_IT_OUT = locate() in H.hud_used?.static_inventory 
	qdel(GET_IT_OUT)



/datum/advclass/town_elder/dreamwatcher 
	name = "Dreamwatcher"

	tutorial = "Your dreams have always been vivid, filled with colors, voices, and shadows that seemed to watch. As a child, you feared them. As an adult, you began to listen. The Church speaks of Noc as the keeper of magic, but to you, he is something deeper: a silent guide whose truths are written not in scripture, but in sleep. Now, as Elder of this town, you offer more than leadership. You help others find clarity in the quiet spaces of their hearts, through signs, symbols, and truths too easily ignored. Some call it intuition. Others call it wisdom. You know it simply as listening."
	outfit = /datum/outfit/job/town_elder/dreamwatcher
	
	//Not a Magician nor an Acolyte, but something more, blessed by Noc since they were born, being capable of Visions and Feelings through dreams, they can feel the highest god influence or and get a hint about any of the active antags.
	category_tags = list(CTAG_TOWN_ELDER)


/datum/outfit/job/town_elder/dreamwatcher/pre_equip(mob/living/carbon/human/H)

	head = /obj/item/clothing/head/softcap
	armor = /obj/item/clothing/shirt/robe/black
	shoes = /obj/item/clothing/shoes/sandals
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/keyring/elder
	beltl = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/satchel
	wrists = /obj/item/clothing/wrists/nocwrappings
	neck = /obj/item/clothing/neck/psycross/noc
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor = 1, /obj/item/needle = 1 )
	
	if(H.patron != /datum/patron/divine/noc)
		H.set_patron(/datum/patron/divine/noc)
	
	H.apply_status_effect(/datum/status_effect/buff/nocblessed)
	// 3 INT and 2 PER buff, stats will be lowered because of that

	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_PER, 1)
	if(H.age == AGE_OLD)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 1)
		
	ADD_TRAIT(H, TRAIT_DREAM_WATCHER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)

	
