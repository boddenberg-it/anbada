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
			<label><input type="checkbox" name="all_data"</input>all data?</label>
			<br>
			<label><input type="checkbox" name="photos_videos"</input>only photos/videos?</label>
			<br>
			<br>
			<input type="submit" class="button" name="action" value="sync"></input>
		</form>
	<body>
</html>
