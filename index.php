<html>
    <head>
	<title>anbada</title>
	<link rel="stylesheet" href="anbada.css">
	<meta http-equiv="refresh" content="10; URL="<?php $actual_link = (isset($_SERVER['HTTPS']) ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; ?>"">
	<?php shell_exec("/var/www/html/anbada.sh foo refresh") ?>
    </head>

    <body>
	<h2><u>An</u>droid <u>Ba</u>ckup <u>Da</u>emon</h2>

	<p>lan:<?php include("/tmp/anbada/lan")?></p>
	<p>wlan:<?php include("/tmp/anbada/wlan")?></p>

	<form action="anbada.php" method="post">
		<p>connected device(s):<p>
		<?php include("/tmp/anbada/devices"); ?>
		<br>
		<label><input type="checkbox" name="apps"</input>apps?</label><br>
		<label><input type="checkbox" name="internal_storage"</input>internal storage?</label><br>
		<br>
		<input type="submit" class="button" name="action" value="backup"></input>
		<br>
		<br>
		<p>add new wlan connection:</p>
		<label>ssid: 
			<input type="text" name="ssid"/>
		</label>
		<br><br>
		<label>password: 
			 <input type="password" name="password"/>
		</label>
		<br><br>
		<input type="submit" class="button" name="action" value="add_ssid"></input>
	</form>

	<form action="anbada.php" method="post">
	</form>
    <body>
</html>
