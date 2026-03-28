[haptools](../index.html)

Overview

* [Installation](installation.html)
* Example files
  + [Locating the files](#locating-the-files)
  + [Running an example command](#running-an-example-command)
  + [Running all examples](#running-all-examples)
* [Contributing](contributing.html)

File Formats

* [Genotypes](../formats/genotypes.html)
* [Haplotypes](../formats/haplotypes.html)
* [Phenotypes and Covariates](../formats/phenotypes.html)
* [Linkage disequilibrium](../formats/ld.html)
* [Summary Statistics](../formats/linear.html)
* [Causal SNPs](../formats/snplist.html)
* [Breakpoints](../formats/breakpoints.html)
* [Sample Info](../formats/sample_info.html)
* [Models](../formats/models.html)
* [Maps](../formats/maps.html)

Commands

* [simgenotype](../commands/simgenotype.html)
* [simphenotype](../commands/simphenotype.html)
* [karyogram](../commands/karyogram.html)
* [transform](../commands/transform.html)
* [index](../commands/index.html)
* [clump](../commands/clump.html)
* [ld](../commands/ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* Example files
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/project_info/example_files.rst)

---

# Example files[](#example-files "Link to this heading")

## Locating the files[](#locating-the-files "Link to this heading")

The examples throughout our documentation make use of two sets of files: test files and example files.

Test files can be found in the [tests/data/ directory](https://github.com/CAST-genomics/haptools/tree/main/tests/data) of our Github repository. These are short, simplified files used exclusively by our automated test suite.

Example files can be found in the [example-files/ directory](https://github.com/CAST-genomics/haptools/tree/main/example-files) of our Github repository. Unlike test files, we expect example files to be useful in your own commands. For example, if you use simgenotype with the 1000 Genomes dataset, you can use our [1000G sample\_info file](https://github.com/cast-genomics/haptools/blob/main/example-files/1000genomes_sampleinfo.tsv). We have also included a set of [model files](https://github.com/cast-genomics/haptools/blob/main/example-files/models) that you can use to create pre-configured admixed populations.

## Running an example command[](#running-an-example-command "Link to this heading")

To run any of the example code or commands in our documentation, follow these steps.

1. [Install haptools](installation.html)
2. Clone our Github repository

   > ```
   > git clone -b v$(haptools --version) https://github.com/CAST-genomics/haptools.git
   > ```
3. Change to the cloned directory

   > ```
   > cd haptools
   > ```
4. Execute the example command

## Running all examples[](#running-all-examples "Link to this heading")

All of our examples are included within our test suite, which is executed regularly by our continuous integration system. To check that all of the examples work on your system, you can just have `pytest` automatically run all of our tests.

1. Follow the [first three steps above](#running-an-example-command)
2. Install `pytest`

   > ```
   > pip install 'pytest>=6.2.5'
   > ```
3. Run our tests

   > ```
   > pytest tests/
   > ```

[Previous](installation.html "Installation")
[Next](contributing.html "Contributing")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).