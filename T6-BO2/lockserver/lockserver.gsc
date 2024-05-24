#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/_utility;
#include maps/mp/zombies/_zm_utility;

/*
	DDDDec's Plutonium T6 Lock Server Command
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
				case "lockserver":
					if (player.score > 9999)
					{
						if(level.round_number > 0)
						{
							if (isdefined(args[1]))
							{
								level thread lockserver(player, args[1]);
							}
							else 
							{
								player tell("You didn't input a ^2password^7 to lock the server with!");
							}
						} 
						else 
						{
							player tell("Round needs to be higher than ^230+^7 to use this command!");
						}
					}
					else
					{
						player tell("You need ^2$10000^7 to lock the server behind a password!");
					}
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

lockserver(player, password)
{
	setdvar("g_password", password);
	setdvar("password", password);
	player tell("You paid ^2$^710000 to lock this current game session");
	player.score = player.score - 10000;
	level thread unlockserver();
	for(;;)
	{
		player tell("^2Locked Server Password^7: " + password);
		wait(60);
	}
}

unlockserver()
{
	level waittill ("end_game");
	setdvar("g_password", "");
	setdvar("password", "");
}
