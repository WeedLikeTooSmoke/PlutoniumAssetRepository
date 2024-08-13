#include maps\mp\zombies\_zm_banking;

/*

    Best thing to do with this would be to have a seperate load folder for plutonium

    i have mine as follows

    /vanilla
    /modded
    /modded_bank_removed

*/

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

    Better alternative

    Instead of having different folders for things you can check what port the server is instead to replace the functions

*/

main()
{
    if (GetDvar("net_port") == "4976") {
        replaceFunc(maps/mp/zombies/_zm_banking::main, ::doNothing);
        replaceFunc(maps/mp/zombies/_zm_banking::init, ::doNothing);
    }
}
doNothing()
{
	  return;
}
