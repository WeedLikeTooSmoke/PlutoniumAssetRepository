#include scripts/zm/clipstone/utils;

welcome(player) {
    headers = [];
	headers["Content-Type"] = "application/json";
	headers["X-API-KEY"] = GetDvar("x_api_key");
    headers["User-Agent"] = "Plutonium/Clipstone";

	data = [];
	data["map"] = getMapName();

	req = httpPost("http://localhost/game/plugins/bo2/zombies/vanilla/plugin.welcome.php", jsonSerialize(data, 4), headers);
	req waittill("done", result);

    welcome = strtok(result, ";");

    wait 0.5;

    foreach (message in welcome) {
        player tell(message);
    }

    // player tell(welcome[0]);
    // player tell(welcome[1]);
    // player tell(welcome[2]);
    // player tell(welcome[3]);
    // player tell(welcome[4]);	
}