/mob/living/carbon/alien/humanoid
	name = "alien"
	icon_state = "alien"
	pass_flags = PASSTABLE
	butcher_results = list(/obj/item/food/meat/slab/xeno = 5, /obj/item/stack/sheet/animalhide/xeno = 1)
	possible_a_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, INTENT_HARM)
	limb_destroyer = TRUE
	hud_type = /datum/hud/alien
	deathsound = 'sound/voice/hiss6.ogg'
	bodyparts = list(/obj/item/bodypart/chest/alien, /obj/item/bodypart/head/alien, /obj/item/bodypart/l_arm/alien,
					/obj/item/bodypart/r_arm/alien, /obj/item/bodypart/r_leg/alien, /obj/item/bodypart/l_leg/alien)
	var/caste = ""
	var/alt_icon = 'icons/mob/alienleap.dmi' //used to switch between the two alien icon files.
	var/leap_on_click = FALSE
	COOLDOWN_DECLARE(pounce_cooldown)
	var/sneaking = FALSE //For sneaky-sneaky mode and appropriate slowdown
	var/drooling = FALSE //For Neurotoxic spit overlays

GLOBAL_LIST_INIT(strippable_alien_humanoid_items, create_strippable_list(list(
	/datum/strippable_item/hand/left,
	/datum/strippable_item/hand/right,
	/datum/strippable_item/mob_item_slot/handcuffs,
	/datum/strippable_item/mob_item_slot/legcuffs
)))

/mob/living/carbon/alien/humanoid/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/strippable, GLOB.strippable_alien_humanoid_items)

/mob/living/carbon/alien/humanoid/restrained(ignore_grab)
	return handcuffed

/mob/living/carbon/alien/humanoid/cuff_resist(obj/item/I)
	playsound(src, 'sound/voice/hiss5.ogg', 40, 1, 1)  //Alien roars when starting to break free
	..(I, cuff_break = INSTANT_CUFFBREAK)

/mob/living/carbon/alien/humanoid/resist_grab(moving_resist)
	if(pulledby.grab_state)
		visible_message("<span class='danger'>[src] breaks free of [pulledby]'s grip!</span>", \
						"<span class='danger'>You break free of [pulledby]'s grip!</span>")
	pulledby.stop_pulling()
	. = 0

/mob/living/carbon/alien/humanoid/get_permeability_protection()
	return 0.8

/mob/living/carbon/alien/humanoid/alien_evolve(mob/living/carbon/alien/humanoid/new_xeno)
	drop_all_held_items()
	return ..()

//For alien evolution/promotion/queen finder procs. Checks for an active alien of that type
/proc/get_alien_type_in_hive(datum/alienpath)
	for(var/mob/living/carbon/alien/humanoid/A in GLOB.alive_mob_list)
		if(!istype(A, alienpath))
			continue
		if(!A.key || A.stat == DEAD) //Only living aliens with a ckey are valid.
			continue
		return A
	return FALSE

/mob/living/carbon/alien/humanoid/check_breath(datum/gas_mixture/breath)
	if(breath && breath.total_moles() > 0 && !sneaking)
		playsound(get_turf(src), pick('sound/voice/lowHiss2.ogg', 'sound/voice/lowHiss3.ogg', 'sound/voice/lowHiss4.ogg'), 50, 0, -5)
	return ..()
