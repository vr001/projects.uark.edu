<?php
	$pageTitle = "Forms";
	require_once('header.php');
?>

<h1><?php echo $pageTitle;?></h1>

<script>
  $(function() {
    var autodata = [
	
	<?php
		/*
		// populate autocomplete list from MySQL result set
		$query_autodata = "SELECT `id`, `column` FROM `db`.`schema`.`table` ORDER BY `column`;";
		$result_autodata = mysql_query($query_autodata) or die( 'Invalid query: ' . mysql_error() );
		while ( $row = mysql_fetch_assoc($result_autodata) ) {
			if($next)
				echo ",
			";
			echo '{label:"' . $row["column"]
				. '",value:"' . $row["column"]
				. '",id:"' . $row["id"] . '"}';
			$next = true;
		}
		*/
	?>
	
		{label:"First Label",value:"First Value",id:"1"},
		{label:"Second Label",value:"Second Value",id:"2"},
		{label:"Third Label",value:"Third Value",id:"3"},
		{label:"Fourth Label",value:"Fourth Value",id:"4"},
		{label:"Fifth Label",value:"Fifth Value",id:"5"}
    ];
    $( "#form1-autocomplete" ).autocomplete({
      source: autodata,
	  select: function(e,u){
		  $("#form1-autocomplete-id").val(u.item.id);
		  $("#form1-autocomplete").val(u.item.value);
		  //$("#form1").submit();
	  }
    });
  });
</script>

<div class="well" id="form1-div">
	<h3>Form1:</h3>
	<form id="form1" role="form">
		<input id="form1-autocomplete-id" name="form1-autocomplete-id" type="hidden" value="<?php echo $_GET['form1-autocomplete-id']; ?>"></input>
		<div class="form-group">
			<label for="form1-autocomplete">Autocomplete:</label>
			<input id="form1-autocomplete" name="form1-autocomplete" type="text" class="form-control" value="<?php echo $_GET['form1-autocomplete']; ?>"></input>
		</div>
		<div class="form-group">
			<label for="form1-date">Datepicker:</label>
			<input id="form1-date" name="form1-date" type="date" value="<?php echo $_GET["form1-date"]; ?>" class="form-control"/>
		</div>
		<div class="form-group">
			<label for="form1-select">Selectlist:</label>
			<select id="form1-select" name="form1-select" class="form-control">
				<?php
					// repopulate active option with last submitted, or default blank
					if(!empty($_GET["form1-select"]))
						echo "<option value='" . $_GET["form1-select"] . "' selected>" . $_GET["form1-select"] . "</option><option></option>";
					else
						echo "<option selected></option>";
				?>
				
				<?php
					/*
					// populate select list from MySQL result set
					// if using value different than label, such as an ID, then can't repopulate active option with submitted label
					$query_selectlistdata = " SELECT DISTINCT `column` FROM `db`.`schema`.`table` ORDER BY `column`; ";
					$result_selectlistdata = mysql_query($query_selectlistdata) or die( 'Invalid query: ' . mysql_error() );
					while ( $row = mysql_fetch_assoc($result_selectlistdata) ) {
						echo '<option value="' . $row["column"] . '">' . $row["column"] . '</option>';
					}
					*/
				?>
				<option value="FirstValue">First Option</option>
				<option value="SecondValue">Second Option</option>
				<option value="ThirdValue">Third Option</option>
				<option value="FourthValue">Fourth Option</option>
				<option value="FifthValue">Fifth Option</option>
			</select>
		</div>
		<button type="submit" class="btn btn-primary">Submit</button>
	</form>
</div>

<?php require_once('footer.php');?>
