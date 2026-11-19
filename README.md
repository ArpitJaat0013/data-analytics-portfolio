# Data Analytics Portfolio

Central home for SQL practice and three capstone projects:

1. **Indian Retail Sales** — exploratory + BI analysis of Indian retail data.
2. **E-Commerce SQL** — relational schema, loading, and analytical queries in PostgreSQL.
3. **Logistics SLA Capstone** — SLA / delivery-performance analysis (built on YuvaIntern experience).

## Repository map

```
.
├── data/                       # Shared datasets (raw / processed / external)
├── notebooks/                  # Shared exploration & SQL-practice notebooks
├── sql/
│   ├── 80-sql-problems/        # Sprint questions + answers
│   └── ecommerce/              # Schema, seed data, analysis queries
├── projects/
│   ├── indian-retail-sales/
│   ├── ecommerce-sql/
│   └── logistics-sla-capstone/
├── scripts/                    # Reusable ETL / helper scripts
├── docs/                       # Setup notes, trackers, write-ups
└── outputs/                    # Charts and exported results
```

Each capstone keeps its own `data/`, `notebooks/` or `queries/`, `src/`, and `outputs/` folders so it can be reused as a standalone portfolio piece.

## Environment

- **Python:** conda env `data-analytics` (see [`environment.yml`](environment.yml))
  ```bash
  conda env create -f environment.yml
  conda activate data-analytics
  ```
- **Database:** local PostgreSQL 18.7 via the `pg-suite` conda env, with pgAdmin 4 for the GUI.
  Connection details and startup commands: [`docs/setup.md`](docs/setup.md).
  Shortcuts: `./scripts/start_db.sh`, `./scripts/stop_db.sh`, `./scripts/start_pgadmin.sh`.

## Progress tracking

- [SQL sprint tracker](docs/sql-sprint-tracker.md)
- Capstone status is tracked in each project README.

## Conventions

- Keep raw data immutable; write cleaned data to `data/processed/` or a project's `data/` folder.
- One notebook per analysis question; name them `NN-short-description.ipynb`.
- Queries live in `.sql` files with a header comment describing the question and the expected output.
- Do not commit credentials, large datasets, or generated outputs. See [`.gitignore`](.gitignore).
