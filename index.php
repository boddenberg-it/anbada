<html>
    <head>
	<title>anbada</title>
	<meta http-equiv="refresh" content="10; URL="<?php $actual_link = (isset($_SERVER['HTTPS']) ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; ?>"">
	<?php shell_exec("/var/www/html/anbada.sh foo refresh") ?>
    </head>
    <body>
	<h2>
		<b>AN</b>droid <b>BA</b>ckup <b>DA</b>emon
	</h2>
	<form action="anbada.php" method="post">
		<p>connected devices:<p>
		<?php include("/tmp/anbada/devices"); ?>
		<br>
		<p>folder:</p>
		<label><input type="checkbox" name="DCIM (photos & videos)"</input>photos?</label><br>
		<label><input type="checkbox" name="Download (downloads)"</input>downloads?</label><br>
		<p></p>
		<label><input type="checkbox" name="apps"</input>apps?</label><br>
		<label><input type="checkbox" name="contacts"</input>contacts?</label><br>
		<p></p>
		<input type="button" value="backup" onclick="submit();"></input>
	</form>
    <body>
</html>
