[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[![](../_static/logo.png)
![](../_static/logo.png)

CHAMOIS](../index.html)

* [User Guide](../guide/index.html)
* [Examples](../examples/index.html)
* [Figures](../figures/index.html)
* CLI Reference
* [API Reference](../api/index.html)
* More
  + [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Search
`Ctrl`+`K`

* [User Guide](../guide/index.html)
* [Examples](../examples/index.html)
* [Figures](../figures/index.html)
* CLI Reference
* [API Reference](../api/index.html)
* [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Section Navigation

Inference

* [Predict (`chamois predict`)](predict.html)
* [Render (`chamois render`)](render.html)

Training

* [Annotate (`chamois annotate`)](annotate.html)
* [Train (`chamois train`)](train.html)
* [Validate (`chamois validate`)](validate.html)
* [Cross-validation (`chamois cv`)](cv.html)
* [Independent cross-validation (`chamois cvi`)](cvi.html)

Compound Search

* [Compare predictions to compound (`chamois compare`)](compare.html)
* [Catalog Search (`chamois search`)](search.html)

Model Interpretation

* [Explain (`chamois explain`)](explain.html)

* CLI Reference

# CLI Reference[#](#cli-reference "Link to this heading")

This section documents the command line interface (CLI) of CHAMOIS.

Note

When installing CHAMOIS with `pip`, an executable named `chamois` will
be created in `/usr/bin` or `$HOME/.local/bin`. If the install path is
not in your `$PATH`, you can also invoke the command line as a
Python module with:

```
$ python -m chamois.cli ...
```

## Inference[#](#inference "Link to this heading")

These sub-commands allow using the inference mechanism of CHAMOIS.
`chamois predict` is the basic entry-point to the CHAMOIS prediction
method, computing ChemOnt class predictions from one or more BGC in
GenBank format. `chamois render` can be used to render class predictions
stored in HDF5 as a tree in the terminal.

Inference

* [Predict (`chamois predict`)](predict.html)
* [Render (`chamois render`)](render.html)

## Training[#](#training "Link to this heading")

These sub-commands can be used for training and evaluating CHAMOIS.
`chamois annotate` can be used to annotate the features of a set of
BGCs in a GenBank file, and create a `features.hdf5` file suitable
for training. `chamois train` can to train CHAMOIS from a dataset.
`chamois validate` can check the performance of a trained model on
a given dataset. `chamois cv` can run (stratified grouped) cross-validation
to evaluate generalization.

Note

Some of these commands have additional dependencies, such as
`chamois train` which requires [scikit-learn](https://scikit-learn.org)
to train the logistic regression classifiers. To install the
required dependencies, make sure to install the `train` extra
(e.g. `pip install "chamois-tool[train]"`).

Training

* [Annotate (`chamois annotate`)](annotate.html)
* [Train (`chamois train`)](train.html)
* [Validate (`chamois validate`)](validate.html)
* [Cross-validation (`chamois cv`)](cv.html)
* [Independent cross-validation (`chamois cvi`)](cvi.html)

## Compound Search[#](#compound-search "Link to this heading")

These sub-commands can be used to explore CHAMOIS predictions.
`chamois gompare` can be used to search which BGC of a dataset is most likely
to produce a query metabolite. `chamois search` can be used to search which
metabolite of a compound catalog (such as [NPAtlas](https://npatlas.org))
is most similar to the predictions.

Compound Search

* [Compare predictions to compound (`chamois compare`)](compare.html)
* [Catalog Search (`chamois search`)](search.html)

## Model Interpretation[#](#model-interpretation "Link to this heading")

These sub-commands help interpreting the CHAMOIS model.

Model Interpretation

* [Explain (`chamois explain`)](explain.html)

[previous

Association network](../figures/network.html "previous page")
[next

Predict (`chamois predict`)](predict.html "next page")

On this page

* [Inference](#inference)
* [Training](#training)
* [Compound Search](#compound-search)
* [Model Interpretation](#model-interpretation)

[Edit on GitHub](https://github.com/zellerlab/CHAMOIS/edit/master/docs/cli/index.rst)

### This Page

* [Show Source](../_sources/cli/index.rst.txt)

© Copyright 2020-2026, Martin Larralde.

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.