<?
$post_data = 'id=1&lt=12&v_t=3232345';

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, 'http://www.test.com.cn/index.php');
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);

$response = curl_exec($ch);