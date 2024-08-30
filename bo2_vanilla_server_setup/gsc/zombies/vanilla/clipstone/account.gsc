account(player) {
    headers = [];
	headers["Content-Type"] = "application/json";
	headers["X-API-KEY"] = GetDvar("x_api_key");
    headers["User-Agent"] = "Plutonium/Clipstone";

	data = [];
	data["username"] = player.name;
	data["guid"] = player getGUID();

	req = httpPost("http://localhost/game/plugins/bo2/zombies/vanilla/plugin.account.php", jsonSerialize(data, 4), headers);
	req waittill("done", result);

    account = strtok(result, ";");

	player resetName();
	player rename(account[1]);

	player.pers["rank"] = account[2];
	player.pers["language"] = account[3];

	player tell(account[0]);

	account = undefined;
}