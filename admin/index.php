<?php

include_once('_resources/credentials.inc.php');
//$page_title = "Home Page";
require_once('_resources/header.inc.php');

echo "<h1>$section_title</h1>"; ?>

<p class='lead'>Here are some local links to this template's components.</p>

<div class='well'>
<?php echo "
  <li><a href='$path_web_root/Forms/'>Forms</a></li>
  <li><a href='$path_web_root/Tables/'>Tables</a></li>
  <li><a href='$path_web_root/FancyBox/'>FancyBox</a></li>
  <li><a href='$path_web_root/Embed/'>Embed</a></li>
  <li><a href='$path_web_root/SubTree/'>SubTree</a></li>
"; ?>
</div><!-- /.well -->

<?php require_once('_resources/footer.inc.php');?>
