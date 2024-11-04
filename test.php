<?php

//    $json_post = file_get_contents('php://input');
//    $json_data = json_decode($json_post);
//    $res_id = $json_data->res_id;
//    try {
//        $db = new cls_db();
//        $qry = $db->conn->prepare("UPDATE res_info SET res_json = ?, res_txt = NULL, res_upd = NOW() WHERE res_id = ?;");
//        $qry->bind_param("si", $json_post, $res_id);
//        $qry->execute();
//    } catch (mysqli_sql_exception $err) {
//        $db = new cls_db();
//        $qry = $db->conn->prepare("UPDATE res_info SET res_txt = ?, res_upd = NOW() WHERE res_id = ?;");
//        $qry->bind_param("si", $err->getMessage(), $res_id);
//        $qry->execute();
//    }
    $res_id = filter_input(INPUT_GET, "res_id", FILTER_VALIDATE_INT);
    $db = new cls_db();
    $qry = $db->conn->prepare("CALL sp_res_grp(?);");
    $qry->bind_param("i", $res_id);
    $qry->execute();
 
    $result = $qry->get_result();
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    print json_encode($rows);
    $qry->free_result($rows);
    
    $qry->next_result();
    $result = $qry->get_result();
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    print json_encode($rows);
    $qry->close();
