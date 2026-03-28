# accessionid API reference[¶](#module-taxadb.accessionid "Permalink to this headline")

*class* `taxadb.accessionid.``AccessionID`(*\*\*kwargs*)[[source]](../_modules/taxadb/accessionid.html#AccessionID)[¶](#taxadb.accessionid.AccessionID "Permalink to this definition")
:   Main accession class

    Provide methods to request accession table and get associated taxonomy for
    :   accession ids.

    |  |  |
    | --- | --- |
    | Parameters: | **\*\*kwargs** – Arbitrary arguments. Supported (username, password, port, hostname, config, dbtype, dbname) |
    | Raises: | `SystemExit` – If table accession does not exist |

    `__init__`(*\*\*kwargs*)[[source]](../_modules/taxadb/accessionid.html#AccessionID.__init__)[¶](#taxadb.accessionid.AccessionID.__init__ "Permalink to this definition")
    :   Initialize self. See help(type(self)) for accurate signature.

    `lineage_id`(*acc\_number\_list*)[[source]](../_modules/taxadb/accessionid.html#AccessionID.lineage_id)[¶](#taxadb.accessionid.AccessionID.lineage_id "Permalink to this definition")
    :   Get taxonomic lineage name for accession ids

        Given a list of accession numbers, yield the accession number and their
        :   associated lineage (in the form of taxids) as tuples

        |  |  |
        | --- | --- |
        | Parameters: | **acc\_number\_list** (`list`) – a list of accession numbers |
        | Yields: | *tuple* – (accession id, lineage list) |

    `lineage_name`(*acc\_number\_list*)[[source]](../_modules/taxadb/accessionid.html#AccessionID.lineage_name)[¶](#taxadb.accessionid.AccessionID.lineage_name "Permalink to this definition")
    :   Get a lineage name for accession ids

        Given a list of acession numbers, yield the accession number and their
        :   associated lineage as tuples

        |  |  |
        | --- | --- |
        | Parameters: | **acc\_number\_list** (`list`) – a list of accession numbers |
        | Yields: | *tuple* – (accession id, lineage name) |

    `sci_name`(*acc\_number\_list*)[[source]](../_modules/taxadb/accessionid.html#AccessionID.sci_name)[¶](#taxadb.accessionid.AccessionID.sci_name "Permalink to this definition")
    :   Get taxonomic scientific name for accession ids

        Given a list of accession numbers, yield the accession number and their
        associated scientific name as tuples

        |  |  |
        | --- | --- |
        | Parameters: | **acc\_number\_list** (`list`) – a list of accession numbers |
        | Yields: | *tuple* – (accession id, taxonomy id) |

    `taxid`(*acc\_number\_list*)[[source]](../_modules/taxadb/accessionid.html#AccessionID.taxid)[¶](#taxadb.accessionid.AccessionID.taxid "Permalink to this definition")
    :   Get taxonomy of accession ids

        Given a list of accession numbers, yield the accession number and their
        associated taxids as tuples

        |  |  |
        | --- | --- |
        | Parameters: | **acc\_number\_list** (`list`) – a list of accession numbers |
        | Yields: | *tuple* – (accession id, taxonomy id) |

# [taxadb](../index.html)

### Navigation

* [Installing Taxadb](install.html)
* [Create a database](download.html)
* [Testing Taxadb](tests.html)
* [Querying the database](query.html)
* [API Documentation](api.html)
  + accessionid API reference
  + [app API reference](app.html)
  + [parser API reference](parser.html)
  + [taxadb API reference](taxadb.html)
  + [taxaid API reference](taxid.html)
  + [schema API reference](schema.html)
  + [util API reference](util.html)

### Related Topics

* [Documentation overview](../index.html)
  + [API Documentation](api.html)
    - Previous: [API Documentation](api.html "previous chapter")
    - Next: [app API reference](app.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/accessionid.rst.txt)