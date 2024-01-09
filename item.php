<?php

require_once "cls_db.php";
require_once "cls_xml.php";

echo "hello";

//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "list":
        item_list();
        break;
    case "sp":
        item_sp();
        break;
    default:
        item_list();
}

function item_list() {
    $db = new cls_db();
    $qry = $db->conn->prepare("SELECT * FROM item;");
    $qry->execute();
    $res = $qry->get_result();
    $xml = cls_xml::res2dom($res);
    echo $xml->saveXML();
//    $xsl = cls_xml::file2dom("item/item_list.xsl");
//    echo cls_xml::xsltrans($xml, $xsl);
    $res->close();
}

function item_sp() {
    $db = new cls_db();
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $prm_id = filter_input(INPUT_GET, "prm_id", FILTER_VALIDATE_INT);
    $db->conn->multi_query("CALL sp_test1({$res_id},{$prm_id});");
    $dom = cls_xml::mul2dom($db->conn, "item/item_test.xsl");
    header('Content-Type: text/xml');
    echo $dom->saveXML();
}
