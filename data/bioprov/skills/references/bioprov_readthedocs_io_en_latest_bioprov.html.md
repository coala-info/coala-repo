[BioProv](index.html)

latest

Contents:

* [BioProv - W3C-PROV provenance documents for bioinformatics](readme.html)
* [Quickstart](readme.html#quickstart)
* [Installation](readme.html#installation)
* [Dependencies](readme.html#dependencies)
* [Source API](modules.html)
  + bioprov package
    - [Subpackages](#subpackages)
      * [bioprov.data package](bioprov.data.html)
      * [bioprov.programs package](bioprov.programs.html)
      * [bioprov.src package](bioprov.src.html)
      * [bioprov.tests package](bioprov.tests.html)
      * [bioprov.workflows package](bioprov.workflows.html)
    - [Submodules](#submodules)
    - [bioprov.bioprov module](#module-bioprov.bioprov)
    - [bioprov.utils module](#module-bioprov.utils)
    - [Module contents](#module-bioprov)

[BioProv](index.html)

* [Docs](index.html) »
* [bioprov](modules.html) »
* bioprov package
* [Edit on GitHub](https://github.com/vinisalazar/BioProv/blob/dev/docs/source/bioprov.rst)

---

# bioprov package[¶](#bioprov-package "Permalink to this headline")

## Subpackages[¶](#subpackages "Permalink to this headline")

* [bioprov.data package](bioprov.data.html)
  + [Module contents](bioprov.data.html#module-bioprov.data)
* [bioprov.programs package](bioprov.programs.html)
  + [Submodules](bioprov.programs.html#submodules)
  + [bioprov.programs.programs module](bioprov.programs.html#module-bioprov.programs.programs)
  + [Module contents](bioprov.programs.html#module-bioprov.programs)
* [bioprov.src package](bioprov.src.html)
  + [Submodules](bioprov.src.html#submodules)
  + [bioprov.src.config module](bioprov.src.html#module-bioprov.src.config)
  + [bioprov.src.files module](bioprov.src.html#module-bioprov.src.files)
  + [bioprov.src.main module](bioprov.src.html#module-bioprov.src.main)
  + [bioprov.src.prov module](bioprov.src.html#module-bioprov.src.prov)
  + [bioprov.src.workflow module](bioprov.src.html#module-bioprov.src.workflow)
  + [Module contents](bioprov.src.html#module-bioprov.src)
* [bioprov.tests package](bioprov.tests.html)
  + [Submodules](bioprov.tests.html#submodules)
  + [bioprov.tests.test\_bioprov\_imports module](bioprov.tests.html#module-bioprov.tests.test_bioprov_imports)
  + [bioprov.tests.test\_bioprov\_integration module](bioprov.tests.html#module-bioprov.tests.test_bioprov_integration)
  + [bioprov.tests.test\_bioprov\_programs module](bioprov.tests.html#module-bioprov.tests.test_bioprov_programs)
  + [bioprov.tests.test\_bioprov\_workflows module](bioprov.tests.html#module-bioprov.tests.test_bioprov_workflows)
  + [bioprov.tests.test\_src\_config module](bioprov.tests.html#module-bioprov.tests.test_src_config)
  + [bioprov.tests.test\_src\_file module](bioprov.tests.html#module-bioprov.tests.test_src_file)
  + [bioprov.tests.test\_src\_main module](bioprov.tests.html#module-bioprov.tests.test_src_main)
  + [bioprov.tests.test\_src\_prov module](bioprov.tests.html#module-bioprov.tests.test_src_prov)
  + [Module contents](bioprov.tests.html#module-bioprov.tests)
* [bioprov.workflows package](bioprov.workflows.html)
  + [Submodules](bioprov.workflows.html#submodules)
  + [bioprov.workflows.blastn\_alignment module](bioprov.workflows.html#module-bioprov.workflows.blastn_alignment)
  + [bioprov.workflows.genome\_annotation module](bioprov.workflows.html#module-bioprov.workflows.genome_annotation)
  + [bioprov.workflows.KaijuWorkflow module](bioprov.workflows.html#module-bioprov.workflows.KaijuWorkflow)
  + [bioprov.workflows.WorkflowOptionsParser module](bioprov.workflows.html#module-bioprov.workflows.WorkflowOptionsParser)
  + [Module contents](bioprov.workflows.html#module-bioprov.workflows.workflows)

## Submodules[¶](#submodules "Permalink to this headline")

## bioprov.bioprov module[¶](#module-bioprov.bioprov "Permalink to this headline")

BioProv command-line application. This module holds the main executable.

*class* bioprov.bioprov.CommandOptionsParser[¶](#bioprov.bioprov.CommandOptionsParser "Permalink to this definition")
:   Bases: `object`

    \_\_init\_\_()[¶](#bioprov.bioprov.CommandOptionsParser.__init__ "Permalink to this definition")

    *classmethod* clear\_db()[¶](#bioprov.bioprov.CommandOptionsParser.clear_db "Permalink to this definition")

    *classmethod* create\_provstore()[¶](#bioprov.bioprov.CommandOptionsParser.create_provstore "Permalink to this definition")

    *classmethod* list()[¶](#bioprov.bioprov.CommandOptionsParser.list "Permalink to this definition")

    *classmethod* show\_config()[¶](#bioprov.bioprov.CommandOptionsParser.show_config "Permalink to this definition")

    *classmethod* show\_db()[¶](#bioprov.bioprov.CommandOptionsParser.show_db "Permalink to this definition")

    *classmethod* show\_provstore()[¶](#bioprov.bioprov.CommandOptionsParser.show_provstore "Permalink to this definition")

    *classmethod* version()[¶](#bioprov.bioprov.CommandOptionsParser.version "Permalink to this definition")

bioprov.bioprov.main(*args=None*)[¶](#bioprov.bioprov.main "Permalink to this definition")
:   Main function to run the BioProv command-line application.
    Calls the subparsers defined in the Workflows module.

    Parameters
    :   **args** – args to call the function with. Usually is None and
        args are automatically extracted from the command line.
        Passing args is used for testing only.

## bioprov.utils module[¶](#module-bioprov.utils "Permalink to this headline")

Helper functions.

*class* bioprov.utils.Warnings[¶](#bioprov.utils.Warnings "Permalink to this definition")
:   Bases: `object`

    Class to handle warnings.

    \_\_init\_\_()[¶](#bioprov.utils.Warnings.__init__ "Permalink to this definition")

bioprov.utils.assert\_tax\_rank(*tax\_rank*)[¶](#bioprov.utils.assert_tax_rank "Permalink to this definition")
:   Tests if a string is a valid taxonomic rank.
    :param tax\_rank: String to be evaluated.
    :return: True or False.

bioprov.utils.build\_prov\_attributes(*dictionary*, *namespace*)[¶](#bioprov.utils.build_prov_attributes "Permalink to this definition")
:   Inserting attributes into a Provenance object can be tricky. We need a NameSpace for said object,
    and attributes must be named correctly. This helper function builds a dictionary of attributes
    properly formatted to be inserted into a namespace.

    Parameters
    :   * **dictionary** – dict with object attributes.
        * **namespace** – instance of Namespace.

    Returns
    :   List of tuples (QualifiedName, value)

bioprov.utils.convert\_bytes(*num*)[¶](#bioprov.utils.convert_bytes "Permalink to this definition")
:   Helper function to convert bytes into KB, MB, etc.
    From <https://stackoverflow.com/questions/2104080/how-can-i-check-file-size-in-python>

    Parameters
    :   **num** – Number of bytes.

bioprov.utils.create\_logger(*log\_level=20*, *log\_file=None*, *tag=None*)[¶](#bioprov.utils.create_logger "Permalink to this definition")

bioprov.utils.dict\_to\_sha256(*dictionary*)[¶](#bioprov.utils.dict_to_sha256 "Permalink to this definition")
:   Get sha256 hexdigest from a dictionary
    :param dictionary: dict
    :return: hexdigest

bioprov.utils.dict\_to\_string(*dictionary*)[¶](#bioprov.utils.dict_to_string "Permalink to this definition")
:   Converts a dictionary to string for pretty printing
    :param dictionary: dict
    :return: str

bioprov.utils.file\_to\_sha256(*path*)[¶](#bioprov.utils.file_to_sha256 "Permalink to this definition")
:   Get the sha256 of file. Returns None if it does not exist.
    :param path: A valid file path.
    :return: sha256 digest or None.

bioprov.utils.get\_size(*path*, *convert=True*)[¶](#bioprov.utils.get_size "Permalink to this definition")
:   Calculate size of a given file.
    :param path: Valid \_path of a file.
    :param convert: Whether to convert the values to bytes, KB, etc.
    :return: Size with converted values. 0 if file does not exist.

bioprov.utils.has\_serializer(*object\_*)[¶](#bioprov.utils.has_serializer "Permalink to this definition")

bioprov.utils.is\_serializable\_type(*type\_*)[¶](#bioprov.utils.is_serializable_type "Permalink to this definition")

bioprov.utils.parser\_help(*parser*)[¶](#bioprov.utils.parser_help "Permalink to this definition")
:   Shows help if no arguments are passed for parser.
    :param parser: An instance of argparse.ArgumentParser
    :return:

bioprov.utils.pattern\_replacer(*pattern*, *iterable\_of\_olds*, *new*)[¶](#bioprov.utils.pattern_replacer "Permalink to this definition")
:   Replaces a list of old terms from a given pattern for a new term.

    Used for switching file paths in the ‘bioprov.src.main.from\_json’ module.

    Parameters
    :   * **pattern** – pattern to replace.
        * **iterable\_of\_olds** – old terms.
        * **new** – new term.

    Returns

bioprov.utils.serializer(*object\_*)[¶](#bioprov.utils.serializer "Permalink to this definition")
:   Helper function to serialize objects into JSON compatible dictionaries.
    :param [object\_](#id1): A BioProv class instance.
    :return: JSON compatible dictionary.

bioprov.utils.serializer\_filter(*\_object*, *keys*)[¶](#bioprov.utils.serializer_filter "Permalink to this definition")
:   Filters keys from \_object.\_\_dict\_\_ to make custom serializers.

    Parameters
    :   * **\_object** – A bioprov object
        * **keys** – keys to be filtered.

    Returns
    :   dict

## Module contents[¶](#module-bioprov "Permalink to this headline")

Init module for package bioprov.

Inherits objects from the src/ package.

[Next](bioprov.data.html "bioprov.data package")
 [Previous](modules.html "bioprov")

---

© Copyright 2020, Vini Salazar
Revision `d72a8c59`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).