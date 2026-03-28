[ms2pip](../../)

About

* [Home](../../)
* [Installation](../../installation/)
* [Usage](../../usage/)
* [Prediction models](../../prediction-models/)

Command line interface

* Command line interface
  + [ms2pip](#ms2pip)
    - [annotate-spectra](#ms2pip-annotate-spectra)
      * [Parameters](#parameters)
      * [Returns](#returns)
    - [correlate](#ms2pip-correlate)
      * [Parameters](#id1)
      * [Returns](#id2)
    - [get-training-data](#ms2pip-get-training-data)
      * [Parameters](#id3)
      * [Returns](#id4)
    - [predict-batch](#ms2pip-predict-batch)
      * [Parameters](#id5)
      * [Returns](#id6)
    - [predict-library](#ms2pip-predict-library)
      * [Parameters](#id7)
      * [Yields](#yields)
    - [predict-single](#ms2pip-predict-single)

Python API reference

* [ms2pip](../../api/ms2pip/)
* [ms2pip.constants](../../api/ms2pip.constants/)
* [ms2pip.correlation](../../api/ms2pip.correlation/)
* [ms2pip.exceptions](../../api/ms2pip.exceptions/)
* [ms2pip.result](../../api/ms2pip.result/)
* [ms2pip.search\_space](../../api/ms2pip.search-space/)
* [ms2pip.spectrum](../../api/ms2pip.spectrum/)
* [ms2pip.spectrum\_input](../../api/ms2pip.spectrum-input/)
* [ms2pip.spectrum\_output](../../api/ms2pip.spectrum-output/)

[ms2pip](../../)

* Command line interface
* [View page source](../../_sources/cli/cli.rst.txt)

---

# Command line interface[](#command-line-interface "Link to this heading")

## ms2pip[](#ms2pip "Link to this heading")

Usage

```
ms2pip [OPTIONS] COMMAND [ARGS]...
```

Options

-l, --logging-level <logging\_level>[](#cmdoption-ms2pip-l "Link to this definition")
:   Options:
    :   DEBUG | INFO | WARNING | ERROR | CRITICAL

--version[](#cmdoption-ms2pip-version "Link to this definition")
:   Show the version and exit.

### annotate-spectra[](#ms2pip-annotate-spectra "Link to this heading")

Annotate observed spectra.

#### Parameters[](#parameters "Link to this heading")

psms
:   PSMList or path to PSM file that is supported by psm\_utils.

spectrum\_file
:   Path to spectrum file with target intensities.

psm\_filetype
:   Filetype of the PSM file. By default, None. Should be one of the supported psm\_utils
    filetypes. See <https://psm-utils.readthedocs.io/en/stable/#supported-file-formats>.

spectrum\_id\_pattern
:   Regular expression pattern to apply to spectrum titles before matching to
    peptide file `spec_id` entries.

model
:   Model to use as reference for the ion types that are extracted from the observed spectra.
    Default: “HCD”, which results in the extraction of singly charged b- and y-ions.

ms2\_tolerance
:   MS2 tolerance in Da for observed spectrum peak annotation. By default, 0.02 Da.

processes
:   Number of parallel processes for multiprocessing steps. By default, all available.

#### Returns[](#returns "Link to this heading")

results: List[ProcessingResult]
:   List of ProcessingResult objects with theoretical m/z and observed intensity values.

Usage

```
ms2pip annotate-spectra [OPTIONS] PSMS SPECTRUM_FILE
```

Options

-t, --psm-filetype <psm\_filetype>[](#cmdoption-ms2pip-annotate-spectra-t "Link to this definition")
:   Options:
    :   flashlfq | ionbot | idxml | msms | mzid | peprec | pepxml | percolator | proteome\_discoverer | proteoscape | xtandem | msamanda | sage\_tsv | sage\_parquet | fragpipe | alphadia | diann | parquet | json | cbor | tsv | sage

-o, --output-name <output\_name>[](#cmdoption-ms2pip-annotate-spectra-o "Link to this definition")

-p, --spectrum-id-pattern <spectrum\_id\_pattern>[](#cmdoption-ms2pip-annotate-spectra-p "Link to this definition")

--model <model>[](#cmdoption-ms2pip-annotate-spectra-model "Link to this definition")
:   Options:
    :   CID | HCD2019 | TTOF5600 | TMT | iTRAQ | iTRAQphospho | HCDch2 | CIDch2 | HCD2021 | Immuno-HCD | CID-TMT | timsTOF2023 | timsTOF2024 | HCD | timsTOF

--ms2-tolerance <ms2\_tolerance>[](#cmdoption-ms2pip-annotate-spectra-ms2-tolerance "Link to this definition")

-n, --processes <processes>[](#cmdoption-ms2pip-annotate-spectra-n "Link to this definition")

Arguments

PSMS[](#cmdoption-ms2pip-annotate-spectra-arg-PSMS "Link to this definition")
:   Required argument

SPECTRUM\_FILE[](#cmdoption-ms2pip-annotate-spectra-arg-SPECTRUM_FILE "Link to this definition")
:   Required argument

### correlate[](#ms2pip-correlate "Link to this heading")

Compare predicted and observed intensities and optionally compute correlations.

#### Parameters[](#id1 "Link to this heading")

psms
:   PSMList or path to PSM file that is supported by psm\_utils.

spectrum\_file
:   Path to spectrum file with target intensities.

psm\_filetype
:   Filetype of the PSM file. By default, None. Should be one of the supported psm\_utils
    filetypes. See <https://psm-utils.readthedocs.io/en/stable/#supported-file-formats>.

spectrum\_id\_pattern
:   Regular expression pattern to apply to spectrum titles before matching to
    peptide file `spec_id` entries.

compute\_correlations
:   Compute correlations between predictions and targets.

add\_retention\_time
:   Add retention time predictions with DeepLC (Requires optional DeepLC dependency).

add\_ion\_mobility
:   Add ion mobility predictions with IM2Deep (Requires optional IM2Deep dependency).

model
:   Model to use for prediction. Default: “HCD”.

model\_dir
:   Directory where XGBoost model files are stored. Default: ~/.ms2pip.

ms2\_tolerance
:   MS2 tolerance in Da for observed spectrum peak annotation. By default, 0.02 Da.

processes
:   Number of parallel processes for multiprocessing steps. By default, all available.

#### Returns[](#id2 "Link to this heading")

results: List[ProcessingResult]
:   Predicted spectra with theoretical m/z and predicted intensity values, and optionally,
    correlations.

Usage

```
ms2pip correlate [OPTIONS] PSMS SPECTRUM_FILE
```

Options

-t, --psm-filetype <psm\_filetype>[](#cmdoption-ms2pip-correlate-t "Link to this definition")
:   Options:
    :   flashlfq | ionbot | idxml | msms | mzid | peprec | pepxml | percolator | proteome\_discoverer | proteoscape | xtandem | msamanda | sage\_tsv | sage\_parquet | fragpipe | alphadia | diann | parquet | json | cbor | tsv | sage

-o, --output-name <output\_name>[](#cmdoption-ms2pip-correlate-o "Link to this definition")

-p, --spectrum-id-pattern <spectrum\_id\_pattern>[](#cmdoption-ms2pip-correlate-p "Link to this definition")

-x, --compute-correlations[](#cmdoption-ms2pip-correlate-x "Link to this definition")

-r, --add-retention-time[](#cmdoption-ms2pip-correlate-r "Link to this definition")

-i, --add-ion-mobility[](#cmdoption-ms2pip-correlate-i "Link to this definition")

--model <model>[](#cmdoption-ms2pip-correlate-model "Link to this definition")
:   Options:
    :   CID | HCD2019 | TTOF5600 | TMT | iTRAQ | iTRAQphospho | HCDch2 | CIDch2 | HCD2021 | Immuno-HCD | CID-TMT | timsTOF2023 | timsTOF2024 | HCD | timsTOF

--model-dir <model\_dir>[](#cmdoption-ms2pip-correlate-model-dir "Link to this definition")

--ms2-tolerance <ms2\_tolerance>[](#cmdoption-ms2pip-correlate-ms2-tolerance "Link to this definition")

-n, --processes <processes>[](#cmdoption-ms2pip-correlate-n "Link to this definition")

Arguments

PSMS[](#cmdoption-ms2pip-correlate-arg-PSMS "Link to this definition")
:   Required argument

SPECTRUM\_FILE[](#cmdoption-ms2pip-correlate-arg-SPECTRUM_FILE "Link to this definition")
:   Required argument

### get-training-data[](#ms2pip-get-training-data "Link to this heading")

Extract feature vectors and target intensities from observed spectra for training.

#### Parameters[](#id3 "Link to this heading")

psms
:   PSMList or path to PSM file that is supported by psm\_utils.

spectrum\_file
:   Path to spectrum file with target intensities.

psm\_filetype
:   Filetype of the PSM file. By default, None. Should be one of the supported psm\_utils
    filetypes. See <https://psm-utils.readthedocs.io/en/stable/#supported-file-formats>.

spectrum\_id\_pattern
:   Regular expression pattern to apply to spectrum titles before matching to
    peptide file `spec_id` entries.

model
:   Model to use as reference for the ion types that are extracted from the observed spectra.
    Default: “HCD”, which results in the extraction of singly charged b- and y-ions.

ms2\_tolerance
:   MS2 tolerance in Da for observed spectrum peak annotation. By default, 0.02 Da.

processes
:   Number of parallel processes for multiprocessing steps. By default, all available.

#### Returns[](#id4 "Link to this heading")

features
:   [`pandas.DataFrame`](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.html#pandas.DataFrame "(in pandas v3.0.1)") with feature vectors and targets.

Usage

```
ms2pip get-training-data [OPTIONS] PSMS SPECTRUM_FILE
```

Options

-t, --psm-filetype <psm\_filetype>[](#cmdoption-ms2pip-get-training-data-t "Link to this definition")
:   Options:
    :   flashlfq | ionbot | idxml | msms | mzid | peprec | pepxml | percolator | proteome\_discoverer | proteoscape | xtandem | msamanda | sage\_tsv | sage\_parquet | fragpipe | alphadia | diann | parquet | json | cbor | tsv | sage

-o, --output-name <output\_name>[](#cmdoption-ms2pip-get-training-data-o "Link to this definition")

-p, --spectrum-id-pattern <spectrum\_id\_pattern>[](#cmdoption-ms2pip-get-training-data-p "Link to this definition")

--model <model>[](#cmdoption-ms2pip-get-training-data-model "Link to this definition")
:   Options:
    :   CID | HCD2019 | TTOF5600 | TMT | iTRAQ | iTRAQphospho | HCDch2 | CIDch2 | HCD2021 | Immuno-HCD | CID-TMT | timsTOF2023 | timsTOF2024 | HCD | timsTOF

--ms2-tolerance <ms2\_tolerance>[](#cmdoption-ms2pip-get-training-data-ms2-tolerance "Link to this definition")

-n, --processes <processes>[](#cmdoption-ms2pip-get-training-data-n "Link to this definition")

Arguments

PSMS[](#cmdoption-ms2pip-get-training-data-arg-PSMS "Link to this definition")
:   Required argument

SPECTRUM\_FILE[](#cmdoption-ms2pip-get-training-data-arg-SPECTRUM_FILE "Link to this definition")
:   Required argument

### predict-batch[](#ms2pip-predict-batch "Link to this heading")

Predict fragmentation spectra for a batch of peptides.

#### Parameters[](#id5 "Link to this heading")

psms
:   PSMList or path to PSM file that is supported by psm\_utils.

psm\_filetype
:   Filetype of the PSM file. By default, None. Should be one of the supported psm\_utils
    filetypes. See <https://psm-utils.readthedocs.io/en/stable/#supported-file-formats>.

add\_retention\_time
:   Add retention time predictions with DeepLC (Requires optional DeepLC dependency).

add\_ion\_mobility
:   Add ion mobility predictions with IM2Deep (Requires optional IM2Deep dependency).

model
:   Model to use for prediction. Default: “HCD”.

model\_dir
:   Directory where XGBoost model files are stored. Default: ~/.ms2pip.

processes
:   Number of parallel processes for multiprocessing steps. By default, all available.

#### Returns[](#id6 "Link to this heading")

predictions: List[ProcessingResult]
:   Predicted spectra with theoretical m/z and predicted intensity values.

Usage

```
ms2pip predict-batch [OPTIONS] PSMS
```

Options

-t, --psm-filetype <psm\_filetype>[](#cmdoption-ms2pip-predict-batch-t "Link to this definition")
:   Options:
    :   flashlfq | ionbot | idxml | msms | mzid | peprec | pepxml | percolator | proteome\_discoverer | proteoscape | xtandem | msamanda | sage\_tsv | sage\_parquet | fragpipe | alphadia | diann | parquet | json | cbor | tsv | sage

-o, --output-name <output\_name>[](#cmdoption-ms2pip-predict-batch-o "Link to this definition")

-f, --output-format <output\_format>[](#cmdoption-ms2pip-predict-batch-f "Link to this definition")
:   Options:
    :   tsv | msp | mgf | spectronaut | bibliospec | dlib

-r, --add-retention-time[](#cmdoption-ms2pip-predict-batch-r "Link to this definition")

-i, --add-ion-mobility[](#cmdoption-ms2pip-predict-batch-i "Link to this definition")

--model <model>[](#cmdoption-ms2pip-predict-batch-model "Link to this definition")
:   Options:
    :   CID | HCD2019 | TTOF5600 | TMT | iTRAQ | iTRAQphospho | HCDch2 | CIDch2 | HCD2021 | Immuno-HCD | CID-TMT | timsTOF2023 | timsTOF2024 | HCD | timsTOF

--model-dir <model\_dir>[](#cmdoption-ms2pip-predict-batch-model-dir "Link to this definition")

-n, --processes <processes>[](#cmdoption-ms2pip-predict-batch-n "Link to this definition")

Arguments

PSMS[](#cmdoption-ms2pip-predict-batch-arg-PSMS "Link to this definition")
:   Required argument

### predict-library[](#ms2pip-predict-library "Link to this heading")

Predict spectral library from protein FASTA file.

#### Parameters[](#id7 "Link to this heading")

fasta\_file
:   Path to FASTA file with protein sequences. Required if search-space-config is not
    provided.

config
:   ProteomeSearchSpace, or a dictionary or path to JSON file with proteome search space
    parameters. Required if fasta\_file is not provided.

add\_retention\_time
:   Add retention time predictions with DeepLC (Requires optional DeepLC dependency).

add\_ion\_mobility
:   Add ion mobility predictions with IM2Deep (Requires optional IM2Deep dependency).

model
:   Model to use for prediction. Default: “HCD”.

model\_dir
:   Directory where XGBoost model files are stored. Default: ~/.ms2pip.

batch\_size
:   Number of peptides to process in each batch.

processes
:   Number of parallel processes for multiprocessing steps. By default, all available.

#### Yields[](#yields "Link to this heading")

predictions: List[ProcessingResult]
:   Predicted spectra with theoretical m/z and predicted intensity values.

Usage

```
ms2pip predict-library [OPTIONS] [FASTA_FILE]
```

Options

-c, --config <config>[](#cmdoption-ms2pip-predict-library-c "Link to this definition")

-o, --output-name <output\_name>[](#cmdoption-ms2pip-predict-library-o "Link to this definition")

-f, --output-format <output\_format>[](#cmdoption-ms2pip-predict-library-f "Link to this definition")
:   Options:
    :   tsv | msp | mgf | spectronaut | bibliospec | dlib

-r, --add-retention-time[](#cmdoption-ms2pip-predict-library-r "Link to this definition")

-i, --add-ion-mobility[](#cmdoption-ms2pip-predict-library-i "Link to this definition")

--model <model>[](#cmdoption-ms2pip-predict-library-model "Link to this definition")
:   Options:
    :   CID | HCD2019 | TTOF5600 | TMT | iTRAQ | iTRAQphospho | HCDch2 | CIDch2 | HCD2021 | Immuno-HCD | CID-TMT | timsTOF2023 | timsTOF2024 | HCD | timsTOF

--model-dir <model\_dir>[](#cmdoption-ms2pip-predict-library-model-dir "Link to this definition")

--batch-size <batch\_size>[](#cmdoption-ms2pip-predict-library-batch-size "Link to this definition")

-n, --processes <processes>[](#cmdoption-ms2pip-predict-library-n "Link to this definition")

Arguments

FASTA\_FILE[](#cmdoption-ms2pip-predict-library-arg-FASTA_FILE "Link to this definition")
:   Optional argument

### predict-single[](#ms2pip-predict-single