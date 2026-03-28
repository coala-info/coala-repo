SIDR

latest

* [Installing SIDR](install.html)
* [Data Preparation](dataprep.html)
* [Running With Raw Input](rundefault.html)
* [Running With a Runfile](runfilerun.html)
* [Runfile Example](runfileexample.html)

SIDR

* Docs »
* Welcome to SIDR’s documentation!
* [Edit on GitHub](https://github.com/damurdock/SIDR/blob/master/docs/index.rst)

---

# Welcome to SIDR’s documentation![¶](#welcome-to-sidr-s-documentation "Permalink to this headline")

SIDR (Sequence Identification with Decision tRees, pronounced *cider*) is a tool to filter Next Generation Sequencing (NGS) data based on a chosen target organism. SIDR uses data fron BLAST (or similar classifiers) to train a Decision Tree model to classify sequence data as either belonging to the target organism, or belonging to something else. This classification can be used to filter the data for later assembly.

There are two ways to run SIDR. The first, or default, method takes a number of bioinformatics files as input and calculates relevant statistics from them. The second, or custom, method takes a specifically formatted tab-delimited file with your chosen statistics and uses that directly to train the model.

## Documentation[¶](#documentation "Permalink to this headline")

* [Installing SIDR](install.html)
  + [Dependencies](install.html#dependencies)
  + [OSX](install.html#osx)
  + [Using a Virtualenv](install.html#using-a-virtualenv)
  + [Installing from PyPI](install.html#installing-from-pypi)
  + [Installing from Source with pip](install.html#installing-from-source-with-pip)
  + [Installing from Source with Setup.py](install.html#installing-from-source-with-setup-py)
* [Data Preparation](dataprep.html)
  + [Assembly](dataprep.html#assembly)
  + [Alignment](dataprep.html#alignment)
  + [BLAST](dataprep.html#blast)
  + [Taxonomy Dump](dataprep.html#taxonomy-dump)
* [Running With Raw Input](rundefault.html)
* [Running With a Runfile](runfilerun.html)
* [Runfile Example](runfileexample.html)

[Next](install.html "Installing SIDR")

---

© Copyright 2017, Duncan Murdock.
Revision `37d56e54`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).