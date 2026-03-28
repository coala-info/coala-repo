[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicCorrectMatrices
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicCorrectMatrices.rst)

---

# scHicCorrectMatrices[¶](#schiccorrectmatrices "Permalink to this headline")

Correct each matrix of the given scool matrix with KR correction.

```
usage: scHicCorrectMatrices --matrix matrix.h5 --outFileName OUTFILENAME
                            [--threads THREADS] [--help] [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   Matrix to reduce in h5 format.

`--outFileName, -o`
:   File name to save the resulting matrix, please add the scool prefix.

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).