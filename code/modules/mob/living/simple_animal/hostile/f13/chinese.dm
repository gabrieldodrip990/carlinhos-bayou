/mob/living/simple_animal/hostile/chinese
	name = "chinese remnant soldier"
	desc = "Chinese soldiers who survived the Great War via ghoulification, and now shoot anything that isn't their own on sight."
	icon = 'icons/fallout/mobs/humans/ghouls.dmi'
	icon_state = "chinesesoldier"
	icon_living = "chinesesoldier"
	icon_dead = "chinesesoldier_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	maxHealth = 80
	health = 80
	harm_intent_damage = 8
	melee_damage_lower = 20
	melee_damage_upper = 38
	attack_verb_simple = "punches"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = INTENT_HARM
	loot = list()
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("china")
	check_friendly_fire = 1
	status_flags = CANPUSH
	tastes = list("people" = 1, "dust" = 2)
	var/retreat_message_said = FALSE

/mob/living/simple_animal/hostile/chinese/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(stat == DEAD || health > maxHealth*0.1)
		retreat_distance = initial(retreat_distance)
		return
	var/atom/my_target = get_target()
	if(!retreat_message_said && my_target)
		visible_message(span_danger("The [name] tries to flee from [my_target]!"))
		retreat_message_said = TRUE
	retreat_distance = 30

/mob/living/simple_animal/hostile/chinese/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if(get_target())
		return
	adjustHealth(-maxHealth*0.225)
	visible_message(span_danger("The [name] bandages itself!"))
	playsound(get_turf(src), 'sound/items/tendingwounds.ogg', 100, 1, ignore_walls = TRUE)
	retreat_message_said = FALSE

/mob/living/simple_animal/hostile/chinese/Aggro()
	. = ..()
	if(.)
		return
	summon_backup(15)
	if(!ckey)
		say(pick("操你祖宗十八代", "乡巴佬", "傻逼" , "妈你个", "操你大爷", "祝你生孩子没屁眼", "扯鸡巴蛋", "狗改不了吃屎", "爆你菊花" ))

/mob/living/simple_animal/hostile/chinese/ranged
	icon_state = "chinesepistol"
	icon_living = "chinesepistol"
	icon_dead = "chinesepistol_dead"
	loot = list()
	ranged = 1
	maxHealth = 110
	health = 110
	retreat_distance = 4
	minimum_distance = 6
	projectiletype = /obj/item/projectile/bullet/c9mm/simple
	projectilesound =  'sound/f13weapons/ninemil.ogg'
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_LIGHT_RANGE_DISTANT)
	)

/mob/living/simple_animal/hostile/chinese/ranged/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(stat == DEAD || health > maxHealth*0.5)
		retreat_distance = initial(retreat_distance)
		return
	var/atom/my_target = get_target()
	if(!retreat_message_said && my_target)
		visible_message(span_danger("The [name] tries to tactically retreat from [my_target]!"))
		retreat_message_said = TRUE
	retreat_distance = 15



/mob/living/simple_animal/hostile/chinese/ranged/assault
	name = "chinese remnant assault soldier"
	icon_state = "chineseassault"
	icon_living = "chineseassault"
	icon_dead = "chineseassault_dead"
	maxHealth = 160
	health = 160
	extra_projectiles = 2
	loot = list()
	projectiletype = /obj/item/projectile/bullet/a556/simple
	projectilesound = 'sound/f13weapons/assaultrifle_fire.ogg'
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(RIFLE_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(RIFLE_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(RIFLE_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(RIFLE_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(RIFLE_LIGHT_RANGE_DISTANT)
	)

/mob/living/simple_animal/hostile/chinese/ranged/assault/Aggro()
	..()
	summon_backup(15)
