<?php
$servername = "cloudgate";
$username   = "projectm_admin";
$password   = "mFqiWNJcv36txFZ";
$dbname     = "projectm_kakpahnasiberlaukdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>