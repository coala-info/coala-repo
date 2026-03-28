# taxaid API reference[¶](#module-taxadb.taxid "Permalink to this headline")

*class* `taxadb.taxid.``TaxID`(*\*\*kwargs*)[[source]](../_modules/taxadb/taxid.html#TaxID)[¶](#taxadb.taxid.TaxID "Permalink to this definition")
:   Main class for querying taxid

    Provide methods to request taxa table and get associated accession ids.

    |  |  |
    | --- | --- |
    | Parameters: | **\*\*kwargs** – Arbitrary arguments. Supported (username, password, port, hostname, config, dbtype, dbname) |
    | Raises: | `SystemExit` – If table taxa does not exist |

    `__init__`(*\*\*kwargs*)[[source]](../_modules/taxadb/taxid.html#TaxID.__init__)[¶](#taxadb.taxid.TaxID.__init__ "Permalink to this definition")
    :   Initialize self. See help(type(self)) for accurate signature.

    `has_parent`(*taxid*, *parent*)[[source]](../_modules/taxadb/taxid.html#TaxID.has_parent)[¶](#taxadb.taxid.TaxID.has_parent "Permalink to this definition")
    :   Check if a taxid has a parent in its lineage

        Given a taxid and a parent in the form of a taxid or a scientific name,
        :   return True if the taxid contains the parent in its lineage

        |  |  |
        | --- | --- |
        | Parameters: | * **taxid** (`int`) – a taxid * **parent** (`int|str`) – taxid or scientific name |
        | Returns: | True if the taxid contains the parent in its lineage, False  otherwise. None if taxid not found |
        | Return type: | bool |

    `lineage_id`(*taxid*, *ranks=False*, *reverse=False*)[[source]](../_modules/taxadb/taxid.html#TaxID.lineage_id)[¶](#taxadb.taxid.TaxID.lineage_id "Permalink to this definition")
    :   Get lineage for a taxonomic id

        Given a taxid, return its associated lineage (in the form of a list of
        :   taxids, each parents of each others)

        |  |  |
        | --- | --- |
        | Parameters: | * **taxid** (`int`) – a taxid * **ranks** (`bool`) – Wether to return the the tax ranks or   not. Default False * **reverse** (`bool`) – Inverted lineage, from top to bottom   taxonomy hierarchy. Default False |
        | Returns: | lineage\_list, associated lineage id with taxid or None if  taxid not found |
        | Return type: | list |

    `lineage_name`(*taxid*, *ranks=False*, *reverse=False*)[[source]](../_modules/taxadb/taxid.html#TaxID.lineage_name)[¶](#taxadb.taxid.TaxID.lineage_name "Permalink to this definition")
    :   Get a lineage name for a taxonomic id

        Given a taxid, return its associated lineage

        |  |  |
        | --- | --- |
        | Parameters: | * **taxid** (`int`) – a taxid * **ranks** (`bool`) – Wether to return the tax ranks or   not. Default False * **reverse** (`bool`) – Inverted lineage, from top to bottom   taxonomy hierarchy. Default False |
        | Returns: | lineage\_name, associated lineage name with taxid or None if  taxid not found |
        | Return type: | list |

    `sci_name`(*taxid*)[[source]](../_modules/taxadb/taxid.html#TaxID.sci_name)[¶](#taxadb.taxid.TaxID.sci_name "Permalink to this definition")
    :   Get taxonomic scientific name for taxonomy id

        Given a taxid, return its associated scientific name

        |  |  |
        | --- | --- |
        | Parameters: | **taxid** (`int`) – a taxid |
        | Returns: | name, scientific name or None if taxid not found |
        | Return type: | str |

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
  + taxaid API reference
  + [schema API reference](schema.html)
  + [util API reference](util.html)

### Related Topics

* [Documentation overview](../index.html)
  + [API Documentation](api.html)
    - Previous: [taxadb API reference](taxadb.html "previous chapter")
    - Next: [schema API reference](schema.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/taxid.rst.txt)