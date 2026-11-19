# Local setup

## 1. Python / notebooks

```bash
conda env create -f environment.yml
conda activate data-analytics
python -c "import pandas, numpy, matplotlib, seaborn; print('ok')"
jupyter lab
```

The same environment can be attached to VS Code: select `data-analytics` as the interpreter, or use Google Colab for cloud notebooks (sign in with a Google account at <https://colab.research.google.com>).

## 2. PostgreSQL + pgAdmin (conda-based, no admin rights required)

Both are installed in a separate `pg-suite` conda environment.

```bash
# one-time
conda create -n pg-suite -c conda-forge python=3.12 postgresql pgadmin4
```

### Data directory

The cluster lives at `~/data-analytics-pgdata` (outside the repo so it is never committed).

```bash
conda activate pg-suite
initdb -D ~/data-analytics-pgdata --username=da_user --auth-local=trust --auth-host=scram-sha-256
```

### Start / stop

```bash
# start
pg_ctl -D ~/data-analytics-pgdata -l ~/data-analytics-pg.log start
# stop
pg_ctl -D ~/data-analytics-pgdata stop
# status
pg_ctl -D ~/data-analytics-pgdata status
```

### Local connection details

| Setting | Value |
| --- | --- |
| Host | `localhost` |
| Port | `5432` |
| User | `da_user` |
| Password | the password you set with `initdb --pwfile` (local development only) |
| Databases | `ecommerce_db`, `sql_practice` |

Connect from the shell:

```bash
psql -h localhost -p 5432 -U da_user -d ecommerce_db
```

SQLAlchemy URL:

```
postgresql+psycopg2://da_user:<local-password>@localhost:5432/ecommerce_db
```

### pgAdmin

```bash
./scripts/start_pgadmin.sh
```

The local pgAdmin sign-in email is `dikshit@local.dev`; its password is kept in `~/.data-analytics-env` (outside this repo). The PostgreSQL server **"Local PostgreSQL (portfolio)"** is already registered with a saved password.

To register a different server manually in pgAdmin:

- **General → Name:** Local PostgreSQL
- **Connection → Host:** `localhost`
- **Connection → Port:** `5432`
- **Connection → Username:** `da_user`
- **Connection → Password:** your local PostgreSQL password

## 3. Troubleshooting

- `pg_ctl: another server might be running` → another PostgreSQL process is using port 5432; check `lsof -i :5432`.
- Password auth failures → confirm `pg_hba.conf` in the data directory allows `scram-sha-256` for host connections.
- pgAdmin will not open → run it from the `pg-suite` env in a terminal and read the error output.
