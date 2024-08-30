/*
Navicat MySQL Data Transfer

Source Server         : Clipstone
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : test2

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2024-08-30 21:04:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bo2_vanilla_round_leaderboard`
-- ----------------------------
DROP TABLE IF EXISTS `bo2_vanilla_round_leaderboard`;
CREATE TABLE `bo2_vanilla_round_leaderboard` (
  `id` int(11) NOT NULL,
  `map` varchar(255) NOT NULL,
  `players` varchar(255) NOT NULL,
  `round` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of bo2_vanilla_round_leaderboard
-- ----------------------------
INSERT INTO `bo2_vanilla_round_leaderboard` VALUES ('1', 'DieRise', 'DDDDec', '0');
INSERT INTO `bo2_vanilla_round_leaderboard` VALUES ('2', 'Buried', 'DDDDec', '0');
INSERT INTO `bo2_vanilla_round_leaderboard` VALUES ('3', 'MobOfTheDead', 'DDDDec', '0');
INSERT INTO `bo2_vanilla_round_leaderboard` VALUES ('4', 'Nuketown', 'DDDDec', '0');
INSERT INTO `bo2_vanilla_round_leaderboard` VALUES ('5', 'Origins', 'DDDDec', '0');
INSERT INTO `bo2_vanilla_round_leaderboard` VALUES ('6', 'Town', 'DDDDec', '2');
INSERT INTO `bo2_vanilla_round_leaderboard` VALUES ('7', 'Farm', 'DDDDec', '0');
INSERT INTO `bo2_vanilla_round_leaderboard` VALUES ('8', 'Tranzit', 'DDDDec', '0');
INSERT INTO `bo2_vanilla_round_leaderboard` VALUES ('9', 'Depot', 'DDDDec', '0');

-- ----------------------------
-- Table structure for `bo2_vanilla_zombie_users`
-- ----------------------------
DROP TABLE IF EXISTS `bo2_vanilla_zombie_users`;
CREATE TABLE `bo2_vanilla_zombie_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guid` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 0,
  `color` varchar(255) NOT NULL DEFAULT '^7',
  `language` varchar(255) NOT NULL DEFAULT 'english',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of bo2_vanilla_zombie_users
-- ----------------------------

-- ----------------------------
-- Table structure for `bo2_vanilla_zombie_user_stats`
-- ----------------------------
DROP TABLE IF EXISTS `bo2_vanilla_zombie_user_stats`;
CREATE TABLE `bo2_vanilla_zombie_user_stats` (
  `guid` int(11) NOT NULL AUTO_INCREMENT,
  `quit` int(11) NOT NULL DEFAULT 0,
  `score` int(11) NOT NULL DEFAULT 0,
  `highest_score` int(11) NOT NULL DEFAULT 0,
  `rounds` int(11) NOT NULL DEFAULT 0,
  `highest_round` int(11) NOT NULL DEFAULT 0,
  `kills` int(11) NOT NULL DEFAULT 0,
  `suicides` int(11) NOT NULL DEFAULT 0,
  `downs` int(11) NOT NULL DEFAULT 0,
  `revives` int(11) NOT NULL DEFAULT 0,
  `perks_drank` int(11) NOT NULL DEFAULT 0,
  `headshots` int(11) NOT NULL DEFAULT 0,
  `gibs` int(11) NOT NULL DEFAULT 0,
  `head_gibs` int(11) NOT NULL DEFAULT 0,
  `right_arm_gibs` int(11) NOT NULL DEFAULT 0,
  `left_arm_gibs` int(11) NOT NULL DEFAULT 0,
  `right_leg_gibs` int(11) NOT NULL DEFAULT 0,
  `left_leg_gibs` int(11) NOT NULL DEFAULT 0,
  `melee_kills` int(11) NOT NULL DEFAULT 0,
  `grenade_kills` int(11) NOT NULL DEFAULT 0,
  `doors_purchased` int(11) NOT NULL DEFAULT 0,
  `distance_traveled` int(11) NOT NULL DEFAULT 0,
  `total_shots` int(11) NOT NULL DEFAULT 0,
  `hits` int(11) NOT NULL DEFAULT 0,
  `deaths` int(11) NOT NULL DEFAULT 0,
  `boards` int(11) NOT NULL DEFAULT 0,
  `wins` int(11) NOT NULL DEFAULT 0,
  `losses` int(11) NOT NULL DEFAULT 0,
  `failed_revives` int(11) NOT NULL DEFAULT 0,
  `sacrifices` int(11) NOT NULL DEFAULT 0,
  `failed_sacrifices` int(11) NOT NULL DEFAULT 0,
  `drops` int(11) NOT NULL DEFAULT 0,
  `nuke_pickedup` int(11) NOT NULL DEFAULT 0,
  `insta_kill_pickedup` int(11) NOT NULL DEFAULT 0,
  `full_ammo_pickedup` int(11) NOT NULL DEFAULT 0,
  `double_points_pickedup` int(11) NOT NULL DEFAULT 0,
  `meat_stink_pickedup` int(11) NOT NULL DEFAULT 0,
  `carpenter_pickedup` int(11) NOT NULL DEFAULT 0,
  `fire_sale_pickedup` int(11) NOT NULL DEFAULT 0,
  `zombie_blood_pickedup` int(11) NOT NULL DEFAULT 0,
  `time_bomb_ammo_pickedup` int(11) NOT NULL DEFAULT 0,
  `use_magicbox` int(11) NOT NULL DEFAULT 0,
  `grabbed_from_magicbox` int(11) NOT NULL DEFAULT 0,
  `use_perk_random` int(11) NOT NULL DEFAULT 0,
  `grabbed_from_perk_random` int(11) NOT NULL DEFAULT 0,
  `use_pap` int(11) NOT NULL DEFAULT 0,
  `pap_weapon_grabbed` int(11) NOT NULL DEFAULT 0,
  `pap_weapon_not_grabbed` int(11) NOT NULL DEFAULT 0,
  `specialty_armorvest_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_quickrevive_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_rof_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_fastreload_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_flakjacket_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_additionalprimaryweapon_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_longersprint_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_deadshot_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_scavenger_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_finalstand_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_grenadepulldeath_drank` int(11) NOT NULL DEFAULT 0,
  `specialty_nomotionsensor` int(11) NOT NULL DEFAULT 0,
  `claymores_planted` int(11) NOT NULL DEFAULT 0,
  `claymores_pickedup` int(11) NOT NULL DEFAULT 0,
  `ballistic_knives_pickedup` int(11) NOT NULL DEFAULT 0,
  `wallbuy_weapons_purchased` int(11) NOT NULL DEFAULT 0,
  `ammo_purchased` int(11) NOT NULL DEFAULT 0,
  `upgraded_ammo_purchased` int(11) NOT NULL DEFAULT 0,
  `power_turnedon` int(11) NOT NULL DEFAULT 0,
  `power_turnedoff` int(11) NOT NULL DEFAULT 0,
  `planted_buildables_pickedup` int(11) NOT NULL DEFAULT 0,
  `buildables_built` int(11) NOT NULL DEFAULT 0,
  `time_played_total` int(11) NOT NULL DEFAULT 0,
  `weighted_rounds_played` int(11) NOT NULL DEFAULT 0,
  `contaminations_received` int(11) NOT NULL DEFAULT 0,
  `contaminations_given` int(11) NOT NULL DEFAULT 0,
  `zdogs_killed` int(11) NOT NULL DEFAULT 0,
  `zdog_rounds_finished` int(11) NOT NULL DEFAULT 0,
  `zdog_rounds_lost` int(11) NOT NULL DEFAULT 0,
  `killed_by_zdog` int(11) NOT NULL DEFAULT 0,
  `screecher_minigames_won` int(11) NOT NULL DEFAULT 0,
  `screecher_minigames_lost` int(11) NOT NULL DEFAULT 0,
  `screechers_killed` int(11) NOT NULL DEFAULT 0,
  `screecher_teleporters_used` int(11) NOT NULL DEFAULT 0,
  `avogadro_defeated` int(11) NOT NULL DEFAULT 0,
  `killed_by_avogadro` int(11) NOT NULL DEFAULT 0,
  `cheat_too_many_weapons` int(11) NOT NULL DEFAULT 0,
  `cheat_out_of_playable` int(11) NOT NULL DEFAULT 0,
  `cheat_too_friendly` int(11) NOT NULL DEFAULT 0,
  `cheat_total` int(11) NOT NULL DEFAULT 0,
  `prison_tomahawk_acquired` int(11) NOT NULL DEFAULT 0,
  `prison_fan_trap_used` int(11) NOT NULL DEFAULT 0,
  `prison_acid_trap_used` int(11) NOT NULL DEFAULT 0,
  `prison_sniper_tower_used` int(11) NOT NULL DEFAULT 0,
  `prison_ee_good_ending` int(11) NOT NULL DEFAULT 0,
  `prison_ee_bad_ending` int(11) NOT NULL DEFAULT 0,
  `prison_ee_spoon_acquired` int(11) NOT NULL DEFAULT 0,
  `prison_brutus_killed` int(11) NOT NULL DEFAULT 0,
  `buried_lsat_purchased` int(11) NOT NULL DEFAULT 0,
  `buried_fountain_transporter_used` int(11) NOT NULL DEFAULT 0,
  `buried_ghost_killed` int(11) NOT NULL DEFAULT 0,
  `buried_ghost_drained_player` int(11) NOT NULL DEFAULT 0,
  `buried_ghost_perk_acquired` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_booze_given` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_booze_break_barricade` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_given` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_protect` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_build_buildable` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_wallbuy` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_fetch_buildable` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_box_lock` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_box_move` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_box_spin` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_powerup_cycle` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_dance` int(11) NOT NULL DEFAULT 0,
  `buried_sloth_candy_crawler` int(11) NOT NULL DEFAULT 0,
  `buried_wallbuy_placed` int(11) NOT NULL DEFAULT 0,
  `buried_wallbuy_placed_ak74u_zm` int(11) NOT NULL DEFAULT 0,
  `buried_wallbuy_placed_an94_zm` int(11) NOT NULL DEFAULT 0,
  `buried_wallbuy_placed_pdw57_zm` int(11) NOT NULL DEFAULT 0,
  `buried_wallbuy_placed_svu_zm` int(11) NOT NULL DEFAULT 0,
  `buried_wallbuy_placed_tazer_knuckles_zm` int(11) NOT NULL DEFAULT 0,
  `buried_wallbuy_placed_870mcs_zm` int(11) NOT NULL DEFAULT 0,
  `tomb_mechz_killed` int(11) NOT NULL DEFAULT 0,
  `tomb_giant_robot_stomped` int(11) NOT NULL DEFAULT 0,
  `tomb_giant_robot_accessed` int(11) NOT NULL DEFAULT 0,
  `tomb_generator_captured` int(11) NOT NULL DEFAULT 0,
  `tomb_generator_defended` int(11) NOT NULL DEFAULT 0,
  `tomb_generator_lost` int(11) NOT NULL DEFAULT 0,
  `tomb_dig` int(11) NOT NULL DEFAULT 0,
  `tomb_golden_shovel` int(11) NOT NULL DEFAULT 0,
  `tomb_golden_hard_hat` int(11) NOT NULL DEFAULT 0,
  `tomb_perk_extension` int(11) NOT NULL DEFAULT 0,
  `pers_boarding` int(11) NOT NULL DEFAULT 0,
  `pers_revivenoperk` int(11) NOT NULL DEFAULT 0,
  `pers_multikill_headshots` int(11) NOT NULL DEFAULT 0,
  `pers_cash_back_bought` int(11) NOT NULL DEFAULT 0,
  `pers_cash_back_prone` int(11) NOT NULL DEFAULT 0,
  `pers_insta_kill` int(11) NOT NULL DEFAULT 0,
  `pers_nube_5_times` int(11) NOT NULL DEFAULT 0,
  `pers_jugg` int(11) NOT NULL DEFAULT 0,
  `pers_jugg_downgrade_count` int(11) NOT NULL DEFAULT 0,
  `pers_carpenter` int(11) NOT NULL DEFAULT 0,
  `pers_max_round_reached` int(11) NOT NULL DEFAULT 0,
  `pers_flopper_counter` int(11) NOT NULL DEFAULT 0,
  `pers_perk_lose_counter` int(11) NOT NULL DEFAULT 0,
  `pers_pistol_points_counter` int(11) NOT NULL DEFAULT 0,
  `pers_double_points_counter` int(11) NOT NULL DEFAULT 0,
  `pers_sniper_counter` int(11) NOT NULL DEFAULT 0,
  `pers_marathon_counter` int(11) NOT NULL DEFAULT 0,
  `pers_box_weapon_counter` int(11) NOT NULL DEFAULT 0,
  `pers_zombie_kiting_counter` int(11) NOT NULL DEFAULT 0,
  `pers_max_ammo_counter` int(11) NOT NULL DEFAULT 0,
  `pers_melee_bonus_counter` int(11) NOT NULL DEFAULT 0,
  `pers_nube_counter` int(11) NOT NULL DEFAULT 0,
  `pers_last_man_standing_counter` int(11) NOT NULL DEFAULT 0,
  `pers_reload_speed_counter` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of bo2_vanilla_zombie_user_stats
-- ----------------------------
