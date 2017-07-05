<?php

?>

<!DOCTYPE html>
<html lang="pl">
<head>
	<title>CSS style menu</title>
	<!-- meta tagi -->
	<meta charset="utf-8">
	<!-- IE browser kompatybilnosc -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- urządzenia mobilne -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- opis strony wyświetlany w wynikach wyszukiwania google -->
	<meta name="description" content="Opis strony nie za długi">
	<!-- autor -->
	<meta name="author" content="Imię i Nazwisko">

	<!-- cache -->
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="pragma" content="no-cache"> 

	<!-- style.css z pliku -->
	<link rel="stylesheet" type="text/css" href="my.css">

	<!-- animate.css z pliku -->
	<link rel="stylesheet" type="text/css" href="animate.css">

	<!-- style ma większy priorytet niż style z pliku css !!! -->
	<style type="text/css"> </style>
	
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

	<!-- java script -->
	<script type="text/javascript">
	$(document).ready(function() {

		$("#upload").on('change',function() {	      	
		 if($("#upload")[0].files.length > 4){
		    alert("Możesz dodać maksymalnie 4 pliki");
		 } else {
			var files = $("#upload")[0].files;
			$('.post-img').html("");
			for (var i = 0; i < files.length; i++) {
			//alert(files[i].name);
			}
			
			$('.loader').css('visibility', 'inherit');	
			var formData = new FormData($("form")[0]);
		  	$.ajax({
		        url: 'js-upload.php',
		        type: 'POST',
		        dataType: false,
		        enctype: 'multipart/form-data',
		        data: formData,
		        cache: false,
		        contentType: false,
		        processData: false,
		        success: function( data ) {
		        	if (data == 1) {
		            	alert("Plik przesłany");
		        	}else{
		        		alert(data);
		        	}
		        },
		        error: function( xhr, d, e ) {
		        	$('.loader').css('visibility', 'hidden');
		            alert("Something goes wrong " + d + xhr.statusText + " error " + xhr.status);		       
		        }
		  	});
		  }
		});	
	});	
	</script>
</head>
<body>

<form method="post" action="" enctype="multipart/form-data">
	<input type="file" name="files[]" multiple="true" accept="image/*" id="upload">
	<input type="submit" name="upload" value="UPLOAD">
</form>

</body>
</html>
