#include maps/mp/_utility;
#include common_scripts/utility;

/*

	Server Init(), Main(), onPlayerConnect() & OnPlayerSay()
	
*/

init()
{		
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread points(player);
    }
}

points(player)
{
    level waittill("initial_blackscreen_passed");

	while(true)
	{
   // Only gives the player the multiplied amount if the death of the zombie isnt by a head shot!
		self waittill( "zombie_death_no_headshot" );

  // If you dont have a global per for your players just change the 'player.pers["level"]' to a int you want to times and remove 'if (int(player.pers["level"]) > 0)'
		if (int(player.pers["level"]) > 0)
			player.score += 10 * int(player.pers["level"]);
	}
}
