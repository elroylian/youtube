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
			$('.menubtn').click(function(){
				// alert("Button click");
				// po naciśnięciu przycisku rozwiń menu
				// $('.menu').addClass('show');
				// $('.menu').toggle('.show');
				$('.menu').slideToggle('.show');
			});
		});
	</script>
</head>
<!-- style inline zmienia gdyz ma wiekszy priorytet -->
<body style="">

<div class="top">
	<img src="img/logo.png" class="animated bounceInRight">

	<img src="img/menu.png" class="menubtn">

	<div class="menu">
		<a href="kontakt.php" class="m animated bounce">Kontakt</a>
		<a href="users.php" class="m animated flipInX">Users</a>
		<a href="shop.php" class="m animated swing">Sklep</a>
	</div>

</div>

<h2> Koniec </h2>

</body>
</html>
