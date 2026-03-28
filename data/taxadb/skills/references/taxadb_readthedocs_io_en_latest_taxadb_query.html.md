# Querying the database[¶](#querying-the-database "Permalink to this headline")

Firstly make sure you have [downloaded](download.html#download) or [built](download.html#build-own-databases) the database.

Below you can find basic examples. For more complex examples, please refer to the complete [documentation](api.html#api).

## Using configuration file or environment variable[¶](#using-configuration-file-or-environment-variable "Permalink to this headline")

Taxadb can now take profit of configuration file or environment variable to
set database connection parameters.

* Using configuration file

You can pass a configuration file when building your object:

```
>>> from taxadb.taxid import TaxID

>>> taxid = TaxID(config='/path/to/taxadb.cfg')
>>> name = taxid.sci_name(33208)
>>> ...
```

* Configuration file format

The configuration file must use syntax supported by [configparser object](https://docs.python.org/3.5/library/configparser.html).
You must set database connection parameters in a section called
`DBSETTINGS` as below:

```
[DBSETTINGS]
dbtype=<sqlite|postgres|mysql>
dbname=taxadb
hostname=taxadb.domain.org
username=admin
password=s3cr3T
port=
```

Some value will default it they are not set.

**hostname** will be set to value `localhost` and **port** is set to
`5432` for `dbtype=postgres` and `3306` for
`dbtype=mysql`.

* Using environment variable

Taxadb can as well use an environment variable to automatically point the
application to a configuration file. To take profit of it, just set
`TAXADB_CONFIG` to the path of your configuration file:

```
(bash) export TAXADB_CONFIG='/path/to/taxadb.cfg'
(csh) set TAXADB_CONFIG='/path/to/taxadb.cfg'
```

Then, just create your object as follow:

```
>>> from taxadb.taxid import TaxID

>>> taxid = Taxid()
>>> name = taxid.sci_name(33208)
>>> ...
```

Note

Arguments passed to object initiation will always overwrite default values
as well as values that might have been set by configuration file or
environment variable `TAXADB_CONFIG`.

## taxids[¶](#taxids "Permalink to this headline")

Several operations on taxids are available in taxadb:

```
>>> from taxadb.taxid import TaxID

>>> taxid = TaxID(dbype='sqlite', dbname='taxadb.sqlite')
>>> name = taxid.sci_name(33208)
>>> print(name)
Metazoa

>>> lineage = taxid.lineage_name(33208)
>>> print(lineage)
['Metazoa', 'Opisthokonta', 'Eukaryota', 'cellular organisms']
>>> lineage = taxid.lineage_name(33208, reverse=True)
>>> print(lineage)
['cellular organism', 'Eukaryota', 'Opisthokonta', 'Metazoa']

>>> taxid.has_parent(33208, 'Eukaryota')
True
```

You can also get the taxid from the scientific name

Get the taxid from a scientific name.

```
>>> from taxadb.names import SciName

>>> names = SciName(dbtype='sqlite', dbname='mydb.sqlite')
>>> taxid = names.taxid('Physisporinus cinereus')
>>> print(taxid)
2056287
```

If you are using MySQL or postgres, you’ll have to provide your username and password
(and optionally the port and hostname):

```
>>> from taxadb.taxid import TaxID

>>> taxid = TaxID(dbype='postgres', dbname='taxadb',
                    username='taxadb', password='*****')
>>> name = taxid.sci_name(33208)
>>> print(name)
Metazoa
```

## accession numbers[¶](#accession-numbers "Permalink to this headline")

Get taxonomic information from accession number(s).

```
>>> from taxadb.accessionid import AccessionID

>>> my_accessions = ['X17276', 'Z12029']
>>> accession = AccessionID(dbtype='sqlite', dbname='taxadb.sqlite')
>>> taxids = accession.taxid(my_accessions)
>>> taxids
<generator object taxid at 0x1051b0830>

>>> for tax in taxids:
        print(tax)
('X17276', 9646)
('Z12029', 9915)
```

# [taxadb](../index.html)

### Navigation

* [Installing Taxadb](install.html)
* [Create a database](download.html)
* [Testing Taxadb](tests.html)
* Querying the database
  + [Using configuration file or environment variable](#using-configuration-file-or-environment-variable)
  + [taxids](#taxids)
  + [accession numbers](#accession-numbers)
* [API Documentation](api.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Testing Taxadb](tests.html "previous chapter")
  + Next: [API Documentation](api.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/query.rst.txt)