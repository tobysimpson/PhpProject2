<?php

require_once "cls_db.php";
require_once "cls_xml.php";


//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "prm":
        rpt_prm();
        break;
    default:
        rpt_prm();
}

function rpt_prm() {
    $db = new cls_db();
    $xsl    = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_rpt_prm({$res_id});");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("rpt/rpt_prm.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

