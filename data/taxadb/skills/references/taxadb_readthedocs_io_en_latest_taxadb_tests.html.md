# Testing Taxadb[¶](#testing-taxadb "Permalink to this headline")

You can easily run some tests. To do so proceed as follow:

```
cd /path/to/taxadb
nosetests
```

This simple command will run tests against an SQLite test database called test\_db.sqlite located in taxadb/test
directory.

It is also possible to only run tests related to accessionid or taxid as follow

```
nosetests -a 'taxid'
nosetests -a 'accessionid'
```

You can also use the configuration file located in root distribution taxadb.ini as follow. This file should contains
database connection settings:

```
nosetests --tc-file taxadb.ini
```

You can override configuration file settings using command line options –tc such as:

```
nosetest --tc-file taxadb.ini --tc=sql.dbname:another_dbname
```

More info at [nose-testconfig](https://pypi.python.org/pypi/nose-testconfig).

## Running tests against PostgreSQL or MySQL[¶](#running-tests-against-postgresql-or-mysql "Permalink to this headline")

**First create a test database to insert test data**

* PostgreSQL

```
createdb <test_db>
```

or from PostgreSQL client psql

```
psql -U postgres
psql> CREATE DATABASE <test_db>;
```

* MySQL

```
mysql -u root
mysql> CREATE DATABASE <test_db>;
```

**Load test data**

* PostgreSQL

```
gunzip -c /path/to/taxadb/taxadb/test/test_mypg_db.sql.gz | psql -d <test_db> -U <user>
```

* MySQL

```
gunzip -c /path/to/taxadb/taxadb/test/test_mypg_db.sql.gz | mysql -D <test_db> -u <user> -p
```

**Run tests**

Either edit taxadb.ini to fit database configuration or use –tc command line option and set appropriate values like
username, password, port, hostname, dbtype(postgres or mysql), dbname.

1. PostgreSQL

```
nosetests --tc-file taxadb.ini
```

```
nosetests -tc-file taxadb.ini --tc=sql.dbtype:postgres --tc=sql.username:postgres --tc=sql.dbname:test_db2
```

2. MySQL

```
nosetests --tc-file taxadb.ini
```

```
nosetests -tc-file taxadb.ini --tc=sql.dbtype:mysql --tc=sql.username:root --tc=sql.dbname:newdbname
```

# [taxadb](../index.html)

### Navigation

* [Installing Taxadb](install.html)
* [Create a database](download.html)
* Testing Taxadb
  + [Running tests against PostgreSQL or MySQL](#running-tests-against-postgresql-or-mysql)
* [Querying the database](query.html)
* [API Documentation](api.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Create a database](download.html "previous chapter")
  + Next: [Querying the database](query.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/tests.rst.txt)