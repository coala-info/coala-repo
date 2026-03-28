[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicQualityControl
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicQualityControl.rst)

---

# scHicQualityControl[¶](#schicqualitycontrol "Permalink to this headline")

```
usage: scHicQualityControl --matrix scool scHi-C matrix
                           [--outputScool OUTPUTSCOOL]
                           [--minimumReadCoverage MINIMUMREADCOVERAGE]
                           [--minimumDensity MINIMUMDENSITY]
                           [--maximumRegionToConsider MAXIMUMREGIONTOCONSIDER]
                           [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                           [--outFileNameDensity OUTFILENAMEDENSITY]
                           [--outFileNameReadCoverage OUTFILENAMEREADCOVERAGE]
                           [--outFileNameQCReport OUTFILENAMEQCREPORT]
                           [--plotOnly] [--runChromosomeCheck] [--dpi DPI]
                           [--threads THREADS] [--help] [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   The single cell Hi-C interaction matrices to investigate for QC. Needs to be in scool format

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--outputScool, -o`
:   scool matrix which contains only the filtered matrices

    Default: “filtered\_matrices.scool”

`--minimumReadCoverage`
:   Remove all samples with a lower read coverage as this value.

    Default: 1000000

`--minimumDensity`
:   Remove all samples with a lower density as this value. The density is given by: number of non-zero interactions / all possible interactions.

    Default: 0.001

`--maximumRegionToConsider`
:   To compute the density, consider only this genomic distance around the diagonal.

    Default: 30000000

`--chromosomes, -c`
:   List of chromosomes that a cell needs to have to be not deleted. However, other chromosomes/contigs and scaffolds which may exist are not deleted. Use scHicAdjustMatrix for this.

`--outFileNameDensity, -od`
:   File name of the density histogram

    Default: “density.png”

`--outFileNameReadCoverage, -or`
:   File name of the read coverage

    Default: “readCoverage.png”

`--outFileNameQCReport, -oqc`
:   File name of the quality report

    Default: “qc\_report.txt”

`--plotOnly`
:   Do not create a new matrix, create only the plots.

    Default: False

`--runChromosomeCheck`
:   Skip the data integrity check for the chromosomes.

    Default: False

`--dpi, -d`
:   The dpi of the plot.

    Default: 300

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).