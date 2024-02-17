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
    level.perk_purchase_limit = 9;
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player); // Waits till the player conencts
        player thread playerpaycheck(player);
		/*
        
			Use threads here that you want to run after the player connects
			Make sure to run functions after waittills
		
		*/
    }
}

playerpaycheck(player)
{
	if(player.pers["rank"] == "Player")
	{
		for(;;)
		{
			player.score = player.score + 10 * int(player.pers["rank"]);
			wait(2);
		}
	}
	else if(player.pers["rank"] == "VIP")
	{
		for(;;)
		{
			player.score = player.score + 10 * int(player.pers["rank"]);
			wait(1.5);
		}
	}
	else if(player.pers["rank"] == "VIP++")
	{
		for(;;)
		{
			player.score = player.score + 10 * int(player.pers["rank"]);
			wait(1);
		}
	}
}
