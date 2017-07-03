<html>
    <head>
	<title>anbada</title>
    </head>
    <body>

	<br><h2><b>AN</b>droid <b>BA</b>ckup <b>DA</b>emon</h2><br>

	<form action="refresh.php" method="post">
		<input type=button value="refresh" onclick="submit()"></input>
	</form>

	<div><p><?php include("/tmp/anbada/myFile.txt"); ?></p></div>

	<form action="backup.php" method="post">
		<input type=checkbox name="Photos" checked="false"></input>
		<br>
		<input type=button value="submit" onclick="submit();"></inpu>
	</form>

    <body>
</html>
