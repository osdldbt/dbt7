foreach (SCRIPT dbt7-gp-create-db
                dbt7-gp-create-tables
                dbt7-gp-create-indexes
                dbt7-gp-data-maintenance
                dbt7-gp-data-validation
                dbt7-gp-drop-tables
                dbt7-gp-get-query-time
                dbt7-gp-load-data
                dbt7-gp-report
                dbt7-gp-run-stream
                dbt7-gp-start-db
                dbt7-gp-stop-db
                dbt7-gp-time-statistics
        )
    configure_file(${SCRIPT}.in ${CMAKE_BINARY_DIR}/${SCRIPT} @ONLY)
endforeach (SCRIPT)

install (
    PROGRAMS ${CMAKE_BINARY_DIR}/dbt7-gp-create-db
             ${CMAKE_BINARY_DIR}/dbt7-gp-create-tables
             ${CMAKE_BINARY_DIR}/dbt7-gp-create-indexes
             ${CMAKE_BINARY_DIR}/dbt7-gp-data-maintenance
             ${CMAKE_BINARY_DIR}/dbt7-gp-data-validation
             ${CMAKE_BINARY_DIR}/dbt7-gp-drop-tables
             ${CMAKE_BINARY_DIR}/dbt7-gp-get-query-time
             ${CMAKE_BINARY_DIR}/dbt7-gp-load-data
             ${CMAKE_BINARY_DIR}/dbt7-gp-report
             ${CMAKE_BINARY_DIR}/dbt7-gp-run-stream
             ${CMAKE_BINARY_DIR}/dbt7-gp-start-db
             ${CMAKE_BINARY_DIR}/dbt7-gp-stop-db
             ${CMAKE_BINARY_DIR}/dbt7-gp-time-statistics
    DESTINATION "bin"
)
