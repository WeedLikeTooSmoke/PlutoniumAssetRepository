#include maps/mp/_utility;
#include common_scripts/utility;

#include scripts/zm/clipstone/account;
#include scripts/zm/clipstone/stats;
#include scripts/zm/clipstone/welcome;
#include scripts/zm/clipstone/utils;
#include scripts/zm/clipstone/help;

init() {		
    level thread onPlayerConnect();
    level thread onPlayerSay();
}

onPlayerConnect() {
    for (;;) {
        level waittill("connected", player);

        // Enabled God Mode
        // player.ignoreme = 1;
		// player enableInvulnerability();

        player thread account(player);
        player thread welcome(player);
        player thread endGameUploadStats(player);
    }
}

onPlayerSay() {
    level endon("end_game");
	self endon("disconnect");
   
    prefix = ".";
    for (;;) {
        level waittill("say", message, player);
        message = toLower(message);
		if (!level.intermission && message[0] == prefix) {
            args = strtok(message, " ");
            command = getSubStr(args[0], 1);
            switch(command) {	
                case "info":
                case "contact":
                case "server":
                case "discord":
                case "website":
                    server(player);
                    break;

				case "quit":
                    quit(player);
                    break;

                case "stats":
                case "s":
                    getStats(player);
                    break;

                case "leaderboard":
                case "lb":
                    getLeaderboard(player);
                    break;

                case "help":
                case "h":
                case "commands":
                case "command":
                case "cmds":
                    help(player, args);
                    break;
            }
        }
    }
}

server(player) {
    headers = [];
	headers["Content-Type"] = "application/json";
	headers["X-API-KEY"] = GetDvar("x_api_key");
    headers["User-Agent"] = "Plutonium/Clipstone";

	req = httpPost("http://localhost/game/plugins/bo2/zombies/vanilla/plugin.server.php", jsonSerialize(data, 4), headers);
	req waittill("done", result);

    server = strtok(result, ";");

    foreach (message in server) {
        player tell(message);
    }
}