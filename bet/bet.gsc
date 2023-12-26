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
				case "bet": // The name of the command taht you want them to use .vault
				case "b": // The name of the command taht you want them to use .vlt
					bet(player, args); // Runs bet(player, args); function 
					break; // End
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

bet(player, args)
{
	self endon("disconnect"); // ends on player disconnect
  self endon("death"); // ends on player death
	self endon("player_downed"); // ends when player is downed
	if (getDvarIntDefault("sv_allowchatbet", 1) == 0) // checks if bets are allowed from dvar
	{
	}
	else
	{
		if (isDefined(args[1])) // checks if amount is set
		{
			if (args[1] == "all") // checks if amount is all
			{
				if (player.score > 0)  // checks if player money is not empty 
				{
					if (randomIntRange(1, 20) <= 6) // returns a random int number
					{
						player tell("^7You won your bet of ^2$^7" + player.score * 2 + "!"); // tells player they won
						player.score = player.score * 2; // gives player the money they won
						player playsound("zmb_cha_ching"); // plays the ca ching sound for the player
					}
					else
					{
						player tell("^7You lost your bet of ^2$^7" + player.score + "!"); // tells player they lost
						player.score = 0; // sets their money to 0 since they bet all
					}
				}
			}
			else 
			{
				if (isInteger(args[1]) && player.score >= int(args[1])) // checks if arg is defined and if player actually has the money out their bank
				{
					if (randomIntRange(1, 20) <= 6) // returns random int number
					{
						player tell("^7You won your bet of ^2$^7" + int(args[1] * 2) + "!"); // tells player they won
						player.score = player.score + int(args[1]) * 2; // gives player the money they won
						player playsound("zmb_cha_ching"); // plays the ca ching sound for the player
					}
					else
					{
						player tell("^7You lost your bet of ^2$^7" + int(args[1]) + "!"); // tells player they lost
						player.score = player.score - int(args[1]); // sets their money to 0 since they bet all
					}
				}
				else
				{
						player tell("^7You cannot make this bet of ^2$^7" + int(args[1]) + "..."); // tells player they cant afford to bet
				}
			}
		}
	}
}
