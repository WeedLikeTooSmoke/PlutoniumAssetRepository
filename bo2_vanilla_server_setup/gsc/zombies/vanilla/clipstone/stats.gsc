#include maps/mp/_utility;
#include common_scripts/utility;
#include scripts/zm/clipstone/utils;

getLeaderboard(player) {
    headers = [];
	headers["Content-Type"] = "application/json";
	headers["X-API-KEY"] = GetDvar("x_api_key");
    headers["User-Agent"] = "Plutonium/Clipstone";

	data = [];
	data["map"] = getMapName();

	req = httpPost("http://localhost/game/plugins/bo2/zombies/vanilla/plugin.getLeaderboard.php", jsonSerialize(data, 4), headers);
	req waittill("done", result);

    player tell(result);
}

getStats(player) {
    headers = [];
	headers["Content-Type"] = "application/json";
	headers["X-API-KEY"] = GetDvar("x_api_key");
    headers["User-Agent"] = "Plutonium/Clipstone";

	data = [];
	data["guid"] = player getGUID();

	req = httpPost("http://localhost/game/plugins/bo2/zombies/vanilla/plugin.getStats.php", jsonSerialize(data, 4), headers);
	req waittill("done", result);

    stats = strtok(result, ";");

    player tell(stats[0]);
    player tell(stats[1]);
    player tell(stats[2]);
    player tell(stats[3]);
    player tell(stats[4]);
}

endGameUploadStats(player) {
    level waittill("end_game");
    player thread uploadStats(player, 0);
    player thread uploadLeaderboard(player);
}

quit(player) {
    player thread uploadStats(player, 1);
    wait 2;
    executeCommand("clientkick_for_reason  " + player GetEntityNumber() + " \"" + " [^2Clipstone^7] Your ^2stats^7 have been ^2saved^7 and ^2uploaded^7, ^2Thanks^7 for playing on the ^2Clipstone^7 servers!" + "\"");
}

uploadLeaderboard(player) {
    players = getPlayers();
	level.HighRoundPlayers = "";
	for ( i = 0; i < players.size; i++ )
	{
		players[i] resetname();
		if( level.HighRoundPlayers == "" )
		{
			level.HighRoundPlayers = players[i].name + "";
		}
		else
		{
			level.HighRoundPlayers = level.HighRoundPlayers + "," + players[i].name;
		}
	}

    headers = [];
	headers["Content-Type"] = "application/json";
	headers["X-API-KEY"] = GetDvar("x_api_key");
    headers["User-Agent"] = "Plutonium/Clipstone";

	data = [];
	data["map"] = getMapName();
    data["round"] = level.round_number;
    data["players"] = level.highRoundPlayers + "";

	req = httpPost("http://localhost/game/plugins/bo2/zombies/vanilla/plugin.leaderboard.php", jsonSerialize(data, 4), headers);
	req waittill("done", result);

    leaderboard = strtok(result, ";");

    foreach (message in leaderboard) {
        player tell(message);
    }
}

