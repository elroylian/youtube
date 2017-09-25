	<?php
	session_start();

	// dont show errors
	error_reporting(0);

	// allow big files
	ini_set('post_max_size','400M');
	ini_set('upload_max_filesize','200M');

	// database
	$mdatabase = 'test';
	$muser = 'root';
	$mpass = 'toor';
	$mhost = 'localhost';
	$mport = 3306;

	// connect to mysql with PDO function
	function Conn(){
	    global $mhost,$mport,$muser,$mpass,$mdatabase;
	    $connection = new PDO('mysql:host='.$mhost.';port='.$mport.';dbname='.$mdatabase.';charset=utf8', $muser, $mpass);
	    // don't cache query
	    $connection->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
	    // show warning text
	    $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
	    // throw error exception
	    $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	    // don't colose connecion on script end
	    $connection->setAttribute(PDO::ATTR_PERSISTENT, false);
	    // set utf for connection utf8_general_ci or utf8_unicode_ci 
	    $connection->setAttribute(PDO::MYSQL_ATTR_INIT_COMMAND, "SET NAMES 'utf8' COLLATE 'utf8_general_ci'");
	    return $connection;
	}

	function saveLink($link, $id = 0){	
	    global $db; // allow mysql connection from global variables
	    if (!empty($link)) {
	        $link = htmlentities($link,ENT_QUOTES,'UTF-8');
	        $r = $db->query("INSERT INTO imageuploads (image,uid_fk) VALUES ('$link','$id')");
	        // last inserted id if you had auto increment primary key id (int or bigint)
	        $id = $db->lastInsertId();
	        return $id;
	    }else{
	        return 0;
	    }
	}

	// db connection
	$db = Conn();

	//connection to database
	$gid = $_SESSION['u_id'] = 777;


	//inserting into database
	// $sql = "INSERT INTO imageuploads (image,uid_fk) VALUES ('$fileNameNew','$id')";

	// echo "<pre>";
	// print_r($_FILES);
	// 1 MB = 1024 KB = 1 048 576 Bytes = 8 388 608 bitów
	$maxsizemb = 1024 * 1024 * 8;
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
				saveLink($fileto, $gid);
				$all[$i] = $fileto;	
			}else{
				echo 'Zbyt duży plik (max 8 MB)';
			}
		}
		$i++;		
	}
	?>
	<form method="post" action="" enctype="multipart/form-data">
		<label>Only JPG</label>
		<input type="file" name="files[]" multiple="true" accept="image/*"><br>
		<!-- or all files -->
		<label>All images</label>
		<input type="file" name="files[]" multiple="true"><br>
		<input type="submit" name="upload" value="UPLOAD">
	</form>
