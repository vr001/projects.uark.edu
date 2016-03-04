<?php

$exclude_html = true;
$include_mysqli = true;
include_once (__DIR__)."/_resources/header.inc.php";

if (!empty($_SERVER["uid"]) && !empty($_SERVER["displayName"])) {

  $query = "CALL login_shib_user('$_SERVER[uid]','$_SERVER[displayName]');";
  if ( ($result = $mysqli_connection->query($query))===false ) {
    printf("ERROR: Could not process login.", $mysqli_connection->error, $query);
  }
  else {
    $row = $result->fetch_row();
    $_SESSION["user_key"] = $row[0];
    $_SESSION["username"] = $_SERVER["displayName"];
    $result->close();
    $http_referer_array = explode("?", $_SERVER["HTTP_REFERER"]);
    $http_referer_plain = $http_referer_array[0];
    header("Location: $http_referer_plain");
  }

} else echo "ERROR: \$_SERVER[uid] and \$_SERVER[displayName] are empty.";

require_once((__DIR__)."/_resources/footer.inc.php");

?>
