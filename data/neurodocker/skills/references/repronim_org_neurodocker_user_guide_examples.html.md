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
* Examples
* [Common Uses](common_uses.html)
* [Minify Containers](minify.html)
* [Templates and Renderers](templates_renderers.html)
* [Add software to Neurodocker](add_template.html)
* [Known Issues](known_issues.html)

* [User Guide](index.html)
* Examples

# Examples[#](#examples "Permalink to this heading")

This page includes examples of using Neurodocker to build containers with popular
neuroimaging packages.

## Supported software[#](#supported-software "Permalink to this heading")

* [\_default](n/a)
* [afni](https://afni.nimh.nih.gov)
* [ants](http://stnava.github.io/ANTs/)
* [bids\_validator](https://github.com/bids-standard/bids-validator)
* [cat12](https://neuro-jena.github.io/cat/)
* [convert3d](http://www.itksnap.org/pmwiki/pmwiki.php?n=Convert3D.Convert3D)
* [dcm2niix](https://www.nitrc.org/plugins/mwiki/index.php/dcm2nii%3AMainPage)
* [freesurfer](https://surfer.nmr.mgh.harvard.edu/)
* [fsl](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/)
* [jq](https://jqlang.github.io/jq/)
* [matlabmcr](https://www.mathworks.com/products/compiler/matlab-runtime.html)
* [minc](https://github.com/BIC-MNI/minc-toolkit-v2)
* [miniconda](https://docs.conda.io/projects/miniconda/en/latest/)
* [mricron](https://github.com/neurolabusc/MRIcron)
* [mrtrix3](https://www.mrtrix.org/)
* [ndfreeze](https://neuro.debian.net/pkgs/neurodebian-freeze.html)
* [neurodebian](https://neuro.debian.net)
* [niftyreg](https://github.com/KCL-BMEIS/niftyreg)
* [petpvc](https://github.com/UCL/PETPVC)
* [spm12](https://www.fil.ion.ucl.ac.uk/spm/)
* [vnc](https://www.realvnc.com/)

The commands generate Dockerfiles. To generate Singularity
recipes, simply replace

```
neurodocker generate docker
```

with

```
neurodocker generate singularity
```

To see the options for each package, please run

```
neurodocker generate docker --help
```

or

```
neurodocker generate singularity --help
```

Note

Neurodocker is meant to create command-line environments. At the moment, graphical
user interfaces (like FreeView and FSLEyes) are not installed properly. It is
possible that this will change in the future.

## FSL[#](#id1 "Permalink to this heading")

### Docker[#](#docker "Permalink to this heading")

```
neurodocker generate docker \
    --pkg-manager apt \
    --base-image debian:bullseye-slim \
    --fsl version=6.0.7.1 \
> fsl6071.Dockerfile

docker build --tag fsl:6.0.7.1 --file fsl6071.Dockerfile .
```

This will ask the following question interactively:

```
FSL is non-free. If you are considering commercial use of FSL, please consult the relevant license(s). Proceed? [y/N]
```

If you are using neurodocker non-interactively, this problem can be avoided using:

```
neurodocker generate docker \
    --pkg-manager apt \
    --base-image debian:buster-slim \
    --yes \
    --fsl version=6.0.4 \
> fsl604.Dockerfile

docker build --tag fsl:6.0.4 --file fsl604.Dockerfile .

# Run fsl's bet program.
docker run --rm -it fsl:6.0.4 bet
```

## AFNI[#](#id2 "Permalink to this heading")

### Docker[#](#afni-docker "Permalink to this heading")

```
neurodocker generate docker \
    --pkg-manager yum \
    --base-image fedora:40 \
    --afni method=binaries version=latest \
> afni-binaries.Dockerfile

docker build --tag afni:latest --file afni-binaries.Dockerfile .
```

This does not install AFNI’s R packages. To install relevant R things, use the following:

```
neurodocker generate docker \
    --pkg-manager yum \
    --base-image fedora:40 \
    --afni method=binaries version=latest install_r_pkgs=true \
> afni-binaries-r.Dockerfile

docker build --tag afni:latest-with-r --file afni-binaries-r.Dockerfile .
```

Todo

Building AFNI from source is currently failing on most tested distributions.

## FreeSurfer[#](#id5 "Permalink to this heading")

### Docker[#](#freesurfer-docker "Permalink to this heading")

```
neurodocker generate docker \
    --pkg-manager apt \
    --base-image debian:bullseye-slim \
    --freesurfer version=7.4.1 \
> freesurfer741.Dockerfile

docker build --tag freesurfer:7.4.1 --file freesurfer741.Dockerfile .
```

Todo

The minified version on Freesurfer currently fails to build on all tested distributions.

## ANTS[#](#id8 "Permalink to this heading")

```
neurodocker generate docker \
    --pkg-manager apt \
    --base-image debian:bullseye-slim \
    --ants version=2.4.3 \
> ants-234.Dockerfile

docker build --tag ants:2.4.3 --file ants-243.Dockerfile .
```

Note

Building docker images of ANTS from source fails on most tested distributions.

## CAT12[#](#id9 "Permalink to this heading")

CAT12 requires the MCR in the correction version.
Miniconda and nipype is optional but recommended to use CAT12 from NiPype.

```
neurodocker generate docker \
    --base-image ubuntu:22.04 \
    --pkg-manager apt \
    --mcr 2017b \
    --cat12 version=r2166_R2017b \
    --miniconda \
     version=latest \
     conda_install='python=3.11 traits nipype numpy scipy h5py scikit-image' \
> cat12-r2166_R2017b.Dockerfile

docker build --tag cat12:r2166_R2017b --file cat12-r2166_R2017b.Dockerfile .
```

## SPM[#](#spm "Permalink to this heading")

```
neurodocker generate docker \
    --pkg-manager apt \
    --base-image centos:7 \
    --spm12 version=r7771 \
> spm12-r7771.Dockerfile

docker build --tag spm12:r7771 --file spm12-r7771.Dockerfile .
```

Note

Building docker images of SPM12 from source fails on most tested distributions.

## Miniconda[#](#id10 "Permalink to this heading")

Docker with new `conda` environment, python packages installed with `conda` and `pip`.

```
neurodocker generate docker \
    --pkg-manager apt \
    --base-image debian:bullseye-slim \
    --miniconda \
        version=latest \
        env_name=env_scipy \
        env_exists=false \
        conda_install=pandas \
        pip_install=scipy \
> conda-env.Dockerfile

docker build --tag conda-env --file conda-env.Dockerfile .
```

### Docker[#](#id11 "Permalink to this heading")

[previous

Command-line Interface](cli.html "previous page")
[next

Common Uses](common_uses.html "next page")

On this page

* [Supported software](#supported-software)
* [FSL](#id1)
  + [Docker](#docker)
* [AFNI](#id2)
  + [Docker](#afni-docker)
* [FreeSurfer](#id5)
  + [Docker](#freesurfer-docker)
* [ANTS](#id8)
* [CAT12](#id9)
* [SPM](#spm)
* [Miniconda](#id10)
  + [Docker](#id11)

[Edit on GitHub](https://github.com/ReproNim/neurodocker/edit/master/docs/user_guide/examples.rst)

### This Page

* [Show Source](../_sources/user_guide/examples.rst.txt)

© Copyright 2017-2025, Neurodocker Developers.

Created using [Sphinx](https://www.sphinx-doc.org/) 6.2.1.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.