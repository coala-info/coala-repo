[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicQualityControl
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicClusterSVL.rst)

---

# scHicQualityControl[¶](#schicqualitycontrol "Permalink to this headline")

scHicClusterSVL uses kmeans or spectral clustering to associate each cell to a cluster and therefore to its cell cycle. The clustering is applied on dimension reduced data based on the ratio of short vs long range contacts per chromosome. This approach reduces the number of dimensions from samples \* (number of bins)^2 to samples \* (number of chromosomes). Please consider also the other clustering and dimension reduction approaches of the scHicExplorer suite. They can give you better results, can be faster or less memory demanding.

```
usage: scHicClusterSVL --matrix scool scHi-C matrix
                       [--numberOfClusters NUMBEROFCLUSTERS]
                       [--clusterMethod {spectral,kmeans}] --outFileName
                       OUTFILENAME [--distanceShortRange DISTANCESHORTRANGE]
                       [--distanceLongRange DISTANCELONGRANGE]
                       [--threads THREADS] [--help] [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   The single cell Hi-C interaction matrices to cluster. Needs to be in scool format

`--numberOfClusters, -c`
:   Number of to be computed clusters

    Default: 7

`--clusterMethod, -cm`
:   Possible choices: spectral, kmeans

    Algorithm to cluster the Hi-C matrices

    Default: “spectral”

`--outFileName, -o`
:   File name to save the resulting clusters

    Default: “clusters.txt”

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--distanceShortRange, -ds`
:   Distance which should be considered as short range. Default 2MB.

    Default: 2000000

`--distanceLongRange, -dl`
:   Distance which should be considered as short range. Default 12MB.

    Default: 12000000

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).