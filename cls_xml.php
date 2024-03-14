<?php

class cls_xml {

    public static function mul2dom($conn) {
        $dom = new DOMDocument('1.0', 'utf-8');
        $dom->formatOutput = true;

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

}
