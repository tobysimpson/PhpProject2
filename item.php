<?php

require_once "cls_db.php";
require_once "cls_xml.php";

//method
$mth = filter_input(INPUT_GET, "mth", FILTER_SANITIZE_STRING);
switch ($mth) {
    case "list":
        item_list();
        break;
    case "ins":
        item_insert();
        break;
    case "upload":
        item_upload();
        break;
    case "download":
        item_download();
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
    $xsl = cls_xml::file2dom("item/item_list.xsl");
    echo cls_xml::xsltrans($xml, $xsl);
    $res->close();
}

function item_upload() {

    $target_dir = "uploads/";

    $submit = filter_input(INPUT_POST, "submit", FILTER_SANITIZE_STRING);

    $name = $_FILES["upfile"]["name"];
    $size = (int) $_FILES["upfile"]["size"];
    $type = $_FILES["upfile"]["type"];
    $tmp = $_FILES["upfile"]["tmp_name"];
    $note = filter_input(INPUT_POST, "note", FILTER_SANITIZE_STRING);
    $err = $_FILES["upfile"]["error"];

    echo $submit . "<br/>" . $name . "<br/>" . $size . "<br/>" . $type . "<br/>" . $note . "<br/>" . $tmp . "<br/>" . $err . "<br/>";

    $db = new cls_db();
    $qry = $db->conn->prepare("INSERT INTO item (name, size, type, note) VALUES ('{$name}',{$size},'{$type}','{$note}');");
    $qry->execute();
    $id = mysqli_insert_id($db->conn);

    echo $id . "<br/>";

    move_uploaded_file($_FILES["upfile"]["tmp_name"], $target_dir . $id);

    $files = scandir($target_dir);
    print_r($files);
    
    header("Location: item.php?mth=list");
}

function item_download() {
    $id = filter_input(INPUT_GET, "id", FILTER_SANITIZE_STRING);
    $name = filter_input(INPUT_GET, "name", FILTER_SANITIZE_STRING);
//    $size = filter_input(INPUT_GET, "size", FILTER_SANITIZE_STRING);
//    $type = filter_input(INPUT_GET, "type", FILTER_SANITIZE_STRING);

    //headers 
//    header("Content-Type: " . $type);
    header("Content-Length: " . filesize("uploads/" . $id));
    header('Content-Disposition: attachment; filename="' . $name . '"');

    //send
    readfile("uploads/" . $id);
}

function item_insert() {
    $db = new cls_db();
    $qry = $db->conn->prepare("INSERT INTO item (v1) VALUES (rand());;");
    $qry->execute();
    $usr_id = mysqli_insert_id($db->conn);
    echo $usr_id;
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
