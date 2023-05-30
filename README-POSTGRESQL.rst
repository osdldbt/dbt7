Some of the scripts for PostgreSQL currently on work when the database system
is local.  One particular script is the one that streams the data into the
database.

See `examples/dbt7_pgsql_profile` for the environment variables required in
order to run the workload.  Since this kit provides scripts that are
destructive, it relies on some special purpose environment variables to be set
in order to help prevent damage to a database that the user may be connecting to
by default.

Run a 1GB test with 3 streams (with DBT7DMPREFIX unset)::

    dbt7-run -n 3 psql $DSHOME /tmp/results

Run a 1GB test with 3 streams and capturing EXPLAIN output query results::

    export DBT7DMPREFIX="LOAD 'auto_explain'; SET auto_explain.log_min_duration TO 0; SET auto_explain.log_level TO notice;"
    dbt7-run -d postgresqle \
            -i ${DSHOME}/query_templates/templates-postgresqle.lst -n 3 \
            pgsql $DSHOME /tmp/results

Run a 1GB test with 3 streams and capturing EXPLAIN ANALYZE output query::

    export DBT7DMPREFIX="LOAD 'auto_explain'; SET auto_explain.log_min_duration TO 0; SET auto_explain.log_analyze TO on; SET auto_explain.log_level TO notice;"
    dbt7-run -d postgresqlea \
            -i ${DSHOME}/query_templates/templates-postgresqlea.lst -n 3 \
            pgsql $DSHOME /tmp/results
