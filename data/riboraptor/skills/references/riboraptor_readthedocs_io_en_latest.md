### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index") |
* [next](installation.html "Installation") |
* riboraptor 0.2.2 documentation »

## Contents

* [Installation](installation.html)
* [Example Workflow](example_workflow.html)
* [Manual](cmd-manual.html)
* [API Usage](api-usage.html)
* [Scores](scores.html)
* [riboraptor](modules.html)
* [History](history.html)
* [Contributing](contributing.html)
* [Credits](authors.html)

#### Next topic

[Installation](installation.html "next chapter")

### This Page

* [Show Source](_sources/index.rst.txt)

1. Docs
2. Welcome to riboraptor’s documentation!

# Welcome to riboraptor’s documentation![¶](#welcome-to-riboraptor-s-documentation "Permalink to this headline")

`riboraptor` library is a Python library for analysis of Ribo-seq data.
It assumes the reads have already been aligned to a reference and are available as BAM/SAM for input.

Current capabilities of `riboraptor` include:

|  |  |
| --- | --- |
| Visualization: | * Plot read length distribution * Plot metagene coverage |
| Utilities: | * Export all gene coverages * Export metagene coverage * Export read length distribution * Calculate periodicity |

```
$ Usage: riboraptor [OPTIONS] COMMAND [ARGS]...

  riboraptor: Tool for ribosome profiling analysis

 Options:
    --version  Show the version and exit.
    --help     Show this message and exit.

 Commands:
    bam-to-bedgraph              Convert bam to bedgraph
    bedgraph-to-bigwig           Convert bedgraph to bigwig
    export-bed-fasta             Export gene level fasta from specified bed
    export-gene-coverages        Export gene level coverage for all genes for given region
    export-metagene-coverage     Export metagene coverage for given region
    export-read-length           Calculate read length distribution
    periodicity                  Calculate periodicity
    plot-metagene                Plot metagene profile
    plot-read-length             Plot read length distribution
    uniq-bam                     Create a new bam with unique mapping reads only
    uniq-mapping-count           Count number of unique mapping reads
```

Contents:

* [Installation](installation.html)
  + [Stable release](installation.html#stable-release)
  + [From sources](installation.html#from-sources)
* [Example Workflow](example_workflow.html)
  + [Step 1: Downloading datasets](example_workflow.html#step-1-downloading-datasets)
  + [Step 2: Copy template](example_workflow.html#step-2-copy-template)
  + [Step 3 : Change your miniconda path](example_workflow.html#step-3-change-your-miniconda-path)
  + [Step 4: Edit snakemake/cluster.yaml](example_workflow.html#step-4-edit-snakemake-cluster-yaml)
  + [Step 5: Submit job](example_workflow.html#step-5-submit-job)
  + [Visualizing Results](example_workflow.html#visualizing-results)
* [Manual](cmd-manual.html)
  + [Contents](cmd-manual.html#contents)
  + [Assumptions](cmd-manual.html#assumptions)
  + [Translatome construction](cmd-manual.html#translatome-construction)
  + [Translatome analysis](cmd-manual.html#translatome-analysis)
  + [Example](cmd-manual.html#example)
* [API Usage](api-usage.html)
  + [Counting Fragment Lengths](api-usage.html#counting-fragment-lengths)
  + [Gene Coverage](api-usage.html#gene-coverage)
* [Scores](scores.html)
* [riboraptor](modules.html)
  + [riboraptor package](riboraptor.html)
* [History](history.html)
  + [0.2.0 (04-23-2018)](history.html#id1)
* [Contributing](contributing.html)
  + [Types of Contributions](contributing.html#types-of-contributions)
  + [Get Started!](contributing.html#get-started)
  + [Pull Request Guidelines](contributing.html#pull-request-guidelines)
  + [Tips](contributing.html#tips)
* [Credits](authors.html)
  + [Development Lead](authors.html#development-lead)
  + [Contributors](authors.html#contributors)

---

# Site map[¶](#site-map "Permalink to this headline")

> * [Index](genindex.html)
> * [Module Index](py-modindex.html)
> * [Search Page](search.html)

[Installation](installation.html "next chapter (use the right arrow)")

### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index") |
* [next](installation.html "Installation") |
* riboraptor 0.2.2 documentation »

© Copyright 2017, Saket Choudhary. Created using [Sphinx](http://sphinx.pocoo.org/).