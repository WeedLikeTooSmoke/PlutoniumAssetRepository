#include common_scripts\utility;
#include maps\_utility;

init()
{
	onPlayerSay(::player_say);
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill ("connecting", player);
		// player connect functions and threads
	}
}

onPlayerSpawned()
{
	for(;;)
	{
		self waittill("spawned_player");
		// player spawned functions and threads
	}
}

player_say(message, mode)
{	
    prefix = ".";
    message = toLower(message);  
    if(message[0] == prefix)
    {
        args = strtok(message, " ");
        command = getSubStr(args[0], 1);

        switch(command) 
        {
		case "test":
		self tell(httprequest());
        }
    }
}

httprequest()
{
	url = "http://localhost/helloworld.php";
    
	headers = [];
	headers["Content-Type"] = "application/json";
    
	data = [];
	data["username"] = self.playername;

	options = [];
	options["headers"] = headers;
	options["body"] = jsonSerialize(data, 0);

	request = http::request(url, options);
	request waittill("done", result, success, error);

	return result;
}