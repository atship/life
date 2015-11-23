<?
#设置连接使用utf-8字符集
$sql = mysql_connect($host, $user, $password);
mysql_set_charset('utf8', $sql);

mysql_select_db($dbName, $sql);

$query = 'select * from tableName';
$result = mysql_query($query, $sql);