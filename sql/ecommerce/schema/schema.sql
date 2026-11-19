-- E-commerce starter schema (PostgreSQL)
-- Adapt table/column names to your final project design.

CREATE TABLE customers (
    customer_id   INTEGER PRIMARY KEY,
    full_name     TEXT        NOT NULL,
    email         TEXT        UNIQUE,
    city          TEXT,
    region        TEXT,
    created_at    TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id   INTEGER PRIMARY KEY,
    category_name TEXT        NOT NULL UNIQUE,
    parent_id     INTEGER     REFERENCES categories(category_id)
);

CREATE TABLE products (
    product_id    INTEGER PRIMARY KEY,
    product_name  TEXT        NOT NULL,
    category_id   INTEGER     REFERENCES categories(category_id),
    price         NUMERIC(12,2) NOT NULL CHECK (price >= 0),
    stock_qty     INTEGER     NOT NULL DEFAULT 0 CHECK (stock_qty >= 0)
);

CREATE TABLE orders (
    order_id      INTEGER PRIMARY KEY,
    customer_id   INTEGER     NOT NULL REFERENCES customers(customer_id),
    order_date    TIMESTAMP   NOT NULL,
    status        TEXT        NOT NULL CHECK (status IN ('pending','paid','shipped','delivered','cancelled','returned')),
    total_amount  NUMERIC(12,2) NOT NULL DEFAULT 0
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id      INTEGER     NOT NULL REFERENCES orders(order_id),
    product_id    INTEGER     NOT NULL REFERENCES products(product_id),
    quantity      INTEGER     NOT NULL CHECK (quantity > 0),
    unit_price    NUMERIC(12,2) NOT NULL CHECK (unit_price >= 0),
    discount      NUMERIC(5,2)  NOT NULL DEFAULT 0 CHECK (discount BETWEEN 0 AND 100)
);

CREATE TABLE payments (
    payment_id    INTEGER PRIMARY KEY,
    order_id      INTEGER     NOT NULL REFERENCES orders(order_id),
    method        TEXT        NOT NULL,
    amount        NUMERIC(12,2) NOT NULL,
    paid_at       TIMESTAMP   NOT NULL
);

CREATE TABLE shipments (
    shipment_id   INTEGER PRIMARY KEY,
    order_id      INTEGER     NOT NULL REFERENCES orders(order_id),
    carrier       TEXT,
    shipped_at    TIMESTAMP,
    delivered_at  TIMESTAMP,
    committed_at  TIMESTAMP,
    CHECK (delivered_at IS NULL OR shipped_at IS NULL OR delivered_at >= shipped_at)
);

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date     ON orders(order_date);
CREATE INDEX idx_items_order     ON order_items(order_id);
CREATE INDEX idx_items_product   ON order_items(product_id);
