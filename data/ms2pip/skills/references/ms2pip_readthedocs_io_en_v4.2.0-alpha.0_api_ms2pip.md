[ms2pip](../../)

About

* [Home](../../)
* [Installation](../../installation/)
* [Usage](../../usage/)
* [Prediction models](../../prediction-models/)

Command line interface

* [Command line interface](../../cli/cli/)

Python API reference

* ms2pip
  + [`predict_single()`](#ms2pip.predict_single)
  + [`predict_batch()`](#ms2pip.predict_batch)
  + [`predict_library()`](#ms2pip.predict_library)
  + [`correlate()`](#ms2pip.correlate)
  + [`get_training_data()`](#ms2pip.get_training_data)
  + [`annotate_spectra()`](#ms2pip.annotate_spectra)
  + [`download_models()`](#ms2pip.download_models)
* [ms2pip.constants](../ms2pip.constants/)
* [ms2pip.correlation](../ms2pip.correlation/)
* [ms2pip.exceptions](../ms2pip.exceptions/)
* [ms2pip.result](../ms2pip.result/)
* [ms2pip.search\_space](../ms2pip.search-space/)
* [ms2pip.spectrum](../ms2pip.spectrum/)
* [ms2pip.spectrum\_input](../ms2pip.spectrum-input/)
* [ms2pip.spectrum\_output](../ms2pip.spectrum-output/)

[ms2pip](../../)

* ms2pip
* [View page source](../../_sources/api/ms2pip.rst.txt)

---

# ms2pip[](#module-ms2pip "Link to this heading")

MS2PIP: Accurate and versatile peptide fragmentation spectrum prediction.

ms2pip.predict\_single(*peptidoform*, *model='HCD'*, *model\_dir=None*)[[source]](../../_modules/ms2pip/core/#predict_single)[](#ms2pip.predict_single "Link to this definition")
:   Predict fragmentation spectrum for a single peptide.

    Parameters:
    :   * **peptidoform** ([*Peptidoform*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.peptidoform.Peptidoform "(in psm_utils)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))
        * **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*)
        * **model\_dir** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* *None*)

    Return type:
    :   [*ProcessingResult*](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")

ms2pip.predict\_batch(*psms*, *add\_retention\_time=False*, *add\_ion\_mobility=False*, *psm\_filetype=None*, *model='HCD'*, *model\_dir=None*, *processes=None*)[[source]](../../_modules/ms2pip/core/#predict_batch)[](#ms2pip.predict_batch "Link to this definition")
:   Predict fragmentation spectra for a batch of peptides.

    Parameters:
    :   * **psms** ([*PSMList*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.psm_list.PSMList "(in psm_utils)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")) – PSMList or path to PSM file that is supported by psm\_utils.
        * **psm\_filetype** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Filetype of the PSM file. By default, None. Should be one of the supported psm\_utils
          filetypes. See <https://psm-utils.readthedocs.io/en/stable/#supported-file-formats>.
        * **add\_retention\_time** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Add retention time predictions with DeepLC (Requires optional DeepLC dependency).
        * **add\_ion\_mobility** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Add ion mobility predictions with IM2Deep (Requires optional IM2Deep dependency).
        * **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Model to use for prediction. Default: “HCD”.
        * **model\_dir** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* *None*) – Directory where XGBoost model files are stored. Default: ~/.ms2pip.
        * **processes** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)") *|* *None*) – Number of parallel processes for multiprocessing steps. By default, all available.

    Returns:
    :   **predictions** – Predicted spectra with theoretical m/z and predicted intensity values.

    Return type:
    :   List[[ProcessingResult](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")]

ms2pip.predict\_library(*fasta\_file=None*, *config=None*, *add\_retention\_time=False*, *add\_ion\_mobility=False*, *model='HCD'*, *model\_dir=None*, *batch\_size=100000*, *processes=None*)[[source]](../../_modules/ms2pip/core/#predict_library)[](#ms2pip.predict_library "Link to this definition")
:   Predict spectral library from protein FASTA file.

    Parameters:
    :   * **fasta\_file** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* *None*) – Path to FASTA file with protein sequences. Required if search-space-config is not
          provided.
        * **config** ([*ProteomeSearchSpace*](../ms2pip.search-space/#ms2pip.search_space.ProteomeSearchSpace "ms2pip.search_space.ProteomeSearchSpace") *|* [*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* *None*) – ProteomeSearchSpace, or a dictionary or path to JSON file with proteome search space
          parameters. Required if fasta\_file is not provided.
        * **add\_retention\_time** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Add retention time predictions with DeepLC (Requires optional DeepLC dependency).
        * **add\_ion\_mobility** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Add ion mobility predictions with IM2Deep (Requires optional IM2Deep dependency).
        * **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Model to use for prediction. Default: “HCD”.
        * **model\_dir** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* *None*) – Directory where XGBoost model files are stored. Default: ~/.ms2pip.
        * **batch\_size** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")) – Number of peptides to process in each batch.
        * **processes** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)") *|* *None*) – Number of parallel processes for multiprocessing steps. By default, all available.

    Yields:
    :   **predictions** (*List[ProcessingResult]*) – Predicted spectra with theoretical m/z and predicted intensity values.

    Return type:
    :   [*Generator*](https://docs.python.org/3/library/typing.html#typing.Generator "(in Python v3.14)")[[*ProcessingResult*](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult"), None, None]

ms2pip.correlate(*psms*, *spectrum\_file*, *psm\_filetype=None*, *spectrum\_id\_pattern=None*, *compute\_correlations=False*, *add\_retention\_time=False*, *add\_ion\_mobility=False*, *model='HCD'*, *model\_dir=None*, *ms2\_tolerance=0.02*, *processes=None*)[[source]](../../_modules/ms2pip/core/#correlate)[](#ms2pip.correlate "Link to this definition")
:   Compare predicted and observed intensities and optionally compute correlations.

    Parameters:
    :   * **psms** ([*PSMList*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.psm_list.PSMList "(in psm_utils)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")) – PSMList or path to PSM file that is supported by psm\_utils.
        * **spectrum\_file** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")) – Path to spectrum file with target intensities.
        * **psm\_filetype** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Filetype of the PSM file. By default, None. Should be one of the supported psm\_utils
          filetypes. See <https://psm-utils.readthedocs.io/en/stable/#supported-file-formats>.
        * **spectrum\_id\_pattern** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Regular expression pattern to apply to spectrum titles before matching to
          peptide file `spec_id` entries.
        * **compute\_correlations** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Compute correlations between predictions and targets.
        * **add\_retention\_time** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Add retention time predictions with DeepLC (Requires optional DeepLC dependency).
        * **add\_ion\_mobility** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Add ion mobility predictions with IM2Deep (Requires optional IM2Deep dependency).
        * **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Model to use for prediction. Default: “HCD”.
        * **model\_dir** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* *None*) – Directory where XGBoost model files are stored. Default: ~/.ms2pip.
        * **ms2\_tolerance** ([*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)")) – MS2 tolerance in Da for observed spectrum peak annotation. By default, 0.02 Da.
        * **processes** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)") *|* *None*) – Number of parallel processes for multiprocessing steps. By default, all available.

    Returns:
    :   **results** – Predicted spectra with theoretical m/z and predicted intensity values, and optionally,
        correlations.

    Return type:
    :   List[[ProcessingResult](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")]

ms2pip.get\_training\_data(*psms*, *spectrum\_file*, *psm\_filetype=None*, *spectrum\_id\_pattern=None*, *model='HCD'*, *ms2\_tolerance=0.02*, *processes=None*)[[source]](../../_modules/ms2pip/core/#get_training_data)[](#ms2pip.get_training_data "Link to this definition")
:   Extract feature vectors and target intensities from observed spectra for training.

    Parameters:
    :   * **psms** ([*PSMList*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.psm_list.PSMList "(in psm_utils)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")) – PSMList or path to PSM file that is supported by psm\_utils.
        * **spectrum\_file** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")) – Path to spectrum file with target intensities.
        * **psm\_filetype** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Filetype of the PSM file. By default, None. Should be one of the supported psm\_utils
          filetypes. See <https://psm-utils.readthedocs.io/en/stable/#supported-file-formats>.
        * **spectrum\_id\_pattern** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Regular expression pattern to apply to spectrum titles before matching to
          peptide file `spec_id` entries.
        * **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Model to use as reference for the ion types that are extracted from the observed spectra.
          Default: “HCD”, which results in the extraction of singly charged b- and y-ions.
        * **ms2\_tolerance** ([*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)")) – MS2 tolerance in Da for observed spectrum peak annotation. By default, 0.02 Da.
        * **processes** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)") *|* *None*) – Number of parallel processes for multiprocessing steps. By default, all available.

    Returns:
    :   [`pandas.DataFrame`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.html#pandas.DataFrame "(in pandas v3.0.1)") with feature vectors and targets.

    Return type:
    :   features

ms2pip.annotate\_spectra(*psms*, *spectrum\_file*, *psm\_filetype=None*, *spectrum\_id\_pattern=None*, *model='HCD'*, *ms2\_tolerance=0.02*, *processes=None*)[[source]](../../_modules/ms2pip/core/#annotate_spectra)[](#ms2pip.annotate_spectra "Link to this definition")
:   Annotate observed spectra.

    Parameters:
    :   * **psms** ([*PSMList*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.psm_list.PSMList "(in psm_utils)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")) – PSMList or path to PSM file that is supported by psm\_utils.
        * **spectrum\_file** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")) – Path to spectrum file with target intensities.
        * **psm\_filetype** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Filetype of the PSM file. By default, None. Should be one of the supported psm\_utils
          filetypes. See <https://psm-utils.readthedocs.io/en/stable/#supported-file-formats>.
        * **spectrum\_id\_pattern** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Regular expression pattern to apply to spectrum titles before matching to
          peptide file `spec_id` entries.
        * **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Model to use as reference for the ion types that are extracted from the observed spectra.
          Default: “HCD”, which results in the extraction of singly charged b- and y-ions.
        * **ms2\_to