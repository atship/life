<?php

$command = 'ls -la';

$file = popen($command, 'r');

while($line = fgets($file)){
    echo $line, '<br/>';
}

echo 'command finished';

pclose($file);