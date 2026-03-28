[Skip to content](#content)

[![Logo](../_static/logo-snake.svg)
![Logo](../_static/logo-snake.svg)Snakedeploy documentation](../index.html)
[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Toggle navigation menu

`⌘
K`

[![Logo](../_static/logo-snake.svg)
![Logo](../_static/logo-snake.svg)Snakedeploy documentation](../index.html)

[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Getting started

* Installation

Workflow users

* [Deploy workflows](../workflow_users/workflow_deployment.html)
* [Register input data](../workflow_users/input_registration.html)

Workflow developers

* [Update conda environment files](../workflow_developers/update_conda_envs.html)
* [Pin/lock conda environments](../workflow_developers/update_conda_envs.html#pin-lock-conda-environments)
* [Update Snakemake wrappers](../workflow_developers/update_snakemake_wrappers.html)

Snakemake developers

* [Scaffold Snakemake Plugins](../snakemake_developers/scaffold_snakemake_plugins.html)

API Reference

* [The Snakedeploy API](../api_reference/snakedeploy.html)
* [Internal API](../api_reference/internal/modules.html)

[Snakedeploy documentation](../index.html)

/

Installation

# Installation

Snakedeploy can be installed via pixi, conda, pypi or from source.

## Install via pixi

For global installation (recommended), run

```
$ pixi global install snakedeploy
```

For local installation into an existing pixi workspace, run

```
$ pixi add snakedeploy
```

## Install via mamba/conda

```
$ mamba install -c bioconda -c conda-forge snakedeploy
```

or

```
$ conda install -c bioconda -c conda-forge snakedeploy
```

## Install via pip

```
$ pip install snakedeploy
```

## Install from source

```
$ git clone git@github.com:snakemake/snakedeploy.git
$ cd snakedeploy
$ pip install .
```

```
$ pip install -e .
```

## Testing the installation

Once snakedeploy is installed, you should be able to inspect the client with

```
snakedeploy --help
```

On this page

* [Install via pixi](#install-via-pixi)
* [Install via mamba/conda](#install-via-mamba-conda)
* [Install via pip](#install-via-pip)
* [Install from source](#install-from-source)
* [Testing the installation](#testing-the-installation)

© 2020, Johannes Koester and Vanessa Sochat Built with [Sphinx 7.3.7](https://www.sphinx-doc.org)