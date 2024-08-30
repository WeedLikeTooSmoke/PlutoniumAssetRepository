help(player, args) {
    headers = [];
	headers["Content-Type"] = "application/json";
	headers["X-API-KEY"] = GetDvar("x_api_key");
    headers["User-Agent"] = "Plutonium/Clipstone";

	data = [];
	data["page"] = args[1];

	req = httpPost("http://localhost/game/plugins/bo2/zombies/vanilla/plugin.help.php", jsonSerialize(data, 4), headers);
	req waittill("done", result);

    help = strtok(result, ";");

    foreach (message in help) {
        player tell(message);
    }
}