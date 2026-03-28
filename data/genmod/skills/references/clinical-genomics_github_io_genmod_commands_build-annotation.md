[genmod docs](../..)

* [Home](../..)
* [Genetic Models](../../genetic-models/)
* Commands
  + [Annotating Variants](../annotate-variants/)
  + [Annotate Genetic Models](../annotate-models/)
  + [Filter Variants](../filter-variants/)
  + [Sort Variants](../sort-variants/)
  + [Build References](./)
  + [Score compounds](../score-compounds/)
  + [Score variants](../score-variants/)

* Search
* [Previous](../sort-variants/)
* [Next](../score-compounds/)
* [Edit on GitHub](https://github.com/Clinical-Genomics/genmod/edit/master/docs/commands/build-annotation.md)

* [Build new annotations with genmod](#build-new-annotations-with-genmod)
  + [Basic command](#basic-command)
  + [Overview](#overview)

# Build new annotations with genmod

## Basic command

```
$ genmod build --help
Usage: genmod build [OPTIONS] ANNOTATION_FILE

  Build a new annotation database

  Build an annotation database from an annotation file.

Options:
  -o, --outdir PATH               Specify the path to a folder where the
                                  annotation files should be stored.
  -t, --annotation_type [bed|ccds|gtf|gene_pred|gff]
                                  Specify the format of the annotation file.
  --splice_padding INTEGER        Specify the the number of bases that the
                                  exons should be padded with. Default is 2
                                  bases.
  -v, --verbose                   Increase output verbosity.
  --help                          Show this message and exit.
```

## Overview

The build command is used for building new annotations. This could be used if another gene defenition than default (refSeq) are preferred, if other regions than genes should be used to annotate compounds or if another organism than humans are used in the analysis.
The supported formats are `bed, ccds, gtf, gene_pred, gff`. Small examples for the supported formats in [conftest.py](https://github.com/Clinical-Genomics/genmod/blob/master/tests/conftest.py)

---

Documentation built with [MkDocs](https://www.mkdocs.org/).

#### Search

From here you can search these documents. Enter your search terms below.

#### Keyboard Shortcuts

| Keys | Action |
| --- | --- |
| `?` | Open this help |
| `n` | Next page |
| `p` | Previous page |
| `s` | Search |