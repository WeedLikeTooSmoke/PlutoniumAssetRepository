<?php

class Vanilla extends Database {
    public function request($item, $type) {
        global $request;

        if ($item == $request[$type]) { return true; } else { return false; }
    }

    public function account() {
        global $settings;

        if (self::request($_SERVER["HTTP_X_API_KEY"], "X_API_KEY")) {

            if (self::request($_SERVER["HTTP_USER_AGENT"], "USER_AGENT")) {

                if (isset($_POST["username"], $_POST["guid"]) && preg_match("/^[0-9]*$/", $_POST['guid'])) {

                    $guid = $_POST["guid"];
                    $username = $_POST["username"];

                    $stmt = $this->connect()->prepare("SELECT * FROM bo2_vanilla_zombie_users WHERE guid = ?");
                    $stmt->execute([$guid]);

                    if ($stmt->RowCount() > 0) {

                        $account = $stmt->fetch();

                        echo "[{$settings["server_color"]}Account^7] Welcome back {$settings["server_color"]}$username^7, You have been logged into your account;[". $account['color'] . sortRank($account['rank']) ."^7] ". $account['color'] ."$username^7;{$account['rank']};{$account['language']}";

                    } else {

                        $stmt = $this->connect()->prepare("INSERT INTO bo2_vanilla_zombie_users (guid, username) values (?, ?)");
                        $stmt->execute([$guid, $username]);

                        $stmt = $this->connect()->prepare("INSERT INTO bo2_vanilla_zombie_user_stats (guid) VALUES (?)");
                        $stmt->execute([$guid]);

                        echo "[{$settings["server_color"]}Account^7] Welcome to {$settings["server_color"]}{$settings["server_name"]} ".$username."^7, Your account has been created;[PLAYER] $username;0;english";

                    }

                } else {

                    echo "[^1ERROR^7] Something went wrong recieving your player data";

                }

            } else {
    
                echo "[^1ERROR^7] You have been denied access to this plugin";
    
            }

        } else {

            echo "[^1ERROR^7] You have been denied access to this plugin";

        }
    }

