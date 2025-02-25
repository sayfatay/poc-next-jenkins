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

# ใช้ Node.js เป็น base image สำหรับ runtime
FROM node:18-alpine AS runner

# ตั้งค่า working directory
WORKDIR /app

# คัดลอกไฟล์ที่ build แล้วมาจาก builder stage
COPY --from=builder /app ./

# ตั้งค่าพอร์ตที่ Next.js ใช้
EXPOSE 3000

# คำสั่งสำหรับรัน Next.js
CMD ["npm", "run", "start"]
