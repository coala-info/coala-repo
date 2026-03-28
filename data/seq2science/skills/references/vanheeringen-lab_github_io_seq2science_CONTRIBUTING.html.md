[seq2science](index.html)

* [Getting started](content/gettingstarted.html)
* [Workflows](content/workflows.html)
* [Using the results](content/results.html)
* [Extensive docs](content/extensive_docs.html)
* [Extra resources](content/extracontent.html)
* [Frequently Asked Questions (FAQ)](content/faq.html)
* Contributing to seq2science
  + [I don’t want to read this whole thing i just have a question](#i-don-t-want-to-read-this-whole-thing-i-just-have-a-question)
    - [Reporting bugs](#reporting-bugs)
  + [Code/documentation](#code-documentation)
    - [Gitflow](#gitflow)
  + [Project design](#project-design)
    - [Documentation](#documentation)
    - [tests](#tests)
    - [source code](#source-code)
      * [envs](#envs)
      * [imgs](#imgs)
      * [rules](#rules)
      * [schemas](#schemas)
      * [scripts](#scripts)
      * [workflows](#workflows)
      * [util.py](#util-py)
      * [important global variables](#important-global-variables)
      * [Global wildcard constraints](#global-wildcard-constraints)
    - [Example PR](#example-pr)

[seq2science](index.html)

* Contributing to seq2science
* [Edit on GitHub](https://github.com/vanheeringen-lab/seq2science/blob/master/docs/CONTRIBUTING.md)

---

# Contributing to seq2science[](#contributing-to-seq2science "Link to this heading")

**Thanks for taking the time to contribute!!**

The following is a set of guidelines and hints how to get started with contributing to seq2science.

## I don’t want to read this whole thing i just have a question[](#i-don-t-want-to-read-this-whole-thing-i-just-have-a-question "Link to this heading")

Questions can be asked on the [github issues page](https://github.com/vanheeringen-lab/seq2science/issues).
Make sure to check if the question has been asked before in old issues and check the [Frequently Asked Section (FAQ)](content/faq.html) in the docs if it’s there.

### Reporting bugs[](#reporting-bugs "Link to this heading")

Bug reports can be made by making an issue on the [github issues page](https://github.com/vanheeringen-lab/seq2science/issues).

## Code/documentation[](#code-documentation "Link to this heading")

Outside of bugs/docs fixes, before you make a code contribution make sure to check in with us (the developers) if we are willing to support the contribution by making an issue first.

For an example on how to add to the documentation, see the example PR [below](#example-pr).

### Gitflow[](#gitflow "Link to this heading")

We (try to) use the [gitflow](https://nvie.com/posts/a-successful-git-branching-model/) model to organise our parallel development.
When making a PR, make sure to start from the develop branch and make a PR to develop branch.

## Project design[](#project-design "Link to this heading")

Seq2science has grown to be a rather large project, with a complicated code structure.
Before contributing to seq2science it is important to be up-to-date with the file and logic structure.

### Documentation[](#documentation "Link to this heading")

The documentation can always be improved, and contributions are highly appreciated!
Apart from the auto-generated part of the docs, all the stuff relevant to the documentation is in the `docs` folder in the root.
The markdown files that make up the documentation are in `docs/content`.

### tests[](#tests "Link to this heading")

Seq2science runs tests on a Jenkins server after each push.
Everything related to the tests can be found in the `tests` folder in the root.

### source code[](#source-code "Link to this heading")

The “source code” is split across multiple folders in the `seq2science` folder.

#### envs[](#envs "Link to this heading")

In the `seq2science/envs` folder all the environments for each rule is stored.
When adding new rules make sure to add a new environment here.

#### imgs[](#imgs "Link to this heading")

These images are being shipped with seq2science.
At the time of writing the only image that is in this folder is a Radboud University logo that is added to the MultiQC report.

#### rules[](#rules "Link to this heading")

In `seq2science/rules` is where the magic happens.
Practically all rules and logic is in this folder. Rules are split across ‘logical’ topics, such as alignment, peak calling or downloading.
A workflow can thus easily include a couple of these files and link different topics.

All the files that start with `configuration_` actually do not contain any rules.
These files are used to parse the samples.tsv and config.yaml.
These files are unfortunately pretty complex, but any time something big is changed, you probably have to change some stuff here.

#### schemas[](#schemas "Link to this heading")

This folder contains multple schemas.
It contains schemas to parse and extend the `config.yaml` at the start of the run, but it also contains e.g. the schema for the MultiQC report.

#### scripts[](#scripts "Link to this heading")

`seq2science/scripts` contains all the scripts that rules use to.

#### workflows[](#workflows "Link to this heading")

In `seq2science/workflows` are the different workflows.
Each workflow consists of a Snakefile, which defines what the total output is, which schemas are needed, and which rules.
In this folder is also an example samples.tsv and config.yaml, which is copied when using `seq2science init`.

#### util.py[](#util-py "Link to this heading")

Useful utility functions are deposited in this file.

#### important global variables[](#important-global-variables "Link to this heading")

Global variables are variables that can be read from anywhere in the workflow.
Both Snakemake and Seq2science uses global variables to keep track of steps and samples.
Most global variables are declared in UPPER\_CASE in `seq2science/rules/configuration_generic.smk`.

* **config** is a dictionary with all the configuration stuff.
  Everything that you write in the config.yaml is in here.
  The config is parsed by the schemas (specified by the Snakefile) in `seq2science/schemas`, and in `seq2science/rules/configuration_`.
* **samples** is the samples.tsv as a pandas dataframe, after parsing done in `seq2science/rules/configuration_`.
  Unused columns are removed, and used columns with empty spaces are filled.

  + **ALL\_SAMPLES** is a list with all sample names from samples.
* **SAMPLEDICT** is a dictionary containing information per sample that is not present in the samples.tsv file.
  In here is stored whether samples are SINGLE-end or PAIRED-end, and their corresponding SRR numbers.
  There are several sub-dictionaries of SAMPLEDICT:

  + **ENA\_SINGLE\_END**, **ENA\_PAIRED\_END**, **SRA\_SINGLE\_END**, **SRA\_PAIRED\_END** contain subsets of the samples,
  + **RUN2DOWNLOAD** contains the download link per sample run.
* **breps** & **treps**, are dataframes with the technical and biological replicates merged (respectively).
  If you want to iterate over either of the technical replicates or biological replicates, or check what a sample belongs to, it is probably easiest to use these.
  There are several accompanying globals:

  + **MERGED\_TREPS** is a list with technical replicates that contain >1 sample (will be merged during the workflow).
  + **TREPS\_FROM\_BREP** and **BREP\_FROM\_TREPS** are dictionaries that track which replicate contains which sub-replicates.
* **ALL\_ASSEMBLIES** is a list of assemblies used in the workflow.

  + **PROVIDERS** is a dictionary to keep track which assembly can be downloaded where.
  + **HAS\_ANNOTATION** is a dictionary to keep track if an assembly has a gene annotation (or has one available for download)
  + **CUSTOM\_ASSEMBLIES** is a dictionary to convert assembly names to custom assembly names, if you use custom assemblies.
  + **ORI\_ASSEMBLIES** is a dictionary to convert custom assembly names to assembly names, if you use custom assemblies.
  + **UCSC\_ASSEMBLIES** is a dictionary that denotes whether an assembly is already available on the UCSC trackhubs.
* **WORKFLOW** is a string with the current workflow, as spelled in `seq2science/workflows` (e.g. “chip\_seq”).
* **FINAL\_BAM** is a variable path to the (filtered and) coordinate sorted bam files with wildcards `{assembly}` and `{sample}`.

  + **FINAL\_BAI** is the variable path to the matching bam index.
    We often use this to apply workflow-specific logic.
* **SEQUENCING\_PROTOCOL** contains the current workflow, spelled out properly (e.g. “ChIP-seq”).

#### Global wildcard constraints[](#global-wildcard-constraints "Link to this heading")

Seq2science sets global wildcard constraints in `seq2science/rules/configuration_generic.smk`.
As wildcards are essentially greedy regex (`.*`), these constraints make sure we adhere to the naming convention of samples and assembly.

For example, one default wildcard constraint in seq2science is that the wildcard `{replicate}` can only match with
the `technical_replicates` column of the samples.tsv.

### Example PR[](#example-pr "Link to this heading")

If something in the documentation is wrong or unclear, please feel free to change it, no matter how small.
Veteran FOSS (Free and Open Source Software) contributors already know how the process of suggesting changes to a project work (called a PR/Pull Request).
However for people new to FOSS this relatively easy process can be a daunting task.
Here we give an example of how to make changes to the documentation and propose them to us (the maintainers).

1. Make a github account
2. Make a “fork” of the repository

   [![fork](_images/fork.jpg)](resources/fork.jpg)
3. Now navigate on your “fork” to the documentation you want to change, for instance you could go to`docs/content/FAQ.md` to add a new question (and answer!).
4. make some changes

   [![fork](_images/edit.jpg)](resources/edit.jpg)
5. “commit” your changes to the `master` branch`.
6. Make a Pull Request (PR).

   * [![fork](_images/PR1.jpg)](resources/PR1.jpg)
   * [![fork](_images/PR2.jpg)](resources/PR2.jpg)
   * [![fork](_images/PR3.jpg)](resources/PR3.jpg)
   * [![fork](_images/PR4.jpg)](resources/PR4.jpg)
7. Wait for us to accept it…
8. See the changed docs online!

[Previous](content/faq.html "Frequently Asked Questions (FAQ)")

---

© Copyright Maarten van der Sande, Siebren Frölich, Jos Smits, Rebecca Snabel, Tilman Schäfers, & Simon van Heeringen..

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).