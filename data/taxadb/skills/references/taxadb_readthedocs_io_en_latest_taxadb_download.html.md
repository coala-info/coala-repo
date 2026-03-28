# Create a database[¶](#create-a-database "Permalink to this headline")

## Build you own database[¶](#build-you-own-database "Permalink to this headline")

In order to create your own database, you first need to download the required data from
the ncbi ftp. The following command does it for you:

```
taxadb download -o taxadb
```

where `-o` refers to an output directory where to download the data.

### SQLite[¶](#sqlite "Permalink to this headline")

The following command will create an **SQLite** database in the current directory.

```
taxadb create -i taxadb --dbname taxadb.sqlite
```

### MySQL[¶](#mysql "Permalink to this headline")

Creating databases is a very vendor specific task. **Peewee**, as most ORMs, can create tables but not databases.
In order to use taxadb with **MySQL**, you’ll have to create the database yourself.

```
mysql -u $user -p
mysql> CREATE DATABASE taxadb;
```

Then, fill database with data

```
taxadb create -i taxadb --dbname taxadb --dbtype mysql --username user --password secret --port 3306 --hostname localhost
```

### PostgreSQL[¶](#postgresql "Permalink to this headline")

Creating databases is a very vendor specific task. **Peewee**, as most ORMs, can create tables but not databases.
In order to use taxadb with **PostgreSQL**, you’ll have to create the database yourself.

```
psql -U $user -d postgres
psql> CREATE DATABASE taxadb;
```

Then, fill database with data

```
taxadb create -i taxadb --dbname taxadb --dbtype postgres --username user --password secret --port 5432 --hostname localhost
```

The following options have default value if not set on the command line:

* `--port` (`5432` for **PostgreSQL**, `3306` for **MySQL**)
* `--hostname` (localhost)

For more information about all the available options, please type:

```
taxadb create --help
```

Warning

When building your database with downloaded data, you can increase the speed
of data loading by using –fast option. This option avoid checking existence
of each accession id in the database before loading related info. In certain
case this may lead to duplicate entries in table accession when loading
the same file twice for example.

# [taxadb](../index.html)

### Navigation

* [Installing Taxadb](install.html)
* Create a database
  + [Build you own database](#build-you-own-database)
* [Testing Taxadb](tests.html)
* [Querying the database](query.html)
* [API Documentation](api.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Installing Taxadb](install.html "previous chapter")
  + Next: [Testing Taxadb](tests.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/download.rst.txt)