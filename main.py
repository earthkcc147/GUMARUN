import os
import json
import requests
from dotenv import load_dotenv

# โหลดค่าจากไฟล์ .env
load_dotenv()

# อ่านค่าจาก .env
API_URL = os.getenv("API_URL")
PRODUCT_DATA_JSON = os.getenv("PRODUCT_DATA")

# แปลงข้อมูล JSON จาก string เป็น dictionary
if not PRODUCT_DATA_JSON:
    print("ไม่มีข้อมูล PRODUCT_DATA ใน .env ❌")
    exit()

try:
    product_data = json.loads(PRODUCT_DATA_JSON)
except json.JSONDecodeError:
    print("ไม่สามารถแปลงข้อมูล PRODUCT_DATA จาก .env ได้ ❌")
    exit()

# รับ username และ password จากผู้ใช้
username = input("กรุณากรอก Username: ")
password = input("กรุณากรอก Password: ")

# สร้าง key สำหรับการดึงข้อมูลจาก .env
api_key_key = f"USER_{username}_API_KEY"
username_key = f"USER_{username}_USERNAME"
password_key = f"USER_{username}_PASSWORD"

# ตรวจสอบข้อมูลผู้ใช้ใน .env
ENV_API_KEY = os.getenv(api_key_key)
ENV_USERNAME = os.getenv(username_key)
ENV_PASSWORD = os.getenv(password_key)

if ENV_USERNAME is None or ENV_PASSWORD is None:
    print("ไม่พบข้อมูลผู้ใช้ในระบบ ❌")
    exit()

if username != ENV_USERNAME or password != ENV_PASSWORD:
    print("ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง ❌")
    exit()
else:
    print(f"ยินดีต้อนรับ {username}! ข้อมูลผู้ใช้ถูกต้อง ✅")

# ฟังก์ชันดึงยอดเงินจาก API
def get_balance(api_key):
    url_balance = API_URL
    data_balance = {
        "key": api_key,
        "action": "balance"
    }

    try:
        response_balance = requests.post(url_balance, data=data_balance)
        if response_balance.status_code == 200:
            balance_data = response_balance.json()
            if 'balance' in balance_data:
                return round(float(balance_data['balance']), 2)
        else:
            print("ไม่สามารถเชื่อมต่อกับ API เพื่อดึงยอดเงินได้ ❌")
    except requests.RequestException as e:
        print(f"เกิดข้อผิดพลาดในการเชื่อมต่อ: {e} ❌")

    return None

# เมนูแสดงประเภทสินค้า
def show_category_menu(api_key):
    # ดึงยอดเงินจาก API
    balance = get_balance(api_key)

    # แสดงหัวเมนูพร้อมยอดเงิน
    if balance is not None:
        print(f"\n--- เมนูหลัก --- {' ' * (30 - len(str(balance)))} ยอดเงิน: {balance} บาท 💳")
    else:
        print("\n--- เมนูหลัก --- ไม่สามารถดึงยอดเงินได้ ❗")

    print("1. Facebook")
    print("2. TikTok")
    print("3. Instagram")
    print("4. Discord")
    print("0. ออกจากโปรแกรม 🚪")
    print("\n-------------------------\n")  # เส้นแบ่งระหว่างเมนู

# เมนูแสดงข้อมูลสินค้าตามหมวดหมู่
def show_main_menu(filtered_products):
    print("\n--- รายการสินค้า ---")
    for index, (product_name, details) in enumerate(filtered_products.items(), start=1):
        print(f"{index}. {details['description']} - ราคาต่อหน่วย: {details['price_per_unit']} บาท")
    print("0. ย้อนกลับ 🔙")
    print("\n-------------------------\n")  # เส้นแบ่งระหว่างเมนู

