<html>
    <head>
	<title>anbada</title>
	<link rel="stylesheet" href="anbada.css">

    </head>

    <body>
	<?php include("header.html"); ?>

	<form action="anbada.php" method="post">
		<p>connected device(s):<p>
		<?php include("/tmp/anbada/devices"); ?>
		<br>
		<input type="submit" class="button" name="action" value="restore"></input>
	</form>
    <body>
</html>
