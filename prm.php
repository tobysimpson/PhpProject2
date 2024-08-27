<?php

require_once "cls_db.php";
require_once "cls_xml.php";

//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "dsp":
        prm_dsp();
        break;
    case "hst":
        prm_hst();
        break;
    case "fwd":
        prm_fwd();
        break;
    case "prv":
        prm_prv();
        break;
    case "edt":
        prm_edt();
        break;
    case "ups":
        prm_ups();
        break;
    case "clr":
        prm_clr();
        break;
    case "eff":
        prm_eff();
        break;
    default:
        prm_rec();
}

function prm_dsp() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prm_dsp();");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prm_dsp.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function prm_hst() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prm_hst({$prm_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prm_hst.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function prm_fwd() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prm_fwd({$res_id},{$prm_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prm_fwd.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function prm_prv() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prm_fwd({$res_id},{$prm_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prm_prv.xsl");
        header('Content-Type: image/svg+xml');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function prm_edt() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prm_edt({$res_id},{$prm_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prm_edt.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function prm_ups() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $yr = filter_input(INPUT_GET, "yr", FILTER_VALIDATE_INT);
    $tj = filter_input(INPUT_GET, "tj", FILTER_VALIDATE_FLOAT);
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prm_ups({$res_id},{$prm_id},{$yr},{$tj});");
    if ($xsl == 1) {
        header("Location: prm.php?mth=edt&res_id=" . $res_id . "&prm_id=" . $prm_id . "&xsl=" . $xsl);
    } else {
        header("Location: res.php?mth=ctx&res_id=" . $res_id . "&yr=" . $yr . "&xsl=0");
    }
}

function prm_clr() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $yr = filter_input(INPUT_GET, "yr", FILTER_VALIDATE_INT);
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prm_clr({$res_id},{$prm_id},{$yr});");
    header("Location: prm.php?mth=edt&res_id=" . $res_id . "&prm_id=" . $prm_id . "&xsl=" . $xsl);
}

function prm_eff() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_prm_eff({$prm_id});");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prm_eff.xsl");
        header('Content-Type: image/svg+xml');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

