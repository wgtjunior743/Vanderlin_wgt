#define get_job_playtime(client, job) ((client.prefs.exp[job]) ? client.prefs.exp[job] MINUTES_TO_DECISECOND : 0)

#define JOB_AVAILABLE 0
#define JOB_UNAVAILABLE_GENERIC 1
#define JOB_UNAVAILABLE_BANNED 2
#define JOB_UNAVAILABLE_PLAYTIME 3
#define JOB_UNAVAILABLE_SLOTFULL 4
#define JOB_UNAVAILABLE_AGE 5
#define JOB_UNAVAILABLE_RACE 6
#define JOB_UNAVAILABLE_SEX 7
#define JOB_UNAVAILABLE_DEITY 8
#define JOB_UNAVAILABLE_QUALITY 9
#define JOB_UNAVAILABLE_PATREON 10
#define JOB_UNAVAILABLE_LASTCLASS 11
#define JOB_UNAVAILABLE_ACCOUNTAGE 12
#define JOB_UNAVAILABLE_JOB_COOLDOWN 13
#define JOB_UNAVAILABLE_RACE_BANNED 14
#define JOB_UNAVAILABLE_TIME_LOCK 15

/* Job datum job_flags */
/// Whether the mob is announced on arrival.
#define JOB_ANNOUNCE_ARRIVAL (1<<0)
/// Whether the mob is added to the crew manifest.
#define JOB_SHOW_IN_CREDITS (1<<1)
/// Whether the mob is equipped through SSjob.EquipRank() on spawn.
#define JOB_EQUIP_RANK (1<<2)
/// Whether this job can be joined through the new_player menu.
#define JOB_NEW_PLAYER_JOINABLE (1<<3)
/// Whether the job can be displayed on the actors list
#define JOB_SHOW_IN_ACTOR_LIST (1<<4)

#define FACTION_NONE		"None"
#define FACTION_NEUTRAL		"Neutral"
#define FACTION_HOSTILE		"Hostile"
#define FACTION_TOWN		"Town"
#define FACTION_FOREIGNERS  "Foreigners"
#define FACTION_MIGRANTS  	"Migrants"
#define FACTION_UNDEAD		"Undead"
#define FACTION_PLANTS		"Plants"
#define FACTION_VINES		"Vines" //Seemingly unused
#define FACTION_CABAL		"Cabal"
#define FACTION_RATS		"Rats"
#define FACTION_ORCS		"Orcs"
#define FACTION_BUMS		"Bums"
#define FACTION_MATTHIOS	"Matthios"

#define NOBLEMEN		(1<<0)
#define GARRISON		(1<<1)
#define CHURCHMEN		(1<<2)
#define SERFS			(1<<3)
#define PEASANTS		(1<<4)
#define APPRENTICES		(1<<5)
#define YOUNGFOLK		(1<<6)
#define OUTSIDERS		(1<<7)
#define COMPANY			(1<<8)
#define INQUISITION 	(1<<9)

#define UNDEAD			(1<<10)


#define JCOLOR_NOBLE "#9c40bf"
#define JCOLOR_MERCHANT "#c2b449"
#define JCOLOR_SOLDIER "#b64949"
#define JCOLOR_SERF "#669968"
#define JCOLOR_PEASANT "#936d6c"
#define JCOLOR_INQUISITION "#FF0000"

// job display orders //

#define JDO_DEFAULT 0
#define JDO_LORD 1
#define JDO_CONSORT 1.1
#define JDO_PRINCE 1.2
#define JDO_HAND 2
#define JDO_STEWARD 3
#define JDO_MINOR_NOBLE 3.5
#define JDO_PHYSICIAN 3.7

#define JDO_MAGICIAN 4
#define JDO_WAPP 5

#define JDO_APOTHECARY 6
#define JDO_FELDSHER 6.1
#define JDO_CLINICAPPRENTICE 6.2

#define JDO_CAPTAIN 7
#define JDO_VET 7.1
#define JDO_ROYALKNIGHT 7.2
#define JDO_MENATARMS 8
#define JDO_CITYWATCHMEN 8.1
#define JDO_GATEMASTER 8.2
#define JDO_DUNGEONEER 9
#define JDO_JAILOR 9.1
#define JDO_SQUIRE 10
#define JDO_FORWARDEN 11
#define JDO_FORGUARD 11.1

#define JDO_PRIEST 12
#define JDO_CLERIC 13
#define JDO_MONK 14
#define JDO_GRAVETENDER 15
#define JDO_CHURCHLING 15.1

#define JDO_SHEPHERD 17
#define JDO_TEMPLAR 17.1

