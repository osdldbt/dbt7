set(CWD "${CMAKE_SOURCE_DIR}/patches/")

install(
    FILES ${CWD}/dbt7-DSGen-software-code-3.2.0rc1.diff
          ${CWD}/dbt7-DSGen-software-code-3.2.0rc1-postgresql-queries.diff
          ${CWD}/dbt7-DSGen-software-code-3.2.0rc1-postgresql-queries-test.diff
          ${CWD}/series
    DESTINATION "share/dbt7/patches"
)
