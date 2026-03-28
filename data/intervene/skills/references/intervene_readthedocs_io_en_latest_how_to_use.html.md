[Intervene](index.html)

latest

Table of contents

* [Introduction](introduction.html)
* [Installation](install.html)
* How to use Intervene
  + [Run Intervene on test data](#run-intervene-on-test-data)
* [Intervene modules](modules.html)
* [Example gallery](examples.html)
* [Interactive Shiny App](shinyapp.html)
* [Support](support.html)
* [Citation](cite.html)
* [Changelog](changelog.html)

[Intervene](index.html)

* [Docs](index.html) »
* How to use Intervene
* [Edit on GitHub](https://github.com/asntech/intervene/blob/master/docs/how_to_use.rst)

---

# How to use Intervene[¶](#how-to-use-intervene "Permalink to this headline")

Once you have installed Intervene, you can type:

```
intervene --help
```

This will show the main help, which lists the three subcommands/modules: `venn`, `upset`, and `pairwise`.

```
usage: intervene <subcommand> [options]

positional arguments <subcommand>:
  {venn,upset,pairwise}
                        List of subcommands
    venn                Venn diagram of intersection of genomic regions or list sets (upto 6-way).
    upset               UpSet diagram of intersection of genomic regions or list sets.
    pairwise            Pairwise intersection and heatmap of N genomic region sets in <BED/GTF/GFF> format.

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
```

To view the help for the individual subcommands, please type:

To view `venn` module help, type

```
intervene venn --help
```

To view `upset` module help, type

```
intervene upset --help
```

To view `pairwise` module help, type

```
intervene pairwise --help
```

## Run Intervene on test data[¶](#run-intervene-on-test-data "Permalink to this headline")

To run Intervene using example data, use the following commands. To access the test data make sure you have `sudo` or `root` access.

To run `venn` module with test data, type

```
intervene venn --test
```

To run `upset` module with test data, type

```
intervene upset --test
```

To run `pairwise` module with test data, type

```
intervene pairwise --test
```

If you have installed Intervene locally from the source code, you may have problem to find test data. You can download the test data here <https://github.com/asntech/intervene/tree/master/intervene/example_data> and point to it using `-i` instead of `--test`.

```
./intervene/intervene venn -i intervene/example_data/ENCODE_hESC/*.bed
./intervene/intervene upset -i intervene/example_data/ENCODE_hESC/*.bed
./intervene/intervene pairwise -i intervene/example_data/dbSUPER_mm9/*.bed
```

These subcommands will save the results in the current working directory with a folder named `Intervene_results`. If you wish to save the results in a specific folder, you can type:

```
intervene <module_name> --test --output ~/path/to/your/results/folder
```

[Next](modules.html "Intervene modules")
 [Previous](install.html "Installation")

---

© Copyright 2017, Aziz Khan.
Revision `d7c77661`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).