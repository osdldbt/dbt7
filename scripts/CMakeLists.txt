add_subdirectory (pgsql)

set (CWD "${CMAKE_SOURCE_DIR}/scripts")

install (
    PROGRAMS
    ${CWD}/dbt7-generate-report
    ${CWD}/dbt7-get-config
    ${CWD}/dbt7-load-test
    ${CWD}/dbt7-plot-results
    ${CWD}/dbt7-post-process
    ${CWD}/dbt7-power-test
    ${CWD}/dbt7-run-workload
    ${CWD}/dbt7-sysstats
    ${CWD}/dbt7-throughput-test
    DESTINATION "bin"
)
