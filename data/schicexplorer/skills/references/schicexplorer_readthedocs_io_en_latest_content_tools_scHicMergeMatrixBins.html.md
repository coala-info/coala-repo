[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicMergeMatrixBins
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicMergeMatrixBins.rst)

---

# scHicMergeMatrixBins[¶](#schicmergematrixbins "Permalink to this headline")

Merges bins from a Hi-C matrix. For example, using a matrix containing 5kb bins, a matrix of 50kb bins can be derived using –numBins 10.

```
usage: scHicMergeMatrixBins --matrix matrix.scool --outFileName OUTFILENAME
                            --numBins int [--runningWindow]
                            [--threads THREADS] [--help] [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   Matrix to reduce in scool format.

`--outFileName, -o`
:   File name to save the resulting matrix. The output is also a .scool file. But don’t add the suffix.

`--numBins, -nb`
:   Number of bins to merge.

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--runningWindow`
:   set to merge for using a running window of length –numBins. Must be an odd number.

    Default: False

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).