#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/_utility;
#include maps/mp/zombies/_zm_utility;

/*
	DDDDec's Plutonium T6 crack vault script example using T6 Utils by fedddddd
*/
init()
{	
	/*
	
		Run threads here that're for the level
	
	*/
	level.custom_vending_precaching = ::default_vending_precaching;
	precachemodel( "p6_zm_vending_electric_cherry_on" );
    level thread onPlayerConnect();
    level thread onPlayerSay();
    level.perk_purchase_limit = 9;
	thread startCustomPerkMachines();
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

default_vending_precaching()
{
    level._effect["marathon_light"] = loadfx( "maps/zombie/fx_zmb_cola_staminup_on" );
}

startCustomPerkMachines()
{
	level thread customPerkMachine( "zombie_perk_bottle_marathon", "p6_zm_vending_electric_cherry_on", "Slot Machine", 500, ( -1090, 6042, -70 ), "slot_machine", ( 0, 375, 0 ), "jugger_light" );
	level thread customPerkMachine( "zombie_perk_bottle_marathon", "p6_zm_vending_electric_cherry_on", "Slot Machine", 1000, ( -1135, 6035, -70 ), "slot_machine", ( 0, 375, 0 ), "jugger_light" );
	level thread customPerkMachine( "zombie_perk_bottle_marathon", "p6_zm_vending_electric_cherry_on", "Slot Machine", 2000, ( -1180, 6033, -70 ), "slot_machine", ( 0, 375, 0 ), "jugger_light" );
	level thread customPerkMachine( "zombie_perk_bottle_marathon", "p6_zm_vending_electric_cherry_on", "Slot Machine", 5000, ( -1225, 6024, -70 ), "slot_machine", ( 0, 375, 0 ), "jugger_light" );
}

lowerMessage( ref, text )
{
    if ( !isdefined( level.zombie_hints ) )
        level.zombie_hints = [];

    precachestring( text );
    level.zombie_hints[ref] = text;
}

setLowerMessage( ent, default_ref )
{
    if ( isdefined( ent.script_hint ) )
        self sethintstring( get_zombie_hint( ent.script_hint ) );
    else
        self sethintstring( get_zombie_hint( default_ref ) );
}

customPerkMachine( bottle, model, perkname, cost, origin, perk, angles, fx )
{
    level endon( "end_game" );

    rperks = spawn( "script_model", origin );
    rperks setmodel( model );
    rperks rotateto( angles, 0.1 );
    level thread lowerMessage( "Custom Perks", "Hold ^3F ^7for " + perkname + " [Cost: " + cost + "]" );
    trig = spawn( "trigger_radius", origin, 1, 25, 25 );
    trig setcursorhint( "HINT_NOICON" );
    trig setLowerMessage( trig, "Custom Perks" );

    for (;;)
    {
        trig waittill( "trigger", player );

        if ( player usebuttonpressed() && player.score >= cost )
        {
            wait 0.2;

            if ( player usebuttonpressed() )
            {
                /* level.trig hide(); */
                player playsound( "zmb_cha_ching" );
                player.score -= cost;
				player tell("Rolling fruits...");
                wait 0.1;
				
				array = [];
				array[0] = "^2Apple";
				array[1] = "^1Strawberry";
				array[2] = "^3Banana";
				array[3] = "^9Kiwi";
				array[4] = "^1Cherry";
				array[5] = "^1Watermelon";
				array[6] = "^3Apricot";
				array[7] = "^3Pineapple";
				array[8] = "^9Date";
				array[9] = "^9Pear";
				array[10] = "^2Avocado";
				array[11] = "^2Lime";
				
				randomNum = [];
				randomNum[0] = randomIntRange(0, 12);
				randomNum[1] = randomIntRange(0, 12);
				randomNum[2] = randomIntRange(0, 12);
				
				fruits = [];
				fruits[0] = array[randomNum[0]];
				player tell("Slot 1: "+ fruits[0]);
				wait 0.5;
				fruits[1] = array[randomNum[1]];
				player tell("Slot 2: "+ fruits[1]);
				wait 0.5;
				fruits[2] = array[randomNum[2]];
				player tell("Slot 3: "+ fruits[2]);
				wait 0.5;
				
				didIWin = [];
				didIWin[0] = 0;
				
				/*
				
					3 in a row winners
				
				*/
				if (fruits[0] == "^2Apple" && fruits[1] == "^2Apple" && fruits[2] == "^2Apple")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^2Apple's");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^2Avocado" && fruits[1] == "^2Avocado" && fruits[2] == "^2Avocado")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^2Avocado's");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^2Lime" && fruits[1] == "^2Lime" && fruits[2] == "^2Lime")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^2Limes");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^1Strawberry" && fruits[1] == "^1Strawberry" && fruits[2] == "^1Strawberry")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^2Strawberry's");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^1Cherry" && fruits[1] == "^1Cherry" && fruits[2] == "^1Cherry")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^2Cherries");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^1Watermelon" && fruits[1] == "^1Watermelon" && fruits[2] == "^1Watermelon")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^2Watermelon's");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^3Banana" && fruits[1] == "^3Banana" && fruits[2] == "^3Banana")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^2Banana's");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^3Apricot" && fruits[1] == "^3Apricot" && fruits[2] == "^3Apricot")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^2Apricot's");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^3Pineapple" && fruits[1] == "^3Pineapple" && fruits[2] == "^3Pineapple")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^2Pineapple's");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^9Kiwi" && fruits[1] == "^9Kiwi" && fruits[2] == "^9Kiwi")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^9Kiwi's");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^9Date" && fruits[1] == "^9Date" && fruits[2] == "^9Date")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^9Date's");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^9Pear" && fruits[1] == "^9Pear" && fruits[2] == "^9Pear")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 5 times the cost by getting 3 ^9Pear's");
					didIWin[0] = 1;
				}
				
				/*
				
					3 colors in a row winners
				
				*/
				if (fruits[0] == "^9Kiwi" && fruits[1] == "^9Date" && fruits[2] == "^9Pear")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^9Brown^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^9Kiwi" && fruits[2] == "^9Date" && fruits[1] == "^9Pear")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^9Brown^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[1] == "^9Kiwi" && fruits[2] == "^9Date" && fruits[0] == "^9Pear")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^9Brown^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[1] == "^9Kiwi" && fruits[0] == "^9Date" && fruits[2] == "^9Pear")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^9Brown^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[2] == "^9Kiwi" && fruits[0] == "^9Date" && fruits[1] == "^9Pear")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^9Brown^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[2] == "^9Kiwi" && fruits[1] == "^9Date" && fruits[0] == "^9Pear")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^9Brown^7 colored fruits");
					didIWin[0] = 1;
				}
				
				if (fruits[0] == "^3Banana" && fruits[1] == "^3Apricot" && fruits[2] == "^3Pineapple")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^3Yellow^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^3Banana" && fruits[2] == "^3Apricot" && fruits[1] == "^3Pineapple")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^3Yellow^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[1] == "^3Banana" && fruits[2] == "^3Apricot" && fruits[0] == "^3Pineapple")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^3Yellow^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[1] == "^3Banana" && fruits[0] == "^3Apricot" && fruits[2] == "^3Pineapple")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^3Yellow^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[2] == "^3Banana" && fruits[0] == "^3Apricot" && fruits[1] == "^3Pineapple")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^3Yellow^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[2] == "^3Banana" && fruits[1] == "^3Apricot" && fruits[0] == "^3Pineapple")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^3Yellow^7 colored fruits");
					didIWin[0] = 1;
				}
				
				if (fruits[0] == "^2Apple" && fruits[1] == "^2Avocado" && fruits[2] == "^2Lime")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^2Green^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^2Apple" && fruits[2] == "^2Avocado" && fruits[1] == "^2Lime")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^2Green^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[1] == "^2Apple" && fruits[2] == "^2Avocado" && fruits[0] == "^2Lime")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^2Green^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[1] == "^2Apple" && fruits[0] == "^2Avocado" && fruits[2] == "^2Lime")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^2Green^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[2] == "^2Apple" && fruits[0] == "^2Avocado" && fruits[1] == "^2Lime")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^2Green^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[2] == "^2Apple" && fruits[1] == "^2Avocado" && fruits[0] == "^2Lime")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^2Green^7 colored fruits");
					didIWin[0] = 1;
				}
				
				if (fruits[0] == "^1Watermelon" && fruits[1] == "^1Cherry" && fruits[2] == "^1Strawberry")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^1Red^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[0] == "^1Watermelon" && fruits[2] == "^1Cherry" && fruits[1] == "^1Strawberry")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^1Red^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[1] == "^1Watermelon" && fruits[2] == "^1Cherry" && fruits[0] == "^1Strawberry")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^1Red^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[1] == "^1Watermelon" && fruits[0] == "^1Cherry" && fruits[2] == "^1Strawberry")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^1Red^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[2] == "^1Watermelon" && fruits[0] == "^1Cherry" && fruits[1] == "^1Strawberry")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^1Red^7 colored fruits");
					didIWin[0] = 1;
				}
				if (fruits[2] == "^1Watermelon" && fruits[1] == "^1Cherry" && fruits[0] == "^1Strawberry")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 5;
					player tell("You won 3 times the cost by getting 3 ^1Red^7 colored fruits");
					didIWin[0] = 1;
				}
				
				/*
				
					Jackpot winner
				
				*/
				if (fruits[2] == "^1Watermelon" && fruits[1] == "^2Avocado" && fruits[0] == "^9Date")
				{
					player playsound( "zmb_cha_ching" );
					player.score = player.score + cost * 25;
					player tell("You won 25 times the cost by getting the jackpot colored fruits");
					didIWin[0] = 1;
				}
				
				if (didIWin[0] == 0)
				{
					player tell("You didn't win anything");
				}
				
				didIWin[0] = 0;
				
				wait 1;
				
                /* level.trig show(); */
            }

            continue;
        }
    }
}
