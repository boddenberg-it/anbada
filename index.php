<html>
    <head>
	<title>anbada</title>
	<!-- to let the LED blink :) -->
	 <meta http-equiv="refresh" content="10; URL=http://anbada/">
	<?php shell_exec("/var/www/html/anbada.sh foo refresh") ?>
    </head>
    <body>

	<br><h2><b>AN</b>droid <b>BA</b>ckup <b>DA</b>emon</h2><br>

	<div><p><?php include("/tmp/anbada/myFile.txt"); ?></p></div>

	<form action="backup.php" method="post">
		<input type=checkbox name="Photos" checked="false"></input>
		<br>
		<input type=button value="submit" onclick="submit();"></inpu>
	</form>

    <body>
</html>
