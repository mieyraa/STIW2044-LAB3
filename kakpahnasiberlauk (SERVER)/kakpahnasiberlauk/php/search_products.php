<?php
include_once("dbconnect.php");
$packageSet = $_POST['packageSet'];

    $sqlsearchproducts= "SELECT * FROM tbl_products";
    $result = $conn->query($sqlsearchproducts);

if ($result->num_rows > 0){
    $response["package"] = array();
    while ($row = $result -> fetch_assoc()){
        $_searchList = array();
        $_searchList[prid] = $row['prid'];
        $_searchList[prname] = $row['prname'];
        $_searchList[prdesc] = $row['prdesc'];
        $_searchList[prqty] = $row['prqty'];
        $_searchList[prprice] = $row['prprice'];
        $_searchList[prdate] = $row['prdate'];
        $_searchList['images'] = 'https://projectmuu.com/kakpahnasiberlauk/images/products/' . $row['images'];
        array_push($response["package"],$_searchList);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>
