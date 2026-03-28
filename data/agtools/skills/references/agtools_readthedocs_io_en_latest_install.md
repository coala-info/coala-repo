[agtools](..)

Home

* [Introduction](..)

Getting Started

* Installation
  + [PyPI](#pypi)
  + [Conda](#conda)
  + [Installing agtools from source](#installing-agtools-from-source)
* [Quick Start](../quickstart/)

Guides

* CLI Examples
  + [Obtaining stats](../examples/stats/)
  + [Renaming elements](../examples/rename/)
  + [Concatenating multiple graphs](../examples/concat/)
  + [Filtering segments](../examples/filter/)
  + [Cleaning a graph file](../examples/clean/)
  + [Get component of a segment](../examples/component/)
  + [Format conversion](../examples/formatconv/)
* [API Tutorial](../tutorial/)
* [Assembler examples](../assemblerexamples/)
* [More examples](../moreexamples/)
* [Applications](../exampleapplications/)

Reference

* [CLI Commands](../cli/)
* [API Documentation](../api/)
* [File Formats](../fileformats/)

Support

* [FAQ](../faq/)
* [Changelog](../changelog/)

[agtools](..)

* Getting Started
* Installation
* [Edit on GitHub](https://github.com/Vini2/agtools/edit/master/docs/install.md)

---

# Installing *agtools*

It is recommended to install *agtools* using either [PyPI](https://pypi.org/project/agtools/) or [Conda](https://anaconda.org/bioconda/agtools).

## PyPI

To install *agtools* globally, use the following command.

```
pip install agtools
```

## Conda

You can install *agtools* through [Bioconda](https://anaconda.org/bioconda/agtools) using `conda` or [`mamba`](https://mamba.readthedocs.io/en/latest/index.html).

```
mamba install -c bioconda agtools
```

If you prefer to install *agtools* in your own environment, you can do so as follows.

```
mamba create -n agtools
mamba activate agtools
mamba install -c bioconda agtools
```

OR

```
mamba create -n agtools -c bioconda agtools
mamba activate agtools
```

## Installing *agtools* from source

If you want to use the development version of *agtools*, you can install it using `flit` as follows. Please make sure you have [`flit`](https://flit.pypa.io/en/stable/) installed beforehand.

```
# clone repository
git clone https://github.com/Vini2/agtools.git

# move to gbintk directory
cd agtools

# create and activate conda env
conda env create -f environment.yml
conda activate agtools

# install using flit
flit install -s --python `which python`

# test installation
agtools --help
```

If you don't want to create your own environment but just install *agtools*, please make sure you have the following packages installed.

* [`flit`](https://flit.pypa.io/en/stable/) - for installation
* [`click`](https://click.palletsprojects.com/en/stable/) - for CLI argument parsing
* [`loguru`](https://loguru.readthedocs.io/en/stable/) - for logging
* [`bidict`](https://bidict.readthedocs.io/en/main/intro.html) - for bidirectional lookup
* [`python-igraph`](https://python.igraph.org/en/stable/index.html) - for graph operations
* [`biopython`](https://biopython.org/) - for sequence operations
* [`pandas`](https://pandas.pydata.org/) - for dataframes

[Previous](.. "Introduction")
[Next](../quickstart/ "Quick Start")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).