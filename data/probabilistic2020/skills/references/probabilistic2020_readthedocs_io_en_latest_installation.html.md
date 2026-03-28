[Probabilistic 20/20](index.html)

latest

* [Download](download.html)
* Installation
  + [Python Package Installation](#python-package-installation)
  + [Local installation](#local-installation)
* [Quick Start](quickstart.html)
* [Tutorial](tutorial.html)
* [FAQ](faq.html)

[Probabilistic 20/20](index.html)

* [Docs](index.html) »
* Installation
* [Edit on GitHub](https://github.com/KarchinLab/probabilistic2020/blob/master/doc/installation.rst)

---

# Installation[¶](#installation "Permalink to this headline")

[![https://travis-ci.org/KarchinLab/probabilistic2020.svg?branch=master](https://travis-ci.org/KarchinLab/probabilistic2020.svg?branch=master)](https://travis-ci.org/KarchinLab/probabilistic2020)

## Python Package Installation[¶](#python-package-installation "Permalink to this headline")

Using the python package installation, all the required python packages for the probabibilistic 20/20 test will automatically be installed for you. We recommend use of python version 3.6, if possible.

To install the package into python you can use pip. If you are installing to a system wide python then you may need to use sudo before the pip command.

```
$ pip install probabilistic2020
```

The scripts for Probabilstic 20/20 can then be found in Your\_Python\_Root\_Dir/bin. You can
check the installation with the following:

```
$ which probabilistic2020
$ probabilistic2020 --help
```

## Local installation[¶](#local-installation "Permalink to this headline")

Local installation is a good option if you do not have privilege to install a python package and already have the required packages. The source files can also be manually downloaded from github at <https://github.com/KarchinLab/probabilistic2020/releases>.

**Required packages:**

* numpy
* scipy
* pandas>=0.17.0
* pysam

If you don’t have the above required packages, you will need to install them. For the following commands to work you will need [pip](http://pip.readthedocs.org/en/latest/installing.html). If you are using a system wide python, you will need to use sudo before the pip command.

```
$ cd probabilstic2020
$ pip install -r requirements.txt
```

Next you will need to build the Probabilistic 20/20 source files. This is can be accomplished in one command.

```
$ make build
```

Once finished building you can then use the scripts in the probabilstic2020/prob2020/console directory. You can check the build worked by the following:

```
$ python prob2020/cosole/probabilistic2020.py --help
```

[Next](quickstart.html "Quick Start")
 [Previous](download.html "Download")

---

© Copyright 2014-19, Collin Tokheim
Revision `8e0b1b95`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).