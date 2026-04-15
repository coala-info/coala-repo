[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[SnapATAC2](index.html)

Choose version

* [Installation](install.html)
* [Tutorials](tutorials/index.html)
* [API reference](api/index.html)
* Development
* [Release notes](changelog.html)
* [Learn](https://kzhang.org/epigenomics-analysis/)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/scverse/SnapATAC2 "GitHub")

Search
`Ctrl`+`K`

Choose version

* [Installation](install.html)
* [Tutorials](tutorials/index.html)
* [API reference](api/index.html)
* Development
* [Release notes](changelog.html)
* [Learn](https://kzhang.org/epigenomics-analysis/)

* [GitHub](https://github.com/scverse/SnapATAC2 "GitHub")

Section Navigation

* Contributing to SnapATAC2

# Contributing to SnapATAC2[#](#contributing-to-snapatac2 "Link to this heading")

## A brief guide to adding new features to SnapATAC2[#](#a-brief-guide-to-adding-new-features-to-snapatac2 "Link to this heading")

The SnapATAC2 Github repository contains three libraries:

1. `snapatac2-core`: Core functions written in Rust.
2. `snapatac2-python`: High-level user-facing functions written in mostly Python.
3. `snapatac2-contrib`: Python package containing additional features from external contributors.

Unless the new feature is essential and highly relevant to functions in the core library, it is recommended to add it to the `snapatac2-contrib` library.
Otherwise, add the feature to the `snapatac2-python` library under the `snapatac2.experimental` module.
We will move function from `snapatac2.experimental` to `snapatac2` once they are sufficiently tested and stable.

[previous

snapatac2.pp.recipe\_10x\_metrics](api/_autosummary/snapatac2.pp.recipe_10x_metrics.html "previous page")
[next

Release Notes](changelog.html "next page")

On this page

* [A brief guide to adding new features to SnapATAC2](#a-brief-guide-to-adding-new-features-to-snapatac2)

© Copyright 2022-2025, Kai Zhang.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.