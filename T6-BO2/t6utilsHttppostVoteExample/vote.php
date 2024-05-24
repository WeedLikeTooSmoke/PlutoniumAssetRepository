<?php
/******************************************************/
/* Copyright (C)  Inc, (appname) All Rights Reserved  */
/*     Written and designed by the Clipstone team     */
/*     Do with these files as you wish, No limits     */
/******************************************************/

$clipstone = array(
	"host" => "127.0.0.1", // Your database hostname (127.0.0.1/78.157.218.205)
    "username" => "root",  // Your database username (root unless you set one)
    "password" => "",      // Your database password (empty unless you set one)
    "database" => "votedatabase",// Your database name
);

// Class: Database
class Database {
    // Connect to database function.
    public static function connect() {
        global $db, $clipstone;
        // Try connect.
        try {
            $db = new PDO("mysql:host={$clipstone['host']};dbname=".$clipstone['database'],$clipstone['username'],$clipstone['password']);
        } catch (PDOException $e) {
            // Falied to connect, Throw error.
            die($e);
        }
    }
}

// Initialize connection.
Database::connect();

// Decode incoming request
$_POST = json_decode(file_get_contents('php://input'), true);

// set default timezone for server
date_default_timezone_set("Europe/London");

// return how we want the date to be
function datetime($times) {
    return date('H-d-m-Y', strtotime($times));
}

// get the present time
$time = datetime("+0 hour");

// past time by 1 hour $time = datetime("-1 hour");
// future time by 1 hour $time = datetime("+1 hour");

// explode time into an array
$time = explode("-", $time);

// assign array vars to their own var
$hour = $time[0];
$day = $time[1];
$month = $time[2];
$year = $time[3];

// check if the post data is set and is not empty
if (isset($_POST['guid']) && !empty($_POST['guid'])) {
    
    // fetch votes for today
    $checkIfVoted = $db->prepare("SELECT * FROM votes WHERE guid = :guid AND day = :day");
    $checkIfVoted->bindParam(":guid", $_POST['guid']);
    $checkIfVoted->bindParam(":day", $day);
    $checkIfVoted->execute();
    
    // check if the player has voted today
    if ($checkIfVoted->RowCount() == 0) {
        
        // returns message to the player saying they have voted
        echo "[^2Votes^7] Thankyou for voting for this server;true";
        
        // inserts the vote into the database
        $insertVotes = $db->prepare("INSERT INTO votes (guid, hour, day, month, year) VALUES (:guid, :hour, :day, :month, :year)");
        $insertVotes->bindParam(":guid", $_POST["guid"]);
        $insertVotes->bindParam(":hour", $hour);
        $insertVotes->bindParam(":day", $day);
        $insertVotes->bindParam(":month", $month);
        $insertVotes->bindParam(":year", $year);
        $insertVotes->execute();
    } else {
        
        // returns message to the player saying they have already voted
        echo "[^2Votes^7] You have already voted today;false";
    }
}
?>
