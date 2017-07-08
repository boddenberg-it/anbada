<html>
    <head>
	<title>anbada</title>
	<link rel="stylesheet" href="anbada.css">
    </head>

    <body>
	<?php include("header.html"); ?>

	<p>connected ssid: <?php include("/tmp/andaba/wlan")?></p>
	<br>
	<form action="anbada.php" method="post">
		<p>add new ssid:</p>
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
    <body>
</html>
