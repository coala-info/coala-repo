[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicClusterCompartments
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicClusterCompartments.rst)

---

# scHicClusterCompartments[¶](#schicclustercompartments "Permalink to this headline")

scHicClusterCompartments uses kmeans or spectral clustering to associate each cell to a cluster and therefore to its cell cycle. The clustering is applied on dimension reduced data based on the A/B compartments track. This approach reduces the number of dimensions from samples \* (number of bins)^2 to samples \* (number of bins). Please consider also the other clustering and dimension reduction approaches of the scHicExplorer suite. They can give you better results, can be faster or less memory demanding.

```
usage: scHicClusterCompartments --matrix scool scHi-C matrix
                                [--numberOfClusters NUMBEROFCLUSTERS]
                                --outFileName OUTFILENAME
                                [--clusterMethod {spectral,kmeans}]
                                [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                                [--norm] [--binarization]
                                [--extraTrack EXTRATRACK]
                                [--histonMarkType HISTONMARKTYPE]
                                [--threads THREADS] [--help] [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   The single cell Hi-C interaction matrices to cluster. Needs to be in scool format

`--numberOfClusters, -c`
:   Number of to be computed clusters

    Default: 12

`--outFileName, -o`
:   File name to save the resulting clusters

    Default: “clusters.txt”

`--clusterMethod, -cm`
:   Possible choices: spectral, kmeans

    Algorithm to cluster the Hi-C matrices

    Default: “spectral”

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--chromosomes`
:   List of chromosomes to be included in the correlation.

`--norm`
:   Different obs-exp normalization as used by Homer software.

    Default: False

`--binarization`
:   Set all positive values of eigenvector to 1 and all negative ones to 0.

    Default: False

`--extraTrack`
:   Either a gene track or a histon mark coverage file(preferably a broad mark) is needed to decide if the values of the eigenvector need a sign flip or not.

`--histonMarkType`
:   set it to active or inactive. This is only necessary if a histon mark coverage file is given as an extraTrack.

    Default: “active”

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).