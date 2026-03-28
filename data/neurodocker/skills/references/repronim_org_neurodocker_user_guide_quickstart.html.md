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
* Quickstart
* [Command-line Interface](cli.html)
* [Examples](examples.html)
* [Common Uses](common_uses.html)
* [Minify Containers](minify.html)
* [Templates and Renderers](templates_renderers.html)
* [Add software to Neurodocker](add_template.html)
* [Known Issues](known_issues.html)

* [User Guide](index.html)
* Quickstart

# Quickstart[#](#quickstart "Permalink to this heading")

## Generate a container[#](#generate-a-container "Permalink to this heading")

Use the command `neurodocker generate` to generate containers. In the examples below,
we generate containers with [Nipype](https://nipype.readthedocs.io/en/latest/),
[Jupyter Notebook](https://jupyter.org/), and [ANTs](https://github.com/ANTsX/ANTs).

Please see the [Examples](examples.html) page for more.

### Docker[#](#docker "Permalink to this heading")

Run the following code snippet to generate a [Dockerfile](https://docs.docker.com/engine/reference/builder/).
This is a file that defines how to build a Docker image.

**This requires having `Docker <https://docs.docker.com/get-docker/>`\_ installed first**

```
neurodocker generate docker \
    --pkg-manager apt \
    --base-image neurodebian:bullseye \
    --ants version=2.4.3 \
    --miniconda version=latest conda_install="nipype notebook" \
    --user nonroot
```

You should see a block of text appear in the console. This is the Dockerfile generated
by *Neurodocker*. Instructions in the Dockerfile are ordered in the same way as the
arguments in the command-line. To build a Docker image with this, save the output to a
file in an empty directory, and build with `docker build`:

```
# creating a new empty directory
mkdir docker-example
cd docker-example
# saving the output of neurodocker command in a file: Dockerfile
neurodocker generate docker \
    --pkg-manager apt \
    --base-image neurodebian:bullseye \
    --ants version=2.4.3 \
    --miniconda version=latest conda_install="nipype notebook" \
    --user nonroot > Dockerfile
# building a new image using the Dockerfile (use --file <dockerfile_name> option if other name is used)
docker build --tag nipype-ants .
```

The image :code: nipype-ants contains :code: ANTs and a Python environment with :code: Nipype and :code: Jupyter Notebook.
You can start a Jupyter Notebook with the following command. This will mount
the current working directory to `work` within the container, so any files you
create in this directory are saved. If we had not mounted this directory, all of the files
created in `/work` would be gone after the container was stopped.
:code: –publish 8888:8888 and :code: –ip 0.0.0.0 –port 8888 is required in order to use Jupyter Notebook from a Docker container.

```
docker run --rm -it \
    --workdir /work \
    --volume $PWD:/work \
    --publish 8888:8888 \
    nipype-ants jupyter-notebook --ip 0.0.0.0 --port 8888
```

Feel free to create a new notebook and `import nipype`.

### Singularity[#](#singularity "Permalink to this heading")

In most cases the only difference between generating Dockerfile and
[Singularity definition file](https://sylabs.io/guides/3.7/user-guide/definition_files.html) (the file that is used to create a Singularity container) is in
a form of `neurodocker generate` command, neurodocker generate singularity has to be used instead of `neurodocker generate docker`.

**This requires having `Singularity <https://sylabs.io/guides/3.7/user-guide/quick\_start.html>`\_ installed first.**

```
neurodocker generate singularity \
    --pkg-manager apt \
    --base-image neurodebian:bullseye\
    --ants version=2.4.3 \
    --miniconda version=latest conda_install="nipype notebook" \
    --user nonroot
```

You should see a block of text appear in the console. This is the Singularity definition.
To build the Singularity image, create a new directory, save this output to a file, and
use `sudo singularity build`. Note that this requires superuser privileges. You
will not be able to run this on a shared computing environment, like a high performance cluster.

```
# creating a new empty directory
mkdir singularity-example
cd singularity-example
# saving the output of the Neurodocker command in the Singularity file
neurodocker generate singularity \
    --pkg-manager apt \
    --base-image neurodebian:bullseye\
    --ants version=2.4.3 \
    --miniconda version=latest conda_install="nipype notebook" \
    --user nonroot > Singularity
# building a new image using the Singularity file
sudo singularity build nipype-ants.sif Singularity
```

This will create a new file `nipype-ants.sif` in this directory. This is the
Singularity container. You can move this file around like any other file – even share
it with all of your friends.

To run Jupyter Notebook, use the following:

```
singularity run --bind $PWD:/work --pwd /work nipype-ants.sif jupyter-notebook
```

Feel free to create a new notebook and `import nipype`.

## Minify a Docker container[#](#minify-a-docker-container "Permalink to this heading")

*Neurodocker* enables you to minify Docker containers for a set of commands. This will
remove files not used by these commands and will dramatically reduce the size of the
Docker image.

See `neurodocker minify --help` for more information.

Note

Neurodocker must be installed with `pip` to minify containers.

```
pip install neurodocker[minify]
```

In the example below, we minify one of the official Python Docker images for certain
commands. This will remove all of the files in `/usr/local/` that are not used by
these commands.

[ReproZip](https://www.reprozip.org/) is used to determine the files used by the
commands.

```
# running a container in the background and assigning `to-minify` name to the container
docker run --rm -itd --name to-minify python:3.10-slim bash
# running minify command for a specific set of python commands
neurodocker minify \
  --container to-minify \
  --dir /usr/local \
  "python -c 'a = 1 + 1; print(a)'" \
  "python -c 'import os'"
```

You will be given a list of all of the files that will be deleted. Review this list of
files before proceeding.

```
docker export to-minify | docker import - minified-python
```

Now if you run `docker images`, the image `minified-python` will be listed.

Warning

Environment variables are lost when saving the minified image as a new image. If
certain environment variables are required in the minified image, users should
create a new Dockerfile that uses the minified image as a base image and then sets
environment variables.

The commands that were run during minification will (read: should) succeed:

```
docker run --rm minified-python python -c "a = 1 + 1; print(a)"
docker run --rm minified-python python -c "import os"
```

But commands not run during minification are *not guaranteed to succeed*. The following
commands, for example, result in errors.

```
docker run --rm minified-python python -c 'import math'
docker run --rm minified-python python -c 'import pathlib'
docker run --rm minified-python pip --help
```

[previous

Installation](installation.html "previous page")
[next

Command-line Interface](cli.html "next page")

On this page

* [Generate a container](#generate-a-container)
  + [Docker](#docker)
  + [Singularity](#singularity)
* [Minify a Docker container](#minify-a-docker-container)

[Edit on GitHub](https://github.com/ReproNim/neurodocker/edit/master/docs/user_guide/quickstart.rst)

### This Page

* [Show Source](../_sources/user_guide/quickstart.rst.txt)

© Copyright 2017-2025, Neurodocker Developers.

Created using [Sphinx](https://www.sphinx-doc.org/) 6.2.1.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.