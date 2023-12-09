#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/_utility;
#include maps/mp/zombies/_zm_utility;

/*
	DDDDec's Plutonium T6 script example using T6 Utils by fedddddd
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
		player thread setupVaultFolder()
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
				case "vault": // The name of the command taht you want them to use .vault
				case "vlt": // The name of the command taht you want them to use .vlt
					crackVault(player, args); // Runs crackVault(player, args); function 
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

setupVaultFolder()
{
    self endon("disconnect"); // End on player disconnect for player who disconnected
    level endon("end_game"); // End on level for all players
	
    numOne = randomIntRange(0, 10); // Return a random in from a range
	numTwo = randomIntRange(0, 10); // Return a random in from a range
	numThree = randomIntRange(0, 10); // Return a random in from a range
	numFour = randomIntRange(0, 10); // Return a random in from a range
	
	numFive = randomIntRange(0, 100000); // Return a random in from a range
	
    path = "bank/"+ numOne +""+ numTwo +""+ numThree +""+ numFour +".txt"; // Path to folder > file
	
    if (!fileExists(path)) // Check if file exists
    {
        writeFile(path, ""); // Write the file using path variable
        while(!fileExists(path)) wait 0.5; // Loop till it creates folder > file

        file = fopen(path, "w"); // Open file stream using path variable
        fwrite(file, numFive); // Write to the file stream
        fclose(file); // Close file stream
    }
}

crackVault(player, args)
{
	self endon("disconnect"); // Ends thread for player on player disconnect
	level endon("end_game"); // Ends thread for level on end game (everyone in the game died)

	path2 = "vault/" + args[1] + ".txt"; // variable containing path to the vault folder

    if (!fileExists(path2)) // Checks if file exists in the folder
    {
        player tell("No vault's were cracked with the code, " + args[1] + "!"); // Tells the player who executed the command
    }
    else
    {
    self.pers["vaultAmount"] = int(readFile(path2)); // Read value from the file
 
    if(int(self.pers["vaultAmount"]) == 0) // Checks i file has been set to 0 therefore has been cracked
    {
        player tell("Sorry, this vault seems to have already been cracked!"); // Tells the player who executed the command
    }
    else
    { 
        player.score += int(self.pers["vaultAmount"]); // Adds the file value to the player score   
        player tell("Congratulations!!!, U cracked vault, " + args[1] + " and won ^2$^7" + int(self.pers["vaultAmount"])); // Tells the player who executed the command
			
        file2 = fopen(path2, "w"); // Opens a file of given name with given mode, returns a file stream
        fremove(file2); // Deletes a file - Removes whatever value is inside the file
        fclose(file2); // Closes the file stream
    }
}
