### Navigation

* [index](../genindex/ "General Index")
* [next](../Tutorial/ "3. Tutorial") |
* [previous](../Introduction/ "1. Introduction") |
* [Mikado](../) »

# 2. Installation[¶](#installation "Permalink to this headline")

## 2.1. System requirements[¶](#system-requirements "Permalink to this headline")

Mikado requires CPython 3.6 or later to function (Python2 is not supported). Additionally, it requires a functioning installation of one among SQLite, PostgreSQL and MySQL. Mikado has additionally the following python dependencies:

```
biopython>=1.78
datrie>=0.8
docutils
drmaa
hypothesis
msgpack>=1.0.0
networkx>=2.3
numpy>=1.17.2
pandas>=1.0
pip
pysam>=0.15.3
pyyaml>=5.1.2
scipy>=1.3.1
snakemake>=5.7.0
sqlalchemy>=1.3.9,<1.4.0
sqlalchemy-utils>=0.34.1
tabulate>=0.8.5
pytest>=5.4.1
python-rapidjson>=1.0.0
toml>=0.10.0
pyfaidx>=0.5.8
dataclasses; python_version < '3.7'
marshmallow
marshmallow-dataclass
typeguard  # Necessary for mashmallow apparently
```

Mikado can run with little system requirements, being capable of analysing human data with less than 4GB of RAM in all stages. It benefits from the availability of multiple processors, as many of the steps of the pipeline are parallelised.

Mikado is at its core a data integrator. The [Daijin pipeline](../Usage/Daijin/#daijin) has been written to facilitate the creation of a functioning workflow. To function, it requires Snakemake [[Snake]](../References/#snake) and the presence of at least one supported RNA-Seq aligner and one supported transcript assembler. If you are planning to execute it on a cluster, we do support job submission on SLURM, LSF and PBS clusters, either in the presence or absence of DRMAA.

## 2.2. Download[¶](#download "Permalink to this headline")

Mikado is available through [BioConda](https://bioconda.github.com); to install it, select or configure a python3 Conda environment, [add the bioconda channel to your environment](https://bioconda.github.io/#set-up-channels), and then install it with:

`conda install -c bioconda mikado`.

This will also take care of installing companion tools such as [PortCullis](https://portcullis.readthedocs.io/). Even with conda, BLAST+, Prodigal, Diamond and TransDecoder have to be installed separately. This can be achieved with:

`conda install -c bioconda prodigal blast transdecoder diamond`

Mikado is available on PyPI, so it is possible to install it with

`pip3 install mikado`

The source for the latest release on PyPI can be obtained with

`pip3 download mikado`

As the package contains some core Cython components, it might be necessary to download and compile the source code instead of relying on the wheel.

Alternatively, Mikado can be installed from source by obtaining it from our [GitHub](https://github.com/EI-CoreBioinformatics/mikado) repository. Either download the [latest release](https://github.com/EI-CoreBioinformatics/mikado/releases/latest) or download the latest stable development snapshot with

`git clone https://github.com/EI-CoreBioinformatics/mikado.git; cd mikado`

## 2.3. Install using containers[¶](#install-using-containers "Permalink to this headline")

We support both Docker and Singularity as container technologies. On GitHub, we currently provide:

* A [Docker file](https://github.com/EI-CoreBioinformatics/mikado/blob/master/Docker/Dockerfile.ubuntu) tracking the “master” github branch, with a Ubuntu 20.04 guest
* A [Singularity recipe](https://github.com/EI-CoreBioinformatics/mikado/blob/master/Singularity/Singularity.ubuntu) tracking the “master” github branch, with a Ubuntu 20.04 guest
* A [Singularity recipe](https://github.com/EI-CoreBioinformatics/mikado/blob/master/Singularity/Singularity.centos) tracking the “master” github branch, with a Centos 7 guest

We plan to release them in the Docker and Singularity hubs.

## 2.4. Building and installing from source[¶](#building-and-installing-from-source "Permalink to this headline")

If you desire to install Mikado from source, this can be achieved with

`` `bash
pip install -U .
` ``

## 2.5. Testing the installed module[¶](#testing-the-installed-module "Permalink to this headline")

It is possible to test whether Mikado has been built successfully by opening a python3 interactive session and digiting:

```
>>  import Mikado
>>  Mikado.test()
```

Alternatively, you use pytest:

```
$ pytest --pyargs Mikado
```

This will run all the tests included in the suite.

[![Logo](../_static/mikado-logo.png)](../)

### [Table of Contents](../)

* [1. Introduction](../Introduction/)
* 2. Installation
  + [2.1. System requirements](#system-requirements)
  + [2.2. Download](#download)
  + [2.3. Install using containers](#install-using-containers)
  + [2.4. Building and installing from source](#building-and-installing-from-source)
  + [2.5. Testing the installed module](#testing-the-installed-module)
* [3. Tutorial](../Tutorial/)
* [4. Tutorial for Daijin](../Tutorial/Daijin_tutorial/)
* [5. Tutorial: how to create a scoring configuration file](../Tutorial/Scoring_tutorial/)
* [6. Adapting Mikado to specific user-cases](../Tutorial/Adapting/)
* [7. Usage](../Usage/)
* [8. Mikado core algorithms](../Algorithms/)
* [9. Scoring files](../Scoring_files/)
* [10. References](../References/)
* [11. Mikado](../Library/modules/)

#### Previous topic

[1. Introduction](../Introduction/ "previous chapter")

#### Next topic

[3. Tutorial](../Tutorial/ "next chapter")

### This Page

* [Show Source](../_sources/Installation.rst.txt)

### Quick search

### Navigation

* [index](../genindex/ "General Index")
* [next](../Tutorial/ "3. Tutorial") |
* [previous](../Introduction/ "1. Introduction") |
* [Mikado](../) »

© Copyright 2015-2021, Venturini Luca, Caim Shabhonam, Mapleson Daniel, Luis Yanes, Kaithakottil Gemy George, Swarbreck David.
Last updated on 06 April 2021.
Created using [Sphinx](http://sphinx-doc.org/) 1.8.5.