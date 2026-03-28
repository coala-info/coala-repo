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
* ms2pip.search\_space
  + [`ModificationConfig`](#ms2pip.search_space.ModificationConfig)
    - [`ModificationConfig.model_config`](#ms2pip.search_space.ModificationConfig.model_config)
  + [`ProteomeSearchSpace`](#ms2pip.search_space.ProteomeSearchSpace)
    - [`ProteomeSearchSpace.from_any()`](#ms2pip.search_space.ProteomeSearchSpace.from_any)
    - [`ProteomeSearchSpace.build()`](#ms2pip.search_space.ProteomeSearchSpace.build)
    - [`ProteomeSearchSpace.filter_psms_by_mz()`](#ms2pip.search_space.ProteomeSearchSpace.filter_psms_by_mz)
    - [`ProteomeSearchSpace.model_config`](#ms2pip.search_space.ProteomeSearchSpace.model_config)
* [ms2pip.spectrum](../ms2pip.spectrum/)
* [ms2pip.spectrum\_input](../ms2pip.spectrum-input/)
* [ms2pip.spectrum\_output](../ms2pip.spectrum-output/)

[ms2pip](../../)

* ms2pip.search\_space
* [View page source](../../_sources/api/ms2pip.search-space.rst.txt)

---

# ms2pip.search\_space[](#module-ms2pip.search_space "Link to this heading")

Define and build the search space for in silico spectral library generation.

This module defines the search space for in silico spectral library generation as a
[`ProteomeSearchSpace`](#ms2pip.search_space.ProteomeSearchSpace "ms2pip.search_space.ProteomeSearchSpace") object. Variable and fixed modifications can be configured
as [`ModificationConfig`](#ms2pip.search_space.ModificationConfig "ms2pip.search_space.ModificationConfig") objects.

The peptide search space can be built from a protein FASTA file and a set of parameters, which can
then be converted to a [`psm_utils.PSMList`](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.PSMList "(in psm_utils)") object for use in [`ms2pip`](../ms2pip/#module-ms2pip "ms2pip"). All
parameters are listed below at [`ProteomeSearchSpace`](#ms2pip.search_space.ProteomeSearchSpace "ms2pip.search_space.ProteomeSearchSpace") and can be passed as a
dictionary, a JSON file, or as a [`ProteomeSearchSpace`](#ms2pip.search_space.ProteomeSearchSpace "ms2pip.search_space.ProteomeSearchSpace") object. For example:

```
{
  "fasta_file": "test.fasta",
  "min_length": 8,
  "max_length": 30,
  "cleavage_rule": "trypsin",
  "missed_cleavages": 2,
  "semi_specific": false,
  "add_decoys": true,
  "modifications": [
    {
      "label": "UNIMOD:Oxidation",
      "amino_acid": "M"
    },
    {
      "label": "UNIMOD:Carbamidomethyl",
      "amino_acid": "C",
      "fixed": true
    }
  ],
  "max_variable_modifications": 3,
  "charges": [2, 3]
}
```

For an unspecific protein digestion, the cleavage rule can be set to `unspecific`. This will
result in a cleavage rule that allows cleavage after any amino acid with an unlimited number of
allowed missed cleavages.

To disable protein digestion when the FASTA file contains peptides, set the cleavage rule to
`-`. This will treat each line in the FASTA file as a separate peptide sequence, but still
allow for modifications and charges to be added.

Examples

```
>>> from ms2pip.search_space import ProteomeSearchSpace, ModificationConfig
>>> search_space = ProteomeSearchSpace(
...     fasta_file="tests/data/test_proteins.fasta",
...     min_length=8,
...     max_length=30,
...     cleavage_rule="trypsin",
...     missed_cleavages=2,
...     semi_specific=False,
...     modifications=[
...         ModificationConfig(label="UNIMOD:Oxidation", amino_acid="M"),
...         ModificationConfig(label="UNIMOD:Carbamidomethyl", amino_acid="C", fixed=True),
...     ],
...     charges=[2, 3],
... )
>>> psm_list = search_space.into_psm_list()
```

```
>>> from ms2pip.search_space import ProteomeSearchSpace
>>> search_space = ProteomeSearchSpace.from_any("tests/data/test_search_space.json")
>>> psm_list = search_space.into_psm_list()
```

class ms2pip.search\_space.ModificationConfig(*\**, *label*, *amino\_acid=None*, *peptide\_n\_term=False*, *protein\_n\_term=False*, *peptide\_c\_term=False*, *protein\_c\_term=False*, *fixed=False*)[[source]](../../_modules/ms2pip/search_space/#ModificationConfig)[](#ms2pip.search_space.ModificationConfig "Link to this definition")
:   Bases: `BaseModel`

    Configuration for a single modification in the search space.

    Parameters:
    :   * **label** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – Label of the modification. This can be any valid ProForma 2.0 label.
        * **amino\_acid** (*Optional**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]*) – Amino acid target of the modification. [`None`](https://docs.python.org/3/library/constants.html#None "(in Python v3.14)") if the modification is not
          specific to an amino acid. Default is None.
        * **peptide\_n\_term** (*Optional**[*[*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")*]*) – Whether the modification occurs only on the peptide N-terminus. Default is False.
        * **protein\_n\_term** (*Optional**[*[*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")*]*) – Whether the modification occurs only on the protein N-terminus. Default is False.
        * **peptide\_c\_term** (*Optional**[*[*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")*]*) – Whether the modification occurs only on the peptide C-terminus. Default is False.
        * **protein\_c\_term** (*Optional**[*[*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")*]*) – Whether the modification occurs only on the protein C-terminus. Default is False.
        * **fixed** (*Optional**[*[*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")*]*) – Whether the modification is fixed. Default is False.

    model\_config = {}[](#ms2pip.search_space.ModificationConfig.model_config "Link to this definition")
    :   Configuration for the model, should be a dictionary conforming to [ConfigDict][pydantic.config.ConfigDict].

class ms2pip.search\_space.ProteomeSearchSpace(*\**, *fasta\_file*, *min\_length=8*, *max\_length=30*, *min\_precursor\_mz=0*, *max\_precursor\_mz=inf*, *cleavage\_rule='trypsin'*, *missed\_cleavages=2*, *semi\_specific=False*, *add\_decoys=False*, *modifications=[ModificationConfig(label='UNIMOD:Oxidation', amino\_acid='M', peptide\_n\_term=False, protein\_n\_term=False, peptide\_c\_term=False, protein\_c\_term=False, fixed=False), ModificationConfig(label='UNIMOD:Carbamidomethyl', amino\_acid='C', peptide\_n\_term=False, protein\_n\_term=False, peptide\_c\_term=False, protein\_c\_term=False, fixed=True)]*, *max\_variable\_modifications=3*, *charges=[2, 3]*)[[source]](../../_modules/ms2pip/search_space/#ProteomeSearchSpace)[](#ms2pip.search_space.ProteomeSearchSpace "Link to this definition")
:   Bases: `BaseModel`

    Search space for in silico spectral library generation.

    Parameters:
    :   * **fasta\_file** (*Path*) – Path to FASTA file with protein sequences.
        * **min\_length** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")) – Minimum peptide length. Default is 8.
        * **max\_length** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")) – Maximum peptide length. Default is 30.
        * **min\_precursor\_mz** (*Optional**[*[*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)")*]*) – Minimum precursor m/z for peptides. Default is 0.
        * **max\_precursor\_mz** (*Optional**[*[*float*](https://docs.python.org/3/library/functions.html#float "(in Python v3.14)")*]*) – Maximum precursor m/z for peptides. Default is np.inf.
        * **cleavage\_rule** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – Cleavage rule for peptide digestion. Default is “trypsin”.
        * **missed\_cleavages** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")) – Maximum number of missed cleavages. Default is 2.
        * **semi\_specific** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Allow semi-specific cleavage. Default is False.
        * **add\_decoys** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Add decoy sequences to search space. Default is False.
        * **modifications** (*List**[*[*ModificationConfig*](#ms2pip.search_space.ModificationConfig "ms2pip.search_space.ModificationConfig")*]*) – List of modifications to consider. Default is oxidation of M and carbamidomethylation
          of C.
        * **max\_variable\_modifications** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")) – Maximum number of variable modifications per peptide. Default is 3.
        * **charges** (*List**[*[*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")*]*) – List of charges to consider. Default is [2, 3].

    classmethod from\_any(*\_input*)[[source]](../../_modules/ms2pip/search_space/#ProteomeSearchSpace.from_any)[](#ms2pip.search_space.ProteomeSearchSpace.from_any "Link to this definition")
    :   Create ProteomeSearchSpace from various input types.

        Parameters:
        :   **\_input** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)") *|* [*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*Path*](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)") *|* [*ProteomeSearchSpace*](#ms2pip.search_space.ProteomeSearchSpace "ms2pip.search_space.ProteomeSearchSpace")) – Search space parameters as a dictionary, a path to a JSON file, an existing
            [`ProteomeSearchSpace`](#ms2pip.search_space.ProteomeSearchSpace "ms2pip.search_space.ProteomeSearchSpace") object.

        Return type:
        :   [*ProteomeSearchSpace*](#ms2pip.search_space.ProteomeSearchSpace "ms2pip.search_space.ProteomeSearchSpace")

    build(*processes=1*)[[source]](../../_modules/ms2pip/search_space/#ProteomeSearchSpace.build)[](#ms2pip.search_space.ProteomeSearchSpace.build "Link to this definition")
    :   Build peptide search space from FASTA file.

        Parameters:
        :   **processes** ([*int*](https://docs.python.org/3/library/functions.html#int "(in Python v3.14)")) – Number of processes to use for parallelization.

    filter\_psms\_by\_mz(*psms*)[[source]](../../_modules/ms2pip/search_space/#ProteomeSearchSpace.filter_psms_by_mz)[](#ms2pip.search_space.ProteomeSearchSpace.filter_psms_by_mz "Link to this definition")
    :   Filter PSMs by precursor m/z range.

        Parameters:
        :   **psms** ([*PSMList*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.psm_list.PSMList "(in psm_utils)"))

        Return type:
        :   [*PSMList*](https://psm-utils.readthedocs.io/en/stable/api/psm_utils/#psm_utils.psm_list.PSMList "(in psm_utils)")

    model\_config = {}[](#ms2pip.search_space.ProteomeSearchSpace.model_config "Link to this definition")
    :   Configuration for the model, should be a dictionary conforming to [ConfigDict][pydantic.config.ConfigDict].

[Previous](../ms2pip.result/ "ms2pip.result")
[Next](../ms2pip.spectrum/ "ms2pip.spectrum")

---

© Copyright .

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).