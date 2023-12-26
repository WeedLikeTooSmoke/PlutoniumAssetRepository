#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/_utility;
#include maps/mp/zombies/_zm_utility;

/*
	DDDDec's Plutonium T6 Clan Tag Levels
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
		    player thread setupLevel();
        player thread setupPlayerLevel();
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

setupLevel() // Initialize level value
{
    self endon("disconnect");
    level endon("end_game");
    
    path2 = "level/" + self getGuid() + ".txt";
    if (!fileExists(path2))
    {
        /*
            Each player will have his or her own file containing the value of their level
            This system decreases the search for an O(1) time information. 
            Direct access to information without use of any search algortim.
        */
        writeFile(path2, "");
        while(!fileExists(path2)) wait 0.5;

        // Set default level value to 0
        file2 = fopen(path2, "w");
        fwrite(file2, "0");
        fclose(file2);
        self.pers["level"] = 0;  
    }
    else
    {
        self.pers["level"] = int(readFile(path2)); // Read value from the file
    }
}

setupPlayerLevel() 
{
	if(self.pers["level"] == 1) 
	{
		self setClantag("^41^2");
	}
	else if(self.pers["level"] == 2)
	{
		self setClantag("^42^2");
	}
	else if(self.pers["level"] == 3)
	{
		self setClantag("^43^2");
	}
	else if(self.pers["level"] == 4)
	{
		self setClantag("^44^2");
	}
	else if(self.pers["level"] == 5)
	{
		self setClantag("^45^2");
	}
	else if(self.pers["level"] == 6)
	{
		self setClantag("^46^2");
	}
	else if(self.pers["level"] == 7)
	{
		self setClantag("^47^2");
	}
	else if(self.pers["level"] == 8)
	{
		self setClantag("^48^2");
	}
	else if(self.pers["level"] == 9)
	{
		self setClantag("^49^2");
	}
	else if(self.pers["level"] == 10)
	{
		self setClantag("^410^2");
	}
	else if(self.pers["level"] == 11)
	{
		self setClantag("^5VIP^2");
	}
	else if(self.pers["level"] == 12)
	{
		self setClantag("^6MOD^2");
	}
	else
	{
		self setClantag("^40^2");
	}
}

playerLevelUp(player)
{
	if(player.pers["level"] == 0)
	{
		if(player.score >= 5000)
		{
			player tell("You just leveled up for ^2$^75000");
			player.score -= 5000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^41^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^75000");
		}
	}
	else if(player.pers["level"] == 1)
	{
		if(player.score >= 10000)
		{
			player tell("You just leveled up for ^2$^710000");
			player.score -= 10000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^42^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^710000");
		}
	}
	else if(player.pers["level"] == 2)
	{
		if(player.score >= 25000)
		{
			player tell("You just leveled up for ^2$^725000");
			player.score -= 25000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^43^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^725000");
		}
	}
	else if(player.pers["level"] == 3)
	{
		if(player.score >= 75000)
		{
			player tell("You just leveled up for ^2$^775000");
			player.score -= 75000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^44^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^775000");
		}
	}
	else if(player.pers["level"] == 4)
	{
		if(player.score >= 100000)
		{
			player tell("You just leveled up for ^2$^7100000");
			player.score -= 100000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^45^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^7100000");
		}
	}
	else if(player.pers["level"] == 5)
	{
		if(player.score >= 200000)
		{
			player tell("You just leveled up for ^2$^7200000");
			player.score -= 200000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^46^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^7200000");
		}
	}
	else if(player.pers["level"] == 6)
	{
		if(player.score >= 300000)
		{
			player tell("You just leveled up for ^2$^7300000");
			player.score -= 300000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^47^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^7300000");
		}
	}
	else if(player.pers["level"] == 7)
	{
		if(player.score >= 400000)
		{
			player tell("You just leveled up for ^2$^7400000");
			player.score -= 400000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^48^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^400000");
		}
	}
	else if(player.pers["level"] == 8)
	{
		if(player.score >= 500000)
		{
			player tell("You just leveled up for ^2$^7500000");
			player.score -= 500000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^49^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^7500000");
		}
	}
	else if(player.pers["level"] == 9)
	{
		if(player.score >= 750000)
		{
			player tell("You just leveled up for ^2$^7750000");
			player.score -= 750000;
			player.pers["level"] = int(player.pers["level"]) + 1;
			player updatelevelValue(player.pers["level"]);
			player setClantag("^410^2");
			player playsound("zmb_cha_ching");
		}
		else
		{
			player tell("You do not have enough money to level up, you need ^2$^7750000");
		}
	}
	else
	{
		player tell("You cannot level up any more!");
	}
}


updatelevelValue( value ) // Update bank value into the file
{
    path = "level/" + self getGuid() + ".txt";

    // Overwrite the bank value
    file = fopen( path, "w" );
    fwrite(file, value + "");
    fclose(file);
}
