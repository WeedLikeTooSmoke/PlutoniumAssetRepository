<?php

include $_SERVER['DOCUMENT_ROOT']."/game/autoload.vanilla.php";

$_POST = json_decode(file_get_contents('php://input'), true);

$vanilla = new Vanilla();
$vanilla->account();