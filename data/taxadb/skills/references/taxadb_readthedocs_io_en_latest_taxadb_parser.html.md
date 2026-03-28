# parser API reference[¶](#module-taxadb.parser "Permalink to this headline")

*class* `taxadb.parser.``Accession2TaxidParser`(*acc\_file=None*, *chunk=500*, *fast=False*, *\*\*kwargs*)[[source]](../_modules/taxadb/parser.html#Accession2TaxidParser)[¶](#taxadb.parser.Accession2TaxidParser "Permalink to this definition")
:   Main parser class for nucl\_xxx\_accession2taxid files

    This class is used to parse accession2taxid files.

    |  |  |
    | --- | --- |
    | Parameters: | * **acc\_file** (`str`) – File to parse * **chunk** (`int`) – Chunk insert size. Default 500 * **fast** (`bool`) – Directly load accession into database, do not check   existence. |

    `__init__`(*acc\_file=None*, *chunk=500*, *fast=False*, *\*\*kwargs*)[[source]](../_modules/taxadb/parser.html#Accession2TaxidParser.__init__)[¶](#taxadb.parser.Accession2TaxidParser.__init__ "Permalink to this definition")
    :   Base class

    `accession2taxid`(*acc2taxid=None*, *chunk=None*)[[source]](../_modules/taxadb/parser.html#Accession2TaxidParser.accession2taxid)[¶](#taxadb.parser.Accession2TaxidParser.accession2taxid "Permalink to this definition")
    :   Parses the accession2taxid files

        This method parses the accession2taxid file, build a dictionary,
        :   stores it in a list and yield for insertion in the database.

        ```
        {
            'accession': accession_id_from_file,
            'taxid': associated_taxonomic_id
        }
        ```

        |  |  |
        | --- | --- |
        | Parameters: | * **acc2taxid** (`str`) – Path to acc2taxid input file (gzipped) * **chunk** (`int`) – Chunk size of entries to gather before   yielding. Default 500 (set at object construction) |
        | Yields: | *list* – Chunk size of read entries |

    `set_accession_file`(*acc\_file*)[[source]](../_modules/taxadb/parser.html#Accession2TaxidParser.set_accession_file)[¶](#taxadb.parser.Accession2TaxidParser.set_accession_file "Permalink to this definition")
    :   Set the accession file to use

        |  |  |
        | --- | --- |
        | Parameters: | **acc\_file** (`str`) – File to be set |
        | Returns: | True |
        | Raises: | `SystemExit` – If acc\_file is None or not a file (check\_file) |

*class* `taxadb.parser.``TaxaDumpParser`(*nodes\_file=None*, *names\_file=None*, *\*\*kwargs*)[[source]](../_modules/taxadb/parser.html#TaxaDumpParser)[¶](#taxadb.parser.TaxaDumpParser "Permalink to this definition")
:   Main parser class for ncbi taxdump files

    This class is used to parse NCBI taxonomy files found in taxdump.gz archive

    |  |  |
    | --- | --- |
    | Parameters: | * **nodes\_file** (`str`) – Path to nodes.dmp file * **names\_file** (`str`) – Path to names.dmp file |

    `__init__`(*nodes\_file=None*, *names\_file=None*, *\*\*kwargs*)[[source]](../_modules/taxadb/parser.html#TaxaDumpParser.__init__)[¶](#taxadb.parser.TaxaDumpParser.__init__ "Permalink to this definition")

    `set_names_file`(*names\_file*)[[source]](../_modules/taxadb/parser.html#TaxaDumpParser.set_names_file)[¶](#taxadb.parser.TaxaDumpParser.set_names_file "Permalink to this definition")
    :   Set names\_file

        Set the accession file to use

        |  |  |
        | --- | --- |
        | Parameters: | **names\_file** (`str`) – Nodes file to be set |
        | Returns: | True |
        | Raises: | `SystemExit` – If names\_file is None or not a file (check\_file) |

    `set_nodes_file`(*nodes\_file*)[[source]](../_modules/taxadb/parser.html#TaxaDumpParser.set_nodes_file)[¶](#taxadb.parser.TaxaDumpParser.set_nodes_file "Permalink to this definition")
    :   Set nodes\_file

        Set the accession file to use

        |  |  |
        | --- | --- |
        | Parameters: | **nodes\_file** (`str`) – Nodes file to be set |
        | Returns: | True |
        | Raises: | `SystemExit` – If nodes\_file is None or not a file (check\_file) |

    `taxdump`(*nodes\_file=None*, *names\_file=None*)[[source]](../_modules/taxadb/parser.html#TaxaDumpParser.taxdump)[¶](#taxadb.parser.TaxaDumpParser.taxdump "Permalink to this definition")
    :   Parse .dmp files

        Parse nodes.dmp and names.dmp files (from taxdump.tgz) and insert
        :   taxons in Taxa table.

        |  |  |
        | --- | --- |
        | Parameters: | * **nodes\_file** (`str`) – Path to nodes.dmp file * **names\_file** (`str`) – Path to names.dmp file |
        | Returns: | Zipped data from both files |
        | Return type: | list |

*class* `taxadb.parser.``TaxaParser`(*verbose=False*)[[source]](../_modules/taxadb/parser.html#TaxaParser)[¶](#taxadb.parser.TaxaParser "Permalink to this definition")
:   Base parser class for taxonomic files

    `__init__`(*verbose=False*)[[source]](../_modules/taxadb/parser.html#TaxaParser.__init__)[¶](#taxadb.parser.TaxaParser.__init__ "Permalink to this definition")
    :   Base class

    `__weakref__`[¶](#taxadb.parser.TaxaParser.__weakref__ "Permalink to this definition")
    :   list of weak references to the object (if defined)

    *static* `cache_taxids`()[[source]](../_modules/taxadb/parser.html#TaxaParser.cache_taxids)[¶](#taxadb.parser.TaxaParser.cache_taxids "Permalink to this definition")
    :   Load data from taxa table into a dictionary

        |  |  |
        | --- | --- |
        | Returns: | Data from taxa table mapped as dictionary |
        | Return type: | data (`dict`) |

    *static* `check_file`(*element*)[[source]](../_modules/taxadb/parser.html#TaxaParser.check_file)[¶](#taxadb.parser.TaxaParser.check_file "Permalink to this definition")
    :   Make some check on a file

        This method is used to check an element is a real file.

        |  |  |
        | --- | --- |
        | Parameters: | **element** (`type`) – File to check |
        | Returns: | True |
        | Raises: | * `SystemExit` – if element file does not exist * `SystemExit` – if element is not a file |

# [taxadb](../index.html)

### Navigation

* [Installing Taxadb](install.html)
* [Create a database](download.html)
* [Testing Taxadb](tests.html)
* [Querying the database](query.html)
* [API Documentation](api.html)
  + [accessionid API reference](accessionid.html)
  + [app API reference](app.html)
  + parser API reference
  + [taxadb API reference](taxadb.html)
  + [taxaid API reference](taxid.html)
  + [schema API reference](schema.html)
  + [util API reference](util.html)

### Related Topics

* [Documentation overview](../index.html)
  + [API Documentation](api.html)
    - Previous: [app API reference](app.html "previous chapter")
    - Next: [taxadb API reference](taxadb.html "next chapter")

### Quick search

©2016-2018, Hadrien Gourle, Juliette Hayer, Emmanuel Quevillon.
|
Powered by [Sphinx 1.8.6](http://sphinx-doc.org/)
& [Alabaster 0.7.12](https://github.com/bitprophet/alabaster)
|
[Page source](../_sources/taxadb/parser.rst.txt)