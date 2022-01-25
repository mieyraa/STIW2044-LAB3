<?php

include_once("dbconnect.php");

$userid = $_POST['userid'];

$sqlloadproducts = "SELECT * FROM tbl_products INNER JOIN tbl_users ON tbl_products.pridowner = tbl_users.user_id ORDER BY tbl_products.prdate DESC";


$result = $conn->query($sqlloadproducts);
if ($result->num_rows > 0) {
    $response["products"] = array();
while ($row = $result->fetch_assoc()) {
        $prlist = array();
        $prlist['prid'] = $row['prid'];
        $prlist['prname'] = $row['prname'];
        $prlist['pridowner'] = $row['pridowner'];
        $prlist['user_name'] = $row['user_name'];
        $prlist['user_email'] = $row['user_email'];
        $prlist['user_phone'] = $row['user_phone'];
        $prlist['prdesc'] = $row['prdesc'];
        $prlist['prprice'] = $row['prprice'];
        $prlist['prqty'] = $row['prqty'];
        $prlist['prdel'] = $row['prdel'];
        $prlist['prstate'] = $row['prstate'];
        $prlist['prloc'] = $row['prloc'];
        $prlist['prlat'] = $row['prlat'];
        $prlist['prlong'] = $row['prlong'];
        $prlist['prdate'] = $row['prdate'];
        array_push($response["products"], $prlist);
}
        echo json_encode($response);
} else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
}
?>