#define JDO_MERCHANT 18
#define JDO_SHOPHAND 18.1
#define JDO_GRABBER 18.2

#define JDO_TAILOR 19

#define JDO_ARMORER 20
#define JDO_WSMITH 21
#define JDO_BAPP 22
#define JDO_ARTIFICER 23

#define JDO_MASON 24

#define JDO_BUTLER 25
#define JDO_SERVANT 26

#define JDO_INNKEEP 27
#define JDO_INNKEEP_CHILD 27.5
#define JDO_COOK 28

#define JDO_BUTCHER 28.1
#define JDO_SOILSON 28.2
#define JDO_FISHER 28.3
#define JDO_HUNTER 28.4
#define JDO_CARPENTER 28.6
#define JDO_CHEESEMAKER 28.7
#define JDO_MINER 28.8
#define JDO_MATRON 28.9
#define JDO_GRAVEMAN 29

#define JDO_JESTER 30
#define JDO_BARD 30.1
#define JDO_PRISONER 31

#define JDO_CHIEF 32

#define JDO_ADVENTURER 33
#define JDO_GAFFER 33.1
#define JDO_PILGRIM 34.2
#define JDO_MIGRANT  34.3
#define JDO_BANDIT 34.3
#define JDO_WRETCH 34.4

#define JDO_MERCENARY 35

#define JDO_VAGRANT 36
#define JDO_ORPHAN 37
#define JDO_SOILCHILD 38

#define JDO_PURITAN 40
#define JDO_ORTHODOXIST	40.1
#define JDO_ABSOLVER 40.2

#define BITFLAG_CHURCH (1<<0)
#define BITFLAG_ROYALTY (1<<1)
#define BITFLAG_CONSTRUCTOR (1<<2)
#define BITFLAG_GARRISON (1<<3)


// Timelock Defines

#define JOB_LIVING_ROLES	/datum/timelock/living
#define JOB_CHURCH_ROLES	/datum/timelock/church
#define JOB_GARRISON_ROLES	/datum/timelock/garrison
#define JOB_INQUISITION_ROLES	/datum/timelock/inquisition
#define JOB_NOBLE_ROLES	/datum/timelock/noble
#define JOB_MERCHANT_COMPANY_ROLES	/datum/timelock/merchant_company
#define JOB_ADVENTURER_ROLES	/datum/timelock/adventurer
#define JOB_LEADERSHIP_ROLES	/datum/timelock/leadership
#define JOB_MEDICAL_ROLES	/datum/timelock/medical
#define JOB_MAGICK_ROLES	/datum/timelock/magick
#define JOB_ARTIFICER_ROLES	/datum/timelock/artificer

#define JOB_THIEF_ROLES	/datum/timelock/thief
#define JOB_BARD_ROLES	/datum/timelock/bard
#define JOB_RANGER_ROLES	/datum/timelock/ranger


/// The only reason some jobs with advclasses also have their job datum is because in the past advclass were not jobs and it didn't saved in the DB, for the NEW jobs that got advclasses, ONLY put the advclasses datums.

