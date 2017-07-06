<p>processing request...</p>

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

$action = $_POST['action'];

	$apps = $_POST['apps'];
	$internal_storage = $_POST['internal_storage'];
	shell_exec("/var/www/ssl/secure/anbada.sh $client $action $apps $internal_storage");

echo "/var/www/ssl/secure/anbada.sh $client $action $apps $internal_storage";
echo '<pre>';
echo htmlspecialchars(print_r($_POST, true));
echo '</pre>';

//redirect("https://anbada/");
?>
