[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicPlotConsensusMatrices
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicPlotConsenusMatrices.rst)

---

# scHicPlotConsensusMatrices[¶](#schicplotconsensusmatrices "Permalink to this headline")

```
usage: scHicPlotConsensusMatrices --matrix scool scHi-C matrix
                                  [--outFileName OUTFILENAME] [--dpi DPI]
                                  [--threads THREADS]
                                  [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                                  [--region REGION] [--colorMap COLORMAP]
                                  [--fontsize FONTSIZE] [--no_header]
                                  [--log1p] [--individual_scale] [--help]
                                  [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--matrix, -m`
:   The consensus matrix created by scHicConsensusMatrices

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--outFileName, -o`
:   File name to save the resulting cluster profile.

    Default: “consensus\_matrices.png”

`--dpi, -d`
:   The dpi of the plot.

    Default: 300

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--chromosomes, -c`
:   List of to be plotted chromosomes

`--region, -r`
:   Region to be plotted for each consensus matrix. Mutual exclusion with the usage of –chromosomes parameter

`--colorMap`
:   Color map to use for the heatmap. Available values can be seen here: <http://matplotlib.org/examples/color/colormaps_reference.html>

    Default: “RdYlBu\_r”

`--fontsize`
:   Fontsize in the plot for x and y axis.

    Default: 10

`--no_header`
:   Do not plot a header.

    Default: True

`--log1p`
:   Apply log1p operation to plot the matrices.

    Default: False

`--individual_scale`
:   Use an individual value range for all cluster consensus matrices. If not set, the same scale is applied to all.

    Default: True

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).