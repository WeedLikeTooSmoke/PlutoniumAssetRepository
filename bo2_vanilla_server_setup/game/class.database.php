<?php

class Database {

    private $HOST;
    private $USERNAME;
    private $PASSWORD;
    private $DBNAME;

    function __construct() {

        $this->HOST = "127.0.0.1";
        $this->USERNAME = "root";
        $this->PASSWORD = "";
        $this->DBNAME = "clipstone4.0";
        
    }

    protected function connect() {

        $dsn = 'mysql:host=' . $this->HOST . ';dbname=' . $this->DBNAME;

        $db = new PDO($dsn, $this->USERNAME, $this->PASSWORD);
        $db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        return $db;

    }

}