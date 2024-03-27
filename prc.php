<?php

require_once "cls_db.php";
require_once "cls_xml.php";

//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "dsp":
        prc_dsp();
        break;
    default:
        prc_dsp();
}

function prc_dsp() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM prc_dsp;");
    $xml = cls_xml::mul2dom($db->conn);
    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("prm/prc_dsp.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}