[ms2pip](../../)

About

* [Home](../../)
* [Installation](../../installation/)
* [Usage](../../usage/)
* [Prediction models](../../prediction-models/)

Command line interface

* [Command line interface](../../cli/cli/)

Python API reference

* [ms2pip](../ms2pip/)
* [ms2pip.constants](../ms2pip.constants/)
* ms2pip.correlation
  + [`ms2pip_pearson()`](#ms2pip.correlation.ms2pip_pearson)
  + [`spectral_angle()`](#ms2pip.correlation.spectral_angle)
* [ms2pip.exceptions](../ms2pip.exceptions/)
* [ms2pip.result](../ms2pip.result/)
* [ms2pip.search\_space](../ms2pip.search-space/)
* [ms2pip.spectrum](../ms2pip.spectrum/)
* [ms2pip.spectrum\_input](../ms2pip.spectrum-input/)
* [ms2pip.spectrum\_output](../ms2pip.spectrum-output/)

[ms2pip](../../)

* ms2pip.correlation
* [View page source](../../_sources/api/ms2pip.correlation.rst.txt)

---

# ms2pip.correlation[](#module-ms2pip.correlation "Link to this heading")

ms2pip.correlation.ms2pip\_pearson(*true*, *pred*)[[source]](../../_modules/ms2pip/correlation/#ms2pip_pearson)[](#ms2pip.correlation.ms2pip_pearson "Link to this definition")
:   Calculate Pearson correlation, including tic-normalization and log-transformation.

ms2pip.correlation.spectral\_angle(*true*, *pred*, *epsilon=1e-07*)[[source]](../../_modules/ms2pip/correlation/#spectral_angle)[](#ms2pip.correlation.spectral_angle "Link to this definition")
:   Calculate square root normalized spectral angle.

    See <https://doi.org/10.1074/mcp.O113.036475>.

[Previous](../ms2pip.constants/ "ms2pip.constants")
[Next](../ms2pip.exceptions/ "ms2pip.exceptions")

---

© Copyright .

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).