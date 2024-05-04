/*

  Re enables RCON messages in the console using t6utils

*/

init()
{
    executeCommand("con_displayRconOutput 1");
}

/*

  Re enables RCON messages in the console using setDVAR

*/

init()
{
    SetDvar("con_displayRconOutput", 1);
}

/*

  Re enables RCON messages in the console using config file

*/

con_displayRconOutput 1
