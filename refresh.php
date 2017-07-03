<?php
function redirect($url){
	if (headers_sent()){
		die('<script type="text/javascript">window.location=\''.$url.'\';</script‌​>');
	}else{
		header('Location: ' . $url);
	      	die();
    	}
}

$client = $_SERVER['REMOTE_ADDR'];
shell_exec("/var/www/html/anbada.sh $client refresh");
redirect("http://anbada/");
?>
