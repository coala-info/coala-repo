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
* ms2pip.spectrum
  + [`Spectrum`](#ms2pip.spectrum.Spectrum)
    - [`Spectrum.model_config`](#ms2pip.spectrum.Spectrum.model_config)
    - [`Spectrum.tic`](#ms2pip.spectrum.Spectrum.tic)
    - [`Spectrum.remove_reporter_ions()`](#ms2pip.spectrum.Spectrum.remove_reporter_ions)
    - [`Spectrum.remove_precursor()`](#ms2pip.spectrum.Spectrum.remove_precursor)
    - [`Spectrum.tic_norm()`](#ms2pip.spectrum.Spectrum.tic_norm)
    - [`Spectrum.log2_transform()`](#ms2pip.spectrum.Spectrum.log2_transform)
    - [`Spectrum.clip_intensity()`](#ms2pip.spectrum.Spectrum.clip_intensity)
    - [`Spectrum.to_spectrum_utils()`](#ms2pip.spectrum.Spectrum.to_spectrum_utils)
  + [`ObservedSpectrum`](#ms2pip.spectrum.ObservedSpectrum)
    - [`ObservedSpectrum.model_config`](#ms2pip.spectrum.ObservedSpectrum.model_config)
  + [`PredictedSpectrum`](#ms2pip.spectrum.PredictedSpectrum)
    - [`PredictedSpectrum.model_config`](#ms2pip.spectrum.PredictedSpectrum.model_config)
* [ms2pip.spectrum\_input](../ms2pip.spectrum-input/)
* [ms2pip.spectrum\_output](../ms2pip.spectrum-output/)

[ms2pip](../../)

* ms2pip.spectrum
* [View page source](../../_sources/api/ms2pip.spectrum.rst.txt)

---

# ms2pip.spectrum[](#module-ms2pip.spectrum "Link to this heading")

MS2 spectrum handling.

class ms2pip.spectrum.Spectrum(*\**, *mz*, *intensity*, *annotations=None*, *identifier=None*, *peptidoform=None*, *precursor\_mz=None*, *precursor\_charge=None*, *retention\_time=None*, *mass\_tolerance=None*, *mass\_tolerance\_unit=None*)[[source]](../../_modules/ms2pip/spectrum/#Spectrum)[](#ms2pip.spectrum.Spectrum "Link to this definition")
:   Bases: `BaseModel`

    MS2 spectrum.

    Parameters:
    :   * **mz** (*np.ndarray*) – Array of m/z values.
        * **intensity** (*np.ndarray*) – Array of intensity values.
        * **annotations** (*Optional**[**np.ndarray**]*) – Array of peak annotations.
        * **identifier** (*Optional**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*) – Spectrum identifier.
        * **peptidoform** (*Optional**[**Union**[**Peptidoform**,* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]**]*) – Peptidoform.
        * **precursor\_mz** (*Optional**[*[*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)")*]*) – Precursor m/z.
        * **precursor\_charge** (*Optional**[*[*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")*]*) – Precursor charge.
        * **retention\_time** (*Optional**[*[*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)")*]*) – Retention time.
        * **mass\_tolerance** (*Optional**[*[*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)")*]*) – Mass tolerance for spectrum annotation.
        * **mass\_tolerance\_unit** (*Optional**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*) – Unit of mass tolerance for spectrum annotation.

    model\_config = {'arbitrary\_types\_allowed': True}[](#ms2pip.spectrum.Spectrum.model_config "Link to this definition")
    :   Configuration for the model, should be a dictionary conforming to [ConfigDict][pydantic.config.ConfigDict].

    property tic[](#ms2pip.spectrum.Spectrum.tic "Link to this definition")
    :   Total ion current.

    remove\_reporter\_ions(*label\_type=None*)[[source]](../../_modules/ms2pip/spectrum/#Spectrum.remove_reporter_ions)[](#ms2pip.spectrum.Spectrum.remove_reporter_ions "Link to this definition")
    :   Set the intensity of reporter ions to 0.

        Return type:
        :   None

    remove\_precursor(*tolerance=0.02*)[[source]](../../_modules/ms2pip/spectrum/#Spectrum.remove_precursor)[](#ms2pip.spectrum.Spectrum.remove_precursor "Link to this definition")
    :   Set the intensity of the precursor peak to 0.

        Return type:
        :   None

    tic\_norm()[[source]](../../_modules/ms2pip/spectrum/#Spectrum.tic_norm)[](#ms2pip.spectrum.Spectrum.tic_norm "Link to this definition")
    :   Normalize spectrum to total ion current.

        Return type:
        :   None

    log2\_transform()[[source]](../../_modules/ms2pip/spectrum/#Spectrum.log2_transform)[](#ms2pip.spectrum.Spectrum.log2_transform "Link to this definition")
    :   Log2-tranform spectrum.

        Return type:
        :   None

    clip\_intensity(*min\_intensity=0.0*)[[source]](../../_modules/ms2pip/spectrum/#Spectrum.clip_intensity)[](#ms2pip.spectrum.Spectrum.clip_intensity "Link to this definition")
    :   Clip intensity values.

        Return type:
        :   None

    to\_spectrum\_utils()[[source]](../../_modules/ms2pip/spectrum/#Spectrum.to_spectrum_utils)[](#ms2pip.spectrum.Spectrum.to_spectrum_utils "Link to this definition")
    :   Convert to spectrum\_utils.spectrum.MsmsSpectrum.

        Notes

        * Requires spectrum\_utils to be installed.
        * If the `precursor_mz` or `precursor_charge` attributes are not set, the theoretical
          m/z and precursor charge of the `peptidoform` attribute are used, if present.
          Otherwise, `ValueError` is raised.

class ms2pip.spectrum.ObservedSpectrum(*\**, *mz*, *intensity*, *annotations=None*, *identifier=None*, *peptidoform=None*, *precursor\_mz=None*, *precursor\_charge=None*, *retention\_time=None*, *mass\_tolerance=None*, *mass\_tolerance\_unit=None*)[[source]](../../_modules/ms2pip/spectrum/#ObservedSpectrum)[](#ms2pip.spectrum.ObservedSpectrum "Link to this definition")
:   Bases: [`Spectrum`](#ms2pip.spectrum.Spectrum "ms2pip.spectrum.Spectrum")

    MS2 spectrum.

    Parameters:
    :   * **mz** ([*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)")) – Array of m/z values.
        * **intensity** ([*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)")) – Array of intensity values.
        * **annotations** ([*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)") *|* *None*) – Array of peak annotations.
        * **identifier** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Spectrum identifier.
        * **peptidoform** ([*Peptidoform*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.peptidoform.Peptidoform "(in psm_utils)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Peptidoform.
        * **precursor\_mz** ([*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)") *|* *None*) – Precursor m/z.
        * **precursor\_charge** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)") *|* *None*) – Precursor charge.
        * **retention\_time** ([*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)") *|* *None*) – Retention time.
        * **mass\_tolerance** ([*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)") *|* *None*) – Mass tolerance for spectrum annotation.
        * **mass\_tolerance\_unit** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Unit of mass tolerance for spectrum annotation.

    model\_config = {'arbitrary\_types\_allowed': True}[](#ms2pip.spectrum.ObservedSpectrum.model_config "Link to this definition")
    :   Configuration for the model, should be a dictionary conforming to [ConfigDict][pydantic.config.ConfigDict].

class ms2pip.spectrum.PredictedSpectrum(*\**, *mz*, *intensity*, *annotations=None*, *identifier=None*, *peptidoform=None*, *precursor\_mz=None*, *precursor\_charge=None*, *retention\_time=None*, *mass\_tolerance=0.001*, *mass\_tolerance\_unit='Da'*)[[source]](../../_modules/ms2pip/spectrum/#PredictedSpectrum)[](#ms2pip.spectrum.PredictedSpectrum "Link to this definition")
:   Bases: [`Spectrum`](#ms2pip.spectrum.Spectrum "ms2pip.spectrum.Spectrum")

    MS2 spectrum.

    Parameters:
    :   * **mz** ([*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)")) – Array of m/z values.
        * **intensity** ([*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)")) – Array of intensity values.
        * **annotations** ([*ndarray*](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v2.4)") *|* *None*) – Array of peak annotations.
        * **identifier** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Spectrum identifier.
        * **peptidoform** ([*Peptidoform*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.peptidoform.Peptidoform "(in psm_utils)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Peptidoform.
        * **precursor\_mz** ([*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)") *|* *None*) – Precursor m/z.
        * **precursor\_charge** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)") *|* *None*) – Precursor charge.
        * **retention\_time** ([*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)") *|* *None*) – Retention time.
        * **mass\_tolerance** (*Optional**[*[*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)")*]*) – Mass tolerance for spectrum annotation.
        * **mass\_tolerance\_unit** (*Optional**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*) – Unit of mass tolerance for spectrum annotation.

    model\_config = {'arbitrary\_types\_allowed': True}[](#ms2pip.spectrum.PredictedSpectrum.model_config "Link to this definition")
    :   Configuration for the model, should be a dictionary conforming to [ConfigDict][pydantic.config.ConfigDict].

[Previous](../ms2pip.search-space/ "ms2pip.search_space")
[Next](../ms2pip.spectrum-input/ "ms2pip.spectrum_input")

---

© Copyright .

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).