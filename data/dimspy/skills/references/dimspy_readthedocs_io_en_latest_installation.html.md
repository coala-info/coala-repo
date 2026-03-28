[DIMSPy](index.html)

latest

* Installation
  + [Conda (recommended)](#conda-recommended)
  + [PyPi](#pypi)
  + [Testing](#testing)
* [API reference](api-reference.html)
* [Command Line Interface](cli.html)
* [Credits](credits.html)
* [Bugs and Issues](bugs-and-issues.html)
* [Changelog](changelog.html)
* [Citation](citation.html)
* [License](license.html)

[DIMSPy](index.html)

* [Docs](index.html) »
* Installation
* [Edit on GitHub](https://github.com/computational-metabolomics/dimspy/blob/master/docs/source/installation.rst)

---

# Installation[¶](#installation "Permalink to this headline")

## Conda (recommended)[¶](#conda-recommended "Permalink to this headline")

Install Miniconda, follow the steps described [here](https://docs.conda.io/projects/conda/en/latest/user-guide/install)

Start the `conda prompt`

* Windows: Open the `Anaconda Prompt` via the Start menu
* macOS or Linux: Open a `Terminal`

Create a dimspy specific `conda` environment.
This will install a the dependencies required to run `dimspy`:

```
$ conda create --yes --name dimspy dimspy -c conda-forge -c bioconda -c computational-metabolomics
```

Note

* The installation process will take a few minutes.
* Feel free to use a different name for the Conda environment

You can use the following command to remove a conda environment:

```
$ conda env remove -y --name dimspy
```

This is only required if something has gone wrong in the previous step.

Activate the `dimspy` environment:

```
$ conda activate dimspy
```

To test your `dimspy` installation, in your Conda Prompt, run the command:

```
$ dimspy --help
```

or:

```
$ python
import dimspy
```

Close and deactivate the `dimspy` environment when you’re done:

```
$ conda deactivate
```

## PyPi[¶](#pypi "Permalink to this headline")

Install the current release of `dimspy` with `pip`:

```
$ pip install dimspy
```

Note

* The installation process will take a few minutes.

To upgrade to a newer release use the `--upgrade` flag:

```
$ pip install --upgrade dimspy
```

If you do not have permission to install software systemwide, you can
install into your user directory using the `--user` flag:

```
$ pip install --user dimspy
```

Alternatively, you can manually download `dimspy` from
[GitHub](https://github.com/computational-metabolomics/dimspy/releases) or
[PyPI](https://pypi.python.org/pypi/dimspy).
To install one of these versions, unpack it and run the following from the
top-level source directory using the Terminal:

```
$ pip install .
```

## Testing[¶](#testing "Permalink to this headline")

DIMSpy uses the Python `pytest` testing package. You can learn more
about pytest on their [homepage](https://pytest.org).

[Next](api-reference.html "API reference")
 [Previous](index.html "Welcome to DIMSpy’s documentation!")

---

© Copyright 2019, Ralf Weber, Jiarui (Albert) Zhou
Revision `4a0b8982`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).