[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicPlotClusterProfiles
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicPlotClusterProfiles.rst)

---

# scHicPlotClusterProfiles[¶](#schicplotclusterprofiles "Permalink to this headline")

```
usage: scHicPlotClusterProfiles --matrix scool scHi-C matrix --clusters
                                cluster file
                                [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                                [--maximalDistance MAXIMALDISTANCE]
                                [--distanceShortRange DISTANCESHORTRANGE]
                                [--distanceLongRange DISTANCELONGRANGE]
                                [--orderBy {svl,orderByFile}]
                                [--fontsize FONTSIZE] [--rotationX ROTATIONX]
                                [--ticks | --legend]
                                [--outFileName OUTFILENAME] [--dpi DPI]
                                [--colorMap COLORMAP] [--threads THREADS]
                                [--help] [--version]
```

## Named Arguments[¶](#Named Arguments "Permalink to this headline")

`--ticks`
:   Plot the cluster names as ticks. Use legend if they overlap.

    Default: False

`--legend`
:   Plot the cluster names as legend. Might be helpful if the ticks overlap.

    Default: False

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   The single cell Hi-C interaction matrices to investigate for QC. Needs to be in scool format

`--clusters, -c`
:   Text file which contains per matrix the associated cluster.

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--chromosomes`
:   List of to be plotted chromosomes

`--maximalDistance, -md`
:   Maximal distance in bases to consider for ratio computation.

    Default: 50000000

`--distanceShortRange, -ds`
:   Distance which should be considered as lower distance for svl ordering. Values from distances smaller this value are not considered. Default 2MB.

    Default: 2000000

`--distanceLongRange, -dl`
:   Distance which should be considered as upper distance for svl ordering. Values from distances greater this value are not considered. Default 12MB.

    Default: 12000000

`--orderBy, -ob`
:   Possible choices: svl, orderByFile

    Algorithm to cluster the Hi-C matrices

    Default: “svl”

`--fontsize`
:   Fontsize in the plot for x and y axis.

    Default: 10

`--rotationX`
:   Rotation in degrees for the labels of x axis.

    Default: 0

`--outFileName, -o`
:   File name to save the resulting cluster profile.

    Default: “clusters\_profile.png”

`--dpi, -d`
:   The dpi of the plot.

    Default: 300

`--colorMap`
:   Color map to use for the heatmap. Available values can be seen here: <http://matplotlib.org/examples/color/colormaps_reference.html>

    Default: “RdYlBu\_r”

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).