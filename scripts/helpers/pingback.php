<?php

$validIpAddressRegex = "/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/";
$validHostnameRegex = "/^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$/";

if (preg_match($validHostnameRegex, $_GET['hostname'], $matches)) {
    $logFile = "setupLog.csv";
    $fields = [date("Y-m-d_H:i:s"), $matches[0]];
    $fp = fopen($logFile, 'a+');
    fputcsv($fp, $fields);
    fclose($fp);
}