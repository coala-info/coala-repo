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
* [ms2pip.exceptions](../ms2pip.exceptions/)
* [ms2pip.result](../ms2pip.result/)
* [ms2pip.search\_space](../ms2pip.search-space/)
* [ms2pip.spectrum](../ms2pip.spectrum/)
* ms2pip.spectrum\_input
  + [`read_spectrum_file()`](#ms2pip.spectrum_input.read_spectrum_file)
* [ms2pip.spectrum\_output](../ms2pip.spectrum-output/)

[ms2pip](../../)

* ms2pip.spectrum\_input
* [View page source](../../_sources/api/ms2pip.spectrum-input.rst.txt)

---

# ms2pip.spectrum\_input[](#module-ms2pip.spectrum_input "Link to this heading")

Read MS2 spectra.

ms2pip.spectrum\_input.read\_spectrum\_file(*spectrum\_file*)[[source]](../../_modules/ms2pip/spectrum_input/#read_spectrum_file)[](#ms2pip.spectrum_input.read_spectrum_file "Link to this definition")
:   Read MS2 spectra from a supported file format; inferring the type from the filename extension.

    Parameters:
    :   **spectrum\_file** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – Path to MGF or mzML file.

    Yields:
    :   *ObservedSpectrum*

    Raises:
    :   [**UnsupportedSpectrumFiletypeError**](../ms2pip.exceptions/#ms2pip.exceptions.UnsupportedSpectrumFiletypeError "ms2pip.exceptions.UnsupportedSpectrumFiletypeError") – If the file extension is not supported.

    Return type:
    :   [*Generator*](https://docs.python.org/3/library/typing.html#typing.Generator "(in Python v3.14)")[[*ObservedSpectrum*](../ms2pip.spectrum/#ms2pip.spectrum.ObservedSpectrum "ms2pip.spectrum.ObservedSpectrum"), None, None]

[Previous](../ms2pip.spectrum/ "ms2pip.spectrum")
[Next](../ms2pip.spectrum-output/ "ms2pip.spectrum_output")

---

© Copyright .

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).