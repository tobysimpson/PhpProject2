<?php

require_once "cls_db.php";
require_once "cls_xml.php";


//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "rec":
        prm_rec();
        break;
    case "hst":
        prm_hst();
        break;
    default:
        prm_rec();
}

function prm_rec() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM prm_rec;");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prm_rec.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}


function prm_hst() {
    $db = new cls_db();
    $xsl    = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
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