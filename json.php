<?php

require_once "cls_db.php";
require_once "cls_xml.php";

//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "ctx1":
        res_ctx1();
        break;
    case "ctx2":
        res_ctx2();
        break;
    case "ins":
        res_ins();
        break;
    case "upd":
        res_upd();
        break;
    case "upd2":
        res_upd2();
        break;
    case "ups":
        prm_ups();
        break;
    case "clr":
        prm_clr();
        break;
    case "dsp":
        prm_dsp();
        break;
    case "rnk":
        res_rnk();
        break;
    case "lst":
        res_lst();
        break;
    case "shk":
        shk_ups();
        break;
    case "tst":
        res_tst();
        break;
    case "itm":
        item_lst();
        break;
}

function item_lst() {
    $db = new cls_db();
//    $ord = filter_input(INPUT_GET, "ord", FILTER_VALIDATE_INT, array("options" => array("default" => 1)));
//    $lim = filter_input(INPUT_GET, "lim", FILTER_VALIDATE_INT, array("options" => array("default" => 10000)));
//    $result = mysqli_query($db->conn, "SELECT * FROM res_rnk ORDER BY {$ord} LIMIT {$lim};");
    $result = mysqli_query($db->conn, "SELECT * FROM item_info;");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function res_ctx1() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $yr = filter_input(INPUT_GET, "yr", FILTER_VALIDATE_INT);
    $result = mysqli_query($db->conn, "CALL sp_res_ctx1({$res_id},{$yr})");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function res_ctx2() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $yr = filter_input(INPUT_GET, "yr", FILTER_VALIDATE_INT);
    $result = mysqli_query($db->conn, "CALL sp_res_ctx2({$res_id},{$yr})");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function res_ins() {
    $db = new cls_db();
    $res_name = urldecode(filter_input(INPUT_GET, "res_name", FILTER_SANITIZE_STRING));
    $res_tok = urldecode(filter_input(INPUT_GET, "res_tok", FILTER_SANITIZE_STRING));
    $options = array('options' => array('default' => 'NULL'));
    $res_trt = filter_input(INPUT_GET, "res_trt", FILTER_VALIDATE_INT, $options);
    $res_frm = filter_input(INPUT_GET, "res_frm", FILTER_VALIDATE_INT, $options);
    $res_lng = filter_input(INPUT_GET, "res_lng", FILTER_VALIDATE_INT, $options);
    $qry = $db->conn->prepare("INSERT INTO res_info (res_name, res_tok, res_trt, res_frm, res_lng) VALUES (?, ?, ?, ?, ?);");
    $qry->bind_param("ssiii", $res_name, $res_tok, $res_trt, $res_frm, $res_lng);
    $qry->execute();
    $res_id = $qry->insert_id;
    $result = mysqli_query($db->conn, "CALL sp_res_ctx1({$res_id}, 2022)");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function res_upd() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $res_name = urldecode(filter_input(INPUT_GET, "res_name", FILTER_SANITIZE_STRING));
    $qry = $db->conn->prepare("UPDATE res_info SET res_name = LEFT(?, 25), res_upd = NOW() WHERE res_id = ?;");
    $qry->bind_param("si", $res_name, $res_id);
    $qry->execute();
    $result = mysqli_query($db->conn, "SELECT * FROM res_info WHERE res_id = {$res_id};");
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
    $result = mysqli_query($db->conn, "CALL sp_res_ctx2({$res_id},{$yr})");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function prm_clr() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $yr = filter_input(INPUT_GET, "yr", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prm_clr({$res_id},{$prm_id},{$yr});");
    $result = mysqli_query($db->conn, "CALL sp_res_ctx2({$res_id},{$yr})");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function prm_dsp() {
    $db = new cls_db();
    $result = mysqli_query($db->conn, "SELECT * FROM prm_dsp");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function res_rnk() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    if ($res_id) {
        $result = mysqli_query($db->conn, "CALL sp_res_rnk({$res_id})");
    } else {
        $result = mysqli_query($db->conn, "CALL sp_res_rnk_all()");
    }
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function res_lst() {
    $db = new cls_db();
    $ord = filter_input(INPUT_GET, "ord", FILTER_VALIDATE_INT, array("options" => array("default" => 1)));
    $lim = filter_input(INPUT_GET, "lim", FILTER_VALIDATE_INT, array("options" => array("default" => 10000)));
    $result = mysqli_query($db->conn, "SELECT * FROM res_rnk WHERE (met_nuc*met_fos*met_ele*met_emi*met_lnd*met_cst*met_smr) IS NOT NULL ORDER BY {$ord} LIMIT {$lim};");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function shk_ups() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $shk_id = filter_input(INPUT_GET, "shk_id", FILTER_VALIDATE_INT);
    $yr = filter_input(INPUT_GET, "yr", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_shk_ups({$res_id},{$shk_id},{$yr});");
    $result = mysqli_query($db->conn, "CALL sp_res_ctx2({$res_id},{$yr})");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}

function res_upd2() {
    $json_post = file_get_contents('php://input');
    $json_data = json_decode($json_post);
    $res_id = $json_data->res_id;
    try {
        $db = new cls_db();
        $qry = $db->conn->prepare("UPDATE res_info SET res_json = ?, res_txt = NULL, res_upd = NOW() WHERE res_id = ?;");
        $qry->bind_param("si", $json_post, $res_id);
        $qry->execute();
    } catch (mysqli_sql_exception $err) {
        $db = new cls_db();
        $qry = $db->conn->prepare("UPDATE res_info SET res_txt = ? WHERE res_id = ?;");
        $qry->bind_param("si", $err->getMessage(), $res_id);
        $qry->execute();
    }
    $result = mysqli_query($db->conn, "SELECT * FROM res_info WHERE res_id = {$res_id};");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
    print json_encode($rows);
}
