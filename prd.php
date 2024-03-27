<?php

require_once "cls_db.php";
require_once "cls_xml.php";

//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "dsp":
        prd_dsp();
        break;
    case "hst":
        prd_hst();
        break;
    case "fwd":
        prd_fwd();
        break;
    case "prv":
        prd_prv();
        break;
    case "edt":
        prd_edt();
        break;
    case "ups":
        prd_ups();
        break;
    case "clr":
        prd_clr();
        break;
    case "eff":
        prd_eff();
        break;
    default:
        prd_rec();
}

function prd_dsp() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM prd_dsp;");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prd_dsp.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function prd_hst() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $prd_id = filter_input(INPUT_GET, "prd_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prd_hst({$prd_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prd_hst.xsl");
        header('Content-Type: image/svg+xml');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function prd_fwd() {
    $db = new cls_db();
    $xsl    = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prd_id = filter_input(INPUT_GET, "prd_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prd_fwd({$res_id},{$prd_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prd_fwd.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function prd_prv() {
    $db = new cls_db();
    $xsl    = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prd_id = filter_input(INPUT_GET, "prd_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prd_fwd({$res_id},{$prd_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prd_prv.xsl");
        header('Content-Type: image/svg+xml');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}



function prd_edt() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prd_id = filter_input(INPUT_GET, "prd_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prd_edt({$res_id},{$prd_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prd_edt.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}


function prd_ups() {
    $db     = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prd_id = filter_input(INPUT_GET, "prd_id", FILTER_VALIDATE_INT);
    $yr     = filter_input(INPUT_GET, "yr",     FILTER_VALIDATE_INT);
    $tj     = filter_input(INPUT_GET, "tj",     FILTER_VALIDATE_FLOAT);
    $db->conn->multi_query("CALL sp_prd_ups({$res_id},{$prd_id},{$yr},{$tj});");
    header("Location: prm.php?mth=edt&res_id=".$res_id."&prd_id=".$prd_id."&xsl=1");
}


function prd_clr() {
    $db     = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prd_id = filter_input(INPUT_GET, "prd_id", FILTER_VALIDATE_INT);
    $yr     = filter_input(INPUT_GET, "yr",     FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prd_clr({$res_id},{$prd_id},{$yr});");
    header("Location: prm.php?mth=edt&res_id=".$res_id."&prd_id=".$prd_id."&xsl=1");
}



function prd_eff() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $prd_id = filter_input(INPUT_GET, "prd_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prd_eff({$prd_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prd_eff.xsl");
        header('Content-Type: image/svg+xml');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}