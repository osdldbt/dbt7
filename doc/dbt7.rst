====================================
Database Test 7 (DBT-7) User's Guide
====================================

.. contents:: Table of Contents

------------
Introduction
------------

This document provides instructions on how to set up and use the Database Test
7 (DBT-7) kit.  This kit provides what is needed to execute a workload similar
to the TPC-DS workload.

This workload is composed of two phases: a load test and a performance test.
Both tests needs to be run together to constitute a complete test run.  A
*Queries per Hour* score is calculated at the end of a complete test that is
calculated from the results of both the load and performance test.

The performance test is composed of several additional tests: a power test, two
data maintenance test, and two throughput tests.

----------------
Installing DBT-7
----------------

The latest stable and development version of the kit can be found on GitHub:
https://github.com/osdldbt/dbt7

The TPC's TPC-DS Tools cannot be redistributed with DBT-7 and must be downloaded
by the tester:
https://www.tpc.org/tpc_documents_current_versions/current_specifications5.asp

Required Software
=================

In addition to the database management system software, the following is also
required:

* cc
* SQLite https://www.sqlite.org/index.html
* lex
* make
* patch
* yacc

Supported Database Systems
--------------------------

These are the currently supported database systems:

* Greenplum
* PostgreSQL

Optional Software
-----------------

* Docutils - **rst2html5** is used to generate HTML from the reStructuredText
  reports.
* **sar**, **pidstat** - While the scripts assume this particular version of
  **sar** and **pidstat** for Linux, it is possible to run on non-Linux based
  operating systems with some modifications to the kit.
* gnuplot - Used for generating plots for the HTML report
* pandoc - Used only to generated PDF files from the HTML reports.

------------
User's Guide
------------

Building TPC-DS Tools
=====================

DBT-7 provides the script `dbt7-build-dsgen` to apply patches and compile the
TPC-DS Tools.  The patches that are applied are minor code changes and query
templates to make the TPC-DS Tools work with the databases supposed by DBT-7.

For example, to build the TPC-DS Tools, unzip the TPC-DS Tools zip file and run
`dbt7-build-dbgen` against the resulting directory::

    unzip *-tpc-ds-tool.zip
    dbt7-build-dsgen DSGen-software-code-3.2.0rc1

Quick Start
-----------

Once the TPC-DS Tools is built, only one command needs to be issued to run a
complete test::

    dbt7-run --tpchtools="TPC-DS V3.0.1" pgsql /tmp/results

This will run the generate the data files for a 1 GB scale factor database
load, power and throughput test, with 2 streams, against PostgreSQL and save
the results of the test in `/tmp/results`.

If all phases of the test complete successfully, the *Queries per Hour* score
will be shown when the test completes.

Reports
-------

The *dbt7-run* script will generate a *summary.rst* text file can be reviewed
for the execution times for each of the tests, query times for each of the
queries in the power test, and the aggregates of the query times from the
throughput test streams.

If system and database stats are collected, the *dbt7-report* script can be run

Advanced Usage
--------------

The *dbt7-run* script can be used to run any combination of a load test, power
test, and throughput tests combined with the data maintenance tests.  But be
aware that a load test must be run in order to create the database before a
power or throughput tests can be run individually.

-----------------------------------------
Database Management System Specific Notes
-----------------------------------------

.. include:: postgresql.rst

-----------------
Developer's Guide
-----------------

Creating Custom Query Templates
===============================

The TPC-DS Tools contain the official set of query templates in the
`query_templates` subdirectory.  Adding support for additional databases for
use in DBT-7 requires up to 3 steps:

1. Create a list of the 99 query templates to be executed, e.g.
   `templates-pgsql.tpl`
2. Create new query template file for any modification needed from the official
   templates.  e.g. Copy `query23.tpl` to `query23postgresql.tpl`.  It is
   important to keep the query number in the filename for proper recording and
   analysis with the DBT-7 kit.
3. Create a new dialect file that contains proper syntax for transaction
   control statements, and limit handling.  e.g. `pgsql.tpl`

Testing Individual Queries
==========================

Running the individual parts of the benchmark, i.e. the Power Test of the
Throughput Test, much less the entire benchmark, don't lend it itself to making
it easy to evaluate individual query performance.  There may be times when the
developer wants to focus on an individual query to evaluate the effects of a
different index, or database system parameters.

The *run-query* script is intended to allow a developer to generate and execute
1 query at a time.

A database needs to be created first, but only needs to be loaded once if
testing individual queries.  This can be done with the run script using the
`--load` flag.  A PostgreSQL example::

    dbt7 run --load pgsql load-results

Then any query can be tested.  For example running Query 4::

    dbt7 run-query 55 pgsql

Here is an example of the output query output, the results, and the execution
time::

    select  i_brand_id brand_id, i_brand brand,
 	    sum(ss_ext_sales_price) ext_price
     from date_dim, store_sales, item
     where d_date_sk = ss_sold_date_sk
 	    and ss_item_sk = i_item_sk
 	    and i_manager_id=36
 	    and d_moy=12
 	    and d_year=2001
     group by i_brand, i_brand_id
     order by ext_price desc, i_brand_id
    limit 100 ;
     brand_id |                       brand                        |     ext_price
    ----------+----------------------------------------------------+--------------------
      3002002 | importoexporti #2                                  |           94269.68
    ...

    (68 rows)

    Query 55 executed in 0.155 second(s).

Additional flags can be used to capture system statistics (`--stats`), software
profiles (`--profile`), or explain plans (`--explain`).
