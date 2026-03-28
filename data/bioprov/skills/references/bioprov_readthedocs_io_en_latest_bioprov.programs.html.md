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
      * bioprov.programs package
      * [bioprov.src package](bioprov.src.html)
      * [bioprov.tests package](bioprov.tests.html)
      * [bioprov.workflows package](bioprov.workflows.html)
    - [Submodules](bioprov.html#submodules)
    - [bioprov.bioprov module](bioprov.html#module-bioprov.bioprov)
    - [bioprov.utils module](bioprov.html#module-bioprov.utils)
    - [Module contents](bioprov.html#module-bioprov)

[BioProv](index.html)

* [Docs](index.html) »
* [bioprov](modules.html) »
* [bioprov package](bioprov.html) »
* bioprov.programs package
* [Edit on GitHub](https://github.com/vinisalazar/BioProv/blob/dev/docs/source/bioprov.programs.rst)

---

# bioprov.programs package[¶](#bioprov-programs-package "Permalink to this headline")

## Submodules[¶](#submodules "Permalink to this headline")

## bioprov.programs.programs module[¶](#module-bioprov.programs.programs "Permalink to this headline")

Module for holding preset instances of the Program class.

bioprov.programs.programs.blastn(*sample=None*, *db=None*, *query\_tag='query'*, *outformat=6*, *extra\_flags=None*)[¶](#bioprov.programs.programs.blastn "Permalink to this definition")
:   Parameters
    :   * **sample** ([*Sample*](bioprov.src.html#bioprov.src.main.Sample "bioprov.src.main.Sample")) – Instance of BioProv.Sample.
        * **db** (*str*) – A string pointing to the reference database directory and title.
        * **query\_tag** (*str*) – A tag for the query file.
        * **outformat** (*int*) – The output format to gather from blastn.
        * **extra\_flags** (*list*) – A list of extra parameters to pass to BLASTN.

    Returns
    :   Instance of PresetProgram for BLASTN.

    Return type
    :   BioProv.PresetProgram.

    Raises
    :   **AssertionError** – Path to the reference database does not exist.

bioprov.programs.programs.blastp(*sample*, *db*, *query\_tag='query'*, *outformat=6*, *extra\_flags=None*)[¶](#bioprov.programs.programs.blastp "Permalink to this definition")
:   Parameters
    :   * **sample** ([*Sample*](bioprov.src.html#bioprov.src.main.Sample "bioprov.src.main.Sample")) – Instance of BioProv.Sample.
        * **db** (*str*) – A string pointing to the reference database directory and title.
        * **query\_tag** (*str*) – A tag for the query file.
        * **outformat** (*int*) – The output format to gather from blastp.
        * **extra\_flags** (*list*) – A list of extra parameters to pass to BLASTP.

    Returns
    :   Instance of PresetProgram for BLASTP.

    Return type
    :   BioProv.PresetProgram.

    Raises
    :   **AssertionError** – Path to the reference database does not exist.

bioprov.programs.programs.diamond(*blast\_type*, *sample*, *db*, *query\_tag='query'*, *outformat=6*, *extra\_flags=None*)[¶](#bioprov.programs.programs.diamond "Permalink to this definition")
:   Parameters
    :   * **blast\_type** (*str*) – Which aligner to use (‘blastp’ or ‘blastx’).
        * **sample** ([*Sample*](bioprov.src.html#bioprov.src.main.Sample "bioprov.src.main.Sample")) – Instance of BioProv.Sample.
        * **db** (*str*) – A string pointing to the reference database path.
        * **query\_tag** (*str*) – A tag for the query file.
        * **outformat** (*int*) – The output format to gather from diamond (0, 5 or 6).
        * **extra\_flags** (*list*) – A list of extra parameters to pass to diamond
          (e.g. –sensitive or –log).

    Returns
    :   Instance of PresetProgram containing Diamond.

    Return type
    :   BioProv.PresetProgram.

bioprov.programs.programs.fasttree(*sample*, *input\_tag='input'*, *extra\_flags=None*)[¶](#bioprov.programs.programs.fasttree "Permalink to this definition")
:   Parameters
    :   * **sample** ([*Sample*](bioprov.src.html#bioprov.src.main.Sample "bioprov.src.main.Sample")) – Instance of BioProv.Sample.
        * **input\_tag** (*str*) – A tag for the input multifasta file.
        * **extra\_flags** (*list*) – A list of extra parameters to pass to FastTree.

    Returns
    :   Instance of PresetProgram containing FastTree.

    Return type
    :   BioProv.PresetProgram.

bioprov.programs.programs.kaiju(*\_sample*, *output\_path=None*, *kaijudb=''*, *nodes=''*, *threads=1*, *r1='R1'*, *r2='R2'*, *add\_param\_str=''*)[¶](#bioprov.programs.programs.kaiju "Permalink to this definition")
:   Run Kaiju on paired-end metagenomic data.

    Parameters
    :   * **\_sample** – An instance of BioProv sample.
        * **output\_path** – Output file of Kaiju.
        * **kaijudb** – Path to Kaiju database.
        * **nodes** – Nodes file to use with Kaiju.False
        * **threads** – Threads to use with Kaiju.
        * **r1** – Tag of forward reads.
        * **r2** – Tag of reverse reads.
        * **add\_param\_str** – Add any paremeters to Kaiju.

    Returns
    :   An instance of Program, containing Kaiju.

bioprov.programs.programs.kaiju2table(*\_sample*, *output\_path=None*, *rank='phylum'*, *nodes=''*, *names=''*, *kaiju\_output='kaiju\_output'*, *add\_param\_str=''*)[¶](#bioprov.programs.programs.kaiju2table "Permalink to this definition")
:   Run kaiju2table to create Kaiju reports.
    :param \_sample: An instance of BioProv sample.
    :param output\_path: Output file of kaiju2table.
    :param rank: Taxonomic rank to create report of.
    :param nodes: Nodes file to use with kaiju2table.
    :param names: Names file to use with kaiju2table.
    :param kaiju\_output: Tag of Kaiju output file.
    :param add\_param\_str: Parameter string to add.
    :return: Instance of Program containing kaiju2table.

bioprov.programs.programs.kallisto\_quant(*sample*, *index*, *output\_dir='./'*, *extra\_flags=None*)[¶](#bioprov.programs.programs.kallisto_quant "Permalink to this definition")
:   Run kallisto’s alignment and quantification

    Parameters
    :   * **sample** ([*Sample*](bioprov.src.html#bioprov.src.main.Sample "bioprov.src.main.Sample")) – Instance of BioProv.Sample.
        * **index** (*str*) – A path to a kallisto index file.
        * **output\_dir** (*str*) – A path to kallisto’s output directory.
        * **extra\_flags** (*list*) – A list of extra parameters to pass to kallisto
          (e.g. –single or –plaintext).

    Returns
    :   Instance of PresetProgram containing kallisto.

    Return type
    :   BioProv.PresetProgram.

bioprov.programs.programs.mafft(*sample*, *input\_tag='input'*, *extra\_flags=None*)[¶](#bioprov.programs.programs.mafft "Permalink to this definition")
:   Parameters
    :   * **sample** ([*Sample*](bioprov.src.html#bioprov.src.main.Sample "bioprov.src.main.Sample")) – Instance of BioProv.Sample.
        * **input\_tag** (*str*) – A tag for the input fasta file.
        * **extra\_flags** (*list*) – A list of extra parameters to pass to MAFFT.

    Returns
    :   Instance of PresetProgram containing MAFFT.

    Return type
    :   BioProv.PresetProgram.

bioprov.programs.programs.muscle(*sample*, *input\_tag='input'*, *msf=False*, *extra\_flags=None*)[¶](#bioprov.programs.programs.muscle "Permalink to this definition")
:   Parameters
    :   * **sample** ([*Sample*](bioprov.src.html#bioprov.src.main.Sample "bioprov.src.main.Sample")) – Instance of BioProv.Sample.
        * **input\_tag** (*str*) – A tag for the input multi-fasta file.
        * **msf** (*bool*) – Whether or not to have the output in msf format.
        * **extra\_flags** (*list*) – A list of extra parameters to pass to Muscle.

    Returns
    :   Instance of PresetProgram for Muscle.

    Return type
    :   BioProv.PresetProgram.

bioprov.programs.programs.prodigal(*sample=None*, *input\_tag='assembly'*, *extra\_flags=None*)[¶](#bioprov.programs.programs.prodigal "Permalink to this definition")
:   Parameters
    :   * **sample** – Instance of BioProv.Sample.
        * **input\_tag** – Instance of BioProv.Sample.
        * **extra\_flags** (*list*) – A list of extra parameters to pass to Prodigal.

    Returns
    :   Instance of PresetProgram containing Prodigal.

bioprov.programs.programs.prokka(*\_sample*, *output\_path=None*, *threads=1*, *add\_param\_str=''*, *assembly='assembly'*, *contigs='prokka\_contigs'*, *genes='prokka\_genes'*, *proteins='prokka\_proteins'*, *feature\_table='feature\_table'*, *submit\_contigs='submit\_contigs'*, *sequin='sequin'*, *genbank='genbank'*, *gff='gff'*, *log='prokka\_log'*, *stats='prokka\_stats'*)[¶](#bioprov.programs.programs.prokka "Permalink to this definition")
:   Parameters
    :   * **\_sample** – An instance of BioProv Sample.
        * **output\_path** – Output directory of Prokka.
        * **threads** – Threads to use for Prokka.
        * **add\_param\_str** – Any additional parameters to be passed to Prokka (in string format)

    The following params are the tags for each file, meaning that they are a string
    present in \_sample.files.keys().

    Parameters
    :   * **assembly** – Input assembly file.
        * **contigs** – Output contigs.
        * **genes** – Output genes.
        * **proteins** – Output proteins.
        * **feature\_table** – Output feature table.
        * **submit\_contigs** – Output contigs formatted for NCBI submission.
        * **sequin** – Output sequin file.
        * **genbank** – Output genbank .gbk file
        * **gff** – Output .gff file
        * **log** – Prokka log file.
        * **stats** – Prokka stats file.

    Returns
    :   An instance of Program, containing Prokka.

bioprov.programs.programs.prokka\_()[¶](#bioprov.programs.programs.prokka_ "Permalink to this definition")
:   Returns
    :   Instance of PresetProgram containing Prokka.

## Module contents[¶](#module-bioprov.programs "Permalink to this headline")

[Next](bioprov.src.html "bioprov.src package")
 [Previous](bioprov.data.html "bioprov.data package")

---

© Copyright 2020, Vini Salazar
Revision `d72a8c59`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).