# เลือกสินค้า
def choose_product(filtered_products, api_key):
    show_main_menu(filtered_products)

    # รับตัวเลือกจากผู้ใช้
    choice = int(input("\nกรุณากรอกหมายเลขสินค้าที่ต้องการ: "))

    if choice == 0:
        print("กลับไปที่เมนูหลัก 🔙")
        return

    # ตรวจสอบว่าผู้ใช้เลือกสินค้าถูกต้องหรือไม่
    if 1 <= choice <= len(filtered_products):
        product_name = list(filtered_products.keys())[choice - 1]
        product = filtered_products[product_name]
        price_per_unit = product['price_per_unit']
        min_quantity = product['min_quantity']
        max_quantity = product['max_quantity']
        service = product['service']
        description = product['description']
        action = product['action']

        print(f"\nคุณเลือกสินค้า: {description} 🛒")
        print(f"ราคาต่อหน่วย: {price_per_unit} บาท 💰")
        print(f"จำนวนขั้นต่ำ: {min_quantity} | จำนวนสูงสุด: {max_quantity} 🎯")
        print("\n-------------------------\n")  # เส้นแบ่งระหว่างรายละเอียดสินค้า

        # รับข้อมูลจากผู้ใช้
        link = input("กรุณากรอกลิงก์ 🔗 (พิมพ์ 00 เพื่อกลับสู่เมนูหลัก): ")
        if link == "00":
            return

        quantity = input(f"กรุณากรอกจำนวน (ขั้นต่ำ {min_quantity}, สูงสุด {max_quantity}) 📊 (พิมพ์ 00 เพื่อกลับสู่เมนูหลัก): ")
        if quantity == "00":
            return

        quantity = int(quantity)

        # ตรวจสอบจำนวนที่ผู้ใช้กรอกว่าผ่านข้อกำหนดขั้นต่ำและสูงสุดหรือไม่
        if quantity < min_quantity or quantity > max_quantity:
            print(f"จำนวนที่กรอกไม่ถูกต้อง กรุณากรอกจำนวนระหว่าง {min_quantity} - {max_quantity} 📉")
            return

        # คำนวณราคาของคำสั่งซื้อ
        total_price = price_per_unit * quantity

        # ดึงยอดเงินจาก API
        balance = get_balance(api_key)

        if balance is not None:
            print(f"ยอดเงินของคุณ: {balance} บาท 💳")
            print("\n-------------------------\n")

            # ตรวจสอบยอดเงินเพียงพอสำหรับการสั่งซื้อหรือไม่
            if balance >= total_price:
                print(f"ยอดเงินของคุณเพียงพอสำหรับการสั่งซื้อ ราคา: {total_price} บาท ✅")

                # ขั้นตอนยืนยันการสั่งซื้อ
                confirm = input(f"คุณยืนยันที่จะสั่งซื้อ {quantity} ชิ้น ในราคา {total_price} บาทหรือไม่? (y/n): ")
                if confirm.lower() != 'y':
                    print("ยกเลิกคำสั่งซื้อ ❌")
                    return

                # URL ของ API ที่จะทำการส่งข้อมูลเพิ่มคำสั่งซื้อ
                url_order = API_URL
                data_order = {
                    "key": api_key,
                    "action": action,
                    "service": service,
                    "link": link,
                    "quantity": quantity
                }

                response_order = requests.post(url_order, data=data_order)

                if response_order.status_code == 200:
                    result_order = response_order.json()
                    if 'order' in result_order:
                        print(f"คำสั่งซื้อของคุณคือ: {result_order['order']} 🎉")
                    else:
                        print("ไม่สามารถสร้างคำสั่งซื้อได้ ❌")
                else:
                    print(f"Error: {response_order.status_code} ⚠️")
            else:
                print(f"ยอดเงินของคุณไม่เพียงพอสำหรับการสั่งซื้อ ราคา: {total_price} บาท ❌")
        else:
            print("ไม่สามารถดึงข้อมูลยอดเงินได้ ❗")
    else:
        print("สินค้าที่เลือกไม่ถูกต้อง ❌")

# แสดงเมนูประเภทสินค้า
while True:
    show_category_menu(ENV_API_KEY)

    try:
        category_choice = int(input("กรุณาเลือกหมวดหมู่สินค้า: "))

        if category_choice == 0:
            print("ออกจากโปรแกรม 👋")
            break
        elif category_choice == 1:
            filtered_products = product_data.get("facebook", {})
            choose_product(filtered_products, ENV_API_KEY)
        elif category_choice == 2:
            filtered_products = product_data.get("tiktok", {})
            choose_product(filtered_products, ENV_API_KEY)
        elif category_choice == 3:
            filtered_products = product_data.get("instagram", {})
            choose_product(filtered_products, ENV_API_KEY)
        elif category_choice == 4:
            filtered_products = product_data.get("discord", {})
            choose_product(filtered_products, ENV_API_KEY)
        else:
            print("ตัวเลือกไม่ถูกต้อง ❌ กรุณาเลือกใหม่")
    except ValueError:
        print("โปรดกรอกตัวเลขที่ถูกต้องสำหรับหมวดหมู่สินค้า ❌")