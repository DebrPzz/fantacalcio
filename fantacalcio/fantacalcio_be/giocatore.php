<?php
require_once "index.php";

use Models\Sport\Giocatore as Giocatore;

$id = ( isset($_GET['id']) ) ? $_GET['id'] : 0;
$message = "";

$item = $id ? new Giocatore($id) : new Giocatore();

if (isset($_REQUEST['act']) && $_REQUEST['act'] == 'del') {
    $item->delete();
}

if (!empty($_POST["item"])) {

    foreach ($_POST["item"] as $k => $v) {
        $item->$k = $v;
    }

    if ($item->validate()) {
        $item->save();
    } else {
        $message = $item->getErrors();
    }
}

if($id && empty($_REQUEST['act']))
    echo json_encode(["item" => $item, "message" => $message]);
else
    echo json_encode(["items" => Giocatore::getAll(), "message" => $message]);
