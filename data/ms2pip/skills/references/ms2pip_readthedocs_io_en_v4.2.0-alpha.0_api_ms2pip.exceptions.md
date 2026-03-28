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
* [ms2pip.correlation](../ms2pip.correlation/)
* ms2pip.exceptions
  + [`MS2PIPError`](#ms2pip.exceptions.MS2PIPError)
  + [`InvalidPeptidoformError`](#ms2pip.exceptions.InvalidPeptidoformError)
  + [`InvalidInputError`](#ms2pip.exceptions.InvalidInputError)
  + [`UnresolvableModificationError`](#ms2pip.exceptions.UnresolvableModificationError)
  + [`UnknownOutputFormatError`](#ms2pip.exceptions.UnknownOutputFormatError)
  + [`UnknownModelError`](#ms2pip.exceptions.UnknownModelError)
  + [`InvalidAminoAcidError`](#ms2pip.exceptions.InvalidAminoAcidError)
  + [`UnsupportedSpectrumFiletypeError`](#ms2pip.exceptions.UnsupportedSpectrumFiletypeError)
  + [`NoMatchingSpectraFound`](#ms2pip.exceptions.NoMatchingSpectraFound)
  + [`TitlePatternError`](#ms2pip.exceptions.TitlePatternError)
  + [`InvalidXGBoostModelError`](#ms2pip.exceptions.InvalidXGBoostModelError)
* [ms2pip.result](../ms2pip.result/)
* [ms2pip.search\_space](../ms2pip.search-space/)
* [ms2pip.spectrum](../ms2pip.spectrum/)
* [ms2pip.spectrum\_input](../ms2pip.spectrum-input/)
* [ms2pip.spectrum\_output](../ms2pip.spectrum-output/)

[ms2pip](../../)

* ms2pip.exceptions
* [View page source](../../_sources/api/ms2pip.exceptions.rst.txt)

---

# ms2pip.exceptions[](#module-ms2pip.exceptions "Link to this heading")

exception ms2pip.exceptions.MS2PIPError[[source]](../../_modules/ms2pip/exceptions/#MS2PIPError)[](#ms2pip.exceptions.MS2PIPError "Link to this definition")
:   Bases: [`Exception`](https://docs.python.org/3/library/exceptions.html#Exception "(in Python v3.14)")

exception ms2pip.exceptions.InvalidPeptidoformError[[source]](../../_modules/ms2pip/exceptions/#InvalidPeptidoformError)[](#ms2pip.exceptions.InvalidPeptidoformError "Link to this definition")
:   Bases: [`MS2PIPError`](#ms2pip.exceptions.MS2PIPError "ms2pip.exceptions.MS2PIPError")

exception ms2pip.exceptions.InvalidInputError[[source]](../../_modules/ms2pip/exceptions/#InvalidInputError)[](#ms2pip.exceptions.InvalidInputError "Link to this definition")
:   Bases: [`MS2PIPError`](#ms2pip.exceptions.MS2PIPError "ms2pip.exceptions.MS2PIPError")

exception ms2pip.exceptions.UnresolvableModificationError[[source]](../../_modules/ms2pip/exceptions/#UnresolvableModificationError)[](#ms2pip.exceptions.UnresolvableModificationError "Link to this definition")
:   Bases: [`MS2PIPError`](#ms2pip.exceptions.MS2PIPError "ms2pip.exceptions.MS2PIPError")

exception ms2pip.exceptions.UnknownOutputFormatError[[source]](../../_modules/ms2pip/exceptions/#UnknownOutputFormatError)[](#ms2pip.exceptions.UnknownOutputFormatError "Link to this definition")
:   Bases: [`ValueError`](https://docs.python.org/3/library/exceptions.html#ValueError "(in Python v3.14)")

exception ms2pip.exceptions.UnknownModelError[[source]](../../_modules/ms2pip/exceptions/#UnknownModelError)[](#ms2pip.exceptions.UnknownModelError "Link to this definition")
:   Bases: [`ValueError`](https://docs.python.org/3/library/exceptions.html#ValueError "(in Python v3.14)")

exception ms2pip.exceptions.InvalidAminoAcidError[[source]](../../_modules/ms2pip/exceptions/#InvalidAminoAcidError)[](#ms2pip.exceptions.InvalidAminoAcidError "Link to this definition")
:   Bases: [`MS2PIPError`](#ms2pip.exceptions.MS2PIPError "ms2pip.exceptions.MS2PIPError")

exception ms2pip.exceptions.UnsupportedSpectrumFiletypeError[[source]](../../_modules/ms2pip/exceptions/#UnsupportedSpectrumFiletypeError)[](#ms2pip.exceptions.UnsupportedSpectrumFiletypeError "Link to this definition")
:   Bases: [`MS2PIPError`](#ms2pip.exceptions.MS2PIPError "ms2pip.exceptions.MS2PIPError")

exception ms2pip.exceptions.NoMatchingSpectraFound[[source]](../../_modules/ms2pip/exceptions/#NoMatchingSpectraFound)[](#ms2pip.exceptions.NoMatchingSpectraFound "Link to this definition")
:   Bases: [`MS2PIPError`](#ms2pip.exceptions.MS2PIPError "ms2pip.exceptions.MS2PIPError")

exception ms2pip.exceptions.TitlePatternError[[source]](../../_modules/ms2pip/exceptions/#TitlePatternError)[](#ms2pip.exceptions.TitlePatternError "Link to this definition")
:   Bases: [`MS2PIPError`](#ms2pip.exceptions.MS2PIPError "ms2pip.exceptions.MS2PIPError")

exception ms2pip.exceptions.InvalidXGBoostModelError[[source]](../../_modules/ms2pip/exceptions/#InvalidXGBoostModelError)[](#ms2pip.exceptions.InvalidXGBoostModelError "Link to this definition")
:   Bases: [`MS2PIPError`](#ms2pip.exceptions.MS2PIPError "ms2pip.exceptions.MS2PIPError")

[Previous](../ms2pip.correlation/ "ms2pip.correlation")
[Next](../ms2pip.result/ "ms2pip.result")

---

© Copyright .

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).