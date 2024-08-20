execute_process(
    COMMAND sed -n "s/^.*(\\(.*\\)).*$/\\1/p;q" ${CMAKE_HOME_DIRECTORY}/ChangeLog
    OUTPUT_VARIABLE MANDATE
)

foreach (MANPAGE dbt7 dbt7-load-test dbt7-power-test dbt7-report dbt7-run
                 dbt7-throughput-test)
    configure_file(
        ${MANPAGE}.1.rst.in
        ${CMAKE_BINARY_DIR}/man/man1/${MANPAGE}.1.rst
    )

    execute_process(
        COMMAND rst2man ${CMAKE_BINARY_DIR}/man/man1/${MANPAGE}.1.rst
        OUTPUT_FILE ${CMAKE_BINARY_DIR}/man/man1/${MANPAGE}.1
    )
endforeach(MANPAGE)

install(
    FILES ${CMAKE_BINARY_DIR}/man/man1/dbt7.1
          ${CMAKE_BINARY_DIR}/man/man1/dbt7-load-test.1
          ${CMAKE_BINARY_DIR}/man/man1/dbt7-power-test.1
          ${CMAKE_BINARY_DIR}/man/man1/dbt7-report.1
          ${CMAKE_BINARY_DIR}/man/man1/dbt7-run.1
          ${CMAKE_BINARY_DIR}/man/man1/dbt7-throughput-test.1
    DESTINATION "share/man/man1"
)
