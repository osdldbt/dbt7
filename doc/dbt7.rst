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

While this kit is primarily intended to execute the TPC-DS workload as close to
its specification as possible, there are additional tools and scripts provided
to aid in testing and development.

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
required for using the DBT-7 scripts and building the TPC-DS Tools:

* gcc
* lex
* make
* patch
* SQLite https://www.sqlite.org/index.html
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
* **sar**, **pidstat** - Used for collecting system and per process statistics.
* gnuplot - Used for generating plots for the HTML report.
* pandoc - Used only to generated PDF files from the HTML reports.

------------
User's Guide
------------

Before getting started: Building TPC-DS Tools
=============================================

The TPC-DS Tools source code (dsgen) is available as a git submodule from
https://github.com/osdldbt/dsgen per TPC EULA v2.2 clause 9.d.  To clone the
repository with the submodule populated::

    git clone --recurse-submodules https://github.com/osdldbt/dbt7.git

If the repository was already cloned without the submodule::

    git submodule update --init

DBT-7 provides the script `dbt7-build-dsgen` to apply patches and compile the
TPC-DS Tools.  The patches that are applied are minor code changes, bug fixes,
and query templates to make the TPC-DS Tools work with the databases supported
by DBT-7. These patches are in the `patches` subdirectory in compliance with
the respective licences and thus needs to be built outside of the DBT-7 build
system, which can be done with the aid of this script::

    dbt7-build-dsgen --patch-dir=patches dsgen

For brevity, future references to the location of the TPC-DS tools will be
`$DSHOME`.

Quick Start
===========

Once the TPC-DS Tools is built, only one command needs to be issued to run a
complete test::

    dbt7-run --tpchtools=$DSHOME pgsql /tmp/results

This will run the generate the data files for a 1 GB scale factor database
load, power and throughput test, with 2 streams, against PostgreSQL and save
the results of the test in `/tmp/results`.

If all phases of the test complete successfully, the *Queries per Hour* score
will be shown when the test completes.

Reports
=======

The *dbt7-run* script will generate a *summary.rst* text file can be reviewed
for the execution times for each of the tests, query times for each of the
queries in the power test, and the aggregates of the query times from the
throughput test streams.

If system and database stats are collected with the `--stats` flag, the
*dbt7-report* script will also summarize the system, database, and per process
statistics.

Advanced Usage
==============

The *dbt7-run* script can be used to run any combination of a Load Test, Power
Test, and Throughput Test combined with the Data Maintenance Test.  But be
aware that a Load Test must be run in order to create the database before a
Power or Throughput Tests can be run individually.  Other use cases are
described in the **Developer's Guide** section.

-----------------------------------------
Database Management System Specific Notes
-----------------------------------------

.. include:: postgresql.rst

-----------------
Developer's Guide
-----------------

Creating Custom Query Templates
===============================

The TPC-DS Tools provide the official set of query templates in the
`query_templates` and variants in `query_variants` subdirectories.  Adding
support for additional databases for use in DBT-7 requires up to 3 sets of
changes:

1. Create a list of the 99 query templates to be executed, e.g.
   `templates-pgsql.tpl`
2. Create a new query template file for any modification needed from the
   official templates.  e.g. Copy `query23.tpl` to `query23postgresql.tpl`.
   While not required, it is important to keep the query number in the filename
   for proper recording and analysis with the DBT-7 kit.
3. Create a new dialect file that contains the appropriate syntax for
   transaction control statements, limit handling, and any additional
   statements to run before and after each query such as recording the query
   start and end times. e.g. `pgsql.tpl`

Generating Data Files
=====================

Database files can be created outside of the execution of the Load Test with
the use of the *dbt7-generate-data* script.  It's primarily intended to test
any changes or bug fixes to **dsdgen**, so any finer use of **dsdgen** needs to
be done by directly executing it without the aid of this script.

For example, this script may be helpful in generating more than 1 chunk of data
in parallel as opposed to typing that by hand for each chunk.

Generating Query Files
======================

Queries files can be created outside of the execution of the Power Test and
Throughput Test with the use of the *dbt7-generate-queries* script.  It is
primarily intended to be able to review queries generated by **dsqgen** without
having to run a Power Test of Throughout Test first.

Any finer use of **dsqgen** needs to be done by executing it directly, but the
*dbt7-generate-queries* script does aid in generating a file per query, if so
desired.

Testing Individual Queries
==========================

Running the individual parts of the benchmark, i.e. the Power Test of the
Throughput Test, much less the entire benchmark, don't lend it itself to making
it easy to evaluate individual query performance.  There may be times when the
developer wants to focus on an individual query to evaluate the effects of a
different index, or database system parameters.

The *run-query* script is intended to allow a developer to generate and execute
one query at a time.  The *dbt7-generate-queries* script can be used to
generate a query file to be executed manually, but *run_query* will also
executed the query generated.

A database needs to be created first, but only needs to be loaded once if
testing individual queries.  This can be done with the run script using the
`--load` flag.  A PostgreSQL example::

    dbt7 run --tpchtools=$DSHOME --load pgsql /tmp/load-results

Then any query can be tested.  For example running Query 55::

    dbt7 run-query --tpchtools=$DSHOME 55 pgsql

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
