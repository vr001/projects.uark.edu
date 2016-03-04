<?php

$include_mysqli = true;

// if individual profile, then validate user_key greater than zero
if ( !empty($_GET["user_key"]) && is_numeric($_GET["user_key"]) && $_GET["user_key"] > 0 ) {
  $user_key = $_GET["user_key"];
  require_once("profile.inc.php");
}
if (empty($array_profile)) {
  $user_key = false;
  $include_tablesorter = true;
}

require_once("_resources/header.inc.php");

$page_header = ( !empty($page_title) ? $page_title : $section_title );

echo "<h1>$page_header</h1>";

// print body of individual profile
if ( !empty($user_key) && !empty($array_profile) ) {

  if (isset($_SESSION["user_key"]) && $_SESSION["user_key"] === $user_key) { 

    if ($array_profile["private_profile"] === "1") { $class = "danger"; $privacy = "Private"; }
    else { $class = "success"; $privacy = "Public"; }
    echo "<div id='privacy_div_wrapper' style='float:right'><div id='privacy_div' class='well'><p><a href='javascript:privatize_profile($array_profile[private_profile])' class='btn btn-$class'>$privacy</a></p></div></div>";

  ?>

  <script>
    function privatize_profile(current_privacy_value){
      if (current_privacy_value === 1) {
	      new_privacy_value = "0";
      } else  new_privacy_value = "1";
      $.ajax({url: "privatize.ajax.php?user_key=<?php echo $_SESSION["user_key"];?>&privatize=" + new_privacy_value, 
	success: function(result){
	    $("#privacy_div").html(result);
	}
      });
    }
  </script>

  <?php }

  echo "
  <div class='well'>

    <label for='email'>Email:</label>
    <p id='email'>$array_profile[email]</p>

  </div>
  ";

}
else // print list of profiles
{

  require_once("profiles.inc.php");

}

 ?>

<?php require_once("_resources/footer.inc.php");?>
