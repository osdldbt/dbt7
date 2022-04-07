Some of the scripts for PostgreSQL currently on work when the database system
is local.  One particular script is the one that streams the data into the
database.

See `examples/dbt7_pgsql_profile` for the environment variables required in
order to run the workload.  Since this kit provides scripts that are
destructive, it relies on some non-standard environment variables to be set in
order to help prevent damage to a database that the user may be connecting to by
default.

Run a 1GB test with 3 streams::

    dbt7-run-workload -a pgsql -s 1 -d pgsql -i templates-postgresql.lst \
            -n 3 -o /tmp/results

Run a 1GB test with 3 streems and capturing EXPLAIN output query results::

    dbt7-run-workload -a pgsql -s 1 -d pgsqle -i templates-postgresqle.lst \
            -n 3 -o /tmp/results

Run a 1GB test with 3 streems and capturing EXPLAIN ANALYZE output query
results::

    dbt7-run-workload -a pgsql -s 1 -d pgsqlea -i templates-postgresqlea.lst \
            -n 3 -o /tmp/results
