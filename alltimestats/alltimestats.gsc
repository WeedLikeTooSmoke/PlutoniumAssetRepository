#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/_utility;
#include maps/mp/zombies/_zm_utility;

/*
	DDDDec's Plutonium T6 bet command
*/
init()
{	
	/*
	
		Run threads here that're for the level
	
	*/
    level thread onPlayerConnect();
    level thread onPlayerSay();
    level.perk_purchase_limit = 9;
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player); // Waits till the player conencts
	player thread updateStatsOnQuit(player);
		/*
        
			Use threads here that you want to run after the player connects
			Make sure to run functions after waittills
		
		*/
    }
}

onPlayerSay()
{
    level endon("end_game"); // End thread when the game ends
	self endon("disconnect"); // End thread for player who disconnected
    self endon("death"); // End thread for player who died
	self endon("player_downed"); // End thread for player if their player is in the downed state
   
    prefix = "."; // Set the prefix variable
    for (;;)
    {
        level waittill("say", message, player); // Waits till a player says something
        message = toLower(message); // Makes the player message lower case
        if(!level.intermission && message[0] == prefix) // Checks if game is still in intermission & if player said something with the prefix in
        {
            args = strtok(message, " "); // Split the player message into arguments
            command = getSubStr(args[0], 1); 
            switch(command) {					
				case "alltimestats":
				case "ats":
					playerAllTimeStats = strToK(player.pers["alltimestats"], ";");
					kills = playerAllTimeStats[0];
					revives = playerAllTimeStats[1];
					headshots = playerAllTimeStats[2];
					downs = playerAllTimeStats[3];
					round = playerAllTimeStats[4];
					player tell("^2Kills^7: " + kills);
					player tell("^2Revives^7: " + revives);
					player tell("^2Headshots^7: " + headshots);
					player tell("^2Downs^7: " + downs);
					player tell("^2Highest Round^7: " + round);
					break;
				/*
				
				Add more here
				case "longCommandName":
				case "shortCommandName":
					functionName(argument);
					break;
				
				*/
            }
        }
    }
}

updateStatsOnQuit(player)
{
	self endon( "disconnect" );
	level waittill("end_game");
	
	path = "alltimestats/" + self getGuid() + ".txt";
	sortStats = strToK(player.pers["alltimestats"], ";");
	sortKills = int(sortStats[0]) + int(player.pers["kills"]);
	sortRevives = int(sortStats[1]) + int(player.pers["revives"]);
	sortHeadshots = int(sortStats[2]) + int(player.pers["headshots"]);
	sortDowns = int(sortStats[3]) + int(player.pers["downs"]);
	if (level.round_number > int(sortRound))
	{
		sortRound = level.round_number;
	}
	else
	{
		sortRound = int(sortStats[4]);
	}
	newStats = sortKills+";"+sortRevives+";"+sortHeadshots+";"+sortDowns+";"+sortRound+"";
	
	file = fopen(path, "w");
    	fwrite(file, newStats + "");
    	fclose(file);
}

setupStats()
{
    self endon("disconnect");
    level endon("end_game");
    
    path = "alltimestats/" + self getGuid() + ".txt";
    if (!fileExists(path))
    {
        writeFile(path, "");
        while(!fileExists(path)) wait 0.5;
        file2 = fopen(path, "w");
        fwrite(file2, "0;0;0;0;0");
        fclose(file2);
        self.pers["alltimestats"] = "0;0;0;0;0";  
    }
    else
    {
        self.pers["alltimestats"] = readFile(path);
    }
}
