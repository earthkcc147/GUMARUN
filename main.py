import os
import json
import requests
from dotenv import load_dotenv

# โหลดค่าจากไฟล์ .env
load_dotenv()

# ฟังก์ชันดึงข้อมูล API_KEY, USERNAME, PASSWORD จาก .env ตามชื่อผู้ใช้
def load_user_data(username):
    api_key = os.getenv(f"{username.upper()}_API_KEY")
    user_password = os.getenv(f"{username.upper()}_PASSWORD")
    if not api_key or not user_password:
        print(f"ข้อมูลสำหรับผู้ใช้ {username} ไม่ถูกต้อง ❌")
        return None, None
    return api_key, user_password

# ฟังก์ชันดึงข้อมูลผลิตภัณฑ์จาก .env
def get_product_data():
    product_data_json = os.getenv("PRODUCT_DATA")
    if not product_data_json:
        print("ไม่มีข้อมูล PRODUCT_DATA ใน .env ❌")
        return None
    try:
        return json.loads(product_data_json)
    except json.JSONDecodeError:
        print("ไม่สามารถแปลงข้อมูล PRODUCT_DATA จาก .env ได้ ❌")
        return None

# ฟังก์ชันดึงยอดเงินจาก API
def get_balance(api_key, api_url):
    url_balance = api_url
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

# ฟังก์ชันแสดงเมนูประเภทสินค้า
def show_category_menu(api_key, api_url, product_data):
    balance = get_balance(api_key, api_url)

    if balance is not None:
        print(f"\n--- เมนูหลัก --- {' ' * (30 - len(str(balance)))} ยอดเงิน: {balance} บาท 💳")
    else:
        print("\n--- เมนูหลัก --- ไม่สามารถดึงยอดเงินได้ ❗")

    print("1. Facebook")
    print("2. TikTok")
    print("3. Instagram")
    print("4. Discord")
    print("0. ออกจากโปรแกรม 🚪")
    print("\n-------------------------\n")

    category_choice = int(input("กรุณาเลือกหมวดหมู่สินค้า: "))
    return category_choice, product_data

# ฟังก์ชันแสดงเมนูหลัก
def show_main_menu(filtered_products):
    print("\n--- รายการสินค้า ---")
    for index, (product_name, details) in enumerate(filtered_products.items(), start=1):
        print(f"{index}. {details['description']} - ราคาต่อหน่วย: {details['price_per_unit']} บาท")
    print("0. ย้อนกลับ 🔙")
    print("\n-------------------------\n")

# ฟังก์ชันเลือกสินค้า
def choose_product(filtered_products, api_key, api_url):
    show_main_menu(filtered_products)

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
        print("\n-------------------------\n")

        link = input("กรุณากรอกลิงก์ 🔗 (พิมพ์ 00 เพื่อกลับสู่เมนูหลัก): ")
        if link == "00":
            return

        quantity = input(f"กรุณากรอกจำนวน (ขั้นต่ำ {min_quantity}, สูงสุด {max_quantity}) 📊 (พิมพ์ 00 เพื่อกลับสู่เมนูหลัก): ")
        if quantity == "00":
            return

        quantity = int(quantity)

        if quantity < min_quantity or quantity > max_quantity:
            print(f"จำนวนที่กรอกไม่ถูกต้อง กรุณากรอกจำนวนระหว่าง {min_quantity} - {max_quantity} 📉")
            return

        total_price = price_per_unit * quantity

        balance = get_balance(api_key, api_url)

        if balance is not None:
            print(f"ยอดเงินของคุณ: {balance} บาท 💳")
            print("\n-------------------------\n")

            if balance >= total_price:
                print(f"ยอดเงินของคุณเพียงพอสำหรับการสั่งซื้อ ราคา: {total_price} บาท ✅")
                confirm = input(f"คุณยืนยันที่จะสั่งซื้อ {quantity} ชิ้น ในราคา {total_price} บาทหรือไม่? (y/n): ")
                if confirm.lower() != 'y':
                    print("ยกเลิกคำสั่งซื้อ ❌")
                    return

                url_order = api_url
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

# หลักการทำงานของโปรแกรม
def main():
    username = input("กรุณากรอก Username: ")
    api_key, password = load_user_data(username)

    if not api_key:
        print("ข้อมูลผู้ใช้ไม่ถูกต้อง ❌")
        return

    input_password = input("กรุณากรอก Password: ")
    if input_password != password:
        print("รหัสผ่านไม่ถูกต้อง ❌")
        return
    else:
        print("ยินดีต้อนรับ! ข้อมูลผู้ใช้ถูกต้อง ✅")

    api_url = os.getenv("API_URL")
    product_data = get_product_data()

    while True:
        category_choice, filtered_products = show_category_menu(api_key, api_url, product_data)

        if category_choice == 0:
            print("ออกจากโปรแกรม 👋")
            break
        elif category_choice == 1:
            filtered_products = product_data.get("facebook", {})
            choose_product(filtered_products, api_key, api_url)
        elif category_choice == 2:
            filtered_products = product_data.get("tiktok", {})
            choose_product(filtered_products, api_key, api_url)
        elif category_choice == 3:
            filtered_products = product_data.get("instagram", {})
            choose_product(filtered_products, api_key, api_url)
        elif category_choice == 4:
            filtered_products = product_data.get("discord", {})
            choose_product(filtered_products, api_key, api_url)
        else:
            print("ตัวเลือกไม่ถูกต้อง ❌ กรุณาเลือกใหม่")

if __name__ == "__main__":
    main()
