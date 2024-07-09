<?php

require_once "cls_db.php";
require_once "cls_xml.php";


//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "lst":
        item_lst();
        break;
    case "ctx":
        res_ctx();
        break;
    case "ins":
        res_ins();
        break;
    case "ups":
        prm_ups();
        break;
    default:
        item_lst();
}



function item_lst() {
    $db = new cls_db();
    $result = mysqli_query($db->conn, "SELECT * FROM item_info;");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC); 
    print json_encode($rows);
}


function res_ctx() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $yr     = filter_input(INPUT_GET, "yr",     FILTER_VALIDATE_INT);
    $result = mysqli_query($db->conn, "CALL sp_res_ctx({$res_id},{$yr})");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC); 
    print json_encode($rows);
}


function res_ins() {
    $db = new cls_db();
    $res_name = urldecode(filter_input(INPUT_GET, "res_name", FILTER_SANITIZE_STRING));
    $qry = $db->conn->prepare("INSERT INTO res_info (res_name) VALUES (LEFT('{$res_name}',25));");
    $qry->execute();
    $res_id = $qry->insert_id;
    $result = mysqli_query($db->conn, "CALL sp_res_ctx({$res_id},2022)");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC); 
    print json_encode($rows);
}


function prm_ups() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $yr = filter_input(INPUT_GET, "yr", FILTER_VALIDATE_INT);
    $tj = filter_input(INPUT_GET, "tj", FILTER_VALIDATE_FLOAT);
    $db->conn->multi_query("CALL sp_prm_ups({$res_id},{$prm_id},{$yr},{$tj});");
    $result = mysqli_query($db->conn, "CALL sp_res_ctx({$res_id},{$yr})");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC); 
    print json_encode($rows);
}