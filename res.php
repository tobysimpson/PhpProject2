<?php

require_once "cls_db.php";
require_once "cls_xml.php";


//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "lst":
        res_lst();
        break;
    case "prm":
        res_prm();
        break;
    case "evt":
        res_evt();
        break;
    case "ins":
        res_ins();
        break;
    default:
        res_lst();
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
    $db->conn->multi_query("SELECT * FROM res_evt WHERE res_evt.res_id = {$res_id};");
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
    $qry = $db->conn->prepare("INSERT INTO res_info (res_name) VALUES ('new');");
    $qry->execute();
    $res_id = $qry->insert_id;
    header("Location: res.php?mth=prm&xsl=1&res_id=".$res_id);
}