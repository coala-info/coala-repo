[Probabilistic 20/20](index.html)

latest

* [Download](download.html)
* [Installation](installation.html)
* Quick Start
  + [Installation](#installation)
  + [Downloading Example](#downloading-example)
  + [Input files](#input-files)
    - [Gene BED annotation](#gene-bed-annotation)
    - [Gene FASTA](#gene-fasta)
    - [Mutation Annotation Format (MAF) file](#mutation-annotation-format-maf-file)
  + [Running the Example](#running-the-example)
* [Tutorial](tutorial.html)
* [FAQ](faq.html)

[Probabilistic 20/20](index.html)

* [Docs](index.html) »
* Quick Start
* [Edit on GitHub](https://github.com/KarchinLab/probabilistic2020/blob/master/doc/quickstart.rst)

---

# Quick Start[¶](#quick-start "Permalink to this headline")

The quick start is meant to test that everything is working with the installation
of the probabilistic2020 package.
This provides running probabilistic2020 with
the minimum number of steps to execute the statistical test.
For more expansive user instructions see [Tutorial](tutorial.html#tutorial-ref).

## Installation[¶](#installation "Permalink to this headline")

Please see the [Installation](installation.html#install-ref).

## Downloading Example[¶](#downloading-example "Permalink to this headline")

Download the quick start example data, and extract the resulting tarball.

```
$ wget http://karchinlab.org/data/2020+/pancreatic_example.tar.gz
$ tar xvzf pancreatic_example.tar.gz
$ cd pancreatic_example
```

## Input files[¶](#input-files "Permalink to this headline")

### Gene BED annotation[¶](#gene-bed-annotation "Permalink to this headline")

BED gene annotation files should contain a single reference transcript per gene.
The name field in the BED file should contain the gene name (not the transcript).
An example BED file containg the annotations for the largest transcripts in SNVBox
is named snvboxGenes.bed.

### Gene FASTA[¶](#gene-fasta "Permalink to this headline")

Gene sequences are extracted from a genome FASTA file, and is a step that only needs to be done once. This has already been done for the example BED file provided, but if you were to use a different transcript annotation then you would need to follow the [Gene FASTA](tutorial.html#make-fasta).

### Mutation Annotation Format (MAF) file[¶](#mutation-annotation-format-maf-file "Permalink to this headline")

Mutations are saved in a MAF-like format. Not All fields in MAF spec are required,
and columns may be in any order. Mutations for pancreatic adenocarcinoma are in the
file pancreatic\_adenocarcinoma.txt.

## Running the Example[¶](#running-the-example "Permalink to this headline")

To execute the statistical test for TSG-like genes by examining elevated proportion
of inactivating mutations, the **tsg** sub-command for **probabilistic2020** is used.
To limit the run time for this example, you can limit the number of iterations to
10,000 with the **-n** parameter. You can further speed up the example by using multiple computer cores with the **-p** parameter.

```
$ probabilistic2020 tsg \
    -n 10000 \
    -i snvboxGenes.fa \
    -b snvboxGenes.bed \
    -m pancreatic_adenocarcinoma.txt \
    -o pancreatic_output_comparison.txt
```

Your results should match those found in the file pancreatic\_output.txt. Particularly, TP53, SMAD4, ARID1A, and SMARCA4 should have a significant inactivating Benjamini-Hochberg (BH) q-value of less than .1.

[Next](tutorial.html "Tutorial")
 [Previous](installation.html "Installation")

---

© Copyright 2014-19, Collin Tokheim
Revision `8e0b1b95`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).