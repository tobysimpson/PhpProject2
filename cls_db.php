<?php

class cls_db {
    
    // single instance of self shared among all instances
    private static $instance = null;
    // db connection config vars
    private $hostname = "localhost";
    private $username = "sure";
    private $password = "@K38U8munsGbHRqg";
    private $dbname   = "sure";
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
    
}
