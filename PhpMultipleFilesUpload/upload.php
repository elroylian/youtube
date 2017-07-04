<?php
// echo "<pre>";
// print_r($_FILES);
// 1 MB = 1024 KB = 1 048 576 Bytes = 8 388 608 bitów
echo $maxsizemb = 1024 * 1024 * 1;

$gid = 1;
$i = 1;
mkdir("galeria/".$gid, 0755, true);
foreach ($_FILES['files']['type'] as $key => $value) {
	if(($value == "image/png") || ($value == "image/jpg") || ($value == "image/gif") || ($value == "image/jpeg")){
		//echo $value.$_FILES['files']['name'][$key];
		$tmp = $_FILES['files']['tmp_name'][$key];		
		$size = $_FILES['files']['size'][$key];	// bytes
		$name = $_FILES['files']['name'][$key];			
		$temporary = explode(".", $_FILES["files"]["name"][$key]);
		$ext = end($temporary);
		if ($size < $maxsizemb) {
			$fileto = "galeria/".$gid."/".md5(microtime()).".".$ext;
			move_uploaded_file($tmp, $fileto);
			$all[$i] = $fileto;	
		}else{
			echo 'Zbyt duży plik (max 1 MB)';
		}
	}
	$i++;		
}
?>
<form method="post" action="" enctype="multipart/form-data">
	<input type="file" name="files[]" multiple="true" accept="image/*">
	<!-- or all files -->
	<input type="file" name="files[]" multiple="true">
	<input type="submit" name="upload" value="UPLOAD">
</form>
