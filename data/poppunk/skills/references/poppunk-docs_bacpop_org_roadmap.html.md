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
* [Overview](overview.html)
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
* Roadmap
* [Miscellaneous](miscellaneous.html)

Back to top

[View this page](_sources/roadmap.rst.txt "View this page")

# Roadmap[¶](#roadmap "Link to this heading")

This document describes our future plans for additions to PopPUNK, [pp-sketchlib](https://github.com/bacpop/pp-sketchlib) and [BeeBOP](https://github.com/bacpop/beebop/)
and BeeBOP. Tasks are in order of priority.

## PopPUNK[¶](#poppunk "Link to this heading")

1. Containerise the workflow. See [#193](https://github.com/bacpop/PopPUNK/issues/193), [#277](https://github.com/bacpop/PopPUNK/issues/277), [#278](https://github.com/bacpop/PopPUNK/issues/278).
2. Add full worked tutorials back to the documentation [#275](https://github.com/bacpop/PopPUNK/issues/275).
3. Codebase optimsation and refactoring
   :   * Modularisation of the network code [#249](https://github.com/bacpop/PopPUNK/issues/249).
       * Removing old functions [#103](https://github.com/bacpop/PopPUNK/issues/103)

Other enhancements listed on the [issue page](https://github.com/bacpop/pp-sketchlib/issues) are currently not planned.

## pp-sketchlib[¶](#pp-sketchlib "Link to this heading")

1. Update installation in package managers
   :   * Update for new macOS [#92](https://github.com/bacpop/ska.rust#planned-features)

Other enhancements listed on the [issue page](https://github.com/bacpop/pp-sketchlib/issues) are currently not planned.

## BeeBOP[¶](#beebop "Link to this heading")

1. Update backend database to v8 [#42](https://github.com/bacpop/beebop/pull/42).
2. Update CI images.
3. Add more info on landing page.
   :   * News page.
       * About page.
       * Methods description.
4. Add custom cluster names (e.g. GPSCs)
5. Integration tests for error logging.
6. Persist user data.
   :   * Persist microreact tokens [#41](https://github.com/bacpop/beebop/pull/41).
       * Allow user to change or delete tokens
7. Add linage/subclusters to results page [#23](https://github.com/bacpop/beebop/pull/23).
8. Report sample quality to user.
9. Front-end update for large numbers of input files.
10. Add serotype prediction for *S. pneumoniae*.
11. Add multiple species databases.

[Next

Miscellaneous](miscellaneous.html)
[Previous

Reference documentation](api.html)

Copyright © 2018-2025, John Lees and Nicholas Croucher

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Roadmap
  + [PopPUNK](#poppunk)
  + [pp-sketchlib](#pp-sketchlib)
  + [BeeBOP](#beebop)