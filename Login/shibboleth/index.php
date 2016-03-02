<?php

$exclude_html = true;
//$include_mysqli = true;

include_once (__DIR__)."/_resources/header.inc.php";

echo $_SERVER["uid"];
echo "<br/>";
echo $_SERVER["displayName"];

$query = "CALL login_shib_user('$_SERVER[uid]','$_SERVER[displayName]');";
if ( ($result = $mysqli->query($query))===false )
{
  printf("Invalid query: %s\nWhole query: %s\n", $mysqli->error, $query);
  exit();
}

while ($row = $result->fetch_array(MYSQLI_ASSOC))
{
  echo "$row[user_key]";
}
$result->close();

/*
if (isset($_POST['email'], $_POST['p'])) {
    $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);
    $password = $_POST['p']; // The hashed password.
    
    $http_referer_array = explode("?", $_SERVER["HTTP_REFERER"]);
    $http_referer_plain = $http_referer_array[0];
    
    if (login($email, $password, $mysqli) == true) {
        // Login success 
        header("Location: $http_referer_plain");
        exit();
    } else {
        // Login failed 
        header("Location: $http_referer_plain?error=1");
        exit();
    }
} else {
    // The correct POST variables were not sent to this page. 
    die("ERROR: Could not process login.");
}
*/

require_once((__DIR__)."/_resources/footer.inc.php");

?>
