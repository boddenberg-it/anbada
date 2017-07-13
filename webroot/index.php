<?php include("header.html"); ?>
  <form action="anbada.php" method="post">
    <p>connected device(s):<p>
    <?php include("/tmp/anbada/devices"); ?>
    <br>
    <label><input type="checkbox" name="apps"</input> apps?
    </label><br>
    <label><input type="checkbox" name="storage"</input> storage?
    </label><br>
    <label><input type="checkbox" name="system_apps"</input> system apps?
    </label><br>
    <br>
    <input type="submit" class="button" name="action" value="backup"></input>
  </form>
<?php include("footer.html"); ?>
