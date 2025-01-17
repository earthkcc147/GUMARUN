#!/bin/bash

# สร้าง Deb Package สำหรับ Zphisher (^.^)
_PACKAGE=zphisher  # ชื่อแพ็กเกจ
_VERSION=2.3.5  # เวอร์ชันของแพ็กเกจ
_ARCH="all"  # สถาปัตยกรรมของแพ็กเกจ
PKG_NAME="${_PACKAGE}_${_VERSION}_${_ARCH}.deb"  # ชื่อไฟล์แพ็กเกจ

# ตรวจสอบว่าไฟล์ launch.sh อยู่ในโฟลเดอร์ scripts หรือไม่ ถ้าไม่มีก็จะแสดงข้อความและหยุดการทำงาน
if [[ ! -e "scripts/launch.sh" ]]; then
    echo "lauch.sh should be in the \`scripts\` Directory. Exiting..."
    exit 1
fi

# หากระบบเป็น Termux หรือ Android จะตั้งค่าตัวแปรที่เกี่ยวข้องกับ Termux
if [[ ${1,,} == "termux" || $(uname -o) == *'Android'* ]];then
    _depend="ncurses-utils, proot, resolv-conf, "  # ระบุ dependencies สำหรับ Termux
    _bin_dir="data/data/com.termux/files/"  # กำหนดที่อยู่สำหรับไฟล์ไบนารีใน Termux
    _opt_dir="data/data/com.termux/files/usr/"  # กำหนดที่อยู่สำหรับไฟล์ใน Termux
    # PKG_NAME=${_PACKAGE}_${_VERSION}_${_ARCH}_termux.deb  # สามารถใช้ชื่อนี้ได้ในกรณีที่ต้องการ
fi

_depend+="curl, php, unzip"  # เพิ่ม dependencies อื่น ๆ ที่ต้องการ
_bin_dir+="usr/bin"  # กำหนดที่อยู่ของไบนารี
_opt_dir+="opt/${_PACKAGE}"  # กำหนดที่อยู่ของไฟล์ในโฟลเดอร์ opt

# ลบโฟลเดอร์ build_env ถ้ามีอยู่แล้ว และสร้างโฟลเดอร์ใหม่
if [[ -d "build_env" ]]; then rm -fr build_env; fi
mkdir -p build_env  # สร้างโฟลเดอร์ build_env
mkdir -p ./build_env/${_bin_dir} ./build_env/$_opt_dir ./build_env/DEBIAN  # สร้างโฟลเดอร์ย่อยภายใน build_env

# สร้างไฟล์ control ที่ใช้ใน DEBIAN
cat <<- CONTROL_EOF > ./build_env/DEBIAN/control
Package: ${_PACKAGE}
Version: ${_VERSION}
Architecture: ${_ARCH}
Maintainer: @htr-tech
Depends: ${_depend}
Homepage: https://github.com/htr-tech/zphisher
Description: An automated phishing tool with 30+ templates. This Tool is made for educational purpose only !
CONTROL_EOF

# สร้างไฟล์ prerm (ใช้ในการลบแพ็กเกจ) ที่จะถูกเรียกใช้เมื่อถอนการติดตั้งแพ็กเกจ
cat <<- PRERM_EOF > ./build_env/DEBIAN/prerm
#!/bin/bash
rm -fr $_opt_dir  # ลบโฟลเดอร์ opt/${_PACKAGE} เมื่อถอนการติดตั้ง
exit 0
PRERM_EOF

# ตั้งสิทธิ์ให้ไฟล์ใน DEBIAN สามารถทำงานได้
chmod 755 ./build_env/DEBIAN
chmod 755 ./build_env/DEBIAN/{control,prerm}

# คัดลอกไฟล์ launch.sh ไปยังไดเรกทอรี bin ของแพ็กเกจ
cp -fr scripts/launch.sh ./build_env/$_bin_dir/$_PACKAGE
chmod 755 ./build_env/$_bin_dir/$_PACKAGE  # ตั้งสิทธิ์ให้ไฟล์ launch.sh สามารถรันได้

# คัดลอกไฟล์ต่าง ๆ เช่น .github, .sites, LICENSE, README.md และ zphisher.sh ไปยังโฟลเดอร์ opt/${_PACKAGE}
cp -fr .github/ .sites/ LICENSE README.md zphisher.sh ./build_env/$_opt_dir

# สร้าง Deb Package ด้วยคำสั่ง dpkg-deb
dpkg-deb --build ./build_env ${PKG_NAME}

# ลบโฟลเดอร์ build_env หลังจากสร้างแพ็กเกจเสร็จ
rm -fr ./build_env