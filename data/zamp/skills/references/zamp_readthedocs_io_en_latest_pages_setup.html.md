# Installation and resource requirements[¶](#installation-and-resource-requirements "Link to this heading")

## Quick start[¶](#quick-start "Link to this heading")

* Install with conda via [Miniforge](https://github.com/conda-forge/miniforge):

  ```
  conda install zamp
  ```
* Install with docker from [Dockerhub](https://hub.docker.com/r/metagenlab/zamp/):

  ```
  docker pull metagenlab/zamp:latest
  ```

## Operating system[¶](#operating-system "Link to this heading")

zAMP is available on [Bioconda](https://bioconda.github.io/) which only support Linux and macOS.

If you use windows, you can still run zAMP via [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

## Installation methods[¶](#installation-methods "Link to this heading")

### *From source*[¶](#from-source "Link to this heading")

You can install zAMP from source, by cloning the [repository](https://github.com/metagenlab/zAMP):

```
git clone https://github.com/metagenlab/zAMP
pip install -e zAMP/
```

Dependencies:
:   * python >=3.11
    * apptainer
    * conda

### *Conda*[¶](#conda "Link to this heading")

You can install zAMP from [Bioconda](https://bioconda.github.io/) with conda installed from [Miniforge](https://github.com/conda-forge/miniforge):

```
# Install conda from Miniforge
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh

# Install zamp
conda install zamp
```

### *Containers*[¶](#containers "Link to this heading")

You can install zAMP by pulling a container image for maximum reproducibility and no extra dependency installation.

We recommend installing zAMP containers via docker or apptainer from any of the container registries below:

* [Dockerhub](https://hub.docker.com/r/metagenlab/zamp/):

  ```
  docker pull metagenlab/zamp:latest
  ```
* [ghcr](https://github.com/metagenlab/zAMP/pkgs/container/zamp):

  ```
  docker pull ghcr.io/metagenlab/zamp:latest
  ```
* [biocontainers](https://quay.io/repository/biocontainers/zamp):

  ```
  docker pull quay.io/biocontainers/zamp:1.0.0--pyhdfd78af_1
  ```

## Resource usage[¶](#resource-usage "Link to this heading")

Some steps in zAMP can be quite resource-intensive, requiring more RAM.

For example, if you want to re-train the RDP classifier on SILVA138.1, you might need around 100GB of RAM.

In terms of duration, and when using the default zAMP module, the bottleneck is usually the DADA2 denoising step, which can take some time with lots of samples.

Actual resource usage like RAM and CPU-time depends on:

* Number of samples
* Sequencing depth of each sample
* Threads set by the user

Note

Usually, a zAMP run duration is less than 1h and does not require more than 32 GB of RAM.

# [zAMP](../index.html)

### Navigation

* Installation and resource requirements
  + [Quick start](#quick-start)
  + [Operating system](#operating-system)
  + [Installation methods](#installation-methods)
  + [Resource usage](#resource-usage)
* [Taxonomic reference databases](ref_DB_preprocessing.html)
* [Running zAMP](execution.html)
* [Under the hood](under_the_hood.html)
* [Downstream Analysis](downstream_analysis.html)
* [Frequently asked questions (FAQ)](FAQ.html)
* [*In silico* validation tool](insilico_validation.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Reproducible Scalable Pipeline For Amplicon-based Metagenomics (zAMP)](../index.html "previous chapter")
  + Next: [Taxonomic reference databases](ref_DB_preprocessing.html "next chapter")

©2020, MetaGenLab.
|
Powered by [Sphinx 8.2.3](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](../_sources/pages/setup.rst.txt)