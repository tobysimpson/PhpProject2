<?php

require_once "cls_db.php";
require_once "cls_xml.php";

//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "res1":
        rpt_res1();
        break;
    case "res2":
        rpt_res2();
        break;
    case "res3":
        rpt_res3();
        break;
    default:
        prd_rec();
}

function rpt_res1() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM rpt_res1;");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("rpt/rpt_res1.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function rpt_res2() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM rpt_res2;");
    $xml = cls_xml::mul2dom($db->conn);
    switch ($xsl) {
        case 1:
            $xsl = cls_xml::file2dom("rpt/rpt_res2.xsl");
            header('Content-Type: text/html');
            echo cls_xml::xsltrans($xml, $xsl);
            break;
        case 2:
            $xsl = cls_xml::file2dom("rpt/xls_res2.xsl");
            header('Content-Type: application/vnd.ms-excel');
            header("Content-Disposition: attachment; filename=rpt_res2.xml");
            echo cls_xml::xsltrans($xml, $xsl);
            break;
        default:
            header('Content-Type: text/xml');
            echo $xml->saveXML();
            break;
    }
}

function rpt_res3() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM rpt_res3;");
    $xml = cls_xml::mul2dom($db->conn);
    switch ($xsl) {
        case 1:
            $xsl = cls_xml::file2dom("rpt/rpt_res3.xsl");
            header('Content-Type: text/html');
            echo cls_xml::xsltrans($xml, $xsl);
            break;
        case 2:
            $xsl = cls_xml::file2dom("rpt/xls_res3.xsl");
            header('Content-Type: application/vnd.ms-excel');
            header("Content-Disposition: attachment; filename=rpt_res3.xml");
//            header('Content-Type: text/xml');
            echo cls_xml::xsltrans($xml, $xsl);
            break;
        default:
            header('Content-Type: text/xml');
            echo $xml->saveXML();
            break;
    }
}
