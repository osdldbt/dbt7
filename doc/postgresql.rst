PostgreSQL
==========

There are additional dialects for PostgreSQL that are provided to collect query
plans and `EXPLAIN ANALYZE` output, as shown in the examples below.  The
`DBT7DMPREFIX` environment variable can be used to inject SQL into the data
maintenance such that `EXPLAIN` output can be captures in those tests.
Otherwise only the 99 queries will have `EXPLAIN` output.

Run a 1GB test (with `DBT7DMPREFIX` unset)::

    dbt7-run psql /tmp/results

Run a 1GB test and capture `EXPLAIN` output query results::

    export DBT7DMPREFIX="LOAD 'auto_explain'; SET auto_explain.log_min_duration TO 0; SET auto_explain.log_level TO notice;"
    dbt7-run -d postgresqle pgsql /tmp/results

Run a 1GB test and capture `EXPLAIN ANALYZE` output query::

    export DBT7DMPREFIX="LOAD 'auto_explain'; SET auto_explain.log_min_duration TO 0; SET auto_explain.log_analyze TO on; SET auto_explain.log_level TO notice;"
    dbt7-run -d postgresqlea \
            pgsql /tmp/results

Advanced PostgreSQL Usage
-------------------------

See `examples/dbt7_pgsql_profile` for the environment variables to set when not
using the `dbt7-run` script, in other words for advanced users.

One example of advanced usage, requiring more user setup and configuration, is
to run this against a PostgreSQL database on a remote system.

Since this kit provides scripts that are potentially destructive, it relies on
some special purpose environment variables to be set in order to help prevent
damage to a database that the user may be connecting to by default.
