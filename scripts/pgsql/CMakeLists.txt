set (CWD "${CMAKE_SOURCE_DIR}/scripts/pgsql")

install (
    PROGRAMS
    ${CWD}/dbt7-pgsql-create-db
    ${CWD}/dbt7-pgsql-create-tables
    ${CWD}/dbt7-pgsql-create-indexes
    ${CWD}/dbt7-pgsql-data-maintenance
    ${CWD}/dbt7-pgsql-dbstat
    ${CWD}/dbt7-pgsql-drop-tables
    ${CWD}/dbt7-pgsql-get-query-time
    ${CWD}/dbt7-pgsql-load-data
    ${CWD}/dbt7-pgsql-report
    ${CWD}/dbt7-pgsql-run-stream
    ${CWD}/dbt7-pgsql-start-db
    ${CWD}/dbt7-pgsql-stop-db
    ${CWD}/dbt7-pgsql-time-statistics
    DESTINATION "bin"
)
