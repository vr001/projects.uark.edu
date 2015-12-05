<?php

include_once('../_resources/credentials.php');
$include_jquery_ui = true;
$include_tablesorter = true;
$include_mysql = true;
require_once('../_resources/header.php');

echo "

<h1>$section_title</h1>

<p><a href='thread.create.php' class='btn btn-success'>Create New Thread</a></p>

";

// default login
if (isset($_GET["default"])){
	$_SESSION["user_id"] = -1;
	$_SESSION["username"] = "Default";
}

?>

<!-- list of threads -->
<?php

if( !empty($mysql_connection) ){
    
    $sql="
		SELECT t.thread_id, t.thread_name,
			mm.max_message_id, m.message_creation_time,
			m.message_author_user_id
		FROM Forum_Threads t
		JOIN Forum_Messages m
			ON t.thread_id = m.message_thread_id
		JOIN (
			SELECT message_thread_id, MAX(message_id) AS max_message_id
			FROM Forum_Messages
			GROUP BY message_thread_id
		) mm
			ON mm.max_message_id = m.message_id
		GROUP BY t.thread_id
		ORDER BY mm.max_message_id DESC;
    ";
    $result = mysql_query($sql) or die(mysql_error());
    $numfields = mysql_num_fields($result);

    // table
    echo "
	    <table border=1>
		    <thead>
			    <tr>
					<th>Thread</th>
					<th>Last Updated</th>
					<th>Updated By</th>
			    </tr>
		    </thead>
		    <tbody>
    ";

    // // data
    while ($row = mysql_fetch_assoc($result))
	    echo "<tr>
			<td><message_data thread_id='$row[thread_id]' thread_name='$row[thread_name]'></message_data>$row[thread_name]</td>
			<td>$row[message_creation_time]</td>
			<td>message_author_user_id $row[message_author_user_id]</td>
	    </tr>\n";
    echo "
		    </tbody>
	    </table>
    ";

    ?>
    <!-- hyperlink whole row -->
    <script>
      $("tr").click( function() {
	  var row = $(this);
	  var thread_id = row.find("message_data").attr("thread_id");
	  var thread_name = row.find("message_data").attr("thread_name");
	  $.ajax({url: "messages.ajax.php?thread_id=" + thread_id, success: function(result){
	    $("#thread_div").hide("blind",function(){
	      $("#thread_div").html(result).prepend("<h2>" + thread_name + "</h2>").show("blind");
	      $("#message_div").show();
	    });
	    row.addClass("bg-primary").siblings().removeClass("bg-primary");
	    $("#message_thread_id").val(thread_id);
	  },cache: false});
      }).hover( function() {
	  $(this).toggleClass("hover");
      });
    </script>
    <style>
      tr.hover {
	cursor: pointer;
      }
    </style>
    <?php

} else {

    // help connecting to database
    echo "ERROR: not connected to MySQL";
    include("$path_real_relative_root/_resources/SQL/database.help.inc.html");

}

?>


<!-- thread of messages -->
<div id='thread_div' class='well'>
  <p>Click a thread to show messages.</p>
</div><!-- /#thread_div.well -->



<!-- post message text area -->
<?php
if (!isset($_SESSION["username"])) { ?>

	<p><a href='?default' class='btn btn-primary'>Login as 'Default'</a></p>

<?php } else { include("message.input.inc.html"); } ?>

<?php require_once('../_resources/footer.php');?>
