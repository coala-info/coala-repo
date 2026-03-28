[View on GitHub](https://github.com/BackofenLab/IntaRNA)

# IntaRNA

## Efficient target prediction incorporating accessibility of interaction sites

# IntaRNA [![releases](https://img.shields.io/github/tag/BackofenLab/IntaRNA.svg)](https://github.com/BackofenLab/IntaRNA/releases) [![Bioconda](https://anaconda.org/bioconda/intarna/badges/version.svg)](https://anaconda.org/bioconda/intarna)

**Efficient RNA-RNA interaction prediction incorporating accessibility and
seeding of interaction sites**

During the last few years, several new small regulatory RNAs
(sRNAs) have been discovered in bacteria. Most of them act as post-transcriptional
regulators by base pairing to a target mRNA, causing translational repressionex
or activation, or mRNA degradation. Numerous sRNAs have already been identified,
but the number of experimentally verified targets is considerably lower.
Consequently, computational target prediction is in great demand. Many existing
target prediction programs neglect the accessibility of target sites and the
existence of a seed, while other approaches are either specialized to certain
types of RNAs or too slow for genome-wide searches.

IntaRNA, developed by
[Prof. Backofen’s bioinformatics group at Freiburg University](http://www.bioinf.uni-freiburg.de),
is a general and fast approach to the
prediction of RNA-RNA interactions incorporating both the accessibility of
interacting sites
as well as the existence of a user-definable seed interaction. We successfully applied
IntaRNA to the prediction of bacterial sRNA targets and determined the exact
locations of the interactions with a higher accuracy than competing programs.

For testing or ad hoc use of IntaRNA, you can use its webinterface at the

**==> [Freiburg RNA tools IntaRNA webserver](http://rna.informatik.uni-freiburg.de/IntaRNA/) <==**

## Contribution

Feel free to contribute to this project by writing
[Issues](https://github.com/BackofenLab/IntaRNA/issues)
with feature requests, bug reports, or just contact messages.

## Citation

If you use IntaRNA, please cite our respective articles

#### Method

* [IntaRNA 2.0: enhanced and customizable prediction of RNA-RNA interactions](https://doi.org/10.1093/nar/gkx279)
  Martin Mann, Patrick R. Wright, and Rolf Backofen,
  Nucleic Acids Research, 45 (W1), W435–W439, 2017, DOI:[10.1093/nar/gkx279](https://doi.org/10.1093/nar/gkx279).
* [IntaRNA: efficient prediction of bacterial sRNA targets incorporating target site accessibility and seed regions](https://doi.org/10.1093/bioinformatics/btn544)
  Anke Busch, Andreas S. Richter, and Rolf Backofen,
  Bioinformatics, 24 no. 24 pp. 2849-56, 2008, DOI:[10.1093/bioinformatics/btn544](https://doi.org/10.1093/bioinformatics/btn544).

#### Features and Application

* [Integration of accessibility data from structure probing into RNA–RNA interaction prediction](https://doi.org/10.1093/bioinformatics/bty1029)
  Milad Miladi, Soheila Montaseri, Rolf Backofen, Martin Raden,
  Bioinformatics, 2019, DOI:[10.1093/bioinformatics/bty1029](https://doi.org/10.1093/bioinformatics/bty1029).
* [IntaRNAhelix - Composing RNA-RNA interactions from stable inter-molecular helices boosts bacterial sRNA target prediction](https://doi.org/10.1142/S0219720019400092)
  Rick Gelhausen, Sebastian Will, Ivo L. Hofacker, Rolf Backofen, and Martin Raden,
  Journal of Bioinformatics and Computational Biology, 2019, 17(5), 1940009, DOI:[10.1142/S0219720019400092](https://doi.org/10.1142/S0219720019400092).
* [CopraRNA and IntaRNA: predicting small RNA targets, networks and interaction domains](https://doi.org/10.1093/nar/gku359)
  Patrick R. Wright, Jens Georg, Martin Mann, Dragos A. Sorescu, Andreas S. Richter, Steffen Lott, Robert Kleinkauf, Wolfgang R. Hess, and Rolf Backofen,
  Nucleic Acids Research, 42 (W1), W119-W123, 2014, DOI:[10.1093/nar/gku359](https://doi.org/10.1093/nar/gku359).
* [The impact of various seed, accessibility and interaction constraints on sRNA target prediction- a systematic assessment](https://doi.org/10.1186/s12859-019-3143-4).
  Martin Raden, Teresa Müller, Stefan Mautner, Rick Gelhausen, and Rolf Backofen,
  BMC Bioinformatics, 21 (15), 2020, DOI:[10.1186/s12859-019-3143-4](https://doi.org/10.1186/s12859-019-3143-4).

# Documentation

## Overview

The following topics are covered by this documentation:

* [Installation](#install)
  + [IntaRNA via conda](#instconda)
  + [IntaRNA docker container](#instdocker)
  + [Dependencies](#deps)
  + [Cloning from github](#instgithub)
  + [Source code distribution](#instsource)
  + [Microsoft Windows installation](#instwin)
  + [OS X installation with homebrew](#instosx)
* [Usage and Parameters](#usage)
* [Just run …](#defaultRun)
  + [Multi-threading and parallelized computation](#multithreading)
  + [Load arguments from file](#parameterFile)
* [General things you should know](#generalInformation)
  + [Interaction Model](#interactionModel)
    - [Single-site, loop-based RNA-RNA interaction](#interactionModel-ssUnconstraintMfe)
    - [Single-site, ensemble-based RNA-RNA interaction](#interactionModel-ssProbability)
    - [Single-site, helix-based RNA-RNA interaction](#interactionModel-ssHelixBlockMfe)
  + [Prediction modes](#predModes)
    - [Emulating other RNA-RNA interaction prediction tools](#predEmulateTools)
    - [Limiting memory consumption - window-based prediction](#predWindowBased)
  + [IntaRNA’s multiple personalities](#personality)
    - [IntaRNA - fast, heuristic RNA-RNA interaction prediction](#IntaRNA)
    - [IntaRNAhelix - helix-based predictions](#IntaRNAhelix)
    - [IntaRNAexact - exact predictions like RNAup](#IntaRNAexact)
    - [IntaRNAduplex - hybrid-only optimization like RNAduplex](#IntaRNAduplex)
    - [IntaRNAsTar - optimized for sRNA-target prediction](#IntaRNAsTar)
    - [IntaRNAseed - identifys and reports seed interactions only](#IntaRNAseed)
    - [IntaRNAens - ensemble-based prediction and partition function computation](#IntaRNAens)
* [How to constrain predicted interactions](#constraintSetup)
  + [Interaction restrictions](#interConstr)
  + [Seed constraints](#seed)
  + [Explicit seed input](#seedExplicit)
  + [Helix constraints](#helix)
  + [SHAPE reactivity data to enhance accessibility computation](#shape)
* [Output Setup](#outputSetup)
  + [Output modes](#outmodes)
  + [Pairwise vs. all-vs-all](#outpairwise)
  + [Sequence indexing](#idxPos0)
  + [Suboptimal RNA-RNA interaction prediction and output restrictions](#subopts)
  + [Energy parameters and temperature](#energy)
  + [Additional output files](#outFiles)
    - [Minimal energy profiles](#profileMinE)
    - [Minimal energy for all intermolecular index pairs](#pairMinE)
    - [Spot probability profiles](#profileSpotProb) using partition functions
    - [Interaction probabilities for interaction spots of interest](#spotProb)
    - [Accessibility and unpaired probabilities](#accessibility)
      * [Local versus global unpaired probabilities](#accLocalGlobal)
      * [Constrain regions to be accessible or blocked](#accConstraints)
      * [Scaling factors for partition function computation for accessibility estimation](#accPfScale)
      * [Read/write accessibility from/to file or stream](#accFromFile)
* [Library for integration in external tools](#lib)
* [Auxiliary R scripts for output visualization etc.](/R)
* [Auxiliary python scripts for IntaRNA-based pipelines](/python)

# Installation

## IntaRNA via conda (bioconda channel)

The most easy way to locally install IntaRNA is via conda using the
[bioconda](https://bioconda.github.io/)
channel (linux only). This way, you will install a pre-built IntaRNA binary along
with all dependencies.
Follow
[![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat-square)](http://bioconda.github.io/recipes/intarna/README.html)
to get detailed information or run the following command to install it to the currently activated environment.

```
conda install -c conda-forge -c bioconda intarna
```

**Note**: Conda is available for Windows, MacOs and Linux. We recommend the [Miniconda installation](https://docs.anaconda.com/miniconda/install/#quick-command-line-install)

**Note further**: *Windows user without Powershell or Commandline experience* might [consider to first install a Linux App via WSL](https://documentation.ubuntu.com/wsl/en/latest/howto/install-ubuntu-wsl2/) and use and install conda therein since most related scripts will be tailored for Linux BASH shells or similar systems.

[![up](/IntaRNA/doc/figures/icon-up.28.png) back to overview](#overview)

## IntaRNA docker container (via QUAY.IO)

An [IntaRNA docker container](https://quay.io/repository/biocontainers/intarna)
([?](https://www.docker.com/)) is provided from the bioconda package via
[Quay.io](https://quay.io/). This gives
you with an encapsulated IntaRNA installation.

**Note** The `biocontainer` builds do not support the `latest` tag, such that you have to specify a version to download! So best

* open the [quay.io IntaRNA tag page](https://quay.io/repository/biocontainers/intarna?tab=tags)
* identify the tag of the container version you want to install, e.g. `3.4.1--pl5321h077b44d_3`
* use this tag in your container pull command as an appendix, e.g.
  + `podman pull quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3` or
  + `docker pull quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3`

[![up](/IntaRNA/doc/figures/icon-up.28.png) back to overview](#overview)

## Dependencies

If you are going to compile IntaRNA from source, ensure you meet the following
dependencies:

* compiler supporting C++11 standard and OpenMP
* [boost C++ library](http://www.boost.org/) version >= 1.50.0
  (ensure the following libraries are installed for development (not just runtime libraries!); or install all e.g. in Ubuntu via package `libboost-all-dev`)
  + libboost\_regex
  + libboost\_program\_options
  + libboost\_filesystem
  + libboost\_system
* [Vienna RNA package](http://www.tbi.univie.ac.at/RNA/) version >= 2.4.14
* `pkg-config` for detailed version checks of dependencies
* if [cloning from github](#instgithub): GNU autotools (automake, autoconf, ..)

Also used by IntaRNA, but already part of the source code distribution (and thus
not needed to be installed separately):

* [Catch](https://github.com/philsquared/Catch) test framework
* [Easylogging++](https://github.com/easylogging/easyloggingpp) logging framework

[![up](/IntaRNA/doc/figures/icon-up.28.png) back to overview](#overview)

## Cloning *Source code* from github (or downloading ZIP-file)

The data provided within the github repository
(or within the `Source code` archives provided at the
[IntaRNA release page](https://github.com/BackofenLab/IntaRNA/releases/latest))
is no complete distribution and
lacks all system specifically generated files. Thus, in order to get started with
a fresh clone of the IntaRNA source code repository you have to run the GNU autotools
to generate all needed files for a proper `configure` and `make`. To this end,
we provide the helper script `autotools-init.sh` that can be run as shown in the following.

```
# call aclocal, automake, autoconf
bash ./autotools-init.sh
```

Afterwards, you can continue as if you would have downloaded an
[IntaRNA package distribution](#instsource).

[![up](/IntaRNA/doc/figures/icon-up.28.png) back to overview](#overview)

## IntaRNA package distribution (e.g. `intaRNA-2.0.0.tar.gz`)

When downloading an IntaRNA package distribution (e.g. `intaRNA-2.0.0.tar.gz`) from the
[IntaRNA release page](https://github.com/BackofenLab/IntaRNA/releases/latest), you should
first ensure, that you have all [dependencies](#deps) installed. If so, you can
simply run the following (assuming `bash` shell).

```
# generate system specific files (use -h for options)
./configure
# compile IntaRNA from source
make
# run tests to ensure all went fine
make tests
# install (use 'configure --prefix=XXX' to change default install directory)
make install
# (alternatively) install to directory XYZ
make install prefix=XYZ
```

If you installed one of the dependencies in a non-standard directory, you have
to use the according `configure` options:

* `--with-vrna` : the prefix where the Vienna RNA package is installed
* `--with-boost` : the prefix where the boost library is installed

Note, the latter is for instance the case if your `configure` call returns an
error message as follows:

```
checking whether the Boost::System library is available... yes
configure: error: Could not find a version of the library!
```

In that case your boost libraries are most likely installed to a non-standard
directory that you have to specify either using `--with-boost` or just the
library directory via `--with-boost-libdir`.

[![up](/IntaRNA/doc/figures/icon-up.28.png) back to overview](#overview)

## Microsoft Windows installation

### … from source

IntaRNA can be compiled, installed, and used on a Microsoft Windows system when
e.g. using [Cygwin](https://www.cygwin.com/) as ‘linux emulator’. Just install
Cygwin with the following packages:

* *Devel*:
  + make
  + gcc-g++
  + autoconf
  + automake
  + pkg-config
* *Libs*:
  + libboost-devel
* *Perl*:
  + perl

and follow either [install from github](#instgithub) or
[install from package](#instsource).

*Note*, the source code comes without any waranties or what-so-ever
(see licence information)!

### … using pre-compiled binaries

For some releases, we also provide precompiled binary packages for Microsoft Windows at the
[IntaRNA release page](https://github.com/BackofenLab/IntaRNA/releases/latest)
that enable ‘out-of-the-box’ usage. If you
want to use them:

* [download](https://github.com/BackofenLab/IntaRNA/releases/latest) the according ZIP archive and extract
* open a [Windows command prompt](https://www.lifewire.com/how-to-open-command-prompt-2618089)
* [run IntaRNA](#usage)

*Note*, these binaries come without any waranties, support or what-so-ever!
They are just an offer due to user requests.

If you do not want to work within the IntaRNA directory or don’t want to provide
the full installation path with every IntaRNA call, you should add the installation
directory to your [`Path` System variable](http://www.computerhope.com/issues/ch000549.htm)
(using a semicolon `;` separator).

[![up](/IntaRNA/doc/figures/icon-up.28.png) back to overview](#overview)

## OS X installation with homebrew (thanks to Lars Barquist)

If you do not want to or can use the pre-compiled binaries for OS X available from
[bioconda](https://anaconda.org/bioconda/intarna), you can compile `IntaRNA`
locally.

The following wraps up how to build `IntaRNA-2.0.2` under OS X (Sierra 10.12.4) using homebrew.

First, install homebrew! :)

```
brew install gcc --without-multilib
```

`--without-multilib` is necessary for OpenMP multithreading support – note
OS X default `gcc`/`clang` doesn’t support OpenMP, so we need to install standard
`gcc`/`g++`

```
brew install boost --cc=gcc-6
