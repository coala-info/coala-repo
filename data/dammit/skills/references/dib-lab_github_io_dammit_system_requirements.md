[ ]
[ ]

dammit

System Requirements

Type to start searching

[dammit](https://github.com/dib-lab/dammit "Go to repository")

dammit

[dammit](https://github.com/dib-lab/dammit "Go to repository")

* [Home](.. "Home")
* [About](../about/ "About")
* [x]

  Installation

  Installation
  + [ ]
    [Requirements](./ "Requirements")
  + [Bioconda](../install/ "Bioconda")
* [ ]

  Databases

  Databases
  + [Basic Usage](../database-usage/ "Basic Usage")
  + [About the Databases](../database-about/ "About the Databases")
  + [Advanced Database Handling](../database-advanced/ "Advanced Database Handling")
* [Tutorial](../tutorial/ "Tutorial")
* [ ]

  For developers

  For developers
  + [Notes for developers](../dev_notes/ "Notes for developers")

# Requirements

dammit, for now, is officially supported on GNU/Linux systems via
[bioconda](https://bioconda.github.io/index.html). macOS support will be
available via bioconda soon.

For the standard pipeline, dammit needs ~18GB of storage space to store its
prepared databases, plus a few hundred MB per BUSCO database. For the
standard annotation pipeline, we recommend at least 16GB of RAM. This can be
reduced by editing LAST parameters via a custom configuration file.

The full pipeline, which uses uniref90, needs several hundred GB of
space and considerable RAM to prepare the databases. You'll also want
either a fat internet connection or a big cup of patience to download
uniref.

For some species, we have found that the amount of RAM required can be proportional to the size of the transcriptome being annotated.

[Previous
About](../about/ "About")
[Next
Bioconda](../install/ "Bioconda")

Copyright © 2020 [Lab for Data Intensive Biology](http://ivory.idyll.org/lab/) at UC Davis

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)