uploadStats(player, quit) {
    round = int(level.round_number) - 1;

    headers = [];
	headers["Content-Type"] = "application/json";
	headers["X-API-KEY"] = GetDvar("x_api_key");
    headers["User-Agent"] = "Plutonium/Clipstone";

	data = [];
	data["guid"] = player getGUID();
    data["quit"] = quit;
    data["score"] = player.score;
    data["round"] = round;
    data["kills"] = player.pers["kills"];
    data["suicides"] = player.pers["suicides"];
    data["downs"] = player.pers["downs"];
    data["revives"] = player.pers["revives"];
    data["perks_drank"] = player.pers["perks_drank"];
    data["headshots"] = player.pers["headshots"];
    data["gibs"] = player.pers["gibs"];
    data["head_gibs"] = player.pers["head_gibs"];
    data["right_arm_gibs"] = player.pers["right_arm_gibs"];
    data["left_arm_gibs"] = player.pers["left_arm_gibs"];
    data["right_leg_gibs"] = player.pers["right_leg_gibs"];
    data["left_leg_gibs"] = player.pers["left_leg_gibs"];
    data["melee_kills"] = player.pers["melee_kills"];
    data["grenade_kills"] = player.pers["grenade_kills"];
    data["doors_purchased"] = player.pers["doors_purchased"];
    data["distance_traveled"] = player.pers["distance_traveled"];
    data["total_shots"] = player.pers["total_shots"];
    data["hits"] = player.pers["hits"];
    data["deaths"] = player.pers["deaths"];
    data["boards"] = player.pers["boards"];
    data["wins"] = player.pers["wins"]; // Grief Stat
    data["losses"] = player.pers["losses"]; // Grief Stat
    data["failed_revives"] = player.pers["failed_revives"];
    data["sacrifices"] = player.pers["sacrifices"];
    data["failed_sacrifices"] = player.pers["failed_sacrifices"];
    data["drops"] = player.pers["drops"];
    data["nuke_pickedup"] = player.pers["nuke_pickedup"];
    data["insta_kill_pickedup"] = player.pers["insta_kill_pickedup"];
    data["full_ammo_pickedup"] = player.pers["full_ammo_pickedup"];
    data["double_points_pickedup"] = player.pers["double_points_pickedup"];
    data["meat_stink_pickedup"] = player.pers["meat_stink_pickedup"];
    data["carpenter_pickedup"] = player.pers["carpenter_pickedup"];
    data["fire_sale_pickedup"] = player.pers["fire_sale_pickedup"];
    data["zombie_blood_pickedup"] = player.pers["zombie_blood_pickedup"];
    data["time_bomb_ammo_pickedup"] = player.pers["time_bomb_ammo_pickedup"];
    data["use_magicbox"] = player.pers["use_magicbox"];
    data["grabbed_from_magicbox"] = player.pers["grabbed_from_magicbox"];
    data["use_perk_random"] = player.pers["use_perk_random"];
    data["grabbed_from_perk_random"] = player.pers["grabbed_from_perk_random"];
    data["use_pap"] = player.pers["use_pap"];
    data["pap_weapon_grabbed"] = player.pers["pap_weapon_grabbed"];
    data["pap_weapon_not_grabbed"] = player.pers["pap_weapon_not_grabbed"];
    data["specialty_armorvest_drank"] = player.pers["specialty_armorvest_drank"];
    data["specialty_quickrevive_drank"] = player.pers["specialty_quickrevive_drank"];
    data["specialty_rof_drank"] = player.pers["specialty_rof_drank"];
    data["specialty_fastreload_drank"] = player.pers["specialty_fastreload_drank"];
    data["specialty_flakjacket_drank"] = player.pers["specialty_flakjacket_drank"];
    data["specialty_additionalprimaryweapon_drank"] = player.pers["specialty_additionalprimaryweapon_drank"];
    data["specialty_longersprint_drank"] = player.pers["specialty_longersprint_drank"];
    data["specialty_deadshot_drank"] = player.pers["specialty_deadshot_drank"];
    data["specialty_scavenger_drank"] = player.pers["specialty_scavenger_drank"];
    data["specialty_finalstand_drank"] = player.pers["specialty_finalstand_drank"];
    data["specialty_grenadepulldeath_drank"] = player.pers["specialty_grenadepulldeath_drank"];
    data["specialty_nomotionsensor"] = player.pers["specialty_nomotionsensor"];
    data["claymores_planted"] = player.pers["claymores_planted"];
    data["claymores_pickedup"] = player.pers["claymores_pickedup"];
    data["ballistic_knives_pickedup"] = player.pers["ballistic_knives_pickedup"];
    data["wallbuy_weapons_purchased"] = player.pers["wallbuy_weapons_purchased"];
    data["ammo_purchased"] = player.pers["ammo_purchased"];
    data["upgraded_ammo_purchased"] = player.pers["upgraded_ammo_purchased"];
    data["power_turnedon"] = player.pers["power_turnedon"];
    data["power_turnedoff"] = player.pers["power_turnedoff"];
    data["planted_buildables_pickedup"] = player.pers["planted_buildables_pickedup"];
    data["buildables_built"] = player.pers["buildables_built"];
    data["time_played_total"] = player.pers["time_played_total"];
    data["weighted_rounds_played"] = player.pers["weighted_rounds_played"];
    data["contaminations_received"] = player.pers["contaminations_received"];
    data["contaminations_given"] = player.pers["contaminations_given"];
    data["zdogs_killed"] = player.pers["zdogs_killed"];
    data["zdog_rounds_finished"] = player.pers["zdog_rounds_finished"];
    data["zdog_rounds_lost"] = player.pers["zdog_rounds_lost"];
    data["killed_by_zdog"] = player.pers["killed_by_zdog"];
    data["screecher_minigames_won"] = player.pers["screecher_minigames_won"];
    data["screecher_minigames_lost"] = player.pers["screecher_minigames_lost"];
    data["screechers_killed"] = player.pers["screechers_killed"];
    data["screecher_teleporters_used"] = player.pers["screecher_teleporters_used"];
    data["avogadro_defeated"] = player.pers["avogadro_defeated"];
    data["killed_by_avogadro"] = player.pers["killed_by_avogadro"];
    data["cheat_too_many_weapons"] = player.pers["cheat_too_many_weapons"];
    data["cheat_out_of_playable"] = player.pers["cheat_out_of_playable"];
    data["cheat_too_friendly"] = player.pers["cheat_too_friendly"];
    data["cheat_total"] = player.pers["cheat_total"];
    data["prison_tomahawk_acquired"] = player.pers["prison_tomahawk_acquired"];
    data["prison_fan_trap_used"] = player.pers["prison_fan_trap_used"];
    data["prison_acid_trap_used"] = player.pers["prison_acid_trap_used"];
    data["prison_sniper_tower_used"] = player.pers["prison_sniper_tower_used"];
    data["prison_ee_good_ending"] = player.pers["prison_ee_good_ending"];
    data["prison_ee_bad_ending"] = player.pers["prison_ee_bad_ending"];
    data["prison_ee_spoon_acquired"] = player.pers["prison_ee_spoon_acquired"];
    data["prison_brutus_killed"] = player.pers["prison_brutus_killed"];
    data["buried_lsat_purchased"] = player.pers["buried_lsat_purchased"];
    data["buried_fountain_transporter_used"] = player.pers["buried_fountain_transporter_used"];
    data["buried_ghost_killed"] = player.pers["buried_ghost_killed"];
    data["buried_ghost_drained_player"] = player.pers["buried_ghost_drained_player"];
    data["buried_ghost_perk_acquired"] = player.pers["buried_ghost_perk_acquired"];
    data["buried_sloth_booze_given"] = player.pers["buried_sloth_booze_given"];
    data["buried_sloth_booze_break_barricade"] = player.pers["buried_sloth_booze_break_barricade"];
    data["buried_sloth_candy_given"] = player.pers["buried_sloth_candy_given"];
    data["buried_sloth_candy_protect"] = player.pers["buried_sloth_candy_protect"];
    data["buried_sloth_candy_build_buildable"] = player.pers["buried_sloth_candy_build_buildable"];
    data["buried_sloth_candy_wallbuy"] = player.pers["buried_sloth_candy_wallbuy"];
    data["buried_sloth_candy_fetch_buildable"] = player.pers["buried_sloth_candy_fetch_buildable"];
    data["buried_sloth_candy_box_lock"] = player.pers["buried_sloth_candy_box_lock"];
    data["buried_sloth_candy_box_move"] = player.pers["buried_sloth_candy_box_move"];
    data["buried_sloth_candy_box_spin"] = player.pers["buried_sloth_candy_box_spin"];
    data["buried_sloth_candy_powerup_cycle"] = player.pers["buried_sloth_candy_powerup_cycle"];
    data["buried_sloth_candy_dance"] = player.pers["buried_sloth_candy_dance"];
    data["buried_sloth_candy_crawler"] = player.pers["buried_sloth_candy_crawler"];
    data["buried_wallbuy_placed"] = player.pers["buried_wallbuy_placed"];
    data["buried_wallbuy_placed_ak74u_zm"] = player.pers["buried_wallbuy_placed_ak74u_zm"];
    data["buried_wallbuy_placed_an94_zm"] = player.pers["buried_wallbuy_placed_an94_zm"];
    data["buried_wallbuy_placed_pdw57_zm"] = player.pers["buried_wallbuy_placed_pdw57_zm"];
    data["buried_wallbuy_placed_svu_zm"] = player.pers["buried_wallbuy_placed_svu_zm"];
    data["buried_wallbuy_placed_tazer_knuckles_zm"] = player.pers["buried_wallbuy_placed_tazer_knuckles_zm"];
    data["buried_wallbuy_placed_870mcs_zm"] = player.pers["buried_wallbuy_placed_870mcs_zm"];
    data["tomb_mechz_killed"] = player.pers["tomb_mechz_killed"];
    data["tomb_giant_robot_stomped"] = player.pers["tomb_giant_robot_stomped"];
    data["tomb_giant_robot_accessed"] = player.pers["tomb_giant_robot_accessed"];
    data["tomb_generator_captured"] = player.pers["tomb_generator_captured"];
    data["tomb_generator_defended"] = player.pers["tomb_generator_defended"];
    data["tomb_generator_lost"] = player.pers["tomb_generator_lost"];
    data["tomb_dig"] = player.pers["tomb_dig"];
    data["tomb_golden_shovel"] = player.pers["tomb_golden_shovel"];
    data["tomb_golden_hard_hat"] = player.pers["tomb_golden_hard_hat"];
    data["tomb_perk_extension"] = player.pers["tomb_perk_extension"];
    data["pers_boarding"] = player.pers["pers_boarding"];
    data["pers_revivenoperk"] = player.pers["pers_revivenoperk"];
    data["pers_multikill_headshots"] = player.pers["pers_multikill_headshots"];
    data["pers_cash_back_bought"] = player.pers["pers_cash_back_bought"];
    data["pers_cash_back_prone"] = player.pers["pers_cash_back_prone"];
    data["pers_insta_kill"] = player.pers["pers_insta_kill"];
    data["pers_nube_5_times"] = player.pers["pers_nube_5_times"];
    data["pers_jugg"] = player.pers["pers_jugg"];
    data["pers_jugg_downgrade_count"] = player.pers["pers_jugg_downgrade_count"];
    data["pers_carpenter"] = player.pers["pers_carpenter"];
    data["pers_max_round_reached"] = player.pers["pers_max_round_reached"];
    data["pers_flopper_counter"] = player.pers["pers_flopper_counter"];
    data["pers_perk_lose_counter"] = player.pers["pers_perk_lose_counter"];
    data["pers_pistol_points_counter"] = player.pers["pers_pistol_points_counter"];
    data["pers_double_points_counter"] = player.pers["pers_double_points_counter"];
    data["pers_sniper_counter"] = player.pers["pers_sniper_counter"];
    data["pers_marathon_counter"] = player.pers["pers_marathon_counter"];
    data["pers_box_weapon_counter"] = player.pers["pers_box_weapon_counter"];
    data["pers_zombie_kiting_counter"] = player.pers["pers_zombie_kiting_counter"];
    data["pers_max_ammo_counter"] = player.pers["pers_max_ammo_counter"];
    data["pers_melee_bonus_counter"] = player.pers["pers_melee_bonus_counter"];
    data["pers_nube_counter"] = player.pers["pers_nube_counter"];
    data["pers_last_man_standing_counter"] = player.pers["pers_last_man_standing_counter"];
    data["pers_reload_speed_counter"] = player.pers["pers_reload_speed_counter"];

	req = httpPost("http://localhost/game/plugins/bo2/zombies/vanilla/plugin.stats.php", jsonSerialize(data, 4), headers);
	req waittill("done", result);

    player tell(result);
}