[phyluce](index.html)

Contents:

* [Purpose](purpose.html)
* Installation
  + [Install Process](#install-process)
    - [Using Conda](#using-conda)
      * [Install miniconda](#install-miniconda)
      * [Install phyluce](#install-phyluce)
      * [What conda installs](#what-conda-installs)
      * [Added benefits](#added-benefits)
    - [Using Docker](#using-docker)
    - [Using Singularity](#using-singularity)
  + [phyluce configuration](#phyluce-configuration)
  + [Other useful tools](#other-useful-tools)
* [Phyluce Tutorials](tutorials/index.html)
* [Phyluce in Daily Use](daily-use/index.html)

* [Citing](citing.html)
* [License](license.html)
* [Attributions](attributions.html)
* [Funding](funding.html)
* [Acknowledgements](ack.html)

[phyluce](index.html)

* Installation
* [View page source](_sources/installation.rst.txt)

---

# Installation[](#installation "Link to this heading")

[phyluce](https://github.com/faircloth-lab/phyluce) uses a number of tools that allow it to assemble data, search for UCE
loci, align resulting reads, manipulate alignments, prepare alignments for
analysis, etc. To accomplish these goals, [phyluce](https://github.com/faircloth-lab/phyluce) uses wrappers around a
number of programs that do each of these tasks (sometimes phyluce can use
several different programs that accomplish the same task in different ways).
As a result, the
[dependency chain](http://en.wikipedia.org/wiki/Dependency_hell) (the
programs that [phyluce](https://github.com/faircloth-lab/phyluce) requires to run) is reasonably complex.

In the current versions (> 1.7.x), **we very strongly suggest** that
users install [phyluce](https://github.com/faircloth-lab/phyluce) using the [miniconda](https://conda.io/miniconda.html) Python distribution.

Attention

We do not support installing phyluce through means other than the
[conda](http://docs.continuum.io/conda/) installer. This means that we do not test [phyluce](https://github.com/faircloth-lab/phyluce) against any
binaries, other than those we build and distribute through [conda](http://docs.continuum.io/conda/).
Although you can configure [phyluce](https://github.com/faircloth-lab/phyluce) to use binaries
of different provenance, this is not officially supported.

Attention

We do not support [phyluce](https://github.com/faircloth-lab/phyluce) on Windows, although you technically
should be able to install [phyluce](https://github.com/faircloth-lab/phyluce) on Windows using the Windows Subsystem
for Linux (WSL) and installing Ubuntu 20.04 LTS from the Windows Store.
You should also be able to use the [docker](https://www.docker.com) image.

Note

We build and test the binaries available through [conda](http://docs.continuum.io/conda/) using
64-bit operating systems that include:

* MacOS 10.15
* Ubuntu 20.04 LTS

We will officially support MacOS 10.16 when the [github](https://github.com/faircloth-lab/phyluce) build system
offers this platform for automated tests.

[phyluce](https://github.com/faircloth-lab/phyluce) is also available for use as a [docker](https://www.docker.com) image. Underneath the hood
the [docker](https://www.docker.com) image runs Ubuntu 20.04 LTS and installs [phyluce](https://github.com/faircloth-lab/phyluce) and related
packages using [conda](http://docs.continuum.io/conda/).

## Install Process[](#install-process "Link to this heading")

### Using Conda[](#using-conda "Link to this heading")

The installation process is a 2-step process. You need to:

1. Install [miniconda](https://conda.io/miniconda.html)
2. Install [phyluce](https://github.com/faircloth-lab/phyluce)

Installing [phyluce](https://github.com/faircloth-lab/phyluce) will install all of the required binaries, libraries, and
[Python](http://www.python.org) dependencies that you need to run the program.

#### Install miniconda[](#install-miniconda "Link to this heading")

First, you need to install [miniconda](https://conda.io/miniconda.html). Follow the instructions for your platform that
are available from [conda.io](https://conda.io/docs/user-guide/install/index.html).
After you have run the install process **be sure** that you:

1. close and re-open your terminal window
2. run `conda list` which should produce output

#### Install phyluce[](#install-phyluce "Link to this heading")

Current practice with [conda](http://docs.continuum.io/conda/) is to keep all environments separate and **not**
to use the base environment as a “default” environment. So, we will be
installing [phyluce](https://github.com/faircloth-lab/phyluce) into an environment named `phyluce-X.x.x` where the
`X.x.x` represents the version you choose.

1. Go to the [phyluce github release page](https://github.com/faircloth-lab/phyluce/releases)
2. Download the appropriate `*.yml` file for the [phyluce](https://github.com/faircloth-lab/phyluce) version
   you want and the **operating system you are using**
3. Install that into an environment corresponding to the phyluce
   version, e.g. `phyluce-1.7.0` following the instructions on the [phyluce](https://github.com/faircloth-lab/phyluce) release page

This will create an environment named `phyluce-X.x.x`, then download and install
everything you need to run [phyluce](https://github.com/faircloth-lab/phyluce) into this `phyluce-X.x.x` [conda](http://docs.continuum.io/conda/) environment.

To use your new [phyluce](https://github.com/faircloth-lab/phyluce) environment, you **must** run (replace `X.x.x` with the
correct version):

```
conda activate phyluce-X.x.x
```

To stop using this phyluce environment, you **must** run:

```
conda deactivate
```

#### What conda installs[](#what-conda-installs "Link to this heading")

When you install phyluce, it specifies a number of dependencies that it needs
to run. If you would like to know **everything** that [conda](http://docs.continuum.io/conda/) has
installed, you can open up the `*.yml` you downloaded (it is simply a text file)
and take a look at the contents.

From within the [conda](http://docs.continuum.io/conda/) environment, you can also run

```
conda activate phyluce-X.x.x
conda list
```

#### Added benefits[](#added-benefits "Link to this heading")

An added benefit of using [conda](http://docs.continuum.io/conda/) is that you can also run all of the 3rd-party
binaries without worrying about setting the correct $PATH, etc.

For example, [phyluce](https://github.com/faircloth-lab/phyluce) requires MUSCLE for installation, and MUSCLE was installed
by [conda](http://docs.continuum.io/conda/) as a dependency of [phyluce](https://github.com/faircloth-lab/phyluce). Because conda puts all of these binaries
in your `$PATH` when the environment is activateed, we can also just run MUSCLE
on the command-line, with, e.g.,:

```
$ muscle -version

MUSCLE v3.8.1551 by Robert C. Edgar
```

### Using Docker[](#using-docker "Link to this heading")

We also provide [phyluce](https://github.com/faircloth-lab/phyluce) as a [docker](https://www.docker.com) image, which means you can run the [phyluce](https://github.com/faircloth-lab/phyluce) installation anywhere that you can run [docker](https://www.docker.com). The [docker](https://www.docker.com) image is built on Ubuntu 20.04 LTS using [conda](http://docs.continuum.io/conda/). To pull the docker image:

1. Go to the [phyluce github release page](https://github.com/faircloth-lab/phyluce/releases)
2. Find the [phyluce](https://github.com/faircloth-lab/phyluce) release you want (usually the most recent)
3. Run the `docker pull` command listed

Although using [docker](https://www.docker.com) is beyond the scope of this guide, you can run [phyluce](https://github.com/faircloth-lab/phyluce) within a docker using a command similar to the following, e.g.:

```
docker run fairclothlab/phyluce:<version> phyluce <phyluce_program_name>
```

Where `<version>` corresponds to the version of phyluce you are using. When you run this, all commands are run in the default directory `/work` and the user within the container is named `phyluce`.

You will very likely want to mount a local directory (on your computer) to this `/work` directory in the docker container and make yourself the owner of the result files. If you are working in `/home/you/phyluce` on your computer, you can accomplish all of by running phyluce like (using phyluce 1.7.0 as an example):

```
docker run \
    -v /home/you/phyluce:/data \
    --user $(id -u):$(id -g) \
    fairclothlab/phyluce:1.7.0 \
    phyluce_assembly_assemblo_spades \
    --output spades-test \
    --config assembly.conf \
    --cores 12
```

The `-v /home/you/phyluce:/data` maps your directory (`/home/you/phyluce`) onto the container working directory (`/work`), the `--user $(id -u):$(id -g)` makes the owner of the files in the container your user and group, the `fairclothlab/phyluce:1.7.0` is the name of the image to use, and the rest are standard phyluce commands.

Finally, you may want to run many commands in the [docker](https://www.docker.com) container (e.g. as in an entire analysis run). This can be accomplished by starting a [bash\_](#id3) shell in the container, and working from within the container’s bash prompt, as in:

```
docker run \
    -v /home/you/phyluce:/data \
    --user $(id -u):$(id -g) \
    -i -t fairclothlab/phyluce:1.7.0 \
    /bin/bash

# this drops you into the shell, where you can run commands, e.g.:
@d51aa2f2d565:/data$ phyluce_assembly_assemblo_spades -h
```

### Using Singularity[](#using-singularity "Link to this heading")

If you are using [Singularity](https://sylabs.io), you should be able to pull the [Docker](https://www.docker.com) image, and convert it for use, although this is not tested and is not supported. For example:

```
singularity pull docker://fairclothlab/phyluce:1.7.0
```

If that does not work, you could also use the [phyluce Dockerfile](https://raw.githubusercontent.com/faircloth-lab/phyluce/main/docker/Dockerfile) to create a [Singularity](https://sylabs.io) definition file, and build a [Singularity](https://sylabs.io) image.

## phyluce configuration[](#phyluce-configuration "Link to this heading")

As of v1.5.x, [phyluce](https://github.com/faircloth-lab/phyluce) uses a configuration file to keep track of paths to relevant
binaries, as well as some configuration information. This file is located at
`$CONDA_PREFIX/phyluce/config`. Although you can edit this file directly, you
can also create a user-specific configuration file at ~/.phyluce.conf (**note the
preceding dot**), which will override the default values with different paths.

So, if you need to use a slightly different binary or you want to experiment
with new binaries (e.g. for assembly), then you can change the paths in this
file rather than deal with hard-coded paths.

Attention

This **WILL NOT** work for the [docker](https://www.docker.com) image by default. You
also do NOT **need** create this file unless you realy know what you are
doing.

Warning

Changing the $PATHs in the config file can break things pretty
substantially, so please use with caution. If you are making changes,
edit the copy at `~/.phyluce.conf`) rather than the default copy.

The format of the config file as of v1.7.0 looks similar to the following:

```
[binaries]
abyss:$CONDA/bin/ABYSS
abyss-pe:$CONDA/bin/abyss-pe
bcftools:$CONDA/bin/bcftools
bedtools:$CONDA/bin/bedtools
bwa:$CONDA/bin/bwa
gblocks:$CONDA/bin/Gblocks
lastz:$CONDA/bin/lastz
mafft:$CONDA/bin/mafft
muscle:$CONDA/bin/muscle
pilon:$CONDA/bin/pilon
raxml-ng:$CONDA/bin/raxml-ng
samtools:$CONDA/bin/samtools
seqtk:$CONDA/bin/seqtk
spades:$CONDA/bin/spades.py
trimal:$CONDA/bin/trimal
velvetg:$CONDA/bin/velvetg
velveth:$CONDA/bin/velveth
snakemake:$CONDA/bin/Snakemake

[workflows]
mapping:$WORKFLOWS/mapping/Snakefile
correction:$WORKFLOWS/contig-correction/Snakefile
phasing:$WORKFLOWS/phasing/Snakefile

#----------------
#    Advanced
#----------------

[headers]
trinity:comp\d+_c\d+_seq\d+|c\d+_g\d+_i\d+|TR\d+\|c\d+_g\d+_i\d+|TRINITY_DN\d+_c\d+_g\d+_i\d+
velvet:node_\d+
abyss:node_\d+
idba:contig-\d+_\d+
spades:NODE_\d+_length_\d+_cov_\d+.\d+

[spades]
max_memory:4
cov_cutoff:5
```

## Other useful tools[](#other-useful-tools "Link to this heading")

You will need to be familiar with the command-line/terminal, and it helps to
have a decent text editor for your platform. Here are some suggestions that
are free:

* [vscode](https://code.visualstudio.com/)
* [atom](https://atom.io/)

[Previous](purpose.html "Purpose")
[Next](tutorials/index.html "Phyluce Tutorials")

---

© Copyright 2012-2024, Brant C. Faircloth.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).