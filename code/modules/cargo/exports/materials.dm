/datum/export/material
	cost = 5 // Cost per MINERAL_MATERIAL_AMOUNT, which is 2000cm3 as of April 2016.
	message = "cm3 of developer's tears. Please, report this on github"
	var/material_id = null
	export_types = list(
		/obj/item/stack/sheet/mineral, /obj/item/stack/tile/mineral,
		/obj/item/stack/ore, /obj/item/coin)
// Yes, it's a base type containing export_types.
// But it has no material_id, so any applies_to check will return false, and these types reduce amount of copypasta a lot

/datum/export/material/get_amount(obj/O)
	if(!material_id)
		return 0
	if(!isitem(O))
		return 0
	var/obj/item/I = O
	if(!(SSmaterials.GetMaterialRef(material_id) in I.custom_materials))
		return 0

	var/amount = I.custom_materials[SSmaterials.GetMaterialRef(material_id)]

	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I
		amount *= S.amount
		if(istype(I, /obj/item/stack/ore))
			amount *= 0.8 // Station's ore redemption equipment is really goddamn good.

	return round(amount/MINERAL_MATERIAL_AMOUNT)

// Materials. Nothing but plasma is really worth selling. Better leave it all to RnD and sell some plasma instead.

/datum/export/material/bananium
	cost = 1000
	material_id = /datum/material/bananium
	message = "cm<sup>3</sup> of bananium"

/datum/export/material/diamond
	cost = 500
	material_id = /datum/material/diamond
	message = "cm<sup>3</sup> of diamonds"

/datum/export/material/plasma
	cost = 200
	k_elasticity = 0
	material_id = /datum/material/plasma
	message = "cm<sup>3</sup> of plasma"

/datum/export/material/uranium
	cost = 100
	material_id = /datum/material/uranium
	message = "cm<sup>3</sup> of uranium"

/datum/export/material/gold
	cost = 125
	material_id = /datum/material/gold
	message = "cm<sup>3</sup> of gold"

/datum/export/material/copper
	cost = 15
	material_id = /datum/material/copper
	message = "cm<sup>3</sup> of copper"

/datum/export/material/silver
	cost = 50
	material_id = /datum/material/silver
	message = "cm<sup>3</sup> of silver"

/datum/export/material/titanium
	cost = 125
	material_id = /datum/material/titanium
	message = "cm3 of titanium"

/datum/export/material/adamantine
	cost = 500
	material_id = /datum/material/adamantine
	message = "cm<sup>3</sup> of adamantine"

/datum/export/material/bscrystal
	cost = 300
	message = "of bluespace crystals"
	material_id = /datum/material/bluespace

/datum/export/material/plastic
	cost = 25
	message = "cm<sup>3</sup> of plastic"
	material_id = /datum/material/plastic

/datum/export/material/iron
	cost = 5
	message = "cm<sup>3</sup> of metal"
	material_id = /datum/material/iron
	export_types = list(
		/obj/item/stack/sheet/iron, /obj/item/stack/tile/plasteel,
		/obj/item/stack/rods, /obj/item/stack/ore, /obj/item/coin)

/datum/export/material/glass
	cost = 5
	message = "cm<sup>3</sup> of glass"
	material_id = /datum/material/glass
	export_types = list(/obj/item/stack/sheet/glass, /obj/item/stack/ore,
		/obj/item/shard)
