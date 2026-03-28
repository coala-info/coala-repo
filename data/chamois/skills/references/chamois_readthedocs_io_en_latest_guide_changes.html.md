[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[![](../_static/logo.png)
![](../_static/logo.png)

CHAMOIS](../index.html)

* [User Guide](index.html)
* [Examples](../examples/index.html)
* [Figures](../figures/index.html)
* [CLI Reference](../cli/index.html)
* [API Reference](../api/index.html)
* More
  + [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Search
`Ctrl`+`K`

* [User Guide](index.html)
* [Examples](../examples/index.html)
* [Figures](../figures/index.html)
* [CLI Reference](../cli/index.html)
* [API Reference](../api/index.html)
* [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Section Navigation

Getting Started

* [Installation](install.html)

Resources

* [Publications](publications.html)
* [Contribution Guide](contributing.html)
* Changelog
* [Copyright Notice](copyright.html)

* [User Guide](index.html)
* Changelog

# Changelog[#](#changelog "Link to this heading")

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased](https://github.com/zellerlab/CHAMOIS/compare/v0.2.2...HEAD)[#](#unreleased "Link to this heading")

## [v0.2.2](https://github.com/zellerlab/CHAMOIS/compare/v0.2.1...v0.2.2) - 2026-02-12[#](#v0-2-2-2026-02-12 "Link to this heading")

### Added[#](#added "Link to this heading")

* CLI option to `search` and `compare` subcommands to output the pairwise distance matrix.

### Changed[#](#changed "Link to this heading")

* Update `zopen` to support auto-detection of Zstd files.
* Use Zstd instead of LZ4 to compress the redistributed Pfam HMMs.

### Fixed[#](#fixed "Link to this heading")

* Support comparing CHAMOIS predictions together with `chamois search` ([#1](https://github.com/zellerlab/CHAMOIS/issues/1)).

## [v0.2.1](https://github.com/zellerlab/CHAMOIS/compare/v0.2.0...v0.2.1) - 2026-01-24[#](#v0-2-1-2026-01-24 "Link to this heading")

### Changed[#](#id1 "Link to this heading")

* Bump `pyhmmer` requirement to `v0.12.0`.
* Use SPDX license qualifiers in `pyproject.toml`.

## [v0.2.0](https://github.com/zellerlab/CHAMOIS/compare/v0.1.3...v0.2.0) - 2025-12-07[#](#v0-2-0-2025-12-07 "Link to this heading")

### Added[#](#id2 "Link to this heading")

* Training option to ignore classes and features in less than *N* groups.
* `cvi` command run independent cross-validation as done in the paper.
* Support for training and evaluating random forest models.
* Support for computing sample weights for observation groups in `fit`.
* Report information content of the prediction in `predict` output.

### Changed[#](#id3 "Link to this heading")

* Relax `anndata` dependency to allow more recent releases.
* Update MIBiG 3.1 dataset to filter out erroneous partial clusters.
* Retrain CHAMOIS with filtered MIBIG 3.1 dataset and improved feature selection.
* Make `chamois.compositions.build_variables` drop empty columns.
* Rename `screen` command to `compare`.
* Incorrect use of chemical groups in cross-validation commands.
* Update Pfam to 38.0.

### Fixed[#](#id4 "Link to this heading")

* Issue with computation of probabilistic Jaccard distance in `validate` command.
* Incorrect error message on non-existing class in `explain` command.
* Incorrect merging of multiple feature tables in CLI.
* Extraction of minimum class and features by groups for majority positive classes.
* Incorrect error message in `predict` command.
* Unsupported sample weighting in older `scikit-learn` releases.

## [v0.1.3](https://github.com/zellerlab/CHAMOIS/compare/v0.1.2...v0.1.3) - 2025-03-30[#](#v0-1-3-2025-03-30 "Link to this heading")

### Fixed[#](#id5 "Link to this heading")

* Build issue on missing `rich` package.

### Added[#](#id6 "Link to this heading")

* Jaccard index to reported metrics in `chamois cv`, `chamois train` and `chamois validate` commands.

## [v0.1.2](https://github.com/zellerlab/CHAMOIS/compare/v0.1.1...v0.1.2) - 2025-03-26[#](#v0-1-2-2025-03-26 "Link to this heading")

### Fixed[#](#id7 "Link to this heading")

* Make installation procedure not require extra packages in most cases.
* Remove `universal` from `bdist_wheel` command in `setup.cfg`.
* Seeds not being passed from the CLI to the actual `ChemicalOntologyPredictor` instances.

### Documentation[#](#documentation "Link to this heading")

* Add missing Javascript files for PyPI icons.
* Update installation instructions for Docker and Singularity.

## [v0.1.1](https://github.com/zellerlab/CHAMOIS/compare/v0.1.0...v0.1.1) - 2025-03-21[#](#v0-1-1-2025-03-21 "Link to this heading")

### Fixed[#](#id8 "Link to this heading")

* Automated deployment and setup of filtered Pfam HMMs from GitHub.

## [v0.1.0](https://github.com/zellerlab/CHAMOIS/compare/bfe081f...v0.1.0) - 2025-03-21[#](#v0-1-0-2025-03-21 "Link to this heading")

Initial release.

[previous

Contributing](contributing.html "previous page")
[next

Copyright Notice](copyright.html "next page")

On this page

* [Unreleased](#unreleased)
* [v0.2.2 - 2026-02-12](#v0-2-2-2026-02-12)
  + [Added](#added)
  + [Changed](#changed)
  + [Fixed](#fixed)
* [v0.2.1 - 2026-01-24](#v0-2-1-2026-01-24)
  + [Changed](#id1)
* [v0.2.0 - 2025-12-07](#v0-2-0-2025-12-07)
  + [Added](#id2)
  + [Changed](#id3)
  + [Fixed](#id4)
* [v0.1.3 - 2025-03-30](#v0-1-3-2025-03-30)
  + [Fixed](#id5)
  + [Added](#id6)
* [v0.1.2 - 2025-03-26](#v0-1-2-2025-03-26)
  + [Fixed](#id7)
  + [Documentation](#documentation)
* [v0.1.1 - 2025-03-21](#v0-1-1-2025-03-21)
  + [Fixed](#id8)
* [v0.1.0 - 2025-03-21](#v0-1-0-2025-03-21)

[Edit on GitHub](https://github.com/zellerlab/CHAMOIS/edit/master/docs/guide/changes.md)

### This Page

* [Show Source](../_sources/guide/changes.md.txt)

© Copyright 2020-2026, Martin Larralde.

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.