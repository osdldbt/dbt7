add_subdirectory (pgsql)

foreach (SCRIPT dbt7
                dbt7-build-dsgen
                dbt7-generate-report
                dbt7-get-config
                dbt7-load-test
                dbt7-plot-results
                dbt7-post-process
                dbt7-power-test
                dbt7-run-workload
                dbt7-throughput-test
        )
    configure_file(${SCRIPT}.in ${CMAKE_BINARY_DIR}/${SCRIPT} @ONLY)
endforeach (SCRIPT)

install (
    PROGRAMS ${CMAKE_BINARY_DIR}/dbt7
             ${CMAKE_BINARY_DIR}/dbt7-build-dsgen
             ${CMAKE_BINARY_DIR}/dbt7-generate-report
             ${CMAKE_BINARY_DIR}/dbt7-get-config
             ${CMAKE_BINARY_DIR}/dbt7-load-test
             ${CMAKE_BINARY_DIR}/dbt7-plot-results
             ${CMAKE_BINARY_DIR}/dbt7-post-process
             ${CMAKE_BINARY_DIR}/dbt7-power-test
             ${CMAKE_BINARY_DIR}/dbt7-run-workload
             ${CMAKE_BINARY_DIR}/dbt7-throughput-test
    DESTINATION "bin"
)
