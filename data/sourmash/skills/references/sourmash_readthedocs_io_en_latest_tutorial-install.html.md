# Installing sourmash[¶](#installing-sourmash "Link to this heading")

This tutorial should run without modification on Linux or Mac OS X,
under [Miniforge](https://github.com/conda-forge/miniforge).

You’ll need about 5 GB of free disk space.

## Install miniforge[¶](#install-miniforge "Link to this heading")

If you don’t have the `mamba` command installed, you’ll need to install
[miniforge](https://github.com/conda-forge/miniforge#install).

On Linux, this should work:

```
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b

~/miniforge3/bin/mamba init

echo 'source ~/.bashrc' > ~/.bash_profile
source ~/.bash_profile
```

otherwise, follow the instructions [here](https://github.com/conda-forge/miniforge#install).

## Install sourmash[¶](#install-sourmash "Link to this heading")

To install sourmash, create a new environment named `smash` and install sourmash:

```
mamba create -y -n smash sourmash-minimal
```

and then activate:

```
conda activate smash
```

You should now be able to use the `sourmash` command:

```
sourmash info
```

Voila!

[![Logo](_static/logo.png)

# sourmash](index.html)

Quickly search, compare, and analyze genomic and metagenomic data sets

### Navigation

* [Tutorials and examples](sidebar.html)
* [How-To Guides](sidebar.html#how-to-guides)
* [Frequently Asked Questions](sidebar.html#frequently-asked-questions)
* [How sourmash works under the hood](sidebar.html#how-sourmash-works-under-the-hood)
* [Reference material](sidebar.html#reference-material)
* [Developing and extending sourmash](sidebar.html#developing-and-extending-sourmash)
* [Full table of contents for all docs](sidebar.html#full-table-of-contents-for-all-docs)
* [Using sourmash from the command line](command-line.html)
* [Prepared databases](databases.html)
* [`sourmash` Python API examples](api-example.html)
* [How to cite sourmash](cite.html)

### Related Topics

* [Documentation overview](index.html)

### This Page

* [Show Source](_sources/tutorial-install.md.txt)

### Quick search

©2016-2023, C. Titus Brown, Luiz Irber, and N. Tessa Pierce-Ward.
|
Powered by [Sphinx 9.0.4](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](_sources/tutorial-install.md.txt)