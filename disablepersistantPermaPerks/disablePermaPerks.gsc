main()
{
    replaceFunc( maps/mp/zombies/_zm_pers_upgrades::pers_upgrade_init, ::doNothing  );
}
doNothing()
{
	return;
}

/*

    stops the persistant perks from initializing

*/
