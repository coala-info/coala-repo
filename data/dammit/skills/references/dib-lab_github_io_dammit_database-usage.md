[ ]
[ ]

dammit

Database Usage

Type to start searching

[dammit](https://github.com/dib-lab/dammit "Go to repository")

dammit

[dammit](https://github.com/dib-lab/dammit "Go to repository")

* [Home](.. "Home")
* [About](../about/ "About")
* [ ]

  Installation

  Installation
  + [Requirements](../system_requirements/ "Requirements")
  + [Bioconda](../install/ "Bioconda")
* [x]

  Databases

  Databases
  + [ ]
    [Basic Usage](./ "Basic Usage")
  + [About the Databases](../database-about/ "About the Databases")
  + [Advanced Database Handling](../database-advanced/ "Advanced Database Handling")
* [Tutorial](../tutorial/ "Tutorial")
* [ ]

  For developers

  For developers
  + [Notes for developers](../dev_notes/ "Notes for developers")

# Basic Usage

dammit handles databases under the `dammit databases` subcommand. By
default, dammit looks for databases in
`$HOME/.dammit/databases` and will install them there if
missing. If you have some of the databases already, you can inform
dammit with the `--database-dir` flag.

To check for databases in the default location:

```
dammit databases
```

To check for them in a custom location, you can either use the
`--database-dir` flag:

```
dammit databases --database-dir /path/to/databases
```

or, you can set the `DAMMIT_DB_DIR` environment variable.
The flag will supersede this variable, falling back to the default if
neither is set. For example:

```
export DAMMIT_DB_DIR=/path/to/databases
```

This can also be added to your `$HOME/.bashrc` file to make
it persistent.

To download and install them into the default directory:

```
dammit databases --install
```

For info on the specific databases used in dammit, see [About Databases](../database-about/).

For advanced installation and usage instructions, check out the
[Advanced Database Handling](../database-advanced/) section.

[Previous
Bioconda](../install/ "Bioconda")
[Next
About the Databases](../database-about/ "About the Databases")

Copyright © 2020 [Lab for Data Intensive Biology](http://ivory.idyll.org/lab/) at UC Davis

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)