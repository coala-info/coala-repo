[BioProv](index.html)

latest

Contents:

* [BioProv - W3C-PROV provenance documents for bioinformatics](readme.html)
* [Quickstart](readme.html#quickstart)
* [Installation](readme.html#installation)
* [Dependencies](readme.html#dependencies)
* [Source API](modules.html)
  + [bioprov package](bioprov.html)
    - [Subpackages](bioprov.html#subpackages)
      * [bioprov.data package](bioprov.data.html)
      * [bioprov.programs package](bioprov.programs.html)
      * [bioprov.src package](bioprov.src.html)
      * bioprov.tests package
      * [bioprov.workflows package](bioprov.workflows.html)
    - [Submodules](bioprov.html#submodules)
    - [bioprov.bioprov module](bioprov.html#module-bioprov.bioprov)
    - [bioprov.utils module](bioprov.html#module-bioprov.utils)
    - [Module contents](bioprov.html#module-bioprov)

[BioProv](index.html)

* [Docs](index.html) »
* [bioprov](modules.html) »
* [bioprov package](bioprov.html) »
* bioprov.tests package
* [Edit on GitHub](https://github.com/vinisalazar/BioProv/blob/dev/docs/source/bioprov.tests.rst)

---

# bioprov.tests package[¶](#bioprov-tests-package "Permalink to this headline")

## Submodules[¶](#submodules "Permalink to this headline")

## bioprov.tests.test\_bioprov\_imports module[¶](#module-bioprov.tests.test_bioprov_imports "Permalink to this headline")

Testing module for the package BioProv.

Tests include:
:   * Imports;
    * Class generation and methods.

bioprov.tests.test\_bioprov\_imports.test\_import\_bioprov()[¶](#bioprov.tests.test_bioprov_imports.test_import_bioprov "Permalink to this definition")
:   Test if the package can be imported correctly.
    :return: ImportError if not able to import.

bioprov.tests.test\_bioprov\_imports.test\_import\_classes\_and\_functions()[¶](#bioprov.tests.test_bioprov_imports.test_import_classes_and_functions "Permalink to this definition")
:   Test if all classes and functions can be imported correctly.
    :return: ImportError if not able to import

bioprov.tests.test\_bioprov\_imports.test\_import\_packages()[¶](#bioprov.tests.test_bioprov_imports.test_import_packages "Permalink to this definition")
:   Test if supplementary packages can be imported correctly.
    :return: ImportError if not able to import

## bioprov.tests.test\_bioprov\_integration module[¶](#module-bioprov.tests.test_bioprov_integration "Permalink to this headline")

Integration testing for drafting new ideas.

bioprov.tests.test\_bioprov\_integration.test\_CLI()[¶](#bioprov.tests.test_bioprov_integration.test_CLI "Permalink to this definition")

bioprov.tests.test\_bioprov\_integration.test\_integration(*debug=False*)[¶](#bioprov.tests.test_bioprov_integration.test_integration "Permalink to this definition")
:   Tests an example pipeline of running Prodigal.
    :return:

## bioprov.tests.test\_bioprov\_programs module[¶](#module-bioprov.tests.test_bioprov_programs "Permalink to this headline")

Testing for the programs package.

bioprov.tests.test\_bioprov\_programs.test\_blastn()[¶](#bioprov.tests.test_bioprov_programs.test_blastn "Permalink to this definition")

bioprov.tests.test\_bioprov\_programs.test\_blastp()[¶](#bioprov.tests.test_bioprov_programs.test_blastp "Permalink to this definition")

bioprov.tests.test\_bioprov\_programs.test\_diamond()[¶](#bioprov.tests.test_bioprov_programs.test_diamond "Permalink to this definition")

bioprov.tests.test\_bioprov\_programs.test\_fasttree()[¶](#bioprov.tests.test_bioprov_programs.test_fasttree "Permalink to this definition")

bioprov.tests.test\_bioprov\_programs.test\_kaiju()[¶](#bioprov.tests.test_bioprov_programs.test_kaiju "Permalink to this definition")
:   Testing the ‘kaiju’ program.
    :return:

bioprov.tests.test\_bioprov\_programs.test\_kaiju2table()[¶](#bioprov.tests.test_bioprov_programs.test_kaiju2table "Permalink to this definition")
:   Testing the ‘kaiju2table’ program
    :return:

bioprov.tests.test\_bioprov\_programs.test\_kallisto()[¶](#bioprov.tests.test_bioprov_programs.test_kallisto "Permalink to this definition")

bioprov.tests.test\_bioprov\_programs.test\_mafft()[¶](#bioprov.tests.test_bioprov_programs.test_mafft "Permalink to this definition")

bioprov.tests.test\_bioprov\_programs.test\_muscle()[¶](#bioprov.tests.test_bioprov_programs.test_muscle "Permalink to this definition")

bioprov.tests.test\_bioprov\_programs.test\_prodigal()[¶](#bioprov.tests.test_bioprov_programs.test_prodigal "Permalink to this definition")
:   Testing the ‘prodigal’ program.
    :return:

bioprov.tests.test\_bioprov\_programs.test\_prokka()[¶](#bioprov.tests.test_bioprov_programs.test_prokka "Permalink to this definition")
:   Testing the ‘prokka’ program.
    :return:

## bioprov.tests.test\_bioprov\_workflows module[¶](#module-bioprov.tests.test_bioprov_workflows "Permalink to this headline")

Testing for the workflows package.

bioprov.tests.test\_bioprov\_workflows.test\_blastn\_workflow()[¶](#bioprov.tests.test_bioprov_workflows.test_blastn_workflow "Permalink to this definition")

bioprov.tests.test\_bioprov\_workflows.test\_genome\_annotation()[¶](#bioprov.tests.test_bioprov_workflows.test_genome_annotation "Permalink to this definition")
:   Tests the ‘genome\_annotation’ workflow with the ‘prodigal’ step.
    :return:

bioprov.tests.test\_bioprov\_workflows.test\_kaiju\_workflow()[¶](#bioprov.tests.test_bioprov_workflows.test_kaiju_workflow "Permalink to this definition")
:   Tests the ‘kaiju’ workflow.
    :return:

## bioprov.tests.test\_src\_config module[¶](#module-bioprov.tests.test_src_config "Permalink to this headline")

Testing for the Config module.

bioprov.tests.test\_src\_config.test\_BioProvDB()[¶](#bioprov.tests.test_src_config.test_BioProvDB "Permalink to this definition")

bioprov.tests.test\_src\_config.test\_Config()[¶](#bioprov.tests.test_src_config.test_Config "Permalink to this definition")
:   Testing for the Config class
    :return:

## bioprov.tests.test\_src\_file module[¶](#module-bioprov.tests.test_src_file "Permalink to this headline")

Testing for the File module.

bioprov.tests.test\_src\_file.test\_File\_and\_Directory()[¶](#bioprov.tests.test_src_file.test_File_and_Directory "Permalink to this definition")
:   Tests objects in the File module:
    :   * existing File instance
        * non-existing File instance
        * get\_size(), convert\_bytes()

    Returns

bioprov.tests.test\_src\_file.test\_SeqFile()[¶](#bioprov.tests.test_src_file.test_SeqFile "Permalink to this definition")
:   Tests the SeqFile constructor.
    :return:

## bioprov.tests.test\_src\_main module[¶](#module-bioprov.tests.test_src_main "Permalink to this headline")

Testing for the bioprov.src.main module.
:   Tests the following classes:
    :   * Program
        * Parameter
        * Run
        * Sample
        * Project

    Also tests JSON and tab-delimited serializer methods.

bioprov.tests.test\_src\_main.create\_sample(*attributes\_*)[¶](#bioprov.tests.test_src_main.create_sample "Permalink to this definition")

bioprov.tests.test\_src\_main.test\_Parameter()[¶](#bioprov.tests.test_src_main.test_Parameter "Permalink to this definition")
:   Testing for the Parameter class.
    :return:

bioprov.tests.test\_src\_main.test\_Program()[¶](#bioprov.tests.test_src_main.test_Program "Permalink to this definition")
:   Testing for the Program class.
    :return:

bioprov.tests.test\_src\_main.test\_Project()[¶](#bioprov.tests.test_src_main.test_Project "Permalink to this definition")
:   Testing for the Project class.
    :return:

bioprov.tests.test\_src\_main.test\_Run()[¶](#bioprov.tests.test_src_main.test_Run "Permalink to this definition")
:   Testing for the Run class.
    :return:

bioprov.tests.test\_src\_main.test\_Sample()[¶](#bioprov.tests.test_src_main.test_Sample "Permalink to this definition")
:   Testing for the Sample class.
    :return:

bioprov.tests.test\_src\_main.test\_empty\_runs\_attr()[¶](#bioprov.tests.test_src_main.test_empty_runs_attr "Permalink to this definition")
:   Tests if, when runs is empty, dependent attributes return None

bioprov.tests.test\_src\_main.test\_from\_df()[¶](#bioprov.tests.test_src_main.test_from_df "Permalink to this definition")
:   Testing for the from and read\_csv functions.
    :return:

bioprov.tests.test\_src\_main.test\_generate\_param\_str()[¶](#bioprov.tests.test_src_main.test_generate_param_str "Permalink to this definition")
:   Testing for generate\_param\_str() function.
    :return:

bioprov.tests.test\_src\_main.test\_json\_Sample()[¶](#bioprov.tests.test_src_main.test_json_Sample "Permalink to this definition")
:   Testing for JSON methods for the Sample class.
    :return:

bioprov.tests.test\_src\_main.test\_parse\_params()[¶](#bioprov.tests.test_src_main.test_parse_params "Permalink to this definition")
:   Testing for the parse\_params() function.
    :return:

bioprov.tests.test\_src\_main.test\_preset\_extra\_flags()[¶](#bioprov.tests.test_src_main.test_preset_extra_flags "Permalink to this definition")

bioprov.tests.test\_src\_main.test\_project\_json\_and\_prov()[¶](#bioprov.tests.test_src_main.test_project_json_and_prov "Permalink to this definition")

## bioprov.tests.test\_src\_prov module[¶](#module-bioprov.tests.test_src_prov "Permalink to this headline")

Testing for prov module.
:   * BioProvDocument class

bioprov.tests.test\_src\_prov.test\_BioProvDocument()[¶](#bioprov.tests.test_src_prov.test_BioProvDocument "Permalink to this definition")
:   Tests the construction of an instance of BioProvDocument.
    :return:

bioprov.tests.test\_src\_prov.test\_EnvProv()[¶](#bioprov.tests.test_src_prov.test_EnvProv "Permalink to this definition")
:   Tests the construction of an instance of Environment.
    :return:

## Module contents[¶](#module-bioprov.tests "Permalink to this headline")

Init file for the tests/ package.

[Next](bioprov.workflows.html "bioprov.workflows package")
 [Previous](bioprov.src.html "bioprov.src package")

---

© Copyright 2020, Vini Salazar
Revision `d72a8c59`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).