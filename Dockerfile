# ใช้ Node.js เป็น base image
FROM node:18-alpine AS builder

# ตั้งค่า working directory
WORKDIR /app

# คัดลอก package.json และติดตั้ง dependencies
COPY package.json package-lock.json ./
RUN npm install

# คัดลอกโค้ดทั้งหมดเข้า container
COPY . .

# สร้าง build ของ Next.js
RUN npm run build

# ใช้ Nginx เป็น Web Server สำหรับ Serve Next.js
FROM nginx:alpine AS runner

# คัดลอกไฟล์ build เข้าไปที่ Nginx
COPY --from=builder /app/.next /usr/share/nginx/html

# คัดลอกไฟล์ config ของ Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# เปิดพอร์ต 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
