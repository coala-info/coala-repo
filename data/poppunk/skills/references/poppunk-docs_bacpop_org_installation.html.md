Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[PopPUNK 2.7.0 documentation](index.html)

[![Logo](_static/poppunk_v2.png)

PopPUNK 2.7.0 documentation](index.html)

Contents:

* [PopPUNK documentation](index.html)
* Installation
* [Overview](overview.html)
* [Sketching (`--create-db`)](sketching.html)
* [Data quality control (`--qc-db`)](qc.html)
* [Fitting new models (`--fit-model`)](model_fitting.html)
* [Distributing PopPUNK models](model_distribution.html)
* [Query assignment (`poppunk_assign`)](query_assignment.html)
* [Creating visualisations](visualisation.html)
* [Minimum spanning trees](mst.html)
* [Subclustering with PopPIPE](subclustering.html)
* [Using GPUs](gpu.html)
* [Troubleshooting](troubleshooting.html)
* [Scripts](scripts.html)
* [Iterative PopPUNK](poppunk_iterate.html)
* [Citing PopPUNK](citing.html)
* [Reference documentation](api.html)
* [Roadmap](roadmap.html)
* [Miscellaneous](miscellaneous.html)

Back to top

[View this page](_sources/installation.rst.txt "View this page")

# Installation[¶](#installation "Link to this heading")

The easiest way to install is through conda, which will also install the
dependencies:

```
conda install poppunk
```

Then run with `poppunk`.

Important

From v2.1.0 onwards, PopPUNK requires python3.8 to run
(which on many default Linux installations is
run using `python3` rather than `python`).

Important

From v2.1.2 onwards, PopPUNK no longer supports `mash`. If you want to
use older databases created with `mash`, please downgrade to <v2

## Installing with conda (recommended)[¶](#installing-with-conda-recommended "Link to this heading")

If you do not have `conda` you can install it through
[miniconda](https://conda.io/miniconda.html) and then add the necessary
channels:

```
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```

Then run:

```
conda install poppunk
```

If you want to use GPUs, take a look at [Using GPUs](gpu.html).

If you are having conflict issues with conda, our advice would be:

* Remove and reinstall miniconda.
* Never install anything in the base environment
* Create a new environment for PopPUNK with `conda create -n pp_env poppunk`

If you have an older version of PopPUNK, you can upgrade using this method – you
may also wish to specify the version, for example `conda install poppunk==2.3.0` if you
wish to upgrade.

conda-forge also has some helpful tips: <https://conda-forge.org/docs/user/tipsandtricks.html>

## Installing with pip[¶](#installing-with-pip "Link to this heading")

If you do not have conda, you can also install through pip:

```
python3 -m pip install poppunk
```

This may not deal with all necessary dependencies, but we are working on it
and it should again be possible in an upcoming release.

## Clone the code[¶](#clone-the-code "Link to this heading")

You can also clone the github to run the latest version, which is executed by:

```
git clone https://github.com/bacpop/PopPUNK.git && cd PopPUNK
python3 setup.py build
python3 setup.py install
python3 poppunk-runner.py
```

This will also give access to the [Scripts](scripts.html#scripts).

You will need to install the dependencies yourself (you can still use
conda or pip for this purpose). See `environment.yml`:

```
mamba env create -f environment.yml
conda activate pp_env
```

[Next

Overview](overview.html)
[Previous

Home](index.html)

Copyright © 2018-2025, John Lees and Nicholas Croucher

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Installation
  + [Installing with conda (recommended)](#installing-with-conda-recommended)
  + [Installing with pip](#installing-with-pip)
  + [Clone the code](#clone-the-code)