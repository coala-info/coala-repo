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

* [Installation](installation.html)
* [Quickstart](quickstart.html)
* [Command-line Interface](cli.html)
* [Examples](examples.html)
* Common Uses
* [Minify Containers](minify.html)
* [Templates and Renderers](templates_renderers.html)
* [Add software to Neurodocker](add_template.html)
* [Known Issues](known_issues.html)

* [User Guide](index.html)
* Common Uses

# Common Uses[#](#common-uses "Permalink to this heading")

## Create locally and use remotely[#](#create-locally-and-use-remotely "Permalink to this heading")

Todo

Add content.

## Working with Data[#](#working-with-data "Permalink to this heading")

Todo

Add content.

## Jupyter Notebook[#](#jupyter-notebook "Permalink to this heading")

This example demonstrates how to build and run an image with Jupyter Notebook.

Note

When you exit a Docker image, any files you created in that image are lost. So if
you create Jupyter Notebooks while in a Docker image, remember to save them to
a mounted directory. Otherwise, the notebooks will be deleted (and unrecoverable)
after you exit the Docker image.

```
neurodocker generate docker \
    --pkg-manager apt \
    --base-image debian:bullseye-slim \
    --miniconda \
        version=latest \
        conda_install="matplotlib notebook numpy pandas seaborn" \
    --user nonroot \
    --workdir /work \
> notebook.Dockerfile

# Build the image.
docker build --tag notebook --file notebook.Dockerfile .

# Run the image. The current directory is mounted to the working directory of the
# Docker image, so our notebooks are saved to the current directory.
docker run --rm -it \
    --publish 8888:8888 \
    --volume $(pwd):/work notebook \
    jupyter-notebook --no-browser --ip 0.0.0.0
```

## Multiple Conda Environments[#](#multiple-conda-environments "Permalink to this heading")

This example demonstrates how to create a Docker image with multiple conda environments.

One can use the image in the following way:

```
docker run --rm -it multi-conda-env bash
# Pandas is installed in envA.
conda activate envA
python -c "import pandas"
# Scipy is installed in envB.
conda activate envB
python -c "import scipy"
```

[previous

Examples](examples.html "previous page")
[next

Minify Containers](minify.html "next page")

On this page

* [Create locally and use remotely](#create-locally-and-use-remotely)
* [Working with Data](#working-with-data)
* [Jupyter Notebook](#jupyter-notebook)
* [Multiple Conda Environments](#multiple-conda-environments)

[Edit on GitHub](https://github.com/ReproNim/neurodocker/edit/master/docs/user_guide/common_uses.rst)

### This Page

* [Show Source](../_sources/user_guide/common_uses.rst.txt)

© Copyright 2017-2025, Neurodocker Developers.

Created using [Sphinx](https://www.sphinx-doc.org/) 6.2.1.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.