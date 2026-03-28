[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicConsensusMatrices
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicConsensusMatrices.rst)

---

# scHicConsensusMatrices[¶](#schicconsensusmatrices "Permalink to this headline")

scHicConsensusMatrices creates based on the clustered samples one consensus matrix for each cluster. The consensus matrices are normalized to an equal read coverage level and are stored all in one scool matrix.

```
usage: scHicConsensusMatrices --matrix scool scHi-C matrix --clusters cluster
                              file --outFileName OUTFILENAME
                              [--no_normalization] [--threads THREADS]
                              [--help] [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   The single cell Hi-C interaction matrices to investigate for QC. Needs to be in scool format

`--clusters, -c`
:   Text file which contains per matrix the associated cluster.

`--outFileName, -o`
:   File name of the consensus scool matrix.

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--no_normalization`
:   Do not plot a header.

    Default: True

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).