<?php


//pwd = /var/www/sure/uploads/
//$res_name = filter_input(INPUT_POST, "res_name", FILTER_SANITIZE_STRING);

$target_dir = "uploads/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);

echo getcwd() . "<br/>";
echo $target_file . "<br/>";
echo is_dir($target_dir) . "<br/>";
echo $_FILES["fileToUpload"]["name"] . "<br/>";
echo $_FILES["fileToUpload"]["tmp_name"] . "<br/>";
echo is_writeable($target_dir) . "<br/>";

$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

// Check if image file is a actual image or fake image
if (isset($_POST["submit"])) {
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    if ($check !== false) {
        echo "File is an image - " . $check["mime"] . "<br/>";
        $uploadOk = 1;
    } else {
        echo "File is not an image." . "<br/>";
        $uploadOk = 0;
    }
}



// Check if file already exists
if (file_exists($target_file)) {
    echo "File already exists." . "<br/>";
    $uploadOk = 0;
}

// Check file size
if ($_FILES["fileToUpload"]["size"] > 500000) {
    echo "File is too large." . "<br/>";
    $uploadOk = 0;
}

// Allow certain file formats
if ($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif") {
    echo "only JPG, JPEG, PNG & GIF files are allowed." . "<br/>";
    $uploadOk = 0;
}

//// Check if $uploadOk is set to 0 by an error
//if ($uploadOk == 0) {
//    echo "File not uploaded." . "<br/>";
//// if everything is ok, try to upload file
//} else {
//    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
//        echo "File " . htmlspecialchars(basename($_FILES["fileToUpload"]["name"])) . " uploaded.";
//    } else {
//        echo "There was an error uploading your file." . "<br/>";
//    }
//}


$files = scandir($target_dir);
print_r($files);
?>