[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicAdjustMatrix
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicAdjustMatrix.rst)

---

# scHicAdjustMatrix[¶](#schicadjustmatrix "Permalink to this headline")

scHicAdjustMatrix is a tool to keep or remove a list of chromosomes of all Hi-C matrices stored in the scool file.

```
usage: scHicAdjustMatrix --matrix MATRIX --outFileName OUTFILENAME
                         [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                         [--createSubmatrix CREATESUBMATRIX]
                         [--action {keep,remove}] [--threads THREADS] [--help]
                         [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   The matrix to adjust in the scool format.

`--outFileName, -o`
:   File name to save the adjusted matrix.

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--chromosomes, -c`
:   List of chromosomes to keep / remove

`--createSubmatrix, -cs`
:   Keep only first n matrices and remove the rest. Good for test data creation.

`--action`
:   Possible choices: keep, remove

    Keep, remove or mask the list of specified chromosomes / regions

    Default: “keep”

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).