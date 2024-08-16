add_subdirectory (pgsql)

set (SCRIPTS "")
foreach (SCRIPT dbt7
                dbt7-build-dsgen
                dbt7-get-config
                dbt7-load-test
                dbt7-plot-results
                dbt7-post-process
                dbt7-power-test
                dbt7-report
                dbt7-run
                dbt7-throughput-test
        )
    configure_file(${SCRIPT}.in ${CMAKE_BINARY_DIR}/${SCRIPT} @ONLY)
    set (SCRIPTS ${SCRIPTS} ${CMAKE_BINARY_DIR}/${SCRIPT})
endforeach (SCRIPT)

install (PROGRAMS ${SCRIPTS} DESTINATION "bin")
