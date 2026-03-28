Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

Toggle site navigation sidebar

[geNomad](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[![Light Logo](_static/figures/logo_light.svg)
![Dark Logo](_static/figures/logo_light.svg)](index.html)

* [geNomad](index.html)

Using geNomad

* Installation
* [Quickstart](quickstart.html)
* [The geNomad pipeline](pipeline.html)
* [Frequently asked questions](faq.html)

Theory

* [Hybrid classification framework and score aggregation](score_aggregation.html)
* [Marker-based classification features](marker_features.html)
* [Neural network-based classification](nn_classification.html)
* [Provirus identification](provirus_identification.html)
* [Taxonomic assignment of virus genomes](taxonomic_assignment.html)
* [Score calibration](score_calibration.html)
* [Post-classification filtering](post_classification_filtering.html)

Back to top

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Installation[#](#installation "Permalink to this heading")

## Installing geNomad[#](#installing-genomad "Permalink to this heading")

You can install geNomad in you computer using either a general-purpose package manager (`pixi`, `mamba`, `conda`) or a Python-specific package manager (`uv` or `pip`).

Pixi

[Pixi](https://pixi.sh/latest/) is probably the simplest way to install geNomad. It takes care of all the dependencies for you and doesn’t require any environment management, meaning the `genomad` command will be available globally.

```
pixi global install -c conda-forge -c bioconda genomad
genomad --help
```

Mamba

[Mamba](https://mamba.readthedocs.io/en/latest/) is a package manager that handles all your dependencies for you. To install geNomad using Mamba, you need to create a new environment and activate it before running the `genomad` command.

```
mamba create -n genomad -c conda-forge -c bioconda genomad
mamba activate genomad
genomad --help
```

Conda

[Conda](https://docs.conda.io/projects/conda/en/stable/) is a package manager that handles all your dependencies for you. To install geNomad using Conda, you need to create a new environment and activate it before running the `genomad` command.

```
conda create -n genomad -c conda-forge -c bioconda genomad
conda activate genomad
genomad --help
```

uv

[`uv`](https://github.com/astral-sh/uv) is a Python-specific package manager that lets you install geNomad as a global command within an isolated environment. However, it won’t take care of the non-Python dependencies required by geNomad (see note below).

```
uv tool install genomad
genomad --help
```

pip

`pip` is a Python-specific package manager that lets you install geNomad as a global command. It is the standard tool for installing Python libraries and should be available to everyone with a Python installation. However, `pip` won’t take care of the non-Python dependencies required by geNomad (see note below).

```
pip install genomad
genomad --help
```

Non-python dependencies

Pixi, Mamba, and Conda will install both the Python dependencies and the non-Python dependencies required by geNomad. If you install geNomad using `uv` or `pip`, make sure to add [`MMseqs2`](https://github.com/soedinglab/MMseqs2/) and [`ARAGORN`](http://www.ansikte.se/ARAGORN/) to your `$PATH`.

## Running geNomad using containers[#](#running-genomad-using-containers "Permalink to this heading")

You can also execute geNomad using containerization tools, such as Docker and Podman. To pull the image, execute the command below.

Docker

```
docker pull antoniopcamargo/genomad
```

Podman

```
podman pull docker.io/antoniopcamargo/genomad
```

To start a geNomad container you have to mount a folder from the host system into the container with the `-v` argument. The following command mounts the current working directory (`$(pwd)`) under `/app` inside the container and then executes the `genomad download-database` and `genomad end-to-end` commands.

Docker

```
docker run -ti --rm -v "$(pwd):/app" antoniopcamargo/genomad download-database .
docker run -ti --rm -v "$(pwd):/app" antoniopcamargo/genomad end-to-end input.fna output genomad_db
```

Podman

```
podman run -u 0 -ti --rm -v "$(pwd):/app" antoniopcamargo/genomad download-database .
podman run -u 0 -ti --rm -v "$(pwd):/app" antoniopcamargo/genomad end-to-end input.fna output genomad_db
```

[Next

Quickstart](quickstart.html)
[Previous

Home](index.html)

Copyright © 2023, Antonio Camargo

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Installation
  + [Installing geNomad](#installing-genomad)
  + [Running geNomad using containers](#running-genomad-using-containers)