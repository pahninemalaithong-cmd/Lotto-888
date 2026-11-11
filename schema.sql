-- Schema for Cloudflare D1 Database (lotto-db)

CREATE TABLE IF NOT EXISTS users (
  id TEXT PRIMARY KEY,
  username TEXT NOT NULL,
  seller_code TEXT NOT NULL,
  phone TEXT NOT NULL DEFAULT '020 8888 8888',
  wallet_balance INTEGER NOT NULL DEFAULT 250000,
  currency TEXT NOT NULL DEFAULT 'LAK',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tickets (
  id TEXT PRIMARY KEY,
  seller_id TEXT NOT NULL,
  seller_phone TEXT NOT NULL,
  lottery_id TEXT NOT NULL,
  lottery_name TEXT NOT NULL,
  round_info TEXT NOT NULL,
  draw_date TEXT NOT NULL,
  created_at TEXT NOT NULL,
  total_amount INTEGER NOT NULL,
  barcode TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending', -- pending, won, lost, cancelled
  win_amount INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS ticket_items (
  id TEXT PRIMARY KEY,
  ticket_id TEXT NOT NULL,
  number TEXT NOT NULL,
  category TEXT NOT NULL,
  sub_type_id TEXT NOT NULL,
  sub_type_label TEXT NOT NULL,
  amount INTEGER NOT NULL,
  rate REAL NOT NULL,
  potential_win INTEGER NOT NULL,
  FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS draw_results (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  lottery_id TEXT NOT NULL,
  lottery_name TEXT NOT NULL,
  draw_date TEXT NOT NULL,
  draw_time TEXT NOT NULL,
  full_number TEXT NOT NULL,
  digit_3_top TEXT NOT NULL,
  digit_2_top TEXT NOT NULL,
  digit_2_bottom TEXT NOT NULL,
  animal_name TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed initial admin user if not exists
INSERT OR IGNORE INTO users (id, username, seller_code, phone, wallet_balance, currency)
VALUES ('usr_001', 'VAH437293', 'VAH437293', '020 8888 8888', 250000, 'LAK');
