[seq2science](../index.html)

* Getting started
  + [Installation](#installation)
    - [seq2science requires anaconda](#seq2science-requires-anaconda)
    - [Easy and recommended installation (bioconda)](#easy-and-recommended-installation-bioconda)
    - [Install from source (not recommended)](#install-from-source-not-recommended)
  + [Running a workflow](#running-a-workflow)
  + [Getting an explanation of what seq2science did (or will do)](#getting-an-explanation-of-what-seq2science-did-or-will-do)
  + [Where does seq2science store results and looks for ‘starting points’?](#where-does-seq2science-store-results-and-looks-for-starting-points)
  + [What is Snakemake?](#what-is-snakemake)
* [Workflows](workflows.html)
* [Using the results](results.html)
* [Extensive docs](extensive_docs.html)
* [Extra resources](extracontent.html)
* [Frequently Asked Questions (FAQ)](faq.html)
* [Contributing to seq2science](../CONTRIBUTING.html)

[seq2science](../index.html)

* Getting started
* [Edit on GitHub](https://github.com/vanheeringen-lab/seq2science/blob/master/docs/content/gettingstarted.md)

---

# Getting started[](#getting-started "Link to this heading")

## Installation[](#installation "Link to this heading")

### seq2science requires anaconda[](#seq2science-requires-anaconda "Link to this heading")

Download and install [miniconda](https://www.anaconda.com/) if not yet installed:

```
user@comp:~$ wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -O mambaforge.sh
user@comp:~$ bash mambaforge.sh # (make sure to say **yes** when asked to initialize conda)
user@comp:~$ source ~/.bashrc
```

Set the correct channels (in this specific order) to use bioconda:

```
user@comp:~$ conda config --add channels defaults
user@comp:~$ conda config --add channels bioconda
user@comp:~$ conda config --add channels conda-forge
```

### Easy and recommended installation (bioconda)[](#easy-and-recommended-installation-bioconda "Link to this heading")

The most straightforward way to install seq2science is by using [conda](https://docs.continuum.io/anaconda/) using the [bioconda](https://bioconda.github.io/) channel. To install seq2science in a fresh environment using bioconda:

```
(base) user@comp:~$ mamba create -n seq2science seq2science
```

This should install the *newest* official release of seq2science.

### Install from source (not recommended)[](#install-from-source-not-recommended "Link to this heading")

To install the latest (potentially unreleased) version of seq2science you can install from source. We generally don’t recommend you doing this.

```
(base) user@comp:~$ git clone https://github.com/vanheeringen-lab/seq2science
(base) user@comp:~$ cd seq2science
(base) user@comp:~/seq2science$ conda env create --name seq2science -f requirements.yaml
(base) user@comp:~/seq2science$ conda activate seq2science
(seq2science) user@comp:~/seq2science$ pip install .
```

## Running a workflow[](#running-a-workflow "Link to this heading")

A typical setup and run of a workflow looks like this, where you start with activating the seq2science environment.

```
(base) user@comp:~$ conda activate seq2science
```

Then navigate to your project dir.

```
(seq2science) user@comp:~$ cd my_project
```

Where you initialize the workflow with a configuration file and samples file, and edit those to your needs.

```
(seq2science) user@comp:~/my_project$ seq2science init {workflow}
```

And finally run the workflow. Note that the first time you run a workflow it will take a while before the real run starts, as seq2science will first install all the necessary software for the analysis steps.

```
(seq2science) user@comp:~.my_project$ seq2science run {workflow} --cores 24
```

## Getting an explanation of what seq2science did (or will do)[](#getting-an-explanation-of-what-seq2science-did-or-will-do "Link to this heading")

Seq2science has a function to write an explanation of what has/will be done with the configuration file for a workflow:

```
(seq2science) user@comp:~.my_project$ seq2science explain {workflow}
```

This will print an extensive (quite technical) explanation that can also serve as a starting point for a material and methods section. This is not a replacement for the documentation, which we definitely recommend you to always read! This explanation is also automatically added to the final QC report.

## Where does seq2science store results and looks for ‘starting points’?[](#where-does-seq2science-store-results-and-looks-for-starting-points "Link to this heading")

We recommend that for a typical run of seq2science you use a folder structure like this:

```
root
└── my_project
    ├── samples.tsv
    ├── config.yaml
    └── {result_dir}
        └── {fastq_dir}
            ├── sample1.fastq.gz
            ├── sample2_R1.fastq.gz
            └── sample2_R2.fastq.gz
```

This structure is the default setting of seq2science, however can be adjusted to your liking in the config.yaml.

## What is Snakemake?[](#what-is-snakemake "Link to this heading")

Since *under-the-hood* seq2science is based on [snakemake](https://snakemake.readthedocs.io/en/stable/), we thought it might be nice to give a little introduction to snakemake.

Snakemake is a pipeline tool that allows users to specify *rules*. Each rule is defined with what it requires as input, what it will output, and what command it needs to run to generate the output from the input. This design allows for the linking of many rules, where the input of one rule is the output of another. When invoking Snakemake it will then decide itself which rules need to be run for the output you specified.

Here is an example Snakefile with just two (very simple) rules:

```
rule one:
    output:
        "file1.txt"
    shell:
        # for this example we just make an empty file
        "touch {output}"

rule two:
    input:
        "file1.txt"
    output:
        "file2.txt"
    shell:
        # for this example we just make an empty file
        "touch {output}"
```

We can tell snakemake to generate for instance file1.txt like this:

```
(base) user@comp:~$ snakemake file1.txt
```

And snakemake will see that rule one can generate this output, sees that it requires no input, and executes the shell command. If we tell snakemake to generate file2.txt:

```
(base) user@comp:~$ snakemake file2.txt
```

It will see that rule two needs to be run, takes a look at the required input for this rule, and checks whether file1.txt already exists. If it does, it will immediatly execute rule two, if file1.txt does not already exist it will execute rule one first.

We highly recommend everyone interested in automating a part of their analysis to take a look at snakemake! For a more complete explanation of how snakemake works see the [snakemake docs](https://snakemake.readthedocs.io/).

[Previous](../index.html "seq2science")
[Next](workflows.html "Workflows")

---

© Copyright Maarten van der Sande, Siebren Frölich, Jos Smits, Rebecca Snabel, Tilman Schäfers, & Simon van Heeringen..

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).