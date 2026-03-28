[HippUnfold Documentation](../index.html)

Getting started

* Installation
  + [Requirements](#requirements)
    - [Notes:](#notes)
  + [Comparison of methods for running HippUnfold](#comparison-of-methods-for-running-hippunfold)
    - [CBRAIN Web-based Platform](#cbrain-web-based-platform)
      * [Pros:](#pros)
      * [Cons:](#cons)
    - [Docker on Windows/Mac (Intel)/Linux](#docker-on-windows-mac-intel-linux)
      * [Pros:](#id1)
      * [Cons:](#id2)
    - [Singularity Container](#singularity-container)
      * [Pros:](#id3)
      * [Cons:](#id4)
    - [Python Environment with Singularity Dependencies](#python-environment-with-singularity-dependencies)
      * [Pros:](#id5)
      * [Cons:](#id6)
  + [Note 1:](#note-1)
* [Running HippUnfold with Docker on Windows](docker.html)
* [Running HippUnfold with Singularity](singularity.html)
* [Running HippUnfold with a Vagrant VM](vagrant.html)

Usage Notes

* [Command-line interface](../usage/cli.html)
* [Running HippUnfold on your data](../usage/useful_options.html)
* [Specialized scans](../usage/specializedScans.html)
* [Template-base segmentation](../usage/templates.html)
* [Frequently asked questions](../usage/faq.html)

Processing pipeline details

* [Pipeline Details](../pipeline/pipeline.html)
* [Algorithmic details](../pipeline/algorithms.html)

Outputs of HippUnfold

* [Output Files](../outputs/output_files.html)
* [Visualization](../outputs/visualization.html)
* [Quality Control](../outputs/QC.html)

Contributing

* [References](../contributing/references.html)
* [Contributing to Hippunfold](../contributing/contributing.html)

[HippUnfold Documentation](../index.html)

* Installation
* [View page source](../_sources/getting_started/installation.md.txt)

---

# Installation[](#installation "Permalink to this heading")

BIDS App for Hippocampal AutoTop (automated hippocampal unfolding and
subfield segmentation)

## Requirements[](#requirements "Permalink to this heading")

* Docker (Intel Mac/Windows/Linux) or Singularity (Linux)
* For those wishing to contribute or modify the code, `pip install` or `poetry install` are also available (Linux), but will still require singularity to handle some dependencies. See [Contributing to HippUnfold](https://hippunfold.readthedocs.io/en/latest/contributing/contributing.html).
* GPU not required
* Note: Apple M1 is currently **not supported**. We don’t have a Docker arm64 container yet, and hippunfold is unusably slow with the emulated amd64 container.

### Notes:[](#notes "Permalink to this heading")

* Inputs to Hippunfold should typically be a BIDS dataset including T1w images or T2w images. Higher-resolution data are preferred (<= 0.8mm) but the pipeline will still work with 1mm T1w images. See [Tutorials](https://hippunfold.readthedocs.io/en/latest/tutorials/standardBIDS.html).
* Other 3D imaging modalities (eg. ex-vivo MRI, 3D histology, etc.) can be used, but may require manual tissue segmentation as the current workflow relies on U-net segmentation trained only on common MRI modalities.

## Comparison of methods for running HippUnfold[](#comparison-of-methods-for-running-hippunfold "Permalink to this heading")

There are several different ways of running HippUnfold. In order of increasing complexity/flexibility, we have:

1. CBRAIN Web-based Platform
2. Singularity Container on Linux
3. Docker Container on Windows/Mac (Intel)/Linux
4. Python Environment with Singularity Dependencies

### CBRAIN Web-based Platform[](#cbrain-web-based-platform "Permalink to this heading")

HippUnfold is available on the [CBRAIN platform](https://github.com/aces/cbrain/wiki), a
web-based platform for batch high-performance computing that is free for researchers.

#### Pros:[](#pros "Permalink to this heading")

* No software installation required
* Fully point and click interface (no CLI)
* Can perform batch-processing

#### Cons:[](#cons "Permalink to this heading")

* Must upload data for processing
* Limited command-line options exposed
* Cannot edit code

### Docker on Windows/Mac (Intel)/Linux[](#docker-on-windows-mac-intel-linux "Permalink to this heading")

The HippUnfold BIDS App is available on a DockerHub as versioned releases and development branches.

#### Pros:[](#id1 "Permalink to this heading")

* Compatible with non-Linux systems
* All dependencies+models (\* See Note 1) in a single container

#### Cons:[](#id2 "Permalink to this heading")

* Typically not possible on shared machines
* Cannot use Snakemake cluster execution profiles
* Cannot edit code

### Singularity Container[](#singularity-container "Permalink to this heading")

The same docker container can also be used with Singularity (now Apptainer). Instructions can be found below.

#### Pros:[](#id3 "Permalink to this heading")

* All dependencies+models (\* See Note 1) in a single container
* Container stored as a single file (.sif)

#### Cons:[](#id4 "Permalink to this heading")

* Compatible on shared systems with Singularity installed
* Cannot use Snakemake cluster execution profiles
* Cannot edit code

### Python Environment with Singularity Dependencies[](#python-environment-with-singularity-dependencies "Permalink to this heading")

Instructions for this can be found in the **Contributing** documentation page.

#### Pros:[](#id5 "Permalink to this heading")

* Complete flexibility to modify code
* External (python and non-python) dependencies as Singularity containers

#### Cons:[](#id6 "Permalink to this heading")

* Must use Python virtual environment
* Only compatible on Linux systems with Singularity for external dependencies

## Note 1:[](#note-1 "Permalink to this heading")

As of version 1.3.0 of HippUnfold, containers are no longer shipped with all the models, and the models are downloaded as part of the workflow. By default, models are placed in `~/.cache/hippunfold` unless you set the `HIPPUNFOLD_CACHE_DIR` environment variable. See [Deep learning nnU-net model files](https://hippunfold.readthedocs.io/en/latest/contributing/contributing.html#deep-learning-nnu-net-model-files) for more information.

[Previous](../index.html "Hippunfold")
[Next](docker.html "Running HippUnfold with Docker on Windows")

---

© Copyright 2020, Jordan DeKraker and Ali R. Khan.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).