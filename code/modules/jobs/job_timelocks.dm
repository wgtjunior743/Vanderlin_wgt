/datum/timelock/living
	name = "Living Roles"

/datum/timelock/living/can_play(client/C)
	return C.get_time_living() >= time_required

/datum/timelock/living/get_role_requirement(client/C)
	return time_required - C.get_time_living()

/datum/timelock/church
	name = "Church Roles"

/datum/timelock/church/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_CHURCH_ROLES_LIST

/datum/timelock/garrison
	name = "Garrison Roles"

/datum/timelock/garrison/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_GARRISON_ROLES_LIST

/datum/timelock/inquisition
	name = "Inquisition Roles"

/datum/timelock/inquisition/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_INQUISITION_ROLES_LIST

/datum/timelock/noble
	name = "Noble Roles"

/datum/timelock/noble/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_NOBLE_ROLES_LIST

/datum/timelock/merchant_company
	name = "Merchant Company Roles"

/datum/timelock/merchant_company/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_MERCHANT_COMPANY_ROLES_LIST

/datum/timelock/adventurer
	name = "Adventurer Roles"

/datum/timelock/adventurer/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_ADVENTURER_ROLES_LIST

/datum/timelock/leadership
	name = "Leadership Roles"

/datum/timelock/leadership/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_LEADERSHIP_ROLES_LIST

/datum/timelock/medical
	name = "Medical Roles"

/datum/timelock/medical/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_MEDICAL_ROLES_LIST

/datum/timelock/magick
	name = "Magick Roles"

/datum/timelock/magick/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_MAGICK_ROLES_LIST


/datum/timelock/artificer
	name = "Artificer Roles"

/datum/timelock/artificer/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_ARTIFICER_ROLES_LIST

/datum/timelock/thief
	name = "Thief Roles"

/datum/timelock/thief/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_THIEF_ROLES_LIST

/datum/timelock/bard
	name = "Bard Roles"

/datum/timelock/bard/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_BARD_ROLES_LIST

/datum/timelock/ranger
	name = "Ranger Roles"

/datum/timelock/ranger/New(name, time_required, list/roles)
	. = ..()
	src.roles = JOB_RANGER_ROLES_LIST











