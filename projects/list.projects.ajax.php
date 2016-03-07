<?php
$include_mysqli = true;
require_once("_resources/header.inc.php");

if( !empty($mysqli_connected) ){
    
    $result = $mysqli_connection->query("CALL fetch_projects()") or die($mysqli_connection->error());
    $numfields = $result->field_count;

    // open table
    echo "
	<table border=1>
		<thead>
			<tr>
				    <th>content_title</th>
				    <th>content_value</th>
				    <th>content_creation_time</th>
				    <th>content_createdby_user_key</th>
			</tr>
		</thead>
		<tbody>
    ";

    // data
    while ($row = $result->fetch_assoc())
	echo "
			<tr>
				<td><content_data content_key='$row[project_key]' content_title='$row[content_title]'></content_data>$row[content_title]</td>
				<td>$row[content_value]</td>
				<td>$row[content_creation_time]</td>
				<td>$row[content_createdby_user_key]</td>
			</tr>\n";
    
	// close table
	echo "
		</tbody>
	</table>
	
	<script>
	  $(hyperlink_row());
	</script>
    ";

} else {

    // help connecting to database
    echo "<p class='bg-danger text-danger'>ERROR: Not Connected to Database</p>";
    include("$path_real_root/_resources/SQL/database.help.inc.html");

}
?>

<?php require_once("_resources/footer.inc.php");?>
