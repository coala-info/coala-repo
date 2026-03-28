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
* ms2pip.result
  + [`ProcessingResult`](#ms2pip.result.ProcessingResult)
    - [`ProcessingResult.model_config`](#ms2pip.result.ProcessingResult.model_config)
    - [`ProcessingResult.as_spectra()`](#ms2pip.result.ProcessingResult.as_spectra)
    - [`ProcessingResult.plot_spectra()`](#ms2pip.result.ProcessingResult.plot_spectra)
  + [`calculate_correlations()`](#ms2pip.result.calculate_correlations)
  + [`write_correlations()`](#ms2pip.result.write_correlations)
* [ms2pip.search\_space](../ms2pip.search-space/)
* [ms2pip.spectrum](../ms2pip.spectrum/)
* [ms2pip.spectrum\_input](../ms2pip.spectrum-input/)
* [ms2pip.spectrum\_output](../ms2pip.spectrum-output/)

[ms2pip](../../)

* ms2pip.result
* [View page source](../../_sources/api/ms2pip.result.rst.txt)

---

# ms2pip.result[](#module-ms2pip.result "Link to this heading")

Definition and handling of MS²PIP results.

class ms2pip.result.ProcessingResult(*\**, *psm\_index*, *psm=None*, *theoretical\_mz=None*, *predicted\_intensity=None*, *observed\_intensity=None*, *correlation=None*, *feature\_vectors=None*)[[source]](../../_modules/ms2pip/result/#ProcessingResult)[](#ms2pip.result.ProcessingResult "Link to this definition")
:   Bases: `BaseModel`

    Result of processing a single PSM.

    Parameters:
    :   * **psm\_index** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)"))
        * **psm** ([*PSM*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.psm.PSM "(in psm_utils)") *|* *None*)
        * **theoretical\_mz** ([*Dict*](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)")*]* *|* *None*)
        * **predicted\_intensity** ([*Dict*](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)")*]* *|* *None*)
        * **observed\_intensity** ([*Dict*](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)")*]* *|* *None*)
        * **correlation** ([*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)") *|* *None*)
        * **feature\_vectors** ([*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)") *|* *None*)

    model\_config = {'arbitrary\_types\_allowed': True}[](#ms2pip.result.ProcessingResult.model_config "Link to this definition")
    :   Configuration for the model, should be a dictionary conforming to [ConfigDict][pydantic.config.ConfigDict].

    as\_spectra()[[source]](../../_modules/ms2pip/result/#ProcessingResult.as_spectra)[](#ms2pip.result.ProcessingResult.as_spectra "Link to this definition")
    :   Convert result to predicted and observed spectra.

        Return type:
        :   [*Tuple*](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.14)")[[*PredictedSpectrum*](../ms2pip.spectrum/#ms2pip.spectrum.PredictedSpectrum "ms2pip.spectrum.PredictedSpectrum") | None, [*ObservedSpectrum*](../ms2pip.spectrum/#ms2pip.spectrum.ObservedSpectrum "ms2pip.spectrum.ObservedSpectrum") | None]

    plot\_spectra()[[source]](../../_modules/ms2pip/result/#ProcessingResult.plot_spectra)[](#ms2pip.result.ProcessingResult.plot_spectra "Link to this definition")
    :   Plot predicted and observed spectra.

        Return type:
        :   matplotlib.axes.Axes

        Notes

        Requires optional dependency `spectrum_utils` to be installed.

ms2pip.result.calculate\_correlations(*results*)[[source]](../../_modules/ms2pip/result/#calculate_correlations)[](#ms2pip.result.calculate_correlations "Link to this definition")
:   Calculate and add Pearson correlations to list of results.

    Parameters:
    :   **results** ([*List*](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.14)")*[*[*ProcessingResult*](#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")*]*)

    Return type:
    :   None

ms2pip.result.write\_correlations(*results*, *output\_file*)[[source]](../../_modules/ms2pip/result/#write_correlations)[](#ms2pip.result.write_correlations "Link to this definition")
:   Write correlations to CSV file.

    Parameters:
    :   * **results** ([*List*](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.14)")*[*[*ProcessingResult*](#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")*]*)
        * **output\_file** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    Return type:
    :   None

[Previous](../ms2pip.exceptions/ "ms2pip.exceptions")
[Next](../ms2pip.search-space/ "ms2pip.search_space")

---

© Copyright .

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).