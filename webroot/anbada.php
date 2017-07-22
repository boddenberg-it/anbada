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

// getting form information
$client = $_SERVER['REMOTE_ADDR'];
$action = $_POST['action'];
$device = $_POST['device'];
$apps = $_POST['apps'];
$obb = $_POST['obb'];
$storage = $_POST['storage'];
$system_apps = $_POST['system_apps'];
$ssid = $_POST['ssid'];
$password = $_POST['password'];
$sort_of_backup = $_POST['sort_of_backup'];
//$file = $_POST['file'];

// ensuring that shell functions only gets necessary information
switch($action) {
	case ("backup"):
	shell_exec("/var/www/ssl/anbada.sh $client $action $device apps:$apps obb:$obb storage:$storage system_apps:$system_apps");
  	break;

	case ("add_ssid"):
	shell_exec("/var/www/ssl/anbada.sh $client $action $ssid $password");
	break;

	case ("restore"):
//	shell_exec("/var/www/ssl/anbada.sh $client $action $device $file");
	break;

	case ("sync"):
	shell_exec("/var/www/ssl/anbada.sh $client $action $device $sort_of_backup");
}
redirect("https://anbada/index.php");
?>
