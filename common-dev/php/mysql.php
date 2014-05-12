<?
#设置连接使用utf-8字符集
$sql = mysql_connect($host, $user, $password);
mysql_set_charset('utf8', $sql);