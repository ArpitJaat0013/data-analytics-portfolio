# E-Commerce SQL

**Goal:** Model an e-commerce dataset in PostgreSQL and answer realistic business questions with SQL.

## Status

- [ ] Schema finalized and loaded
- [ ] Seed / sample data loaded
- [ ] 10+ analytical queries written
- [ ] Query performance checked with EXPLAIN
- [ ] Final write-up

## Structure

- `data/` — source / seed CSVs
- `schema/` — DDL (see [`schema/schema.sql`](schema/schema.sql) for a starter)
- `queries/` — one `.sql` file per business question
- `outputs/` — query results and notes

## Connection

Use the `ecommerce_db` database from [`docs/setup.md`](../../docs/setup.md).

## Example questions

1. Monthly revenue and order count, with MoM growth.
2. Repeat-customer rate and cohort retention.
3. Average order value by category and region.
4. Products with the highest return / cancellation rate.
5. Inventory turnover and slow-moving stock.
