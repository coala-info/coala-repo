# Taxadb[¶](#taxadb "Permalink to this headline")

Taxadb is an application to locally query the ncbi taxonomy. Taxadb is written in python, and access its database using
the [peewee](http://peewee.readthedocs.io) library.

In brief Taxadb:

* is a small tool to query the [ncbi](https://ncbi.nlm.nih.gov/taxonomy) taxonomy.
* is written in python >= 3.5.
* has built-in support for [SQLite](https://www.sqlite.org), [MySQL](https://www.mysql.com) and
  [PostgreSQL](https://www.postgresql.org).
* has available pre-built SQLite databases ([Download build databases](taxadb/download.html#download)).
* has a comprehensive [API documentation](taxadb/api.html#api).
* is actively being developed on [GitHub](https://github.com/HadrienG/taxadb.git) and available under the MIT license. Please see the [README](https://github.com/HadrienG/taxadb) for more information on development, support, and contributing.

## Quickstart[¶](#quickstart "Permalink to this headline")

Click on the images below to access the documentation for creating the database with the engine you wish to use:

[![postgresql](_images/postgresql.png)](taxadb/download.html#using-postgres)
[![mysql](_images/mysql.png)](taxadb/download.html#using-mysql)
[![sqlite](_images/sqlite.png)](taxadb/download.html#using-sqlite)

* [Installation guide](taxadb/install.html#install) explains how to install Taxadb.
* [Download or build data](taxadb/download.html#download) explains how to build Taxadb database(s).
* [Test the application](taxadb/tests.html#tests) allows to run several tests for supported databases.
* [Querying taxadb](taxadb/query.html#query) shows examples on how to query a Taxadb database.
* [API reference](taxadb/api.html#api) describes available classes and methods to use Taxadb.

## Contents[¶](#contents "Permalink to this headline")

* [Installing Taxadb](taxadb/install.html)
  + [Using pip](taxadb/install.html#using-pip)
  + [From github](taxadb/install.html#from-github)
* [Create a database](taxadb/download.html)
  + [Build you own database](taxadb/download.html#build-you-own-database)
* [Testing Taxadb](taxadb/tests.html)
  + [Running tests against PostgreSQL or MySQL](taxadb/tests.html#running-tests-against-postgresql-or-mysql)
* [Querying the database](taxadb/query.html)
  + [Using configuration file or environment variable](taxadb/query.html#using-configuration-file-or-environment-variable)
  + [taxids](taxadb/query.html#taxids)
  + [accession numbers](taxadb/query.html#accession-numbers)
* [API Documentation](taxadb/api.html)
  + [accessionid API reference](taxadb/accessionid.html)
  + [app API reference](taxadb/app.html)
  + [parser API reference](taxadb/parser.html)
  + [taxadb API reference](taxadb/taxadb.html)
  + [taxaid API reference](taxadb/taxid.html)
  + [schema API reference](taxadb/schema.html)
  + [util API reference](taxadb/util.html)

## Indices and tables[¶](#indices-and-tables "Permalink to this headline")

* [Index](genindex.html)
* [Module Index](py-modindex.html)
* [Search Page](search.html)

*This documentation was generated on* 2022-06-14 *at* 10:05.

# taxadb

### Navigation

* [Installing Taxadb](taxadb/install.html)
* [Create a database](taxadb/download.html)
* [Testing Taxadb](taxadb/tests.html)
* [Querying the database](taxadb/query.html)
* [API Documentation](taxadb/api.html)

### Related Topics

* Documentation overview
  + Next: [Installing Taxadb](taxadb/install.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](_sources/index.rst.txt)