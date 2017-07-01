<?php
$page = $_SERVER['PHP_SELF'];
$client = $_SERVER['REMOTE_ADDR'];
$sec = "10"
?>

<html>
    <title>anbada</title>
    <head>
    <meta http-equiv="refresh" content="<?php echo $sec?>;URL='<?php echo $page?>'">
    </head>
    <body>

	<br><h2><b>AN</b>droid <b>BA</b>ckup <b>DA</b>emon</h2><br>

	<input type=checkbox name="DCIM folder"
		checked="true"
		onClick="<?php shell_exec('/var/www/html/test2.sh uffda') ?>">

	<form action="<?php shell_exec('/var/www/html/anbada.sh'); ?>"><input type="submit" value="backup"></form>

	<div><p><?php include('/tmp/anbada/myFile.txt'); ?></p></div>

	<div><p><?php echo $client ?></p></div>
        <div><p>Uffda</p></div>

    <body>
</html>
