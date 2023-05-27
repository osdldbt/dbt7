foreach (SCRIPT dbt7-pgsql-create-db
                dbt7-pgsql-create-tables
                dbt7-pgsql-create-indexes
                dbt7-pgsql-data-maintenance
                dbt7-pgsql-dbstat
                dbt7-pgsql-drop-tables
                dbt7-pgsql-get-query-time
                dbt7-pgsql-load-data
                dbt7-pgsql-report
                dbt7-pgsql-run-stream
                dbt7-pgsql-start-db
                dbt7-pgsql-stop-db
                dbt7-pgsql-time-statistics
        )
    configure_file(${SCRIPT}.in ${CMAKE_BINARY_DIR}/${SCRIPT} @ONLY)
endforeach (SCRIPT)

install (
    PROGRAMS ${CMAKE_BINARY_DIR}/dbt7-pgsql-create-db
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-create-tables
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-create-indexes
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-data-maintenance
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-dbstat
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-drop-tables
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-get-query-time
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-load-data
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-report
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-run-stream
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-start-db
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-stop-db
             ${CMAKE_BINARY_DIR}/dbt7-pgsql-time-statistics
    DESTINATION "bin"
)
