#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/_utility;
#include maps/mp/zombies/_zm_utility;

/*
	DDDDec's Plutonium T6 Nickname
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
	player thread setupnickname();
		/*
        
			Use threads here that you want to run after the player connects
			Make sure to run functions after waittills
		
		*/
    }
}

setupnickname()
{
	self endon("disconnect");
	level endon("end_game");
	path = "nickname/" + self getguid() + ".txt";
	if(!fileexists(path))
	{
		writefile(path, "");
		while(!fileexists(path))
		{
			wait 0.5;
		}
		file2 = fopen(path, "w");
		fwrite(file2, self.name);
		fclose(file2);
		self.pers["nickname"] = self.name;
	}
	else
	{
		self.pers["nickname"] = readfile(path);
	}
}

/*

Then you would use something like this to change their name to the nickname and other ranks/levels/clantags:

player rename("[" + player.pers["tagColor"] + "" + player.pers["tag"] + "^7][" + player.pers["rank"] + "][" + player.pers["level
"] + "] " + player.pers["nickname"]);

*/
