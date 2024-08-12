create extension sqlite_fdw;
CREATE SERVER sqlite_server FOREIGN DATA WRAPPER sqlite_fdw options (database '/tmp/call_log.db');
GRANT USAGE ON FOREIGN SERVER sqlite_server TO postgres;

CREATE FOREIGN TABLE call_logs (
    id INTEGER,
    call_date DATE,
    call_time TIME,
    incoming_number VARCHAR(20),
    duration INTEGER
) SERVER sqlite_server OPTIONS (
    table 'call_logs'  
);

-- 创建 products 表
CREATE TABLE IF NOT EXISTS public.products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    in_stock BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 插入示例产品数据
INSERT INTO public.products (name, description, price) VALUES
('Example Product 1', 'This is a description for product 1', 19.99),
('Example Product 2', 'This is a description for product 2', 29.99),
('Example Product 3', 'This is a description for product 3', 39.99),
('Example Product 4', 'This is a description for product 4', 49.99);