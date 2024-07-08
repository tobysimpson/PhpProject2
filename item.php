<?php

require_once "cls_db.php";
require_once "cls_xml.php";


//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "lst":
        item_lst();
        break;
    case "res":
        item_res();
        break;
    default:
        item_lst();
}

function item_lst() {
    $db = new cls_db();
    $xsl = filter_input(INPUT_GET, "xsl", FILTER_VALIDATE_INT);
    $db->conn->multi_query("SELECT * FROM item_info;");
    $xml = cls_xml::mul2dom($db->conn);

    if ($xsl == 1) {
        $xsl = cls_xml::file2dom("item/item_lst.xsl");
        header('Content-Type: text/html');
        echo cls_xml::xsltrans($xml, $xsl);
    } else {
        header('Content-Type: text/xml');
        echo $xml->saveXML();
    }
}

function item_res() {
    $db = new cls_db();
    $result = mysqli_query($db->conn, "SELECT * FROM item_info;");
    $rows = mysqli_fetch_all($result, MYSQLI_ASSOC); // assoc arrays in rows
    print json_encode($rows);

}