# taxadb API reference[¶](#module-taxadb.taxadb "Permalink to this headline")

*class* `taxadb.taxadb.``TaxaDB`(*\*\*kwargs*)[[source]](../_modules/taxadb/taxadb.html#TaxaDB)[¶](#taxadb.taxadb.TaxaDB "Permalink to this definition")
:   Main TaxaDB package class

    Parent class of the Taxadb application. Use this class to create inheriting
    classes.

    |  |  |
    | --- | --- |
    | Parameters: | **\*\*kwargs** – Arbitrary arguments. Supported (username, password, port, hostname, config, dbtype, dbname) |
    | Raises: | `AttributeError` – If cannot instantiate taxadb.schema.DatabaseFactory. |

    `MAX_LIST`[¶](#taxadb.taxadb.TaxaDB.MAX_LIST "Permalink to this definition")
    :   Maximum number of bind variables to pass to
        request methods. Due to SQLite limit of passed arguments to a
        statement, we limit number of accession and taxid to
        request to 999 (<https://www.sqlite.org/c3ref/bind_blob.html>)

        |  |  |
        | --- | --- |
        | Type: | `int` |

    `__del__`()[[source]](../_modules/taxadb/taxadb.html#TaxaDB.__del__)[¶](#taxadb.taxadb.TaxaDB.__del__ "Permalink to this definition")
    :   Ensure database connection is closed

    `__init__`(*\*\*kwargs*)[[source]](../_modules/taxadb/taxadb.html#TaxaDB.__init__)[¶](#taxadb.taxadb.TaxaDB.__init__ "Permalink to this definition")
    :   Initialize self. See help(type(self)) for accurate signature.

    `__weakref__`[¶](#taxadb.taxadb.TaxaDB.__weakref__ "Permalink to this definition")
    :   list of weak references to the object (if defined)

    `_unmapped_taxid`(*acc*, *do\_exit=False*)[[source]](../_modules/taxadb/taxadb.html#TaxaDB._unmapped_taxid)[¶](#taxadb.taxadb.TaxaDB._unmapped_taxid "Permalink to this definition")
    :   Prints error message to stderr if an accession number is not
        mapped with a taxid

        Source ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/README
        >> If for some reason the source organism cannot be mapped to the
        taxonomy database, the column will contain 0.<<

        |  |  |
        | --- | --- |
        | Parameters: | * **acc** (`str`) – Accession number not mapped with taxid * **do\_exit** (`bool`) – Exit with code 1. Default False |

    *static* `check_list_ids`(*ids*)[[source]](../_modules/taxadb/taxadb.html#TaxaDB.check_list_ids)[¶](#taxadb.taxadb.TaxaDB.check_list_ids "Permalink to this definition")
    :   Check the list of ids is not longer that MAX\_LIST

        |  |  |
        | --- | --- |
        | Parameters: | **ids** (`list`) – List of bind values |
        | Returns: | True |
        | Raises: | `SystemExit` – If len of the list of greater than MAX\_LIST. |

    `check_table_exists`(*table*)[[source]](../_modules/taxadb/taxadb.html#TaxaDB.check_table_exists)[¶](#taxadb.taxadb.TaxaDB.check_table_exists "Permalink to this definition")
    :   Check a table exists in the database

        |  |  |
        | --- | --- |
        | Parameters: | **table** (`str`) – Database table name to check. |
        | Returns: | True |
        | Raises: | `SystemExit` – if table does not exist |

    `get`(*name*)[[source]](../_modules/taxadb/taxadb.html#TaxaDB.get)[¶](#taxadb.taxadb.TaxaDB.get "Permalink to this definition")
    :   Get a database setting from the connection arguments

        |  |  |
        | --- | --- |
        | Returns: | value (`str`) if found, None otherwise |

    `set`(*option*, *value*, *section='DBSETTINGS'*)[[source]](../_modules/taxadb/taxadb.html#TaxaDB.set)[¶](#taxadb.taxadb.TaxaDB.set "Permalink to this definition")
    :   Set a configuration value

        |  |  |
        | --- | --- |
        | Parameters: | * **option** (`str`) – Config key * **value** (`str`) – Config value * **section** (`str`) – Config section, default ‘DBSETTINGS’ |
        | Returns: | True |

# [taxadb](../index.html)

### Navigation

* [Installing Taxadb](install.html)
* [Create a database](download.html)
* [Testing Taxadb](tests.html)
* [Querying the database](query.html)
* [API Documentation](api.html)
  + [accessionid API reference](accessionid.html)
  + [app API reference](app.html)
  + [parser API reference](parser.html)
  + taxadb API reference
  + [taxaid API reference](taxid.html)
  + [schema API reference](schema.html)
  + [util API reference](util.html)

### Related Topics

* [Documentation overview](../index.html)
  + [API Documentation](api.html)
    - Previous: [parser API reference](parser.html "previous chapter")
    - Next: [taxaid API reference](taxid.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/taxadb.rst.txt)