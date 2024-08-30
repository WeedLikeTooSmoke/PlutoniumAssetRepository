getMapName() {
	location = getDvar( "ui_zm_mapstartlocation" );
	gamemode = getDvar( "ui_gametype" );
	if( location == "processing" )
		return "Buried";
	else if( location == "rooftop" )
		return "DieRise";
	else if( location == "prison" )
		return "MobOfTheDead";
	else if( location == "nuked" )
		return "Nuketown";
	else if( location == "tomb" )
		return "Origins";
	else if( location == "town" )
		return "Town";
	else if( location == "farm" )
		return "Farm";
	else if( location == "transit" )
		if ( gamemode == "zclassic") 
			return "Tranzit";
		if ( gamemode == "zstandard") 
			return "Depot";
	return "NA";
}