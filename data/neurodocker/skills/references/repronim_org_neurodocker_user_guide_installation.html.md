[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[Neurodocker documentation](../index.html)

* [User Guide](index.html)
* [API Reference](../api.html)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/ReproNim/neurodocker "GitHub")
* [Docker Hub](https://hub.docker.com/r/repronim/neurodocker "Docker Hub")

Search
`Ctrl`+`K`

* [User Guide](index.html)
* [API Reference](../api.html)

* [GitHub](https://github.com/ReproNim/neurodocker "GitHub")
* [Docker Hub](https://hub.docker.com/r/repronim/neurodocker "Docker Hub")

Section Navigation

* Installation
* [Quickstart](quickstart.html)
* [Command-line Interface](cli.html)
* [Examples](examples.html)
* [Common Uses](common_uses.html)
* [Minify Containers](minify.html)
* [Templates and Renderers](templates_renderers.html)
* [Add software to Neurodocker](add_template.html)
* [Known Issues](known_issues.html)

* [User Guide](index.html)
* Installation

# Installation[#](#installation "Permalink to this heading")

## container (preferred)[#](#container-preferred "Permalink to this heading")

We recommend using the Neurodocker Docker image, which can be access through
Docker or Singularity.

```
docker run --rm repronim/neurodocker:latest --help
```

Note: Some tools require an interactive input during installation (e.g. FSL). This can either be handled using the Neurodocker –yes option (see examples -> FSL) or running the container interactively will also allow to answer this question:

```
docker run -i --rm
```

Alternatively, a singularity container:

```
singularity run docker://repronim/neurodocker:latest --help
```

Note: The version tag latest is a moving target and points to the latest stable release.

```
repronim/neurodocker:latest -> latest release (0.9.4 now)
repronim/neurodocker:master -> master branch
repronim/neurodocker:0.9.4
repronim/neurodocker:0.9.2
repronim/neurodocker:0.9.1
repronim/neurodocker:0.9.0
repronim/neurodocker:0.8.0
repronim/neurodocker:0.7.0
...
```

## pip[#](#pip "Permalink to this heading")

Neurodocker can also be installed with `pip`. This is useful if you want to use
the Neurodocker Python API. Python 3.10 or newer is required.

```
python -m pip install neurodocker
neurodocker --help
```

## conda[#](#conda "Permalink to this heading")

We recommend using a virtual environment or a `conda` environment.
In order to create a new `conda` environment and install Neurodocker:

```
conda create -n neurodocker python=3.10
conda activate neurodocker
python -m pip install neurodocker
neurodocker --help
```

[previous

User Guide](index.html "previous page")
[next

Quickstart](quickstart.html "next page")

On this page

* [container (preferred)](#container-preferred)
* [pip](#pip)
* [conda](#conda)

[Edit on GitHub](https://github.com/ReproNim/neurodocker/edit/master/docs/user_guide/installation.rst)

### This Page

* [Show Source](../_sources/user_guide/installation.rst.txt)

© Copyright 2017-2025, Neurodocker Developers.

Created using [Sphinx](https://www.sphinx-doc.org/) 6.2.1.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.