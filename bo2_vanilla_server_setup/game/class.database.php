<?php

class Database {

    private $HOST;
    private $USERNAME;
    private $PASSWORD;
    private $DBNAME;

    function __construct() {

        $this->HOST = "127.0.0.1";
        $this->USERNAME = "<put your mysql username here>";
        $this->PASSWORD = "<put your mysql password here>";
        $this->DBNAME = "<put your mysqldb name here>";
        
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
