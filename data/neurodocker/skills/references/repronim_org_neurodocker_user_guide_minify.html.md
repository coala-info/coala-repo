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
* [Common Uses](common_uses.html)
* Minify Containers
* [Templates and Renderers](templates_renderers.html)
* [Add software to Neurodocker](add_template.html)
* [Known Issues](known_issues.html)

* [User Guide](index.html)
* Minify Containers

# Minify Containers[#](#minify-containers "Permalink to this heading")

Neurodocker provides a utility to minify existing Docker containers for specific
commands. This feature relies heavily on [ReproZip](https://www.reprozip.org/).

Note

Neurodocker must be installed with `pip` to minify containers.

```
pip install neurodocker[minify]
```

The Docker engine must also be installed and running. You can confirm that
Docker is installed and running by executing

```
docker images
```

on the command-line. If Docker is not available, the `neurodocker minify`
command will not be available.

## Minify image with ANTs[#](#minify-image-with-ants "Permalink to this heading")

In the following example, a Docker image is built with ANTs version 2.3.1 and a
functional scan. The image is minified for running `antsMotionCorr`.
The original ANTs Docker image is 1.96 GB, and the minified image is 369 MB.
The only directory that is pruned is `/opt`, which includes the ANTs
installation. This means that important directories like `/usr` and
`/bin` are untouched, and the container can still be used interactively.

```
# Create a Docker image with ANTs, and download a functional scan.
download_cmd="curl -fsSL -o /home/func.nii.gz http://psydata.ovgu.de/studyforrest/phase2/sub-01/ses-movie/func/sub-01_ses-movie_task-movie_run-1_bold.nii.gz"
neurodocker generate docker \
    --pkg-manager yum \
    --base-image centos:7 \
    --ants version=2.3.1 \
    --run="$download_cmd" \
    | docker build -t ants:2.3.1 -

# Run the container in the background.
docker run --rm -itd --name ants-container ants:2.3.1

# Find all of the files under `/opt` that are not used by the command(s),
# and queue those files for deletion.
cmd="antsMotionCorr -d 3 -a /home/func.nii.gz -o /home/func_avg.nii.gz"
neurodocker minify \
    --container ants-container \
    --dir /opt \
    "$cmd"
# Read through the list of files that will be deleted, and respond with
# the keyboard. Then, create a new Docker image using the pruned container.
docker export ants-container | docker import - ants:2.3.1-min-motioncorr

# View a summary of the Docker images.
docker images
# REPOSITORY   TAG                    IMAGE ID       CREATED             SIZE
# ants         2.3.1-min-motioncorr   597aedcbf7fc   2 minutes ago       369MB
# ants         2.3.1                  4fda1f47feb2   4 minutes ago       1.96GB
# centos       7                      8652b9f0cb4c   3 months ago        204MB
```

[previous

Common Uses](common_uses.html "previous page")
[next

Templates and Renderers](templates_renderers.html "next page")

On this page

* [Minify image with ANTs](#minify-image-with-ants)

[Edit on GitHub](https://github.com/ReproNim/neurodocker/edit/master/docs/user_guide/minify.rst)

### This Page

* [Show Source](../_sources/user_guide/minify.rst.txt)

© Copyright 2017-2025, Neurodocker Developers.

Created using [Sphinx](https://www.sphinx-doc.org/) 6.2.1.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.