[ ]
[ ]

[Skip to content](#installation)

blast2galaxy Documentation

Installation

[blast2galaxy](https://github.com/IPK-BIT/blast2galaxy "Go to repository")

blast2galaxy Documentation

[blast2galaxy](https://github.com/IPK-BIT/blast2galaxy "Go to repository")

* [Introduction](..)
* [ ]

  Installation

  [Installation](./)

  Table of contents
  + [Prerequisites](#prerequisites)
  + [Installation with pip](#installation-with-pip)
  + [Installation with mamba or conda](#installation-with-mamba-or-conda)
  + [Using Biocontainers image with Docker or Podman](#using-biocontainers-image-with-docker-or-podman)
  + [Using Apptainer (Singularity) image](#using-apptainer-singularity-image)
* [Configuration](../configuration/)
* [ ]

  Usage

  Usage
  + [CLI Usage](../usage_cli/)
  + [API Usage](../usage_api/)
* [Tutorial](../tutorial/)
* [CLI Reference](../cli/)
* [API Reference](../api/)

Table of contents

* [Prerequisites](#prerequisites)
* [Installation with pip](#installation-with-pip)
* [Installation with mamba or conda](#installation-with-mamba-or-conda)
* [Using Biocontainers image with Docker or Podman](#using-biocontainers-image-with-docker-or-podman)
* [Using Apptainer (Singularity) image](#using-apptainer-singularity-image)

# Installation

## Prerequisites

* Python version has to be >= 3.10

Note

It is highly recommended to install blast2galaxy in an isolated environment created with an environment management tool like conda/mamba, pixi, virtualenv or similar.

## Installation with pip

You can install blast2galaxy from PyPI.org using pip:

```
pip install blast2galaxy
```

After installation you can check if the blast2galaxy CLI was installed correctly by executing the following command on your shell:

```
blast2galaxy --help
```

## Installation with mamba or conda

blast2galaxy is available as a [Bioconda package](https://bioconda.github.io/recipes/blast2galaxy/README.html).

Note

Please make sure you have added the channels `bioconda` and `conda-forge` to your mamba/conda settings.
You can do this by executing the following commands:

```
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict
```

This will modify your ~/.condarc file.

You can install blast2galaxy the from the `bioconda` channel:

```
mamba install blast2galaxy
```

or

```
conda install blast2galaxy
```

After installation you can check if the blast2galaxy CLI was installed correctly by executing the following command on your shell:

```
blast2galaxy --help
```

## Using Biocontainers image with Docker or Podman

blast2galaxy is available as a [Biocontainers](https://biocontainers.pro/) image.

Please replace `<tag>` in the commands listed below with an available version tag. All available version tags are listed here: <https://quay.io/repository/biocontainers/blast2galaxy?tab=tags>

### Pull the image

Using Podman:

```
podman pull quay.io/biocontainers/blast2galaxy:<tag>
```

Using Docker:

```
docker pull quay.io/biocontainers/blast2galaxy:<tag>
```

### Start a container

Using Podman:

```
$ podman run -it blast2galaxy:<tag>
```

Using Docker:

```
$ docker run -it blast2galaxy:<tag>
```

When the container is running you can check if everything works fine by executing the following command on the shell of the running container:

```
blast2galaxy --help
```

## Using Apptainer (Singularity) image

Pull the image:

```
$ apptainer pull blast2galaxy.sif https://depot.galaxyproject.org/singularity/blast2galaxy:<tag>
```

Start a container:

```
$ apptainer shell blast2galaxy.sif
```

When the container is running you can check if everything works fine by executing the following command on the shell of the running container:

```
blast2galaxy --help
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)