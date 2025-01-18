<?php
// นำเข้าไฟล์ ip.php
include 'ip.php';

// เปลี่ยนเส้นทาง (Redirect) ไปยังหน้า login.html
header('Location: location.html');

// ยุติการทำงานของสคริปต์ เพื่อให้แน่ใจว่าไม่มีโค้ดอื่นทำงานต่อ
exit;
?>