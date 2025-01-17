# ใช้ Alpine Linux เป็นฐานสำหรับ Docker image
FROM alpine:latest

# เพิ่มข้อมูลเกี่ยวกับผู้ดูแล Docker image นี้
LABEL MAINTAINER="https://github.com/htr-tech/zphisher"

# กำหนด Working directory ภายใน container
WORKDIR /zphisher/

# คัดลอกไฟล์ทั้งหมดจากโฟลเดอร์ปัจจุบัน (ที่สร้าง Docker image) ไปยัง /zphisher ภายใน container
ADD . /zphisher

# ติดตั้ง dependencies ที่จำเป็นสำหรับการรัน Zphisher (bash, ncurses, curl, unzip, wget, php)
RUN apk add --no-cache bash ncurses curl unzip wget php 

# กำหนดคำสั่งที่จะรันเมื่อ container เริ่มทำงาน
CMD "./zphisher.sh"