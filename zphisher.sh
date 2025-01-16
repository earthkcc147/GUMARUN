__version__="2.3.5"

## ค่าเริ่มต้นสำหรับโฮสต์และพอร์ต
HOST='127.0.0.1' # โฮสต์ที่ใช้ (ค่าเริ่มต้นคือ localhost)
PORT='8080'      # พอร์ตที่ใช้ (ค่าเริ่มต้นคือ 8080)

## ANSI สี (สำหรับข้อความและพื้นหลัง)
RED="$(printf '\033[31m')"  # สีแดง
GREEN="$(printf '\033[32m')"  # สีเขียว
ORANGE="$(printf '\033[33m')"  # สีส้ม
BLUE="$(printf '\033[34m')"  # สีน้ำเงิน
MAGENTA="$(printf '\033[35m')"  # สีม่วงแดง
CYAN="$(printf '\033[36m')"  # สีฟ้า
WHITE="$(printf '\033[37m')"  # สีขาว
BLACK="$(printf '\033[30m')"  # สีดำ

# สีพื้นหลัง
REDBG="$(printf '\033[41m')"  # พื้นหลังสีแดง
GREENBG="$(printf '\033[42m')"  # พื้นหลังสีเขียว
ORANGEBG="$(printf '\033[43m')"  # พื้นหลังสีส้ม
BLUEBG="$(printf '\033[44m')"  # พื้นหลังสีน้ำเงิน
MAGENTABG="$(printf '\033[45m')"  # พื้นหลังสีม่วงแดง
CYANBG="$(printf '\033[46m')"  # พื้นหลังสีฟ้า
WHITEBG="$(printf '\033[47m')"  # พื้นหลังสีขาว
BLACKBG="$(printf '\033[40m')"  # พื้นหลังสีดำ
RESETBG="$(printf '\e[0m\n')"  # รีเซ็ตสีพื้นหลังกลับเป็นค่าเริ่มต้น

## การตั้งค่าดาวน์โหลดและจัดการโฟลเดอร์
BASE_DIR=$(realpath "$(dirname "$BASH_SOURCE")") # กำหนดตำแหน่งของโฟลเดอร์ฐาน

# ตรวจสอบว่าโฟลเดอร์ .server มีอยู่หรือไม่ หากไม่มีให้สร้างใหม่
if [[ ! -d ".server" ]]; then
        mkdir -p ".server"
fi

# ตรวจสอบว่าโฟลเดอร์ auth มีอยู่หรือไม่ หากไม่มีให้สร้างใหม่
if [[ ! -d "auth" ]]; then
        mkdir -p "auth"
fi

# ตรวจสอบว่าโฟลเดอร์ .server/www มีอยู่หรือไม่ หากมีอยู่ให้ลบและสร้างใหม่
if [[ -d ".server/www" ]]; then
        rm -rf ".server/www"
        mkdir -p ".server/www"
else
        mkdir -p ".server/www"
fi

## ลบไฟล์ log ที่อาจมีอยู่ก่อนหน้า
if [[ -e ".server/.loclx" ]]; then
        rm -rf ".server/.loclx" # ลบไฟล์ .loclx หากมีอยู่
fi

if [[ -e ".server/.cld.log" ]]; then
        rm -rf ".server/.cld.log" # ลบไฟล์ .cld.log หากมีอยู่
fi