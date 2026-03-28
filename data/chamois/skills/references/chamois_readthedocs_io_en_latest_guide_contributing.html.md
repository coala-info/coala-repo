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
* Contribution Guide
* [Changelog](changes.html)
* [Copyright Notice](copyright.html)

* [User Guide](index.html)
* Contributing

# Contributing[#](#contributing "Link to this heading")

For bug fixes or new features, please file an issue before submitting a pull request.
If the change is not trivial, it may be best to wait for feedback.

## Generating data[#](#generating-data "Link to this heading")

The `Makefile` in the project repository handles the generation of the
training and benchmarking datasets. Simply running `make` will re-generate
the `mibig-2.0` and `mibig-3.1` datasets, including the `features.hdf5`
and `classes.hdf5` needed to train CHAMOIS.

## Managing versions[#](#managing-versions "Link to this heading")

As it is a good project management practice, we should follow
[semantic versioning](https://semver.org/), so remember the following:

* As long as the model predicts the same thing, retraining/updating the model
  should be considered a non-breaking change, so you should bump the MINOR
  version of the program.
* Upgrading the internal HMMs could potentially change the output but won’t
  break the program, they should be treated as non-breaking change, so you
  should bump the MINOR version of the program.
* If the model changes prediction (e.g. predicted classes change), then you
  should bump the MAJOR version of the program as it it a breaking change.
* Changes in the code should be treated following semver the usual way.
* Changed in the CLI should be treated as changed in the API (e.g. a new
  CLI option or a new command bumps the MINOR version, removal of an option
  bumps the MAJOR version).

## Upgrading the internal model[#](#upgrading-the-internal-model "Link to this heading")

After having trained a new version of the model, simply copy the
resulting JSON file to `chamois/predictor/predictor.json`.

## Upgrading the internal HMMs[#](#upgrading-the-internal-hmms "Link to this heading")

To download the subset of Pfam HMMs required by the model, simply run:

```
$ python setup.py clean download_pfam --inplace
```

[previous

Publications](publications.html "previous page")
[next

Changelog](changes.html "next page")

On this page

* [Generating data](#generating-data)
* [Managing versions](#managing-versions)
* [Upgrading the internal model](#upgrading-the-internal-model)
* [Upgrading the internal HMMs](#upgrading-the-internal-hmms)

[Edit on GitHub](https://github.com/zellerlab/CHAMOIS/edit/master/docs/guide/contributing.md)

### This Page

* [Show Source](../_sources/guide/contributing.md.txt)

© Copyright 2020-2026, Martin Larralde.

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.