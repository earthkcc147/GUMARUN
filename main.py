import os
import json
import requests
from dotenv import load_dotenv

# โหลดค่าจากไฟล์ .env
load_dotenv()

user_api_key = os.getenv("API_KEY")
user_username = os.getenv("USERNAME")
user_password = os.getenv("PASSWORD")

# รับข้อมูล username ที่ต้องการล็อกอิน
username_input = input("กรุณากรอก Username: ")
password_input = input("กรุณากรอก Password: ")

# สร้างคีย์ที่จะใช้ในการดึงข้อมูลจาก .env
user_api_key = os.getenv(f"USER_{username_input}_API_KEY")
user_username = os.getenv(f"USER_{username_input}_USERNAME")
user_password = os.getenv(f"USER_{username_input}_PASSWORD")

# ตรวจสอบว่า .env มีข้อมูลของผู้ใช้ที่กรอกหรือไม่
if user_api_key is None or user_username is None or user_password is None:
    print("ไม่พบข้อมูลของผู้ใช้ใน .env ❌")
    exit()

# ตรวจสอบชื่อผู้ใช้และรหัสผ่าน
if username_input != user_username or password_input != user_password:
    print("ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง ❌")
    exit()
else:
    print("ยินดีต้อนรับ! ข้อมูลผู้ใช้ถูกต้อง ✅")

# อ่านข้อมูล PRODUCT_DATA จาก .env
PRODUCT_DATA_JSON = os.getenv("PRODUCT_DATA")

if not PRODUCT_DATA_JSON:
    print("ไม่มีข้อมูล PRODUCT_DATA ใน .env ❌")
    exit()

try:
    product_data = json.loads(PRODUCT_DATA_JSON)
except json.JSONDecodeError:
    print("ไม่สามารถแปลงข้อมูล PRODUCT_DATA จาก .env ได้ ❌")
    exit()

# ฟังก์ชันดึงยอดเงินจาก API
def get_balance():
    url_balance = API_URL
    data_balance = {
        "key": user_api_key,  # ใช้ API Key ของผู้ใช้ที่ล็อกอิน
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

# เมนูแสดงประเภทสินค้า (Facebook, Tiktok, Instagram)
def show_category_menu():
    balance = get_balance()

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
def choose_product(filtered_products):
    show_main_menu(filtered_products)

    # รับตัวเลือกจากผู้ใช้
    choice = int(input("\nกรุณากรอกหมายเลขสินค้าที่ต้องการ: "))

    if choice == 0:
        print("กลับไปที่เมนูหลัก 🔙")
        return

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

        link = input("กรุณากรอกลิงก์ 🔗 (พิมพ์ 00 เพื่อกลับสู่เมนูหลัก): ")
        if link == "00":
            return

        quantity = input(f"กรุณากรอกจำนวน (ขั้นต่ำ {min_quantity}, สูงสุด {max_quantity}) 📊 (พิมพ์ 00 เพื่อกลับสู่เมนูหลัก): ")
        if quantity == "00":
            return

        quantity = int(quantity)

        # ตรวจสอบจำนวนที่กรอก
        if quantity < min_quantity or quantity > max_quantity:
            print(f"จำนวนที่กรอกไม่ถูกต้อง กรุณากรอกจำนวนระหว่าง {min_quantity} - {max_quantity} 📉")
            return

        total_price = price_per_unit * quantity
        balance = get_balance()

        if balance is not None:
            print(f"ยอดเงินของคุณ: {balance} บาท 💳")
            if balance >= total_price:
                print(f"ยอดเงินของคุณเพียงพอสำหรับการสั่งซื้อ ราคา: {total_price} บาท ✅")

                # ยืนยันการสั่งซื้อ
                confirm = input(f"คุณยืนยันที่จะสั่งซื้อ {quantity} ชิ้น ในราคา {total_price} บาทหรือไม่? (y/n): ")
                if confirm.lower() != 'y':
                    print("ยกเลิกคำสั่งซื้อ ❌")
                    return

                url_order = API_URL
                data_order = {
                    "key": user_api_key,
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
    show_category_menu()

    try:
        category_choice = int(input("กรุณาเลือกหมวดหมู่สินค้า: "))

        if category_choice == 0:
            print("ออกจากโปรแกรม 👋")
            break
        elif category_choice == 1:
            filtered_products = product_data.get("facebook", {})
            choose_product(filtered_products)
        elif category_choice == 2:
            filtered_products = product_data.get("tiktok", {})
            choose_product(filtered_products)
        elif category_choice == 3:
            filtered_products = product_data.get("instagram", {})
            choose_product(filtered_products)
        elif category_choice == 4:
            filtered_products = product_data.get("discord", {})
            choose_product(filtered_products)
        else:
            print("ตัวเลือกไม่ถูกต้อง ❌")
    except ValueError:
        print("กรุณากรอกหมายเลขที่ถูกต้อง ❌")