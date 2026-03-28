[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicNormalize
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicNormalize.rst)

---

# scHicNormalize[¶](#schicnormalize "Permalink to this headline")

```
usage: scHicNormalize --matrix scool scHi-C matrix --outFileName OUTFILENAME
                      [--threads THREADS] --normalize
                      {smallest,read_count,multiplicative}
                      [--setToZeroThreshold SETTOZEROTHRESHOLD]
                      [--value VALUE]
                      [--maximumRegionToConsider MAXIMUMREGIONTOCONSIDER]
                      [--help] [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   The single cell Hi-C interaction matrices to investigate for QC. Needs to be in scool format

`--outFileName, -o`
:   File name of the normalized scool matrix.

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--normalize, -n`
:   Possible choices: smallest, read\_count, multiplicative

    Normalize to a) all matrices to the lowest read count of the given matrices, b) all to a given read coverage value or c) to a multiplicative value

    Default: “smallest”

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--setToZeroThreshold, -z`
:   Values smaller as this threshold are set to 0.

    Default: 1.0

`--value, -v`
:   This value is used to either be interpreted as the desired read\_count or the multiplicative value. This depends on the value for –normalize

    Default: 1

`--maximumRegionToConsider`
:   To compute the normalization factor for the normalization mode ‘smallest’ and ‘read\_count’, consider only this genomic distance around the diagonal.

    Default: 30000000

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).