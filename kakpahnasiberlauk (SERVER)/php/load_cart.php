<?php
error_reporting(0);
include_once("dbconnect.php");
$user_email = $_POST['user_email'];

$sqlloadcart= "SELECT * FROM tbl_cart INNER JOIN tbl_products ON tbl_cart.prid = tbl_products.prid WHERE tbl_cart.user_email = $user_email";

$result = $conn->query($sqlloadcart);
if ($result->num_rows > 0) {
    $response["cart"] = array();
    while ($row = $result ->fetch_assoc()){
        $productList = array();
        $productList['prid'] = $row['prid'];
        $productList['prname'] = $row['prname'];
        $productList['prprice'] = $row['prprice'];
        $productList['prqty'] = $row['prqty'];
        $productList['cartqty'] = $row['cartqty'];
        array_push($response["cart"],$productList);
    }
    echo json_encode($response);
}else{
    echo "failed";
}
?>
