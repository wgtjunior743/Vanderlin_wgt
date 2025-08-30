/datum/stressevent/viewsinpunish
	timer = 5 MINUTES
	stressadd = -2
	desc = span_green("I saw a sinner get punished!")

/datum/stressevent/miasmagasmaniac
	timer = 10 SECONDS
	stressadd = -1
	desc = span_green("It smells like death in here.")

/datum/stressevent/viewdeathmaniac
	timer = 30 SECONDS
	stressadd = -1
	desc = span_green("Death. Hehe...")

/datum/stressevent/viewdismembermaniac
	timer = 2 MINUTES
	stressadd = -1
	desc = span_green("I saw limbs fly. Hehe...")

/datum/stressevent/viewgibmaniac
	timer = 2 MINUTES
	stressadd = -2
	desc = span_green("That was amazing! Can someone do it again? I wanna see it again.")

/datum/stressevent/viewexecution
	timer = 5 MINUTES
	stressadd = -3 // to counteract the +1 from watching death
	desc = span_green("Nice civilized entertainment.")

/datum/stressevent/psyprayer
	timer = 30 MINUTES
	stressadd = -2
	desc = span_green("The Gods smiles upon me.")

/datum/stressevent/lovezizo
	timer = 99999 MINUTES
	stressadd = -666 // :)
	desc = span_green("ZIZOZIZOZIZO")

/datum/stressevent/joke
	timer = 1 MINUTES
	stressadd = -2
	desc = span_green("I heard a good joke.")

/datum/stressevent/tragedy
	timer = 1 MINUTES
	stressadd = -2
	desc = span_green("Life isn't so bad after all.")

/datum/stressevent/blessed
	timer = 60 MINUTES
	stressadd = -5
	desc = span_green("I feel soothed.")

/datum/stressevent/triumph
	timer = 60 MINUTES
	stressadd = -10
	desc = span_green("I remember a TRIUMPH.")

/datum/stressevent/drunk
	timer = 999 MINUTES
	stressadd = -1
	desc = list(span_green("Alcohol eases the pain."),span_green("Alcohol, my true friend."))

/datum/stressevent/pweed
	timer = 1 MINUTES
	stressadd = -1
	desc = list(span_green("A relaxing smoke."),span_green("A flavorful smoke."))

/datum/stressevent/weed
	timer = 999 MINUTES
	stressadd = -4
	desc = span_blue("I love you sweet leaf.")

/datum/stressevent/high
	timer = 999 MINUTES
	stressadd = -4
	desc = span_blue("I'm so high, don't take away my sky.")

/datum/stressevent/hug
	timer = 30 MINUTES
	stressadd = -1
	desc = span_green("Somebody gave me a nice hug.")

/datum/stressevent/stuffed
	timer = 20 MINUTES
	stressadd = -3
	desc = span_green("I'm stuffed! Feels good.")

/datum/stressevent/goodfood
	timer = 10 MINUTES
	stressadd = -2
	desc = list(span_green("A meal fit for a god!"),span_green("Delicious!"))

/datum/stressevent/prebel
	timer = 5 MINUTES
	stressadd = -5
	desc = span_green("Down with the tyranny!")

/datum/stressevent/clean
	timer = 20 MINUTES
	stressadd = -1
	desc = span_green("I cleaned myself recently.")

/datum/stressevent/clean_plus
	timer = 30 MINUTES
	stressadd = -1
	desc = span_green("That was an amazing bath.")

/datum/stressevent/music
	timer = 30 SECONDS
	stressadd = 0 // you suck at music
	desc = span_green("This music is pleasant.")

/datum/stressevent/beautiful
	timer = 2 MINUTES
	stressadd = -2
	desc = span_green("Their face is a work of art!")

/datum/stressevent/music/two
	stressadd = -1
	desc = span_green("This music is relaxing.")

/datum/stressevent/music/three
	stressadd = -1
	desc = span_green("This music is wonderful.")

/datum/stressevent/music/four
	stressadd = -2
	desc = span_green("This music is exceptional.")

/datum/stressevent/music/five
	stressadd = -2
	desc = span_green("This music is enchanting.")

/datum/stressevent/music/six
	stressadd = -3
	desc = span_green("This music is divine.")

/datum/stressevent/eora
	stressadd = -4
	timer = INFINITY
	desc = span_boldgreen("Eora brings me peace.")

// Bard buffs below

/datum/stressevent/bardicbuff
	timer = 30 SECONDS
	desc = span_nicegreen("Bardic inspiration moves mine soul even more!")
	stressadd = -1

/datum/stressevent/vblood
	stressadd = -5
	desc = span_bold("Virgin blood!")
	timer = 5 MINUTES

/datum/stressevent/bathwater
	stressadd = -1
	desc = span_blue("Relaxing.")
	timer = 15 SECONDS

/datum/stressevent/bathwater/on_apply(mob/living/user)
	. = ..()
	if(user.client)
		record_round_statistic(STATS_BATHS_TAKEN)
		SEND_SIGNAL(user, COMSIG_BATH_TAKEN)

/datum/stressevent/ozium
	stressadd = -99
	desc = span_blue("I've taken a hit and entered a painless world.")
	timer = 999 MINUTES

/datum/stressevent/moondust
	stressadd = -5
	desc = span_green("Moondust surges through me.")
	timer = 2 MINUTES

/datum/stressevent/moondust_purest
	stressadd = -6
	desc = span_green("PUREST moondust surges through me!")

/datum/stressevent/calm
	stressadd = -3
	desc = span_green("I feel soothed and calm.")

/datum/stressevent/perfume
	stressadd = -1
	desc = span_green("A soothing fragrance envelops me.")
	timer = 10 MINUTES

/datum/stressevent/divine_beauty
	stressadd = -2
	desc = span_green("I feel touched by a divine beauty.")
	timer = 5 MINUTES

/datum/stressevent/apprentice_making_me_proud
	timer = 5 MINUTES
	stressadd = -3
	desc = span_green("My apprentice is improving, all thanks to me!")

/datum/stressevent/saw_old_party
	timer = 2 MINUTES
	stressadd = -2
	desc = span_green("Its always good to see an old friends face.")

/datum/stressevent/astrata_grandeur
	timer = 30 MINUTES
	stressadd = -2
	desc = span_green("Astrata's light shines brightly through me. I must not let others ever forget that.")

/datum/stressevent/graggar_culling_finished
	stressadd = -1
	desc = span_green("I have prevailed over my rival! Graggar favours me now!")
	timer = INFINITY

/datum/stressevent/night_owl_night
	stressadd = -1
	desc = span_green("I love the night!")
	timer = 20 MINUTES
