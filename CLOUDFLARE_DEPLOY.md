# 🚀 คำแนะนำการนำ Lotto WebApp ขึ้น Cloudflare Pages + Cloudflare D1 Database

ระบบนี้ถูกพัฒนาให้รองรับ **Cloudflare Pages** (Hosting) ร่วมกับ **Cloudflare D1** (Serverless SQL Database) แบบ Full-stack เรียบร้อยแล้ว

---

## 🛠️ โครงสร้างระบบบน Cloudflare:
1. **Frontend Hosting**: Cloudflare Pages (`/dist`)
2. **Serverless Functions (Backend API)**: Cloudflare Pages Functions (`/functions/api/*`)
   - `GET /api/user`, `POST /api/user` (วอลเล็ตและการเติมเงิน)
   - `GET /api/tickets`, `POST /api/tickets` (บันทึกโพยและรายการ)
   - `POST /api/tickets/cancel` (ยกเลิกโพยและคืนเงิน)
   - `GET /api/results`, `POST /api/results` (บันทึกผลหวยและตรวจรางวัลอัตโนมัติ)
   - `GET /api/init` (สร้างตาราง D1 อัตโนมัติเมื่อรันครั้งแรก)
3. **Database**: Cloudflare D1 Database (`lotto-db` SQLite at the edge)

---

## ⚡ ขั้นตอนการ Deploy ขึ้น Cloudflare (3 ขั้นตอนง่ายๆ):

### ขั้นตอนที่ 1: เข้าสู่ระบบ Cloudflare ในเทอร์มินัล
รันคำสั่งนี้เพื่อให้ Wrangler เปิดหน้าเว็บให้คุณกดยืนยันเข้าสู่ระบบ Cloudflare:
```bash
npx wrangler login
```

---

### ขั้นตอนที่ 2: สร้างฐานข้อมูล Cloudflare D1
รันคำสั่งสร้าง D1 Database ชื่อ `lotto-db`:
```bash
npx wrangler d1 create lotto-db
```
เมื่อสร้างเสร็จ ระบบจะแสดงข้อความที่มี `database_id` เช่น:
```toml
[[d1_databases]]
binding = "DB"
database_name = "lotto-db"
database_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```
ให้นำ `database_id` ที่ได้ ไปอัปเดตลงในไฟล์ `wrangler.toml` ในโปรเจกต์

จากนั้นรันคำสั่งสร้างตารางในฐานข้อมูลบน Cloudflare:
```bash
npm run db:init:remote
```

---

### ขั้นตอนที่ 3: สั่ง Deploy ขึ้น Cloudflare Pages
รันคำสั่งเดียว ระบบจะ Build และส่งขึ้น Cloudflare Pages ทันที:
```bash
npm run deploy
```

เมื่อ Deploy เสร็จสิ้น Wrangler จะแสดง URL ให้ใช้งานจริงทันที เช่น:
👉 `https://lotto-webapp.pages.dev`

---

## 🔗 การเชื่อมต่อ D1 Binding บนหน้า Cloudflare Dashboard (กรณีต้องการตรวจเช็ค):
1. ไปที่ **Cloudflare Dashboard** -> **Workers & Pages** -> เลือกโปรเจกต์ `lotto-webapp`
2. ไปที่แท็บ **Settings** -> **Functions** -> หัวข้อ **D1 database bindings**
3. กด **Add binding**:
   - Variable name: `DB`
   - D1 database: เลือก `lotto-db`
4. กด **Save**
