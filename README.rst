Supported Database Management Systems
=====================================

Read specific README files for additional information on each supported
database.

* PostgreSQL - README-POSTGRESQL.rst

TPC-DS Tools
============

The TPC currently restricts redistribution of their code but it can be freely
downloaded from:
https://www.tpc.org/tpc_documents_current_versions/current_specifications5.asp

The TPC-DS Tools needs to be patched in order to be usable by this kit.
Patches are currently supplied for *DSGen-software-code-3.2.0rc1* in the
`patches` subdirectory.  The script `dbt7-build-dsgen` is provided to help
patch and build the TPC-DS tools.

The patch `dbt7-DSGen-software-code-3.2.0rc1` allows the code to build.

The patch `dbt7-DSGen-software-code-3.2.0rc1-postgresql-queries` applies minor
query changes that allows the affected queries to be run by PostgreSQL.  It also
adds additional templates that allows query plans to be captured instead of
query results.

To build the TPC-DS Tools::

    unzip *-tpc-ds-tool.zip
    dbt7-build-dsgen DSGen-software-code-3.2.0rc1
