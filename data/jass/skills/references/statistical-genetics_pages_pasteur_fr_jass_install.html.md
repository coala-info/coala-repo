[JASS](index.html)

Contents:

* [What is JASS: A python package to perform Multi-trait GWAS](about.html)
* Installation
  + [Installation with pip (recommended)](#installation-with-pip-recommended)
    - [Additional software installation on Linux](#additional-software-installation-on-linux)
* [Data preparation](data_import.html)
* [Compute Multi-trait GWAS with JASS](generating_joint_analysis.html)
* [References](bibliography.html)
* [Command line reference](command_line_usage.html)
* [Developer documentation](develop.html)

[JASS](index.html)

* Installation
* [Edit on GitLab](https://gitlab.pasteur.fr/statistical-genetics/jass/blob/master/doc/source/install.rst)

---

# Installation[](#installation "Permalink to this heading")

You can use JASS locally through the command line interface in a terminal.
You need **python3** to install and use JASS. As of May 2025, JASS runs on python from 3.8 to 3.12.

## Installation with pip (recommended)[](#installation-with-pip-recommended "Permalink to this heading")

We advise users to install jass in a virtual environment

```
python3 -m venv $PATH_NEW_ENVIRONMENT
source $PATH_NEW_ENVIRONMENT/bin/activate
pip3 install git+https://gitlab.pasteur.fr/statistical-genetics/jass.git
pip3 install -r https://gitlab.pasteur.fr/statistical-genetics/jass/-/raw/master/requirements.txt
```

### Additional software installation on Linux[](#additional-software-installation-on-linux "Permalink to this heading")

Some python packages require additional non-python software that you might need to install, e.g. on Ubuntu, with:

```
sudo apt install libfreetype6-dev #(required by matplotlib)
sudo apt install libhdf5-dev #(required by tables)
```

[Previous](about.html "What is JASS: A python package to perform Multi-trait GWAS")
[Next](data_import.html "Data preparation")

---

© Copyright 2018, Hugues Aschard, Vi.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).