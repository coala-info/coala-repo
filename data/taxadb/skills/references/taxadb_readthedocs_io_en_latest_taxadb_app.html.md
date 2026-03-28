# app API reference[¶](#module-taxadb.app "Permalink to this headline")

`taxadb.app.``create_db`(*args*)[[source]](../_modules/taxadb/app.html#create_db)[¶](#taxadb.app.create_db "Permalink to this definition")
:   Main function for the ‘taxadb create’ sub-command.

    This function creates a taxonomy database with 2 tables: Taxa and Sequence.

    |  |  |
    | --- | --- |
    | Parameters: | * **args.input** (`str`) – input directory. It is the directory created   by taxadb download * **args.dbname** (`str`) – name of the database to be created * **args.dbtype** (`str`) – type of database to be used. * **args.division** (`str`) – division to create the db for. * **args.fast** (`bool`) – Disables checks for faster db creation. Use   with caution! |

`taxadb.app.``download_files`(*args*)[[source]](../_modules/taxadb/app.html#download_files)[¶](#taxadb.app.download_files "Permalink to this definition")
:   Main function for the taxadb download sub-command.

    This function can download taxump.tar.gz and the content of the
    accession2taxid directory from the ncbi ftp.

    |  |  |
    | --- | --- |
    | Parameters: | **args** (*object*) – The arguments from argparse |

# [taxadb](../index.html)

### Navigation

* [Installing Taxadb](install.html)
* [Create a database](download.html)
* [Testing Taxadb](tests.html)
* [Querying the database](query.html)
* [API Documentation](api.html)
  + [accessionid API reference](accessionid.html)
  + app API reference
  + [parser API reference](parser.html)
  + [taxadb API reference](taxadb.html)
  + [taxaid API reference](taxid.html)
  + [schema API reference](schema.html)
  + [util API reference](util.html)

### Related Topics

* [Documentation overview](../index.html)
  + [API Documentation](api.html)
    - Previous: [accessionid API reference](accessionid.html "previous chapter")
    - Next: [parser API reference](parser.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/app.rst.txt)