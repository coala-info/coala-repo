[ms2pip](../)

About

* [Home](../)
* [Installation](../installation/)
* Usage
  + [Usage modes](#usage-modes)
    - [`predict-single`](#predict-single)
    - [`predict-batch`](#predict-batch)
    - [`predict-library`](#predict-library)
    - [`correlate`](#correlate)
    - [`correlate-single`](#correlate-single)
    - [`get-training-data`](#get-training-data)
    - [`annotate-spectra`](#annotate-spectra)
  + [Input](#input)
    - [Peptides / PSMs](#peptides-psms)
      * [PSM file types](#psm-file-types)
      * [Peptide sequence properties](#peptide-sequence-properties)
      * [Amino acid modifications](#amino-acid-modifications)
    - [Spectrum file](#spectrum-file)
  + [Output](#output)
* [Prediction models](../prediction-models/)

Command line interface

* [Command line interface](../cli/cli/)

Python API reference

* [ms2pip](../api/ms2pip/)
* [ms2pip.constants](../api/ms2pip.constants/)
* [ms2pip.correlation](../api/ms2pip.correlation/)
* [ms2pip.exceptions](../api/ms2pip.exceptions/)
* [ms2pip.result](../api/ms2pip.result/)
* [ms2pip.search\_space](../api/ms2pip.search-space/)
* [ms2pip.spectrum](../api/ms2pip.spectrum/)
* [ms2pip.spectrum\_input](../api/ms2pip.spectrum-input/)
* [ms2pip.spectrum\_output](../api/ms2pip.spectrum-output/)

[ms2pip](../)

* Usage
* [View page source](../_sources/usage.rst.txt)

---

# Usage[](#usage "Link to this heading")

## Usage modes[](#usage-modes "Link to this heading")

MS²PIP has various usage modes that each can be accessed through the command-line interface, or
through the Python API.

### `predict-single`[](#predict-single "Link to this heading")

In this mode, a single peptide spectrum is predicted with MS²PIP and optionally plotted with
[spectrum\_utils](https://spectrum-utils.readthedocs.io/). For instance,

```
ms2pip predict-single "PGAQANPYSR/3" --model TMT --plot
```

results in:

![Predicted spectrum](../_images/PGAQANPYSR-3-TMT.png)

### `predict-batch`[](#predict-batch "Link to this heading")

Provide a list of peptidoforms (see [Peptides / PSMs](#peptides-psms)) to predict multiple spectra at once.
For instance,

```
ms2pip predict-batch peptides.tsv --model TMT
```

results in a file `peptides_predictions.csv` with the predicted spectra.

### `predict-library`[](#predict-library "Link to this heading")

Predict spectra for a full peptide search space generated from a protein FASTA file. Various
peptide search space parameters can be configured to control the peptidoforms that are generated.
See [`ms2pip.search_space`](../api/ms2pip.search-space/#module-ms2pip.search_space "ms2pip.search_space") for more information.

Minimal example:

```
ms2pip predict-library proteins.fasta
```

This mode was first developed in collaboration with the ProGenTomics group for the
[MS²PIP for DIA](https://github.com/brvpuyve/MS2PIP-for-DIA) project.

### `correlate`[](#correlate "Link to this heading")

Predict spectrum intensities for a list of peptides and correlate them with observed intensities
from a spectrum file. This mode is useful for evaluating MS²PIP models or for (re)scoring
peptide-spectrum matches.

For instance:

```
ms2pip correlate --psm-filetype sage results.sage.tsv spectra.mgf
```

### `correlate-single`[](#correlate-single "Link to this heading")

Predict spectrum intensities for a single peptide and correlate them with observed intensities from
an `ObservedSpectrum` object. This mode is only available through the Python API, not
through the command-line interface.

### `get-training-data`[](#get-training-data "Link to this heading")

Given a list of peptides and corresponding spectra, generate training data for MS²PIP. This
includes observed intensities for the supported ion types and the feature vectors for each ion.
For more info, see [Training new MS²PIP models](../prediction-models/#training-new-ms2pip-models).

### `annotate-spectra`[](#annotate-spectra "Link to this heading")

Given a list of peptides annotate the peaks in the corresponding spectra.

## Input[](#input "Link to this heading")

### Peptides / PSMs[](#peptides-psms "Link to this heading")

#### PSM file types[](#psm-file-types "Link to this heading")

For peptide information input, MS²PIP accepts any file format that is supported by
[`psm_utils`](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#module-psm_utils "(in psm_utils)"). See
[Supported file formats](https://psm-utils.readthedocs.io/en/stable/#supported-file-formats) for
the full list. The simplest format is a tab-separated file with at least the columns
`peptidoform` and `spectrum_id` present.

* `peptidoform` is the full
  [ProForma 2.0 notation](https://doi.org/10.1021/acs.jproteome.1c00771) including amino acid
  modifications and precursor charge state.
* `spectrum_id` should match the `TITLE` or `nativeID` field of the related spectrum in the
  optional MGF or mzML file, if provided. Otherwise, any value is accepted.

For example:

```
peptidoform spectrum_id
RNVIM[Oxidation]DKVAK/2     1
KHLEQHPK/2  2
...
```

See [`psm_utils.io.tsv`](https://psm-utils.readthedocs.io/en/stable/api/psm_utils.io/#module-psm_utils.io.tsv "(in psm_utils)") for the full specification.

#### Peptide sequence properties[](#peptide-sequence-properties "Link to this heading")

Peptides must be strictly longer than 2 and shorter than 100 amino acids and
cannot contain the following amino acid one-letter codes: B, J, O, U, X or Z.
Peptides not fulfilling these requirements will be filtered out and will not be
reported in the output.

#### Amino acid modifications[](#amino-acid-modifications "Link to this heading")

Amino acid modification labels must be resolvable to a known mass shift. This means that
accepted labels are:

* A name or accession from an controlled vocabulary, such as Unimod or PSI-MOD. (e.g.,
  `Oxidation`, `U:Oxidation`, `U:35`, `MOD:00046`…)
* An elemental formula (e.g, `Formula:C12H20O2`)
* A mass shift in Da (e.g., `+15.9949`)

Any unresolvable modification will result in an error. If needed, PSM files can be converted with
[`psm_utils.io`](https://psm-utils.readthedocs.io/en/stable/api/psm_utils.io/#module-psm_utils.io "(in psm_utils)") and modifications can be renamed with the
[`rename_modifications()`](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.psm_list.PSMList.rename_modifications "(in psm_utils)") method.

### Spectrum file[](#spectrum-file "Link to this heading")

In the [correlate](../cli/cli/#ms2pip-correlate) and [get-training-data](../cli/cli/#ms2pip-get-training-data) usage modes, a spectrum file with observed
spectra must be provided to MS²PIP. Spectrum files in mzML, MGF, Thermo raw, and Bruker raw formats
are supported.

Note

To read Thermo raw files, the
[.NET runtime](https://learn.microsoft.com/en-us/dotnet/core/install/) must be installed.

Make sure that the PSM file `spectrum_id` matches the MGF `TITLE` field or mzML `nativeID`
fields. If the values of these fields are different, but the PSM file `spectrum_id` is embedded
in them, the `spectrum_id_pattern` argument can be used to extract the `spectrum_id` from
the `TITLE` or `nativeID` fields with a regular expression pattern. For example, if an MGF
entry has `TITLE=scan=1`, but the PSM file has `spectrum_id=1`, `spectrum_id_pattern` can be
set to `scan=(\d+)`. Note that the pattern must contain a single matching group that captures the
`spectrum_id`.

Note

Find out more about regular expression patterns and try them on
[regex101.com](https://regex101.com/). You can try out the above examples at
<https://regex101.com/r/TynuIe/1>.

Spectra present in the spectrum file, but missing in the PSM file (and vice versa) will be skipped.

## Output[](#output "Link to this heading")

MS²PIP supports various spectral library output formats, including TSV, MGF, MSP, Spectronaut CSV,
BiblioSpec/Skyline SSL and MS2, and Encycopedia DLIB.

Note that the normalization of intensities depends on the output file format. In the TSV file
output, intensities are log2-transformed. To “unlog” the intensities, use the following formula:

```
intensity = (2 ** log2_intensity) - 0.001
```

[Previous](../installation/ "Installation")
[Next](../prediction-models/ "Prediction models")

---

© Copyright .

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).