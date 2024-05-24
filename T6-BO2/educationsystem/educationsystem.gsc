#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/_utility;
#include maps/mp/zombies/_zm_utility;

/*
	DDDDec's Plutonium T6 Education System & Commands
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
        player thread educationsystem(player);
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
				    case "answerquestion":
				    case "aq":
				    {
					    answereducationsystem(player, args);
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

educationsystem(player)
{
	for(;;)
	{
		questions = [];
		questions[0] = "What is 172 + 48;220";
		questions[1] = "What is 723 + 175;898";
		questions[2] = "What is 102 + 682;784";
		questions[3] = "What is 62 + 17;79";
		questions[4] = "What is 5 x 5;25";
		questions[5] = "What is 17 x 3;51";
		questions[6] = "What is 4 x 11;44";
		questions[7] = "What is 12 x 13;156";
		questions[8] = "What is 26 - 12;14";
		questions[9] = "What is 129 - 53;76";
		questions[10] = "What is 520 - 274;246";
		questions[11] = "What is 862 - 127;735";
		player.pers["educationSystemActive"] = 1;
		level waittill("end_of_round");wait(0,2);
		player.pers["educationSystemQuestion"] = "";
		player.pers["educationSystemAnswer"] = "";
		randomnum = randomintrange(0, 12);
		splitquestion = strtok(questions[randomnum], ";");
		self tell("Education System: " + splitquestion[0] + "?");
		self tell("You have 30 seconds to answer the question correctly");
		player.pers["educationSystemQuestion"] = splitquestion[0];
		player.pers["educationSystemAnswer"] = splitquestion[1];
		player.pers["educationSystemActive"] = 0;
		wait(30);
		player.pers["educationSystemQuestion"] = undefined;
		player.pers["educationSystemAnswer"] = undefined;
		questions = undefined;
		player.pers["educationSystemActive"] = 1;
	}
}

answereducationsystem(player, args)
{
	if(player.pers["educationSystemActive"] == 0)
	{
		if(int(args[1]) == int(player.pers["educationSystemAnswer"]))
		{
			if(isdefined(args[1]))
			{
				randomnum = randomintrange(0, 5000);
				player resetname();
				say(player.name + " Answered the question correctly for: " + player.pers["educationSystemQuestion"] + "!");
				player.score = player.score + randomnum;
				player tell("You've recieved ^2$^7" + randomnum + ", For answering the question correctly!");
				player.pers["educationSystemQuestion"] = undefined;
				player.pers["educationSystemAnswer"] = undefined;
				player.pers["educationSystemActive"] = 1;
				player rename("[" + player.pers["tagColor"] + "" + player.pers["tag"] + "^7][" + player.pers["rank"] + "][" + player.pers["GSC
"] + "] " + player.pers["nickname"]);
			}
			else
			{
				player tell("^2.answerquestion^7/^2.aq <^2Answer^7> ^7- Answer the education question");
			}
		}
		else
		{
			player tell(args[1] + " is incorrect");
		}
	}
	else
	{
		player tell("There are no active education questions");
	}
}
