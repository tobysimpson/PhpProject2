<?php

class cls_xml {

    public static function vec2dom($arr, $name) {
        $dom = new DOMDocument('1.0', 'utf-8');
        $dom->formatOutput = true;
        $root = $dom->createElement('res');
        $root->setAttribute("name", $name);
        $dom->appendChild($root);

        $ele = $dom->createElement('vec');
        $root->appendChild($ele);
        for ($i = 0; $i < count($arr); $i++) {
            $ele->setAttribute("v" . $i, $arr[$i]);
        }
        return $dom;
    }

    //2d with keys
    public static function arr2dom($arr, $name) {
        $dom = new DOMDocument('1.0', 'utf-8');
        $dom->formatOutput = true;
        $root = $dom->createElement('res');
        $root->setAttribute("name", $name);
        $dom->appendChild($root);

        foreach ($arr as $row) {
            $ele = $dom->createElement('row');
            foreach ($row as $key => $val) {
                $ele->setAttribute($key, $val);
            }
            $root->appendChild($ele);
        }
        return $dom;
    }

    public static function file2dom($filename) {
        $dom = new DOMDocument;
        $dom->load($filename);
        return $dom;
    }

    public static function xsltrans($xml, $xsl) {
        $proc = new XSLTProcessor;
        $proc->registerPHPFunctions();
        $proc->importStyleSheet($xsl);
        return $proc->transformToXML($xml);
    }

    /*
     * =========================
     * recordsets
     * =========================
     */

    public static function res2arr($res) {
        $arr = array();
        while ($row = $res->fetch_assoc()) {
            $arr[] = $row;
        }
        return $arr;
    }

    public static function res2dom($res, $xsl = "") {
        $dom = new DOMDocument('1.0', 'utf-8');
        $dom->formatOutput = true;

        if (strlen($xsl) > 0) {
            $prc = $dom->createProcessingInstruction('xml-stylesheet', 'type="text/xsl" href="' . $xsl . '"');
            $dom->appendChild($prc);
        }

        $root = $dom->createElement('root');
        $dom->appendChild($root);

        //fields
//        while ($finfo = $res->fetch_field()) {
//            $node = $dom->createElement('fld');
//            $node->setAttribute("table", $finfo->table);
//            $node->setAttribute("name", $finfo->name);
//            $node->setAttribute("type", $finfo->type);
//            $node->setAttribute("flags", $finfo->flags);
//            $node->setAttribute("max_length", $finfo->max_length);
//            $root->appendChild($node);
//        }
//        
        //rows
        while ($row = $res->fetch_assoc()) {
            $node = $dom->createElement('row');
            foreach ($row as $key => $val) {
                $node->setAttribute($key, $val);
            }
            $root->appendChild($node);
        }
        return $dom;
    }

    public static function mul2dom($conn, $xsl = "") {
        $dom = new DOMDocument('1.0', 'utf-8');
        $dom->formatOutput = true;

        if (strlen($xsl) > 0) {
            $prc = $dom->createProcessingInstruction('xml-stylesheet', 'type="text/xsl" href="' . $xsl . '"');
            $dom->appendChild($prc);
        }

        $root = $dom->createElement('root');
        $dom->appendChild($root);

        do {
            $res = $conn->store_result();

            if ($res) {
                $rows = $dom->createElement('tbl');
                $root->appendChild($rows);

                while ($row = $res->fetch_assoc()) {
                    $node = $dom->createElement('row');
                    foreach ($row as $key => $val) {
                        $node->setAttribute($key, $val);
                    }
                    $rows->appendChild($node);
                }
            }
        } while ($conn->next_result());

        return $dom;
    }

}
