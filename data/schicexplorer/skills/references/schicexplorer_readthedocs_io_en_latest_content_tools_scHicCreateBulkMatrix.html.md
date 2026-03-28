[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicCreateBulkMatrix
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicCreateBulkMatrix.rst)

---

# scHicCreateBulkMatrix[¶](#schiccreatebulkmatrix "Permalink to this headline")

```
usage: scHicCreateBulkMatrix --matrix scool scHi-C matrix --outFileName
                             OUTFILENAME [--threads THREADS] [--help]
                             [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   The single cell Hi-C interaction matrices to cluster. Needs to be in scool format

`--outFileName, -o`
:   File name to save the exported cooler matrix. Please add .cool appendix.

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

![../../_images/nagano_bulk.png](../../_images/nagano_bulk.png)

Nagano 2017 1 Mb resolution bulk matrix.

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).