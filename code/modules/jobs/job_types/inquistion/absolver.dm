/datum/job/absolver
	title = "Absolver"
	department_flag = INQUISITION
	faction = "Station"
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	total_positions = 1 // THE ONE.
	spawn_positions = 1
	allowed_races = list(SPEC_ID_HUMEN)
	allowed_patrons = list(/datum/patron/psydon) //You MUST have a Psydonite character to start. Just so people don't get japed into Oops Suddenly Psydon!
	tutorial = "The Oratorium claims you are naught more than a 'cleric', but you know the truth; you are a sacrificial lamb. Your hands, unmarred through prayer and pacifism, have been gifted with the power to manipulate blood - to siphon away the wounds of others, so that you may endure in their stead. Let your censer's light shepherd the Inquisitor's retinue forth, lest they're led astray by wrath and temptation."
	selection_color = JCOLOR_INQUISITION
	outfit = /datum/outfit/job/absolver
	bypass_lastclass = TRUE
	display_order = JDO_ABSOLVER
	min_pq = 3 // Low potential for grief. A pacifist by trade. Also needs to know wtf a PSYDON is.
	give_bank_account = 15

	traits = list(
		TRAIT_NOPAINSTUN,
		TRAIT_PACIFISM,
		TRAIT_EMPATH,
		TRAIT_CRITICAL_RESISTANCE,
		TRAIT_STEELHEARTED,
		TRAIT_INQUISITION,
		TRAIT_SILVER_BLESSED,
	)

	jobstats = list(
		STATKEY_END = 3,
		STATKEY_SPD = -2,
		STATKEY_CON = 7,
	)

	spells = list(
		/datum/action/cooldown/spell/psydonlux_tamper,
		/datum/action/cooldown/spell/psydonabsolve,
		/datum/action/cooldown/spell/diagnose,
	)

	skills = list(
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/sewing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/labor/fishing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/crafting = SKILL_LEVEL_JOURNEYMAN,
	)


// REMEMBER FLAGELLANT? REMEMBER LASZLO? THIS IS HIM NOW. FEEL OLD YET?

/datum/job/absolver/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.grant_language(/datum/language/oldpsydonic)
		H.verbs |= /mob/living/carbon/human/proc/view_inquisition

/datum/outfit/job/absolver/pre_equip(mob/living/carbon/human/H)
	..()

	H.hud_used?.shutdown_bloodpool()
	H.hud_used?.initialize_bloodpool()
	H.hud_used?.bloodpool.set_fill_color("#dcdddb")
	H?.hud_used?.bloodpool?.name = "Psydon's Grace: [H.bloodpool]"
	H?.hud_used?.bloodpool?.desc = "Devotion: [H.bloodpool]/[H.maxbloodpool]"
	H.maxbloodpool = 1000

	wrists = /obj/item/clothing/wrists/bracers/psythorns
	gloves = /obj/item/clothing/gloves/leather/otavan/inqgloves
	beltr = /obj/item/flashlight/flare/torch/lantern/psycenser
	beltl = /obj/item/storage/belt/pouch/coins/rich
	neck = /obj/item/clothing/neck/psycross/silver
	cloak = /obj/item/clothing/cloak/absolutionistrobe
	backr = /obj/item/storage/backpack/satchel/otavan
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/trou/leather/advanced/colored/duelpants
	armor = /obj/item/clothing/armor/cuirass/psydon
	shirt = /obj/item/clothing/armor/gambeson/heavy/inq
	shoes = /obj/item/clothing/shoes/psydonboots
	mask = /obj/item/clothing/head/helmet/blacksteel/psythorns
	head = /obj/item/clothing/head/helmet/heavy/absolver
	ring = /obj/item/clothing/ring/signet/silver
	backpack_contents = list(
		/obj/item/book/bibble/psy = 1,
		/obj/item/natural/bundle/cloth = 2,
		/obj/item/reagent_containers/glass/bottle/healthpot = 2,
		/obj/item/paper/inqslip/arrival/abso = 1,
		/obj/item/needle = 1,
		/obj/item/natural/worms/leech = 1,
		/obj/item/key/inquisition = 1,
		)

/datum/outfit/job/absolver/post_equip(mob/living/carbon/human/H, visuals_only)
	. = ..()
	GLOB.inquisition.add_member_to_school(H, "Sanctae", 0, "Absolver")
