servervote(player)
{
	headers = [];
	headers["Content-Type"] = "application/json";

	data = [];
	data["guid"] = player getGuid();

  req = httpPost("http://localhost/vote.php", jsonSerialize(data, 0), headers);
	req waittill("done", result);
	
	splitreturn = strToK(result, ";");
	
	if (splitreturn[1] == "true")
	{
		player tell(splitreturn[0]);
	}
	else
	{
		player tell(splitreturn[0]);
	}
}
