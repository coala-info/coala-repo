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
      * [bioprov.tests package](bioprov.tests.html)
      * bioprov.workflows package
    - [Submodules](bioprov.html#submodules)
    - [bioprov.bioprov module](bioprov.html#module-bioprov.bioprov)
    - [bioprov.utils module](bioprov.html#module-bioprov.utils)
    - [Module contents](bioprov.html#module-bioprov)

[BioProv](index.html)

* [Docs](index.html) »
* [bioprov](modules.html) »
* [bioprov package](bioprov.html) »
* bioprov.workflows package
* [Edit on GitHub](https://github.com/vinisalazar/BioProv/blob/dev/docs/source/bioprov.workflows.rst)

---

# bioprov.workflows package[¶](#bioprov-workflows-package "Permalink to this headline")

## Submodules[¶](#submodules "Permalink to this headline")

## bioprov.workflows.blastn\_alignment module[¶](#module-bioprov.workflows.blastn_alignment "Permalink to this headline")

## bioprov.workflows.genome\_annotation module[¶](#module-bioprov.workflows.genome_annotation "Permalink to this headline")

## bioprov.workflows.KaijuWorkflow module[¶](#module-bioprov.workflows.KaijuWorkflow "Permalink to this headline")

Class holding the KaijuWorkflow main function and parser.

## bioprov.workflows.WorkflowOptionsParser module[¶](#module-bioprov.workflows.WorkflowOptionsParser "Permalink to this headline")

Class for parsing command-line options.

## Module contents[¶](#module-bioprov.workflows.workflows "Permalink to this headline")

Module containing preset workflows created with the Workflow class.

*class* bioprov.workflows.workflows.KaijuWorkflow[¶](#bioprov.workflows.workflows.KaijuWorkflow "Permalink to this definition")
:   Bases: `object`

    Class holding the KaijuWorkflow main function and parser.

    \_\_init\_\_()[¶](#bioprov.workflows.workflows.KaijuWorkflow.__init__ "Permalink to this definition")

    description *= 'Run Kaiju on metagenomic data and create reports for taxonomic ranks.'*[¶](#bioprov.workflows.workflows.KaijuWorkflow.description "Permalink to this definition")

    *static* main(*input\_file*, *output\_path=None*, *kaijudb=None*, *nodes=None*, *names=None*, *threads=1*, *\_tag=None*, *verbose=False*, *resume=True*, *kaiju\_params=''*, *kaiju2table\_params=''*)[¶](#bioprov.workflows.workflows.KaijuWorkflow.main "Permalink to this definition")
    :   Main function to run the Kaiju workflow.

        Parameters
        :   * **input\_file** – Input tab delimited file with the columns: ‘sample-id’, ‘R1’, ‘R2’
            * **output\_path** – Directory to create Kaiju output files.
            * **kaijudb** – Kaiju database file.
            * **nodes** – Kaiju nodes file.
            * **names** – Kaiju names file.
            * **threads** – Number of threads to use with Kaiju.
            * **\_tag** – Tag for Project.
            * **verbose** – Verbose output.
            * **resume** – Check for existing files and skip running Kaiju for them.
            * **kaiju\_params** – Parameter string to add to Kaiju command.
            * **kaiju2table\_params** – Parameter string to add to kaiju2table command.

        Returns

    *classmethod* parser()[¶](#bioprov.workflows.workflows.KaijuWorkflow.parser "Permalink to this definition")
    :   Parser for the Kaiju workflow.
        :return: instance of argparse.ArgumentParser.

*class* bioprov.workflows.workflows.WorkflowOptionsParser[¶](#bioprov.workflows.workflows.WorkflowOptionsParser "Permalink to this definition")
:   Bases: `object`

    Class for parsing command-line options.

    \_\_init\_\_()[¶](#bioprov.workflows.workflows.WorkflowOptionsParser.__init__ "Permalink to this definition")

    parse\_options(*options*)[¶](#bioprov.workflows.workflows.WorkflowOptionsParser.parse_options "Permalink to this definition")
    :   Parses options and returns correct workflow.
        :type options: argparse.Namespace
        :param options: arguments passed by the parser.
        :return: Runs the specified subparser in options.subparser\_name.

bioprov.workflows.workflows.blastn\_alignment(*\*\*kwargs*)[¶](#bioprov.workflows.workflows.blastn_alignment "Permalink to this definition")

bioprov.workflows.workflows.genome\_annotation(*\*\*kwargs*)[¶](#bioprov.workflows.workflows.genome_annotation "Permalink to this definition")

[Previous](bioprov.tests.html "bioprov.tests package")

---

© Copyright 2020, Vini Salazar
Revision `d72a8c59`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).