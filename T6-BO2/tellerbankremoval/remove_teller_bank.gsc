#include maps\mp\zombies\_zm_banking;

main()
{
    replaceFunc(maps/mp/zombies/_zm_banking::main, ::doNothing);
	  replaceFunc(maps/mp/zombies/_zm_banking::init, ::doNothing);
}
doNothing()
{
	  return;
}

/*

    Best thing to do with this would be to have a seperate load folder for plutonium

    i have mine as follows

    /vanilla
    /modded
    /modded_bank_removed

*/
