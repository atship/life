<?
$xml = <<< 'xml'
    <resource>
        <res>this is value</res>
        <sound>sound.ogg</sound>
    </resource>
xml

$xml_obj = simplexml_load_string($xml);

echo $xml_obj->res; //this is value
echo $xml_obj->sound; //sound.ogg