#!/bin/bash

# ฉันไม่ค่อยคุ้นเคยกับ Docker ถ้ามีอะไรผิดพลาดสามารถส่ง PR มาได้ (^.^)

# กำหนดตัวแปร BASE_DIR เป็นที่อยู่ของสคริปต์นี้
BASE_DIR=$(realpath "$(dirname "$BASH_SOURCE")")

# ตรวจสอบว่าโฟลเดอร์ auth มีอยู่หรือไม่ ถ้าไม่มีก็สร้างใหม่
if [[ ! -d "$BASE_DIR/auth" ]]; then
    echo "Creating Auth Directory.."
    mkdir -p "$BASE_DIR/auth"
fi

# กำหนดตัวแปรสำหรับชื่อคอนเทนเนอร์และอิมเมจที่ต้องการใช้
CONTAINER="zphisher"
IMAGE="htrtech/zphisher:latest"
IMG_MIRROR="ghcr.io/htr-tech/zphisher:latest"

# กำหนดที่อยู่ของโฟลเดอร์ที่จะใช้ในโวลุ่ม
MOUNT_LOCATION=${BASE_DIR}/auth

# ตรวจสอบว่าคอนเทนเนอร์ที่ชื่อว่า $CONTAINER มีอยู่ในระบบหรือไม่
check_container=$(docker ps --all --format "{{.Names}}")

# ถ้าคอนเทนเนอร์ยังไม่ถูกสร้าง ก็จะทำการสร้างใหม่
if [[ ! $check_container == $CONTAINER ]]; then
    echo "Creating new container..."
    docker create \
        --interactive --tty \  # สั่งให้คอนเทนเนอร์ทำงานในโหมดอินเทอร์แอคทีฟ และให้ TTY
        --volume ${MOUNT_LOCATION}:/zphisher/auth/ \  # เชื่อมโยงโฟลเดอร์ auth ไปยังโฟลเดอร์ในคอนเทนเนอร์
        --network host \  # ใช้เครือข่ายโฮสต์
        --name "${CONTAINER}" \  # กำหนดชื่อคอนเทนเนอร์
        "${IMAGE}"  # กำหนดอิมเมจที่ใช้
fi

# เริ่มต้นคอนเทนเนอร์ที่ถูกสร้างขึ้นมา
docker start --interactive "${CONTAINER}"

# คำสั่งที่ถูกคอมเมนต์ไว้ ใช้สำหรับการรันคอนเทนเนอร์แบบชั่วคราว
# docker run --rm -ti --network="host" -v ${MOUNT_LOCATION}:/zphisher/auth/ --name "$CONTAINER" "$IMAGE"