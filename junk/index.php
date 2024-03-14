<html>
    <head>
        <title></title>
        <link rel="stylesheet" href="https://toby.euler.usi.ch/styles.css"/>
    </head>
    <body>


        <?php
        //echo 123;
        ?>


        <!--        <form action="upload.php" method="post" enctype="multipart/form-data">
                    Select image to upload:
                    <input type="file" name="fileToUpload" id="fileToUpload">
                    <input type="submit" value="Upload Image" name="submit">
                </form>-->

        <a href="item.php?mth=list">list files</a>

        <hr/>

        <form action="item.php?mth=upload" method="post" enctype="multipart/form-data">
            <input type="test"   name="note" value=""/>
            <input type="file"   name="upfile"/>
            <input type="submit" name="submit" value="send"/>
        </form>

    </body>
</html>
