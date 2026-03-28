# schema API reference[¶](#module-taxadb.schema "Permalink to this headline")

*class* `taxadb.schema.``Accession`(*\*args*, *\*\*kwargs*)[[source]](../_modules/taxadb/schema.html#Accession)[¶](#taxadb.schema.Accession "Permalink to this definition")
:   table Accession.

    Each row is a sequence from nucl\_\*.accession2taxid.gz. Each sequence
    :   has a taxid.

    `id`[¶](#taxadb.schema.Accession.id "Permalink to this definition")
    :   the primary key

        |  |  |
        | --- | --- |
        | Type: | `pw.PrimaryKeyField` |

    `taxid`[¶](#taxadb.schema.Accession.taxid "Permalink to this definition")
    :   reference to a taxon in the table
        Taxa.

        |  |  |
        | --- | --- |
        | Type: | `pw.ForeignKeyField` |

    `accession`[¶](#taxadb.schema.Accession.accession "Permalink to this definition")
    :   the accession number of the sequence.

        |  |  |
        | --- | --- |
        | Type: | `pw.CharField` |

    `DoesNotExist`[¶](#taxadb.schema.Accession.DoesNotExist "Permalink to this definition")
    :   alias of `AccessionDoesNotExist`

*class* `taxadb.schema.``DatabaseFactory`(*config=None*, *\*\*kwargs*)[[source]](../_modules/taxadb/schema.html#DatabaseFactory)[¶](#taxadb.schema.DatabaseFactory "Permalink to this definition")
:   Database factory to support multiple database type.

    This class may be used to create a database for different type (SQLite,
    :   PostgreSQL, MySQL).

    |  |  |
    | --- | --- |
    | Parameters: | * **config** (`str`) – Path to configuration file. * **\*\*kwargs** – Arbitrary arguments. Supported (username, password, port,   hostname) |
    | Raises: | `AttributeError` – If error occurred during database object build |

    `__init__`(*config=None*, *\*\*kwargs*)[[source]](../_modules/taxadb/schema.html#DatabaseFactory.__init__)[¶](#taxadb.schema.DatabaseFactory.__init__ "Permalink to this definition")
    :   Initialize self. See help(type(self)) for accurate signature.

    `__weakref__`[¶](#taxadb.schema.DatabaseFactory.__weakref__ "Permalink to this definition")
    :   list of weak references to the object (if defined)

    `_load_config`(*config=None*)[[source]](../_modules/taxadb/schema.html#DatabaseFactory._load_config)[¶](#taxadb.schema.DatabaseFactory._load_config "Permalink to this definition")
    :   Load configuration file

        |  |  |
        | --- | --- |
        | Parameters: | **config** (`str`) – Path to configuration file |
        | Returns: | True |

    `_set_args`(*args*)[[source]](../_modules/taxadb/schema.html#DatabaseFactory._set_args)[¶](#taxadb.schema.DatabaseFactory._set_args "Permalink to this definition")
    :   Set database connection settings and info as config

        |  |  |
        | --- | --- |
        | Parameters: | **args** (`dict`) – Dictionary for database settings |
        | Returns: | True |

    `get`(*name*, *section='DBSETTINGS'*)[[source]](../_modules/taxadb/schema.html#DatabaseFactory.get)[¶](#taxadb.schema.DatabaseFactory.get "Permalink to this definition")
    :   Get a database connection setting

        First checks if the configuration has been set and if the setting is
        in here. Otherwise, check if this setting is set as an attribute.

        |  |  |
        | --- | --- |
        | Parameters: | * **name** (`str`) – Database setting to request * **section** (`str`) – Section to look for, default ‘DBSETTINGS’ |
        | Returns: | value (`str`) if set, None otherwise |

    `get_database`()[[source]](../_modules/taxadb/schema.html#DatabaseFactory.get_database)[¶](#taxadb.schema.DatabaseFactory.get_database "Permalink to this definition")
    :   Returns the correct database driver

        |  |  |
        | --- | --- |
        | Returns: | `pw.Database` |
        | Raises: | `AttributeError` – if –username or –password not passed (if –dbtype [postgres|mysql]) |

    `set`(*option*, *value*, *section='DBSETTINGS'*)[[source]](../_modules/taxadb/schema.html#DatabaseFactory.set)[¶](#taxadb.schema.DatabaseFactory.set "Permalink to this definition")
    :   Set a configuration value

        |  |  |
        | --- | --- |
        | Parameters: | * **option** (`str`) – Config key * **value** (`str`) – Config value * **section** (`str`) – Config section, default ‘DBSETTINGS’ |
        | Returns: | True |

    `set_config`(*config=None*, *args=None*)[[source]](../_modules/taxadb/schema.html#DatabaseFactory.set_config)[¶](#taxadb.schema.DatabaseFactory.set_config "Permalink to this definition")
    :   Read configuration file with database settings

        It
        :param config: Path to configuration file
        :type config: `str`
        :param args: Option arguments
        :type args: `dict`

        |  |  |
        | --- | --- |
        | Returns: | `configparser.ConfigParser` |

*class* `taxadb.schema.``Taxa`(*\*args*, *\*\*kwargs*)[[source]](../_modules/taxadb/schema.html#Taxa)[¶](#taxadb.schema.Taxa "Permalink to this definition")
:   table Taxa.

    Each row is a taxon.

    `ncbi_taxid`[¶](#taxadb.schema.Taxa.ncbi_taxid "Permalink to this definition")
    :   the TaxID of
        the taxon (from nodes.dmp)

        |  |  |
        | --- | --- |
        | Type: | `pw.IntegerField` |

    `parent_taxid`[¶](#taxadb.schema.Taxa.parent_taxid "Permalink to this definition")
    :   the TaxID of
        the parent taxon (from nodes.dmp)

        |  |  |
        | --- | --- |
        | Type: | `pw.IntegerField` |

    `tax_name`[¶](#taxadb.schema.Taxa.tax_name "Permalink to this definition")
    :   the scientific name of
        the taxon (from names.dmp)

        |  |  |
        | --- | --- |
        | Type: | `pw.CharField` |

    `lineage_level`[¶](#taxadb.schema.Taxa.lineage_level "Permalink to this definition")
    :   the level of lineage of
        the taxon (from nodes.dmp)

        |  |  |
        | --- | --- |
        | Type: | `pw.CharField` |

    `DoesNotExist`[¶](#taxadb.schema.Taxa.DoesNotExist "Permalink to this definition")
    :   alias of `TaxaDoesNotExist`

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
  + [taxadb API reference](taxadb.html)
  + [taxaid API reference](taxid.html)
  + schema API reference
  + [util API reference](util.html)

### Related Topics

* [Documentation overview](../index.html)
  + [API Documentation](api.html)
    - Previous: [taxaid API reference](taxid.html "previous chapter")
    - Next: [util API reference](util.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/schema.rst.txt)