#define JOB_CHURCH_ROLES_LIST	list(/datum/job/priest, /datum/job/monk, /datum/job/templar, /datum/job/undertaker)
#define JOB_GARRISON_ROLES_LIST	list(/datum/job/dungeoneer, /datum/job/forestguard, /datum/job/advclass/forestguard/infantry, /datum/job/advclass/forestguard/ranger, /datum/job/advclass/forestguard/reaver, /datum/job/advclass/forestguard/brawler, /datum/job/advclass/forestguard/ruffian, /datum/job/forestwarden, /datum/job/guardsman, /datum/job/advclass/garrison/footman, /datum/job/advclass/garrison/archer, /datum/job/advclass/garrison/pikeman, /datum/job/gatemaster, /datum/job/advclass/gatemaster/gatemaster_whip, /datum/job/advclass/gatemaster/gatemaster_mace, /datum/job/advclass/gatemaster/gatemaster_bow, /datum/job/jailor, /datum/job/men_at_arms, /datum/job/advclass/menatarms/watchman_pikeman, /datum/job/advclass/menatarms/watchman_swordsmen, /datum/job/advclass/menatarms/watchman_ranger, /datum/job/royalknight, /datum/job/lieutenant, /datum/job/advclass/royalknight/knight, /datum/job/advclass/royalknight/steam, /datum/job/captain)
#define JOB_INQUISITION_ROLES_LIST	list(/datum/job/inquisitor,/datum/job/advclass/puritan/inspector, /datum/job/advclass/puritan/ordinator, /datum/job/adept, /datum/job/advclass/adept/bzealot, /datum/job/advclass/adept/rthief, /datum/job/advclass/adept/highwayman, /datum/job/absolver, /datum/job/advclass/confessor, /datum/job/advclass/disciple, /datum/job/advclass/psyaltrist, /datum/job/advclass/psydoniantemplar)
#define JOB_NOBLE_ROLES_LIST	list(/datum/job/archivist, /datum/job/captain, /datum/job/consort, /datum/job/advclass/consort/highborn, /datum/job/advclass/consort/courtesan, /datum/job/advclass/consort/lowborn, /datum/job/advclass/consort/courtesan/night_spy, /datum/job/courtphys, /datum/job/consort, /datum/job/advclass/hand/hand, /datum/job/advclass/hand/spymaster, /datum/job/advclass/hand/advisor, /datum/job/lord, /datum/job/magician, /datum/job/minor_noble, /datum/job/steward)
#define JOB_MERCHANT_COMPANY_ROLES_LIST	list(/datum/job/merchant, /datum/job/grabber, /datum/job/shophand)
#define JOB_LEADERSHIP_ROLES_LIST	list(/datum/job/priest, /datum/job/captain, /datum/job/lord, /datum/job/inquisitor,/datum/job/advclass/puritan/inspector, /datum/job/advclass/puritan/ordinator, /datum/job/forestwarden, /datum/job/town_elder)
#define JOB_MEDICAL_ROLES_LIST	list(/datum/job/advclass/pilgrim/physicker, /datum/job/clinicapprentice, /datum/job/courtphys, /datum/job/feldsher, /datum/job/advclass/mercenary/ironmaiden, /datum/job/advclass/sawbones, /datum/job/advclass/roguemage)
#define JOB_MAGICK_ROLES_LIST	list(/datum/job/advclass/mercenary/sellmage, /datum/job/advclass/mercenary/spellsword, /datum/job/magician, /datum/job/mageapprentice, /datum/job/advclass/combat/mage, /datum/job/advclass/wretch/hedgemage, /datum/job/migrant/heartfelt_magos)
#define JOB_ARTIFICER_ROLES_LIST	list(/datum/job/artificer, /datum/job/migrant/heartfelt_artificer)
#define JOB_ADVENTURER_ROLES_LIST	list(/datum/job/adventurer, /datum/job/advclass/combat/amazon, /datum/job/advclass/combat/barbarian, /datum/job/advclass/combat/cleric, /datum/job/advclass/combat/inhumencleric, /datum/job/advclass/combat/dbomb, /datum/job/advclass/combat/dredge, /datum/job/advclass/combat/dranger, /datum/job/advclass/combat/hollowranger, /datum/job/advclass/combat/mage, /datum/job/advclass/combat/monk, /datum/job/advclass/combat/ranger, /datum/job/advclass/combat/rogue, /datum/job/advclass/combat/vikingr, /datum/job/advclass/combat/sfighter, /datum/job/advclass/combat/bladesinger, /datum/job/advclass/combat/hoplite, /datum/job/advclass/combat/longbeard, /datum/job/advclass/combat/paladin, /datum/job/advclass/combat/profanepaladin, /datum/job/advclass/combat/swordmaster, /datum/job/advclass/combat/vaquero, /datum/job/advclass/combat/lancer, /datum/job/advclass/combat/lakkariancleric, /datum/job/advclass/adventurer/qatil, /datum/job/advclass/combat/rare/sentinel, /datum/job/advclass/combat/swashbuckler, /datum/job/advclass/combat/gravedigger, /datum/job/advclass/combat/puritan)
#define JOB_THIEF_ROLES_LIST	list(/datum/job/advclass/combat/rogue, /datum/job/advclass/knave)
#define JOB_BARD_ROLES_LIST	list(/datum/job/advclass/pilgrim/bard, /datum/job/bard)
#define JOB_RANGER_ROLES_LIST	list(/datum/job/advclass/combat/ranger, /datum/job/advclass/combat/hollowranger, /datum/job/advclass/combat/dranger)


#define TIMELOCK_JOB(role_id, hours) new/datum/timelock(role_id, hours, role_id)

// Used to add a timelock to a job. Will be passed onto derivatives
#define AddTimelock(Path, timelockList) \
##Path/setup_requirements(list/L){\
	L += timelockList;\
	. = ..(L);\
}

// Used to add a timelock to a job. Will be passed onto derivates. Will not include the parent's timelocks.
#define OverrideTimelock(Path, timelockList) \
##Path/setup_requirements(list/L){\
	L = timelockList;\
	. = ..(L);\
}
