Supported Database Management Systems
=====================================

Read specific README files for additional information on each suppported
database.

* PostgreSQL - README-POSTGRESQL.rst

TPC Source Code
===============

The TPC currently restricts redistribution of their code but it can be freely
downloaded from:
https://www.tpc.org/tpc_documents_current_versions/current_specifications5.asp

The TPC source code needs to be patched to be used for this kit.  Patches are
current supplied for DSGen-software-code-3.2.0rc1 and can be applied with::

    patch -p1 < patches/dbt7-DSGen-software-code-3.2.0rc1.diff
    patch -p1 < patches/dbt7-DSGen-software-code-3.2.0rc1-postgresql-queries.diff

The patch `dbt7-DSGen-software-code-3.2.0rc1` allows the code to build.

The patch `dbt7-DSGen-software-code-3.2.0rc1-postgresql-queries` applies minor
query changes that allows the affect queries to be run by PostgreSQL.  It also
adds additional templates that allows query plans to be captured instead of
query results.

To build the TPC source code::

    cd DSGen-software-code-3.2.0rc1/tools
    make clean # The TPC supplied code has some lingering artifacts...
    make
