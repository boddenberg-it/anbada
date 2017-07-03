<?php $client = $_SERVER['REMOTE_ADDR']; ?>
<html>
    <title>anbada</title>
    <head>
<!--    <meta http-equiv="refresh" content="10"> -->
    </head>
    <body>

	<br><h2><b>AN</b>droid <b>BA</b>ckup <b>DA</b>emon</h2><br>

	<input type=checkbox name="DCIM folder"
		checked="false"
		onClick="<?php shell_exec("/var/www/html/anbada.sh $client checkbox_photos") ?>"
	</input>

	<form action="<?php shell_exec("/var/www/html/anbada.sh $client backup"); ?>"><input type="submit" value="backup"></form>

	<div><p><?php include('/tmp/anbada/myFile.txt'); ?></p></div>

	<div><p><?php echo $client ?></p></div>
        <div><p>Uffda</p></div>

    <body>
</html>
