<!-- Zphisher -->

<!-- แสดงโลโก้ของเครื่องมือ Zphisher -->
<p align="center">
  <img src=".github/misc/logo.png">
</p>

<!-- แสดงข้อมูลสถานะต่าง ๆ ของโปรเจค เช่น เวอร์ชั่น, ลิขสิทธิ์, จำนวนดาว, จำนวนปัญหาที่เปิดอยู่ และจำนวนฟอร์ก -->
<p align="center">
  <img src="https://img.shields.io/badge/Version-2.3.5-green?style=for-the-badge">
  <img src="https://img.shields.io/github/license/htr-tech/zphisher?style=for-the-badge">
  <img src="https://img.shields.io/github/stars/htr-tech/zphisher?style=for-the-badge">
  <img src="https://img.shields.io/github/issues/htr-tech/zphisher?color=red&style=for-the-badge">
  <img src="https://img.shields.io/github/forks/htr-tech/zphisher?color=teal&style=for-the-badge">
</p>

<!-- แสดงข้อมูลเพิ่มเติมเกี่ยวกับโปรเจค เช่น ผู้เขียน, การเปิดแหล่งที่มา, ความคงทน, และภาษาที่ใช้เขียน -->
<p align="center">
  <img src="https://img.shields.io/badge/Author-htr--tech-blue?style=flat-square">
  <img src="https://img.shields.io/badge/Open%20Source-Yes-darkgreen?style=flat-square">
  <img src="https://img.shields.io/badge/Maintained%3F-Yes-lightblue?style=flat-square">
  <img src="https://img.shields.io/badge/Written%20In-Bash-darkcyan?style=flat-square">
  <img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fhtr-tech%2Fzphisher&title=Visitors&edge_flat=false"/></a>
</p>

<!-- แสดงคำบรรยายโปรเจค -->
<p align="center"><b>A beginners friendly, Automated phishing tool with 30+ templates.</b></p>

<!-- ข้อความคำเตือน (Disclaimer) -->
<h3><p align="center">Disclaimer</p></h3>

<i>
  การกระทำใดๆ ที่เกี่ยวข้องกับ <b>Zphisher</b> เป็นความรับผิดชอบของผู้ใช้เอง การใช้เครื่องมือนี้ในทางที่ผิดอาจทำให้เกิด <b>ข้อกล่าวหาทางอาญา</b> ต่อผู้กระทำผิด <b>ผู้พัฒนาไม่สามารถรับผิดชอบ</b> ในกรณีที่มีข้อกล่าวหาทางอาญาเกิดขึ้นจากการใช้เครื่องมือนี้ในทางที่ผิดกฎหมาย

  <b>เครื่องมือนี้อาจเป็นอันตรายต่อสื่อสังคมออนไลน์</b> ควรตรวจสอบกฎหมายในพื้นที่ของคุณก่อนที่จะใช้งานหรือเข้าถึงเครื่องมือนี้ในทางที่ผิด

  <b>เครื่องมือนี้สร้างขึ้นเพื่อการศึกษาหรือการทดลองเท่านั้น</b> อย่าพยายามใช้เครื่องมือนี้ในทางที่ผิดกฎหมาย <b>หากคุณมีเจตนาเช่นนั้น กรุณาออกจากที่นี้ทันที</b>

  เครื่องมือนี้แสดงวิธีการทำงานของ "ฟิชชิ่ง" เท่านั้น <b>คุณไม่ควรนำข้อมูลไปใช้เพื่อเข้าถึงบัญชีของผู้อื่นโดยไม่ได้รับอนุญาต</b> อย่างไรก็ตาม คุณสามารถทดลองใช้เครื่องมือนี้ได้ด้วยความเสี่ยงของคุณเอง
</i>



##
<!-- ส่วนของฟีเจอร์ (Features) -->
### Features
- หน้าเข้าสู่ระบบล่าสุดและอัพเดต
- ใช้งานง่าย เหมาะสำหรับผู้เริ่มต้น
- มีหลายตัวเลือกสำหรับการสร้างท่อต่อ (Tunneling)
  - Localhost (การใช้งานภายในเครื่อง)
  - Cloudflared (การใช้งานผ่าน Cloudflare)
  - LocalXpose (การใช้งานผ่าน LocalXpose)
- รองรับการซ่อน URL
- รองรับ Docker (สามารถใช้ใน Docker environment ได้)

##

<!-- ส่วนของการติดตั้ง (Installation) -->
### Installation

<!-- การติดตั้งโดยการ clone repository -->
- เพียงแค่ clone repository นี้ -
  ```
  git clone --depth=1 https://github.com/htr-tech/zphisher.git
  ```

- จากนั้นไปที่โฟลเดอร์ที่ clone ไว้และรัน `zphisher.sh` -
  ```
  $ cd zphisher
  $ bash zphisher.sh
  ```
- เมื่อใช้งานครั้งแรก จะติดตั้ง dependencies อัตโนมัติ เพียงเท่านี้ ***Zphisher*** ก็พร้อมใช้งานแล้ว

##

<!-- การติดตั้งใน Termux -->
### Installation (Termux)
คุณสามารถติดตั้ง Zphisher ใน Termux ได้ง่าย ๆ ด้วยคำสั่ง tur-repo
```
$ pkg install tur-repo
$ pkg install zphisher
$ zphisher
```

### หมายเหตุ :
***Termux ไม่สนับสนุนการแฮ็ก*** .. ดังนั้นอย่าพูดคุยเกี่ยวกับ *zphisher* ในกลุ่มการสนทนาใด ๆ ของ Termux หากต้องการข้อมูลเพิ่มเติม : [wiki](https://wiki.termux.com/wiki/Hacking)

##

<!-- ปุ่มสำหรับเปิดใน Google Cloud Shell -->
<p align="left">
  <a href="https://shell.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/htr-tech/zphisher.git&tutorial=README.md" target="_blank"><img src="https://gstatic.com/cloudssh/images/open-btn.svg"></a>
</p>

##