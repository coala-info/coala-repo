Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[PopPUNK 2.7.0 documentation](index.html)

[![Logo](_static/poppunk_v2.png)

PopPUNK 2.7.0 documentation](index.html)

Contents:

* [PopPUNK documentation](index.html)
* [Installation](installation.html)
* Overview
* [Sketching (`--create-db`)](sketching.html)
* [Data quality control (`--qc-db`)](qc.html)
* [Fitting new models (`--fit-model`)](model_fitting.html)
* [Distributing PopPUNK models](model_distribution.html)
* [Query assignment (`poppunk_assign`)](query_assignment.html)
* [Creating visualisations](visualisation.html)
* [Minimum spanning trees](mst.html)
* [Subclustering with PopPIPE](subclustering.html)
* [Using GPUs](gpu.html)
* [Troubleshooting](troubleshooting.html)
* [Scripts](scripts.html)
* [Iterative PopPUNK](poppunk_iterate.html)
* [Citing PopPUNK](citing.html)
* [Reference documentation](api.html)
* [Roadmap](roadmap.html)
* [Miscellaneous](miscellaneous.html)

Back to top

[View this page](_sources/overview.rst.txt "View this page")

# Overview[¶](#overview "Link to this heading")

This page details the way in which we would advise that you *should* use and
run PopPUNK, if possible.

## Use the command line interface[¶](#use-the-command-line-interface "Link to this heading")

### Installation and version[¶](#installation-and-version "Link to this heading")

Install via conda if possible. Version 2.7.8 of PopPUNK and version 2.0.1 of pp-sketchlib
are the current minimum supported versions.

### Use query assignment mode[¶](#use-query-assignment-mode "Link to this heading")

If a database is available for your species (see <https://www.bacpop.org/poppunk-databases/>)
we would strongly recommend downloading it to use to cluster your genomes. This
has many advantages:

* No need to run through the potentially complex model fitting.
* Assured model performance.
* Considerably faster run times.
* Use existing cluster definitions.
* Use the context of large, high quality reference populations to interpret your genomes’ clusters.

See [Query assignment (poppunk\_assign)](query_assignment.html) for instructions on how to use this mode.

You can think of this as being similar to using an existing MLST/cgMLST/wgMLST scheme
to define your sample’s strains.

If you want to avoid any merged clusters (and get ‘stable nomenclature’) use the
`--stable` flag.

### GPSCs for *Streptococcus pneumoniae*[¶](#gpscs-for-streptococcus-pneumoniae "Link to this heading")

Current best practices are listed on the [pneumogen website](<https://www.pneumogen.net/gps>/#/training#gpsc-assignment) of the GPS project.

### Fit your own model[¶](#fit-your-own-model "Link to this heading")

If a database isn’t available for your species, you can fit your own. This consists of three steps:

1. Sketch your genomes (see [Sketching (--create-db)](sketching.html)).
2. Quality control your database (see [Data quality control (--qc-db)](qc.html)).
3. Fit a model (see [Fitting new models (--fit-model)](model_fitting.html)).
4. Repeat step two, until you have a model which works for your needs.

After getting a good fit, you may want to share it with others so that they can
use it to assign queries. See [Distributing PopPUNK models](model_distribution.html) for advice. We would also
be interested to hear from you if you’d like to add your new model to the
pre-fit databases above – please contact poppunk@poppunk.net.

### Create visualisations[¶](#create-visualisations "Link to this heading")

A number of plots are created by default. You can also
create files for further visualisation in [microreact](https://microreact.org/),
[cytoscape](http://www.cytoscape.org/),
[grapetree](http://dx.doi.org/10.1101/gr.232397.117) and
[phandango](http://jameshadfield.github.io/phandango/). We have found that
looking at the appearance of clusters on a tree is always very helpful, and would
recommend this for any fit.

Older versions of PopPUNK mandated this be chosen as part of the main analysis,
and then with `--generate-viz` mode. This is now run separately, after the
main analysis, with `poppunk_visualise`.

See [Creating visualisations](visualisation.html) for details on options.

## Use an online interface[¶](#use-an-online-interface "Link to this heading")

If available, you may want to use one of the browser-based interfaces to
PopPUNK. These include [beebop](https://beebop.dide.ic.ac.uk/) and
[pathogen.watch](https://pathogen.watch/genomes/all?genusId=1301&speciesId=1313)
(*S. pneumoniae* only).

Using these interfaces requires nothing to be installed or set up, doesn’t require any
genome data to be shared with us, and will return interactive visualisations. If your
species isn’t available, or you have large batches of genomes to cluster you will
likely want to use the command line interface instead.

[Next

Sketching (`--create-db`)](sketching.html)
[Previous

Installation](installation.html)

Copyright © 2018-2025, John Lees and Nicholas Croucher

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Overview
  + [Use the command line interface](#use-the-command-line-interface)
    - [Installation and version](#installation-and-version)
    - [Use query assignment mode](#use-query-assignment-mode)
    - [GPSCs for *Streptococcus pneumoniae*](#gpscs-for-streptococcus-pneumoniae)
    - [Fit your own model](#fit-your-own-model)
    - [Create visualisations](#create-visualisations)
  + [Use an online interface](#use-an-online-interface)