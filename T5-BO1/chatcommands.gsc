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
		// Run commands on connect here
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	for(;;)
	{
		self waittill("spawned_player");
		// Run commands on player spawn
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
	    // command usage would be .hello
	    // and would spit out 'world'
            case "hello":
                self tell(world());
                break;

	    // Add more commands here same as above
        }
    }
}


// Put functions and threads down here
world()
{
	return "world";
}