    public function stats() {
        global $settings;

        if (self::request($_SERVER["HTTP_X_API_KEY"], "X_API_KEY")) {

            if (self::request($_SERVER["HTTP_USER_AGENT"], "USER_AGENT")) {

                if (isset($_POST["guid"]) && preg_match("/^[0-9]*$/", $_POST['guid'])) {

                    $guid = $_POST["guid"];
                    $quit = $_POST["quit"] ?? 0;
                    $score = $_POST["score"] ?? 0;
                    $round = $_POST["round"] ?? 0;
                    $kills = $_POST["kills"] ?? 0;
                    $suicides = $_POST["suicides"] ?? 0;
                    $downs = $_POST["downs"] ?? 0;
                    $revives = $_POST["revives"] ?? 0;
                    $perks_drank = $_POST["perks_drank"] ?? 0;
                    $headshots = $_POST["headshots"] ?? 0;
                    $gibs = $_POST["gibs"] ?? 0;
                    $head_gibs = $_POST["head_gibs"] ?? 0;
                    $right_arm_gibs = $_POST["right_arm_gibs"] ?? 0;
                    $left_arm_gibs = $_POST["left_arm_gibs"] ?? 0;
                    $right_leg_gibs = $_POST["right_leg_gibs"] ?? 0;
                    $left_leg_gibs = $_POST["left_leg_gibs"] ?? 0;
                    $melee_kills = $_POST["melee_kills"] ?? 0;
                    $grenade_kills = $_POST["grenade_kills"] ?? 0;
                    $doors_purchased = $_POST["doors_purchased"] ?? 0;
                    $distance_traveled = $_POST["distance_traveled"] ?? 0;
                    $total_shots = $_POST["total_shots"] ?? 0;
                    $hits = $_POST["hits"] ?? 0;
                    $deaths = $_POST["deaths"] ?? 0;
                    $boards = $_POST["boards"] ?? 0;
                    $wins = $_POST["wins"] ?? 0;
                    $losses = $_POST["losses"] ?? 0;
                    $failed_revives = $_POST["failed_revives"] ?? 0;
                    $sacrifices = $_POST["sacrifices"] ?? 0;
                    $failed_sacrifices = $_POST["failed_sacrifices"] ?? 0;
                    $drops = $_POST["drops"] ?? 0;
                    $nuke_pickedup = $_POST["nuke_pickedup"] ?? 0;
                    $insta_kill_pickedup = $_POST["insta_kill_pickedup"] ?? 0;
                    $full_ammo_pickedup = $_POST["full_ammo_pickedup"] ?? 0;
                    $double_points_pickedup = $_POST["double_points_pickedup"] ?? 0;
                    $meat_stink_pickedup = $_POST["meat_stink_pickedup"] ?? 0;
                    $carpenter_pickedup = $_POST["carpenter_pickedup"] ?? 0;
                    $fire_sale_pickedup = $_POST["fire_sale_pickedup"] ?? 0;
                    $zombie_blood_pickedup = $_POST["zombie_blood_pickedup"] ?? 0;
                    $time_bomb_ammo_pickedup = $_POST["time_bomb_ammo_pickedup"] ?? 0;
                    $use_magicbox = $_POST["use_magicbox"] ?? 0;
                    $grabbed_from_magicbox = $_POST["grabbed_from_magicbox"] ?? 0;
                    $use_perk_random = $_POST["use_perk_random"] ?? 0;
                    $grabbed_from_perk_random = $_POST["grabbed_from_perk_random"] ?? 0;
                    $use_pap = $_POST["use_pap"] ?? 0;
                    $pap_weapon_grabbed = $_POST["pap_weapon_grabbed"] ?? 0;
                    $pap_weapon_not_grabbed = $_POST["pap_weapon_not_grabbed"] ?? 0;
                    $specialty_armorvest_drank = $_POST["specialty_armorvest_drank"] ?? 0;
                    $specialty_quickrevive_drank = $_POST["specialty_quickrevive_drank"] ?? 0;
                    $specialty_rof_drank = $_POST["specialty_rof_drank"] ?? 0;
                    $specialty_fastreload_drank = $_POST["specialty_fastreload_drank"] ?? 0;
                    $specialty_flakjacket_drank = $_POST["specialty_flakjacket_drank"] ?? 0;
                    $specialty_additionalprimaryweapon_drank = $_POST["specialty_additionalprimaryweapon_drank"] ?? 0;
                    $specialty_longersprint_drank = $_POST["specialty_longersprint_drank"] ?? 0;
                    $specialty_deadshot_drank = $_POST["specialty_deadshot_drank"] ?? 0;
                    $specialty_scavenger_drank = $_POST["specialty_scavenger_drank"] ?? 0;
                    $specialty_finalstand_drank = $_POST["specialty_finalstand_drank"] ?? 0;
                    $specialty_grenadepulldeath_drank = $_POST["specialty_grenadepulldeath_drank"] ?? 0;
                    $specialty_nomotionsensor = $_POST["specialty_nomotionsensor"] ?? 0;
                    $claymores_planted = $_POST["claymores_planted"] ?? 0;
                    $claymores_pickedup = $_POST["claymores_pickedup"] ?? 0;
                    $ballistic_knives_pickedup = $_POST["ballistic_knives_pickedup"] ?? 0;
                    $wallbuy_weapons_purchased = $_POST["wallbuy_weapons_purchased"] ?? 0;
                    $ammo_purchased = $_POST["ammo_purchased"] ?? 0;
                    $upgraded_ammo_purchased = $_POST["upgraded_ammo_purchased"] ?? 0;
                    $power_turnedon = $_POST["power_turnedon"] ?? 0;
                    $power_turnedoff = $_POST["power_turnedoff"] ?? 0;
                    $planted_buildables_pickedup = $_POST["planted_buildables_pickedup"] ?? 0;
                    $buildables_built = $_POST["buildables_built"] ?? 0;
                    $time_played_total = $_POST["time_played_total"] ?? 0;
                    $weighted_rounds_played = $_POST["weighted_rounds_played"] ?? 0;
                    $contaminations_received = $_POST["contaminations_received"] ?? 0;
                    $contaminations_given = $_POST["contaminations_given"] ?? 0;
                    $zdogs_killed = $_POST["zdogs_killed"] ?? 0;
                    $zdog_rounds_finished = $_POST["zdog_rounds_finished"] ?? 0;
                    $zdog_rounds_lost = $_POST["zdog_rounds_lost"] ?? 0;
                    $killed_by_zdog = $_POST["killed_by_zdog"] ?? 0;
                    $screecher_minigames_won = $_POST["screecher_minigames_won"] ?? 0;
                    $screecher_minigames_lost = $_POST["screecher_minigames_lost"] ?? 0;
                    $screechers_killed = $_POST["screechers_killed"] ?? 0;
                    $screecher_teleporters_used = $_POST["screecher_teleporters_used"] ?? 0;
                    $avogadro_defeated = $_POST["avogadro_defeated"] ?? 0;
                    $killed_by_avogadro = $_POST["killed_by_avogadro"] ?? 0;
                    $cheat_too_many_weapons = $_POST["cheat_too_many_weapons"] ?? 0;
                    $cheat_out_of_playable = $_POST["cheat_out_of_playable"] ?? 0;
                    $cheat_too_friendly = $_POST["cheat_too_friendly"] ?? 0;
                    $cheat_total = $_POST["cheat_total"] ?? 0;
                    $prison_tomahawk_acquired = $_POST["prison_tomahawk_acquired"] ?? 0;
                    $prison_fan_trap_used = $_POST["prison_fan_trap_used"] ?? 0;
                    $prison_acid_trap_used = $_POST["prison_acid_trap_used"] ?? 0;
                    $prison_sniper_tower_used = $_POST["prison_sniper_tower_used"] ?? 0;
                    $prison_ee_good_ending = $_POST["prison_ee_good_ending"] ?? 0;
                    $prison_ee_bad_ending = $_POST["prison_ee_bad_ending"] ?? 0;
                    $prison_ee_spoon_acquired = $_POST["prison_ee_spoon_acquired"] ?? 0;
                    $prison_brutus_killed = $_POST["prison_brutus_killed"] ?? 0;
                    $buried_lsat_purchased = $_POST["buried_lsat_purchased"] ?? 0;
                    $buried_fountain_transporter_used = $_POST["buried_fountain_transporter_used"] ?? 0;
                    $buried_ghost_killed = $_POST["buried_ghost_killed"] ?? 0;
                    $buried_ghost_drained_player = $_POST["buried_ghost_drained_player"] ?? 0;
                    $buried_ghost_perk_acquired = $_POST["buried_ghost_perk_acquired"] ?? 0;
                    $buried_sloth_booze_given = $_POST["buried_sloth_booze_given"] ?? 0;
                    $buried_sloth_booze_break_barricade = $_POST["buried_sloth_booze_break_barricade"] ?? 0;
                    $buried_sloth_candy_given = $_POST["buried_sloth_candy_given"] ?? 0;
                    $buried_sloth_candy_protect = $_POST["buried_sloth_candy_protect"] ?? 0;
                    $buried_sloth_candy_build_buildable = $_POST["buried_sloth_candy_build_buildable"] ?? 0;
                    $buried_sloth_candy_wallbuy = $_POST["buried_sloth_candy_wallbuy"] ?? 0;
                    $buried_sloth_candy_fetch_buildable = $_POST["buried_sloth_candy_fetch_buildable"] ?? 0;
                    $buried_sloth_candy_box_lock = $_POST["buried_sloth_candy_box_lock"] ?? 0;
                    $buried_sloth_candy_box_move = $_POST["buried_sloth_candy_box_move"] ?? 0;
                    $buried_sloth_candy_box_spin = $_POST["buried_sloth_candy_box_spin"] ?? 0;
                    $buried_sloth_candy_powerup_cycle = $_POST["buried_sloth_candy_powerup_cycle"] ?? 0;
                    $buried_sloth_candy_dance = $_POST["buried_sloth_candy_dance"] ?? 0;
                    $buried_sloth_candy_crawler = $_POST["buried_sloth_candy_crawler"] ?? 0;
                    $buried_wallbuy_placed = $_POST["buried_wallbuy_placed"] ?? 0;
                    $buried_wallbuy_placed_ak74u_zm = $_POST["buried_wallbuy_placed_ak74u_zm"] ?? 0;
                    $buried_wallbuy_placed_an94_zm = $_POST["buried_wallbuy_placed_an94_zm"] ?? 0;
                    $buried_wallbuy_placed_pdw57_zm = $_POST["buried_wallbuy_placed_pdw57_zm"] ?? 0;
                    $buried_wallbuy_placed_svu_zm = $_POST["buried_wallbuy_placed_svu_zm"] ?? 0;
                    $buried_wallbuy_placed_tazer_knuckles_zm = $_POST["buried_wallbuy_placed_tazer_knuckles_zm"] ?? 0;
                    $buried_wallbuy_placed_870mcs_zm = $_POST["buried_wallbuy_placed_870mcs_zm"] ?? 0;
                    $tomb_mechz_killed = $_POST["tomb_mechz_killed"] ?? 0;
                    $tomb_giant_robot_stomped = $_POST["tomb_giant_robot_stomped"] ?? 0;
                    $tomb_giant_robot_accessed = $_POST["tomb_giant_robot_accessed"] ?? 0;
                    $tomb_generator_captured = $_POST["tomb_generator_captured"] ?? 0;
                    $tomb_generator_defended = $_POST["tomb_generator_defended"] ?? 0;
                    $tomb_generator_lost = $_POST["tomb_generator_lost"] ?? 0;
                    $tomb_dig = $_POST["tomb_dig"] ?? 0;
                    $tomb_golden_shovel = $_POST["tomb_golden_shovel"] ?? 0;
                    $tomb_golden_hard_hat = $_POST["tomb_golden_hard_hat"] ?? 0;
                    $tomb_perk_extension = $_POST["tomb_perk_extension"] ?? 0;
                    $pers_boarding = $_POST["pers_boarding"] ?? 0;
                    $pers_revivenoperk = $_POST["pers_revivenoperk"] ?? 0;
                    $pers_multikill_headshots = $_POST["pers_multikill_headshots"] ?? 0;
                    $pers_cash_back_bought = $_POST["pers_cash_back_bought"] ?? 0;
                    $pers_cash_back_prone = $_POST["pers_cash_back_prone"] ?? 0;
                    $pers_insta_kill = $_POST["pers_insta_kill"] ?? 0;
                    $pers_nube_5_times = $_POST["pers_nube_5_times"] ?? 0;
                    $pers_jugg = $_POST["pers_jugg"] ?? 0;
                    $pers_jugg_downgrade_count = $_POST["pers_jugg_downgrade_count"] ?? 0;
                    $pers_carpenter = $_POST["pers_carpenter"] ?? 0;
                    $pers_max_round_reached = $_POST["pers_max_round_reached"] ?? 0;
                    $pers_flopper_counter = $_POST["pers_flopper_counter"] ?? 0;
                    $pers_perk_lose_counter = $_POST["pers_perk_lose_counter"] ?? 0;
                    $pers_pistol_points_counter = $_POST["pers_pistol_points_counter"] ?? 0;
                    $pers_double_points_counter = $_POST["pers_double_points_counter"] ?? 0;
                    $pers_sniper_counter = $_POST["pers_sniper_counter"] ?? 0;
                    $pers_marathon_counter = $_POST["pers_marathon_counter"] ?? 0;
                    $pers_box_weapon_counter = $_POST["pers_box_weapon_counter"] ?? 0;
                    $pers_zombie_kiting_counter = $_POST["pers_zombie_kiting_counter"] ?? 0;
                    $pers_max_ammo_counter = $_POST["pers_max_ammo_counter"] ?? 0;
                    $pers_melee_bonus_counter = $_POST["pers_melee_bonus_counter"] ?? 0;
                    $pers_nube_counter = $_POST["pers_nube_counter"] ?? 0;
                    $pers_last_man_standing_counter = $_POST["pers_last_man_standing_counter"] ?? 0;
                    $pers_reload_speed_counter = $_POST["pers_reload_speed_counter"] ?? 0;
                    

                    $stmt = $this->connect()->prepare("SELECT * FROM bo2_vanilla_zombie_user_stats WHERE guid = ?");
                    $stmt->execute([$guid]);

                    if ($stmt->RowCount() > 0) {

                        $stats = $stmt->fetch();

                        if ($score > $stats["highest_score"]) { $highest_score = $score; } else { $highest_score = $stats["highest_score"]; }
                        if ($round > $stats["highest_round"]) { $highest_round = $round; } else { $highest_round = $stats["highest_round"]; }

                        $stmt = $this->connect()->prepare("UPDATE bo2_vanilla_zombie_user_stats SET
                        quit = quit + ?,
                        score = score + ?,
                        highest_score = ?,
                        rounds = rounds + ?,
                        highest_round = ?,
                        kills = kills + ?,
                        suicides = suicides + ?,
                        downs = downs + ?,
                        revives = revives + ?,
                        perks_drank = perks_drank + ?,
                        headshots = headshots + ?,
                        gibs = gibs + ?,
                        head_gibs = head_gibs + ?,
                        right_arm_gibs = right_arm_gibs + ?,
                        left_arm_gibs = left_arm_gibs + ?,
                        right_leg_gibs = right_leg_gibs + ?,
                        left_leg_gibs = left_leg_gibs + ?,
                        melee_kills = melee_kills + ?,
                        grenade_kills = grenade_kills + ?,
                        doors_purchased = doors_purchased + ?,
                        distance_traveled = distance_traveled + ?,
                        total_shots = total_shots + ?,
                        hits = hits+ ?,
                        deaths = deaths + ?,
                        boards = boards + ?,
                        wins = wins + ?,
                        losses = losses + ?,
                        failed_revives = failed_revives + ?,
                        sacrifices = sacrifices + ?,
                        failed_sacrifices = failed_sacrifices + ?,
                        drops = drops + ?,
                        nuke_pickedup = nuke_pickedup + ?,
                        insta_kill_pickedup = insta_kill_pickedup + ?,
                        full_ammo_pickedup = full_ammo_pickedup + ?,
                        double_points_pickedup = double_points_pickedup + ?,
                        meat_stink_pickedup = meat_stink_pickedup + ?,
                        carpenter_pickedup = carpenter_pickedup + ?,
                        fire_sale_pickedup = fire_sale_pickedup + ?,
                        zombie_blood_pickedup = zombie_blood_pickedup + ?,
                        time_bomb_ammo_pickedup = time_bomb_ammo_pickedup + ?,
                        use_magicbox = use_magicbox + ?,
                        grabbed_from_magicbox = grabbed_from_magicbox + ?,
                        use_perk_random = use_perk_random + ?,
                        grabbed_from_perk_random = grabbed_from_perk_random + ?,
                        use_pap = use_pap + ?,
                        pap_weapon_grabbed = pap_weapon_grabbed + ?,
                        pap_weapon_not_grabbed = pap_weapon_not_grabbed + ?,
                        specialty_armorvest_drank = specialty_armorvest_drank + ?,
                        specialty_quickrevive_drank = specialty_quickrevive_drank + ?,
                        specialty_rof_drank = specialty_rof_drank + ?,
                        specialty_fastreload_drank = specialty_fastreload_drank + ?,
                        specialty_flakjacket_drank = specialty_flakjacket_drank + ?,
                        specialty_additionalprimaryweapon_drank = specialty_additionalprimaryweapon_drank + ?,
                        specialty_longersprint_drank = specialty_longersprint_drank + ?,
                        specialty_deadshot_drank = specialty_deadshot_drank + ?,
                        specialty_scavenger_drank = specialty_scavenger_drank + ?,
                        specialty_finalstand_drank = specialty_finalstand_drank + ?,
                        specialty_grenadepulldeath_drank = specialty_grenadepulldeath_drank + ?,
                        specialty_nomotionsensor = specialty_nomotionsensor + ?,
                        claymores_planted = claymores_planted + ?,
                        claymores_pickedup = claymores_pickedup + ?,
                        ballistic_knives_pickedup = ballistic_knives_pickedup + ?,
                        wallbuy_weapons_purchased = wallbuy_weapons_purchased + ?,
                        ammo_purchased = ammo_purchased + ?,
                        upgraded_ammo_purchased = upgraded_ammo_purchased + ?,
                        power_turnedon = power_turnedon + ?,
                        power_turnedoff = power_turnedoff + ?,
                        planted_buildables_pickedup = planted_buildables_pickedup + ?,
                        buildables_built = buildables_built + ?,
                        time_played_total = time_played_total + ?,
                        weighted_rounds_played = weighted_rounds_played + ?,
                        contaminations_received = contaminations_received + ?,
                        contaminations_given = contaminations_given + ?,
                        zdogs_killed = zdogs_killed + ?,
                        zdog_rounds_finished = zdog_rounds_finished + ?,
                        zdog_rounds_lost = zdog_rounds_lost + ?,
                        killed_by_zdog = killed_by_zdog + ?,
                        screecher_minigames_won = screecher_minigames_won + ?,
                        screecher_minigames_lost = screecher_minigames_lost + ?,
                        screechers_killed = screechers_killed + ?,
                        screecher_teleporters_used = screecher_teleporters_used + ?,
                        avogadro_defeated = avogadro_defeated + ?,
                        killed_by_avogadro = killed_by_avogadro + ?,
                        cheat_too_many_weapons = cheat_too_many_weapons + ?,
                        cheat_out_of_playable = cheat_out_of_playable + ?,
                        cheat_too_friendly = cheat_too_friendly + ?,
                        cheat_total = cheat_total + ?,
                        prison_tomahawk_acquired = prison_tomahawk_acquired + ?,
                        prison_fan_trap_used = prison_fan_trap_used + ?,
                        prison_acid_trap_used = prison_acid_trap_used + ?,
                        prison_sniper_tower_used = prison_sniper_tower_used + ?,
                        prison_ee_good_ending = prison_ee_good_ending + ?,
                        prison_ee_bad_ending = prison_ee_bad_ending + ?,
                        prison_ee_spoon_acquired = prison_ee_spoon_acquired + ?,
                        prison_brutus_killed = prison_brutus_killed + ?,
                        buried_lsat_purchased = buried_lsat_purchased + ?,
                        buried_fountain_transporter_used = buried_fountain_transporter_used + ?,
                        buried_ghost_killed = buried_ghost_killed + ?,
                        buried_ghost_drained_player = buried_ghost_drained_player + ?,
                        buried_ghost_perk_acquired = buried_ghost_perk_acquired + ?,
                        buried_sloth_booze_given = buried_sloth_booze_given + ?,
                        buried_sloth_booze_break_barricade = buried_sloth_booze_break_barricade + ?,
                        buried_sloth_candy_given = buried_sloth_candy_given + ?,
                        buried_sloth_candy_protect = buried_sloth_candy_protect + ?,
                        buried_sloth_candy_build_buildable = buried_sloth_candy_build_buildable + ?,
                        buried_sloth_candy_wallbuy = buried_sloth_candy_wallbuy + ?,
                        buried_sloth_candy_fetch_buildable = buried_sloth_candy_fetch_buildable + ?,
                        buried_sloth_candy_box_lock = buried_sloth_candy_box_lock + ?,
                        buried_sloth_candy_box_move = buried_sloth_candy_box_move + ?,
                        buried_sloth_candy_box_spin = buried_sloth_candy_box_spin + ?,
                        buried_sloth_candy_powerup_cycle = buried_sloth_candy_powerup_cycle + ?,
                        buried_sloth_candy_dance = buried_sloth_candy_dance + ?,
                        buried_sloth_candy_crawler = buried_sloth_candy_crawler + ?,
                        buried_wallbuy_placed = buried_wallbuy_placed + ?,
                        buried_wallbuy_placed_ak74u_zm = buried_wallbuy_placed_ak74u_zm + ?,
                        buried_wallbuy_placed_an94_zm = buried_wallbuy_placed_an94_zm + ?,
                        buried_wallbuy_placed_pdw57_zm = buried_wallbuy_placed_pdw57_zm + ?,
                        buried_wallbuy_placed_svu_zm = buried_wallbuy_placed_svu_zm + ?,
                        buried_wallbuy_placed_tazer_knuckles_zm = buried_wallbuy_placed_tazer_knuckles_zm + ?,
                        buried_wallbuy_placed_870mcs_zm = buried_wallbuy_placed_870mcs_zm + ?,
                        tomb_mechz_killed = tomb_mechz_killed + ?,
                        tomb_giant_robot_stomped = tomb_giant_robot_stomped + ?,
                        tomb_giant_robot_accessed = tomb_giant_robot_accessed + ?,
                        tomb_generator_captured = tomb_generator_captured + ?,
                        tomb_generator_defended = tomb_generator_defended + ?,
                        tomb_generator_lost = tomb_generator_lost + ?,
                        tomb_dig = tomb_dig + ?,
                        tomb_golden_shovel = tomb_golden_shovel + ?,
                        tomb_golden_hard_hat = tomb_golden_hard_hat+ ?,
                        tomb_perk_extension = tomb_perk_extension + ?,
                        pers_boarding = pers_boarding + ?,
                        pers_revivenoperk = pers_revivenoperk + ?,
                        pers_multikill_headshots = pers_multikill_headshots + ?,
                        pers_cash_back_bought = pers_cash_back_bought + ?,
                        pers_cash_back_prone = pers_cash_back_prone + ?,
                        pers_insta_kill = pers_insta_kill + ?,
                        pers_nube_5_times = pers_nube_5_times + ?,
                        pers_jugg = pers_jugg + ?,
                        pers_jugg_downgrade_count = pers_jugg_downgrade_count + ?,
                        pers_carpenter = pers_carpenter + ?,
                        pers_max_round_reached = pers_max_round_reached + ?,
                        pers_flopper_counter = pers_flopper_counter + ?,
                        pers_perk_lose_counter = pers_perk_lose_counter + ?,
                        pers_pistol_points_counter = pers_pistol_points_counter + ?,
                        pers_double_points_counter = pers_double_points_counter + ?,
                        pers_sniper_counter = pers_sniper_counter + ?,
                        pers_marathon_counter = pers_marathon_counter + ?,
                        pers_box_weapon_counter = pers_box_weapon_counter + ?,
                        pers_zombie_kiting_counter = pers_zombie_kiting_counter + ?,
                        pers_max_ammo_counter = pers_max_ammo_counter + ?,
                        pers_melee_bonus_counter = pers_melee_bonus_counter + ?,
                        pers_nube_counter = pers_nube_counter + ?,
                        pers_last_man_standing_counter = pers_last_man_standing_counter + ?,
                        pers_reload_speed_counter = pers_reload_speed_counter + ?
                        WHERE guid = ?");
                        $stmt->execute([$quit, $score, $highest_score, $round, $highest_round, $kills, $suicides, $downs, $revives, $perks_drank, $headshots, $gibs, $head_gibs, $right_arm_gibs, $left_arm_gibs, $right_leg_gibs, $left_leg_gibs, $melee_kills, $grenade_kills, $doors_purchased, $distance_traveled, $total_shots, $hits, $deaths, $boards, $wins, $losses, $failed_revives, $sacrifices, $failed_sacrifices, $drops, $nuke_pickedup, $insta_kill_pickedup, $full_ammo_pickedup, $double_points_pickedup, $meat_stink_pickedup, $carpenter_pickedup, $fire_sale_pickedup, $zombie_blood_pickedup, $time_bomb_ammo_pickedup, $use_magicbox, $grabbed_from_magicbox, $use_perk_random, $grabbed_from_perk_random, $use_pap, $pap_weapon_grabbed, $pap_weapon_not_grabbed, $specialty_armorvest_drank, $specialty_quickrevive_drank, $specialty_rof_drank, $specialty_fastreload_drank, $specialty_flakjacket_drank, $specialty_additionalprimaryweapon_drank, $specialty_longersprint_drank, $specialty_deadshot_drank, $specialty_scavenger_drank, $specialty_finalstand_drank, $specialty_grenadepulldeath_drank, $specialty_nomotionsensor, $claymores_planted, $claymores_pickedup, $ballistic_knives_pickedup, $wallbuy_weapons_purchased, $ammo_purchased, $upgraded_ammo_purchased, $power_turnedon, $power_turnedoff, $planted_buildables_pickedup, $buildables_built, $time_played_total, $weighted_rounds_played, $contaminations_received, $contaminations_given, $zdogs_killed, $zdog_rounds_finished, $zdog_rounds_lost, $killed_by_zdog, $screecher_minigames_won, $screecher_minigames_lost, $screechers_killed, $screecher_teleporters_used, $avogadro_defeated, $killed_by_avogadro, $cheat_too_many_weapons, $cheat_out_of_playable, $cheat_too_friendly, $cheat_total, $prison_tomahawk_acquired, $prison_fan_trap_used, $prison_acid_trap_used, $prison_sniper_tower_used, $prison_ee_good_ending, $prison_ee_bad_ending, $prison_ee_spoon_acquired, $prison_brutus_killed, $buried_lsat_purchased, $buried_fountain_transporter_used, $buried_ghost_killed, $buried_ghost_drained_player, $buried_ghost_perk_acquired, $buried_sloth_booze_given, $buried_sloth_booze_break_barricade, $buried_sloth_candy_given, $buried_sloth_candy_protect, $buried_sloth_candy_build_buildable, $buried_sloth_candy_wallbuy, $buried_sloth_candy_fetch_buildable, $buried_sloth_candy_box_lock, $buried_sloth_candy_box_move, $buried_sloth_candy_box_spin, $buried_sloth_candy_powerup_cycle, $buried_sloth_candy_dance, $buried_sloth_candy_crawler, $buried_wallbuy_placed, $buried_wallbuy_placed_ak74u_zm, $buried_wallbuy_placed_an94_zm, $buried_wallbuy_placed_pdw57_zm, $buried_wallbuy_placed_svu_zm, $buried_wallbuy_placed_tazer_knuckles_zm, $buried_wallbuy_placed_870mcs_zm, $tomb_mechz_killed, $tomb_giant_robot_stomped, $tomb_giant_robot_accessed, $tomb_generator_captured, $tomb_generator_defended, $tomb_generator_lost, $tomb_dig, $tomb_golden_shovel, $tomb_golden_hard_hat, $tomb_perk_extension, $pers_boarding, $pers_revivenoperk, $pers_multikill_headshots, $pers_cash_back_bought, $pers_cash_back_prone, $pers_insta_kill, $pers_nube_5_times, $pers_jugg, $pers_jugg_downgrade_count, $pers_carpenter, $pers_max_round_reached, $pers_flopper_counter, $pers_perk_lose_counter, $pers_pistol_points_counter, $pers_double_points_counter, $pers_sniper_counter, $pers_marathon_counter, $pers_box_weapon_counter, $pers_zombie_kiting_counter, $pers_max_ammo_counter, $pers_melee_bonus_counter, $pers_nube_counter, $pers_last_man_standing_counter, $pers_reload_speed_counter, $guid]);

                        echo "[{$settings["server_color"]}{$settings["server_name"]}^7] Your stats have been uploaded to your account";

                    } else {

                        echo "[{$settings["server_color"]}{$settings["server_name"]}^7] Seems you don't have an account to upload the stats to";

                    }

                } else {

                    echo "[^1ERROR^7] Something went wrong recieving your player data";
        
                }

            } else {

                echo "[^1ERROR^7] You have been denied access to this plugin";
    
            }

        } else {

            echo "[^1ERROR^7] You have been denied access to this plugin";

        }
    }

    public function welcome() {
        global $settings;

        if (self::request($_SERVER["HTTP_X_API_KEY"], "X_API_KEY")) {

            if (self::request($_SERVER["HTTP_USER_AGENT"], "USER_AGENT")) {

                if (isset($_POST["map"])) {

                    $map = $_POST['map'];

                    $stmt = $this->connect()->prepare("SELECT * FROM bo2_vanilla_round_leaderboard WHERE map = ?");
                    $stmt->execute([$map]);

                    if ($stmt->RowCount() > 0) {

                        $leaderboard = $stmt->fetch();
                        echo "------------[ {$settings["server_color"]}{$settings["server_name"]} Zombies^7 ]------------;Welcome to the {$settings["server_color"]}{$settings["server_name"]}^7 vanilla black ops 2 servers;The leaderboard for {$settings["server_color"]}$map^7 is round {$settings["server_color"]}{$leaderboard['round']} by {$leaderboard['players']};Use commands {$settings["server_color"]}.help^7 or {$settings["server_color"]}.commands^7 for a list of commands;-----------[ {$settings["server_color"]}discord.gg/clipstone^7 ]-----------";

                    } else {

                        echo "[^1ERROR^7] Their is not a leaderboard for $map";

                    }

                } else {

                    echo "[^1ERROR^7] Something went wrong recieving data from the server";

                }

            } else {

                echo "[^1ERROR^7] You have been denied access to this plugin";

            }

        } else {

            echo "[^1ERROR^7] You have been denied access to this plugin";

        }
    }

    public function getStats() {
        global $settings;

        if (self::request($_SERVER["HTTP_X_API_KEY"], "X_API_KEY")) {

            if (self::request($_SERVER["HTTP_USER_AGENT"], "USER_AGENT")) {

                if (isset($_POST["guid"]) && preg_match("/^[0-9]*$/", $_POST['guid'])) {

                    $guid = $_POST['guid'];

                    $stmt = $this->connect()->prepare("SELECT * FROM bo2_vanilla_zombie_user_stats WHERE guid = ?");
                    $stmt->execute([$guid]);

                    if ($stmt->RowCount() > 0) {

                        $stats = $stmt->fetch();
                        echo "[{$settings["server_color"]}{$settings["server_name"]}^7] Kills | {$settings["server_color"]}".number_format($stats['kills']).";[{$settings["server_color"]}{$settings["server_name"]}^7] Downs | {$settings["server_color"]}".number_format($stats['downs']).";[{$settings["server_color"]}{$settings["server_name"]}^7] Revives | {$settings["server_color"]}".number_format($stats['revives']).";[{$settings["server_color"]}{$settings["server_name"]}^7] Deaths | {$settings["server_color"]}".number_format($stats['deaths']).";[{$settings["server_color"]}{$settings["server_name"]}^7] Highest Round | {$settings["server_color"]}".number_format($stats['highest_round']);

                    } else {

                        echo "[^1ERROR^7] You don't have an account to fetch data from";

                    }

                } else {

                    echo "[^1ERROR^7] Something went wrong recieving data from the server";

                }

            } else {

                echo "[^1ERROR^7] You have been denied access to this plugin";

            }

        } else {

            echo "[^1ERROR^7] You have been denied access to this plugin";

        }
    }

    public function getLeaderboard() {
        global $settings;

        if (self::request($_SERVER["HTTP_X_API_KEY"], "X_API_KEY")) {

            if (self::request($_SERVER["HTTP_USER_AGENT"], "USER_AGENT")) {

                if (isset($_POST["map"])) {

                    $map = $_POST["map"];

                    $stmt = $this->connect()->prepare("SELECT * FROM bo2_vanilla_round_leaderboard WHERE map = ?");
                    $stmt->execute([$map]);

                    if ($stmt->RowCount() > 0) {

                        $leaderboard = $stmt->fetch();
                        echo "[{$settings["server_color"]}{$settings["server_name"]}^7] $map | round {$settings["server_color"]}{$leaderboard["round"]}^7 by {$settings["server_color"]}{$leaderboard["players"]}^7";

                    } else {

                        echo "[^1ERROR^7] You don't have an account to fetch data from";

                    }

                } else {

                    echo "[^1ERROR^7] Something went wrong recieving data from the server";

                }

            } else {

                echo "[^1ERROR^7] You have been denied access to this plugin";

            }

        } else {

            echo "[^1ERROR^7] You have been denied access to this plugin";

        }
    }

    public function help() {
        global $settings;

        if (self::request($_SERVER["HTTP_X_API_KEY"], "X_API_KEY")) {

            if (self::request($_SERVER["HTTP_USER_AGENT"], "USER_AGENT")) {

                if (isset($_POST["page"]) && is_numeric($_POST['page'])) {

                    $page = $_POST["page"];

                    if ($page == 1) {
                        echo "[{$settings["server_color"]}{$settings["server_name"]}^7] {$settings["server_color"]}.info^7 | Shows {$settings["server_name"]}'s socials and contacts;[{$settings["server_color"]}{$settings["server_name"]}^7] {$settings["server_color"]}.leaderboard^7 | Shows the current maps leaderboard;[{$settings["server_color"]}{$settings["server_name"]}^7] {$settings["server_color"]}.alltimestats^7 | Shows your all time main stats";
                    } else {

                    }

                } else {

                    echo "[{$settings["server_color"]}{$settings["server_name"]}^7] {$settings["server_color"]}.help <page>^7 | {$settings["server_color"]}.commands <page>^7";

                }

            } else {

                echo "[^1ERROR^7] You have been denied access to this plugin";

            }

        } else {

            echo "[^1ERROR^7] You have been denied access to this plugin";

        }
    }

    public function leaderboard() {
        global $settings;

        if (self::request($_SERVER["HTTP_X_API_KEY"], "X_API_KEY")) {

            if (self::request($_SERVER["HTTP_USER_AGENT"], "USER_AGENT")) {

                if (isset($_POST['map'], $_POST['round'], $_POST['players'])) {

                    $map = $_POST['map'];
                    $round = $_POST['round'];
                    $players = $_POST['players'];

                    $stmt = $this->connect()->prepare("SELECT * FROM bo2_vanilla_round_leaderboard WHERE map = ?");
                    $stmt->execute([$map]);

                    if ($stmt->RowCount() > 0) {

                        $leaderboard = $stmt->fetch();

                        if ($round > $leaderboard['round']) {

                            echo "[{$settings["server_color"]}{$settings["server_name"]}^7] You have beaten {$settings["server_color"]}{$leaderboard['players']}'s^7 previous record for {$settings["server_color"]}$map^7;[{$settings["server_color"]}{$settings["server_name"]}^7] New record for {$settings["server_color"]}$map^7 is {$settings["server_color"]}$round^7 by {$settings["server_color"]}$players^7";

                            $stmt = $this->connect()->prepare("UPDATE bo2_vanilla_round_leaderboard SET players = ?, round = ? WHERE map = ?");
                            $stmt->execute([$players, $round, $map]);

                        } else {

                            echo "[{$settings["server_color"]}{$settings["server_name"]}^7] You didn't break the record for {$settings["server_color"]}$map";

                        }

                    } else {

                        echo "[{$settings["server_color"]}{$settings["server_name"]}^7] Their are no records for {$settings["server_color"]}$map";

                    }

                } else {

                    echo "[^1ERROR^7] Failed to recieve data from the server";

                }

            } else {

                echo "[^1ERROR^7] You have been denied access to this plugin";

            }

        } else {

            echo "[^1ERROR^7] You have been denied access to this plugin";

        }
    }

    public function server() {
        global $settings;

        if (self::request($_SERVER["HTTP_X_API_KEY"], "X_API_KEY")) {

            if (self::request($_SERVER["HTTP_USER_AGENT"], "USER_AGENT")) {

                echo "[{$settings["server_color"]}{$settings["server_name"]}^7] Discord | {$settings["server_color"]}{$settings["server_discord"]};[{$settings["server_color"]}{$settings["server_name"]}^7] Website | {$settings["server_color"]}{$settings["server_website"]}";

            } else {

                echo "[^1ERROR^7] You have been denied access to this plugin";

            }

        } else {

            echo "[^1ERROR^7] You have been denied access to this plugin";

        }
    }

    public function getAccount() {
        global $settings;

        if (self::request($_SERVER["HTTP_X_API_KEY"], "X_API_KEY")) {

            if (self::request($_SERVER["HTTP_USER_AGENT"], "USER_AGENT")) {

                if (isset($_POST['guid']) && preg_match("/^[0-9]*$/", $_POST['guid'])) {

                    $guid = $_POST['guid'];

                    $stmt = $this->connect()->prepare("SELECT * FROM bo2_vanilla_zombie_users WHERE guid = ?");
                    $stmt->execute([$guid]);

                    if ($stmt->RowCount() > 0) {

                        $account = $stmt->fetch();

                        echo "[{$settings["server_color"]}{$settings["server_name"]}^7] GUID | {$settings["server_color"]}$guid^7;[{$settings["server_color"]}{$settings["server_name"]}^7] Username | {$settings["server_color"]}{$account['username']}^7;[{$settings["server_color"]}{$settings["server_name"]}^7] Rank | {$settings["server_color"]}". sortRank($account['rank']) ."^7;[{$settings["server_color"]}{$settings["server_name"]}^7] Language | {$settings["server_color"]}{$account['language']}^7";

                    } else {

                        echo "[^1ERROR^7] You do not have an account to get data from";

                    }

                } else {

                    echo "[^1ERROR^7] Failed to recieve data from the server";

                }

            } else {

                echo "[^1ERROR^7] You have been denied access to this plugin";

            }

        } else {

            echo "[^1ERROR^7] You have been denied access to this plugin";

        }
    }
}
