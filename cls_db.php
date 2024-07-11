<?php

class cls_db {
    
    // single instance of self shared among all instances
    private static $instance = null;
    // db connection config vars
    private $hostname = "localhost";
    private $username = "root";
    private $password = "Flowerdb1";
    private $dbname   = "db1";
    //objects
    public $conn    = null;
    
               
    public function __construct() {
        $this->conn = new mysqli($this->hostname, $this->username, $this->password, $this->dbname);
    }

    public function __destruct() {
        $this->conn->close();
        $this->conn = null;
    }
    
    /*
     * ========================
     * singleton stuff
     * ========================
     */

    public static function getInstance() {
        if (!self::$instance instanceof self) {
            self::$instance = new self;
        }
        return self::$instance;
    }

    public function __clone() {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }

    public function __wakeup() {
        trigger_error('Deserializing is not allowed.', E_USER_ERROR);
    }
    //flowergarden
    //Flowerbd1
}
