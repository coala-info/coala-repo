..
Copyright (C) 2023 Roberto Rossini
SPDX-License-Identifier: MIT
Introduction
============
hictk is a blazing fast toolkit to work with .hic and .cool files.
hictk is capable of reading and writing files in .cool, .mcool, .scool, and .hic format (including hic v9).
.. only:: not latex
Documentation formats
---------------------
You are reading the HTML version of the documentation. An alternative `PDF
version `\_ is
also available.
Installation
------------
.. only:: latex
Documentation formats
---------------------
You are reading the PDF version of the documentation.
The live HTML version of the documentation is available at ``\_.
.. rubric:: Installation
hictk is developed on Linux and tested on Linux, macOS, and Windows. CLI tools can be installed in several different ways. Refer to :doc:`Installation <./installation>` for more details.
hictk can be compiled on most UNIX-like systems (including many Linux distributions and macOS) as well as Windows. See the :doc:`build instructions <./installation\_src>` for more details.
hictk can be used from languages other than C++ through the following bindings:
\* Python bindings through `hictkpy `\_
\* R bindings through `hictkR `\_
.. only:: not latex
How to cite this project?
-------------------------
.. only:: latex
.. rubric:: How to cite this project?
Please use the following BibTeX template to cite hictk in scientific
discourse:
.. code-block:: bibtex
@article{hictk,
author = {Rossini, Roberto and Paulsen, Jonas},
title = "{hictk: blazing fast toolkit to work with .hic and .cool files}",
journal = {Bioinformatics},
volume = {40},
number = {7},
pages = {btae408},
year = {2024},
month = {06},
issn = {1367-4811},
doi = {10.1093/bioinformatics/btae408},
url = {https://doi.org/10.1093/bioinformatics/btae408},
eprint = {https://academic.oup.com/bioinformatics/article-pdf/40/7/btae408/58385157/btae408.pdf},
}
.. only:: not latex
Table of contents
-----------------
.. toctree::
:caption: Installation
:maxdepth: 1
installation
installation\_src
.. toctree::
:caption: FAQ
:maxdepth: 1
faq
.. toctree::
:caption: Getting Started
:maxdepth: 1
quickstart\_cli
quickstart\_api
downloading\_test\_datasets
file\_validation
file\_metadata
format\_conversion
reading\_interactions
creating\_cool\_and\_hic\_files
creating\_multires\_files
balancing\_matrices
.. toctree::
:caption: How-Tos
:maxdepth: 2
tutorials/reordering\_chromosomes
tutorials/dump\_interactions\_to\_cool\_hic\_file
.. toctree::
:caption: CLI and API Reference
:maxdepth: 2
cli\_reference
cpp\_api/index
Python API
R API
.. toctree::
:caption: Telemetry
:maxdepth: 1
telemetry