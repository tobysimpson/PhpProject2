<?php

require_once "cls_db.php";
require_once "cls_xml.php";

//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
        case "lst":
        res_lst();
        break;
    case "ord":
        res_ord();
        break;
    case "evt":
        res_evt();
        break;
    case "ins":
        res_ins();
        break;
    case "edt":
        res_edt();
        break;
    case "upd":
        res_upd();
        break;
    case "rnk":
        res_rnk();
    case "ctx":
        res_ctx();
        break;
    case "grp":
        res_grp();
        break;
    case "act":
        res_act();
        break;
}

function res_lst() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM res_info;");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("res/res_lst.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}


function res_ord() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $ord = filter_input(INPUT_GET, "ord", FILTER_VALIDATE_INT, array("options" => array("default" => 1)));
    $lim = filter_input(INPUT_GET, "lim", FILTER_VALIDATE_INT, array("options" => array("default" => 10000)));
    $db->conn->multi_query("SELECT * FROM res_rnk ORDER BY {$ord} LIMIT {$lim};");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("res/res_ord.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}


function res_act() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM res_act;");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("res/res_lst.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}



function res_prm() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_res_prm({$res_id})");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("res/res_prm.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function res_evt() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM res_evt WHERE res_evt.res_id = {$res_id} ORDER BY res_id, yr, prm_id;");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("res/res_evt.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function res_ins() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $qry = $db->conn->prepare("INSERT INTO res_info (res_name) VALUES ('new');");
    $qry->execute();
    $res_id = $qry->insert_id;

    if ($xsl == 1) {
        header("Location: res.php?mth=edt&res_id={$res_id}&xsl=1");
    } else {
        header("Location: res.php?mth=ctx&res_id={$res_id}&yr=2022&xsl=0");
    }
}

function res_edt() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM res_info WHERE res_id = {$res_id};");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("res/res_edt.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function res_upd() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_POST, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_POST, "res_id", FILTER_VALIDATE_INT);
    $res_name = filter_input(INPUT_POST, "res_name", FILTER_SANITIZE_STRING);
    $res_del = (int) !is_null(filter_input(INPUT_POST, "res_del", FILTER_VALIDATE_BOOL));
    var_dump($res_del);
    $qry = $db->conn->prepare("UPDATE res_info SET res_name = LEFT('{$res_name}',25), res_upd = NOW() WHERE res_id = {$res_id};");
    $qry->execute();
    header("Location: res.php?mth=lst&res_id=" . $res_id . "&xsl=" . $xsl);
}

function res_rnk() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    if ($res_id) {
        $db->conn->multi_query("CALL sp_res_rnk({$res_id})");
    } else {
        $db->conn->multi_query("CALL sp_res_rnk_all()");
    }
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("res/res_lst.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function res_ctx() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $yr = filter_input(INPUT_GET, "yr", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_res_ctx({$res_id},{$yr})");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("res/res_ctx.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}


function res_grp() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_res_grp({$res_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("res/res_grp.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

