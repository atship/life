<?php

$zip = new ZipArchive();

if ($zip->open("myzip.zip") === true){
    $zip->extractTo("mydir");
    $zip->close();
}

echo 'extract zip file complete(unknown success or not)';