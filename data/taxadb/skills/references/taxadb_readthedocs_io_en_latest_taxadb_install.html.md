# Installing Taxadb[¶](#installing-taxadb "Permalink to this headline")

Taxadb requires `python >= 3.5` to work. Taxadb can work with SQLite, PostgreSQL and MySQL. By default Taxadb
works with SQLite as it comes with modern Python distributions.

## Using pip[¶](#using-pip "Permalink to this headline")

To install taxadb, simply type one of the following in a terminal:

```
pip install taxadb
```

Installing taxadb with PostgreSQL and/or MySQL support

```
pip install .[postgres, mysql] taxadb
```

This should install psycopg2 and PyMySQL Python packages

## From github[¶](#from-github "Permalink to this headline")

If you wish to install taxadb from github, you can do the following

```
git clone https://github.com/HadrienG/taxadb.git
cd taxadb
python setup.py install
```

Installing Taxadb for PostgreSQL and/or MySQL

```
git clone https://github.com/HadrienG/taxadb.git
cd taxadb
pip install psycopg2 PyMySQL
python setup.py install
```

# [taxadb](../index.html)

### Navigation

* Installing Taxadb
  + [Using pip](#using-pip)
  + [From github](#from-github)
* [Create a database](download.html)
* [Testing Taxadb](tests.html)
* [Querying the database](query.html)
* [API Documentation](api.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Taxadb](../index.html "previous chapter")
  + Next: [Create a database](download.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/install.rst.txt)