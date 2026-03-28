[evofr](../index.html)

Contents

* [Installation Guide](../installation.html)
* [API Reference](../api_reference.html)
* [Getting started with `evofr`](../notebooks/example_mlr.html)

[evofr](../index.html)

* [API Reference](../api_reference.html)
* evofr.data package
* [View page source](../_sources/source/evofr.data.rst.txt)

---

# evofr.data package[](#evofr-data-package "Link to this heading")

## Submodules[](#submodules "Link to this heading")

## evofr.data.case\_counts module[](#module-evofr.data.case_counts "Link to this heading")

*class* CaseCounts(*raw\_cases*, *date\_to\_index=None*)[](#evofr.data.case_counts.CaseCounts "Link to this definition")
:   Bases: [`DataSpec`](#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec")

    Parameters:
    :   * **raw\_cases** (*DataFrame*)
        * **date\_to\_index** (*dict* *|* *None*)

    make\_data\_dict(*data=None*)[](#evofr.data.case_counts.CaseCounts.make_data_dict "Link to this definition")
    :   Get arguments to be passed to numpyro models as a dictionary.

        Parameters:
        :   **data** (*dict* *|* *None*) – Optional dictionary to add arguments to.

        Returns:
        :   Dictionary containing arguments.

        Return type:
        :   dict

## evofr.data.case\_frequencies module[](#module-evofr.data.case_frequencies "Link to this heading")

*class* CaseFrequencyData(*raw\_cases*, *raw\_seq*, *date\_to\_index=None*, *var\_names=None*, *pivot=None*)[](#evofr.data.case_frequencies.CaseFrequencyData "Link to this definition")
:   Bases: [`DataSpec`](#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec")

    Parameters:
    :   * **raw\_cases** (*DataFrame*)
        * **raw\_seq** (*DataFrame*)
        * **date\_to\_index** (*dict* *|* *None*)
        * **var\_names** (*List* *|* *None*)
        * **pivot** (*str* *|* *None*)

    make\_data\_dict(*data=None*)[](#evofr.data.case_frequencies.CaseFrequencyData.make_data_dict "Link to this definition")
    :   Get arguments to be passed to numpyro models as a dictionary.

        Parameters:
        :   **data** (*dict* *|* *None*) – Optional dictionary to add arguments to.

        Returns:
        :   Dictionary containing arguments.

        Return type:
        :   dict

*class* HierarchicalCFData(*raw\_cases*, *raw\_seq*, *group*, *date\_to\_index=None*)[](#evofr.data.case_frequencies.HierarchicalCFData "Link to this definition")
:   Bases: `object`

    Parameters:
    :   * **raw\_cases** (*DataFrame*)
        * **raw\_seq** (*DataFrame*)
        * **group** (*str*)
        * **date\_to\_index** (*dict* *|* *None*)

    make\_data\_dict(*data=None*)[](#evofr.data.case_frequencies.HierarchicalCFData.make_data_dict "Link to this definition")
    :   Parameters:
        :   **data** (*dict* *|* *None*)

## evofr.data.data\_helpers module[](#module-evofr.data.data_helpers "Link to this heading")

counts\_to\_matrix(*raw\_seqs*, *var\_names*, *date\_to\_index=None*)[](#evofr.data.data_helpers.counts_to_matrix "Link to this definition")
:   Process ‘raw\_seq’ data to nd.array including unobserved dates.

    Parameters:
    :   * **raw\_seq** – a dataframe containing sequence counts with
          columns ‘sequences’ and ‘date’.
        * **var\_names** (*List**[**str**]*) – list of variant to count observations.
        * **date\_to\_index** (*dict* *|* *None*) – optional dictionary for mapping calender dates to nd.array indices.
        * **raw\_seqs** (*DataFrame*)

    Returns:
    :   nd.array containing number of sequences of each variant on each date.

    Return type:
    :   C

expand\_dates(*dates*, *T\_forecast*)[](#evofr.data.data_helpers.expand_dates "Link to this definition")
:   Extend existing dates list with forecast interval of length ‘T\_forecast’

    Parameters:
    :   **T\_forecast** (*int*)

forecast\_dates(*dates*, *T\_forecast*)[](#evofr.data.data_helpers.forecast_dates "Link to this definition")
:   Generate dates of forecast given forecast interval of length ‘T\_forecast’.

    Parameters:
    :   **T\_forecast** (*int*)

format\_var\_names(*raw\_names*, *pivot=None*)[](#evofr.data.data_helpers.format_var_names "Link to this definition")
:   Places pivot category to be last element if present.

    Parameters:
    :   * **raw\_names** (*List**[**str**]*)
        * **pivot** (*str* *|* *None*)

prep\_cases(*raw\_cases*, *date\_to\_index=None*)[](#evofr.data.data_helpers.prep_cases "Link to this definition")
:   Process raw\_cases data to nd.array including unobserved dates.

    Parameters:
    :   * **raw\_cases** (*DataFrame*) – a dataframe containing case counts with columns ‘cases’ and ‘date’.
        * **date\_to\_index** (*dict* *|* *None*) – optional dictionary for mapping calender dates to nd.array indices.

    Returns:
    :   nd.array containing number of cases on each date.

    Return type:
    :   C

prep\_dates(*raw\_dates*)[](#evofr.data.data_helpers.prep_dates "Link to this definition")
:   Return vector of dates and a mapping of dates to indices.

    Parameters:
    :   **raw\_dates** (*Series*) – pandas series containing dates of interest

    Returns:
    :   * *dates* – list containing dates
        * *date\_to\_index* – dictionary taking in dates and returning integer indices

prep\_sequence\_counts(*raw\_seqs*, *date\_to\_index=None*, *var\_names=None*, *pivot=None*)[](#evofr.data.data_helpers.prep_sequence_counts "Link to this definition")
:   Process ‘raw\_seq’ data to nd.array including unobserved dates.

    Parameters:
    :   * **raw\_seq** – a dataframe containing sequence counts with
          columns ‘sequences’ and ‘date’.
        * **raw\_seqs** (*DataFrame*)
        * **date\_to\_index** (*dict* *|* *None*)
        * **var\_names** (*List* *|* *None*)
        * **pivot** (*str* *|* *None*)

    date\_to\_index:
    :   optional dictionary for mapping calender dates to nd.array indices.

    var\_names:
    :   optional list of variant to count observations.

    pivot:
    :   optional name of variant to place last.
        This will usually used as a reference or pivot strain.

    Returns:
    :   * *var\_names* – list of variants counted
        * *C* – nd.array containing number of sequences of each variant on each date.

    Parameters:
    :   * **raw\_seqs** (*DataFrame*)
        * **date\_to\_index** (*dict* *|* *None*)
        * **var\_names** (*List* *|* *None*)
        * **pivot** (*str* *|* *None*)

## evofr.data.data\_spec module[](#module-evofr.data.data_spec "Link to this heading")

*class* DataSpec[](#evofr.data.data_spec.DataSpec "Link to this definition")
:   Bases: `ABC`

    *abstract* make\_data\_dict(*data=None*)[](#evofr.data.data_spec.DataSpec.make_data_dict "Link to this definition")
    :   Get arguments to be passed to numpyro models as a dictionary.

        Parameters:
        :   **data** (*dict* *|* *None*) – Optional dictionary to add arguments to.

        Returns:
        :   Dictionary containing arguments.

        Return type:
        :   dict

    registry *= {'CaseCounts': <class 'evofr.data.case\_counts.CaseCounts'>, 'CaseFrequencyData': <class 'evofr.data.case\_frequencies.CaseFrequencyData'>, 'DelaySequenceCounts': <class 'evofr.models.mlr\_nowcast.DelaySequenceCounts'>, 'DistanceMigrationData': <class 'evofr.models.migration\_from\_distances.DistanceMigrationData'>, 'HierCases': <class 'evofr.data.hier\_cases.HierCases'>, 'HierFrequencies': <class 'evofr.data.hier\_frequencies.HierFrequencies'>, 'InnovationSequenceCounts': <class 'evofr.models.mlr\_innovation.InnovationSequenceCounts'>, 'VariantFrequencies': <class 'evofr.data.variant\_frequencies.VariantFrequencies'>}*[](#evofr.data.data_spec.DataSpec.registry "Link to this definition")

## evofr.data.hier\_cases module[](#module-evofr.data.hier_cases "Link to this heading")

*class* HierCases(*raw\_cases*, *group*, *date\_to\_index=None*)[](#evofr.data.hier_cases.HierCases "Link to this definition")
:   Bases: [`DataSpec`](#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec")

    Parameters:
    :   * **raw\_cases** (*DataFrame*)
        * **group** (*str*)
        * **date\_to\_index** (*dict* *|* *None*)

    make\_data\_dict(*data=None*)[](#evofr.data.hier_cases.HierCases.make_data_dict "Link to this definition")
    :   Get arguments to be passed to numpyro models as a dictionary.

        Parameters:
        :   **data** (*dict* *|* *None*) – Optional dictionary to add arguments to.

        Returns:
        :   Dictionary containing arguments.

        Return type:
        :   dict

## evofr.data.hier\_frequencies module[](#module-evofr.data.hier_frequencies "Link to this heading")

*class* HierFrequencies(*raw\_seq*, *group*, *date\_to\_index=None*, *pivot=None*, *aggregation\_frequency=None*)[](#evofr.data.hier_frequencies.HierFrequencies "Link to this definition")
:   Bases: [`DataSpec`](#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec")

    Parameters:
    :   * **raw\_seq** (*DataFrame*)
        * **group** (*str*)
        * **date\_to\_index** (*dict* *|* *None*)
        * **pivot** (*str* *|* *None*)
        * **aggregation\_frequency** (*str* *|* *None*)

    make\_data\_dict(*data=None*)[](#evofr.data.hier_frequencies.HierFrequencies.make_data_dict "Link to this definition")
    :   Get arguments to be passed to numpyro models as a dictionary.

        Parameters:
        :   **data** (*dict* *|* *None*) – Optional dictionary to add arguments to.

        Returns:
        :   Dictionary containing arguments.

        Return type:
        :   dict

## evofr.data.variant\_frequencies module[](#module-evofr.data.variant_frequencies "Link to this heading")

*class* VariantFrequencies(*raw\_seq*, *date\_to\_index=None*, *var\_names=None*, *pivot=None*, *aggregation\_frequency=None*)[](#evofr.data.variant_frequencies.VariantFrequencies "Link to this definition")
:   Bases: [`DataSpec`](#evofr.data.data_spec.DataSpec "evofr.data.data_spec.DataSpec")

    Parameters:
    :   * **raw\_seq** (*DataFrame*)
        * **date\_to\_index** (*dict* *|* *None*)
        * **var\_names** (*List* *|* *None*)
        * **pivot** (*str* *|* *None*)
        * **aggregation\_frequency** (*str* *|* *None*)

    make\_data\_dict(*data=None*)[](#evofr.data.variant_frequencies.VariantFrequencies.make_data_dict "Link to this definition")
    :   Get arguments to be passed to numpyro models as a dictionary.

        Parameters:
        :   **data** (*dict* *|* *None*) – Optional dictionary to add arguments to.

        Returns:
        :   Dictionary containing arguments.

        Return type:
        :   dict

variant\_counts\_to\_dataframe(*var\_counts*, *var\_names=['Variant', 'other']*, *start\_date=Timestamp('2022-01-01 00:00:00')*)[](#evofr.data.variant_frequencies.variant_counts_to_dataframe "Link to this definition")
:   Convert matrix of variant counts to pandas dataframe
    for input to ef.VariantFrequencies.

    Parameters:
    :   * **var\_counts** – nd.array of counts var\_counts[t,v] of variant v on day t.
        * **variant\_names** – List of variant names to assign each column.
        * **start\_date** – Pandas datetime to use as first date.
        * **var\_names** (*List**[**str**]*)

    Return type:
    :   seq\_counts

## Module contents[](#module-evofr.data "Link to this heading")

[Previous](../api_reference.html "API Reference")
[Next](evofr.models.html "evofr.models package")

---

© Copyright 2025, Marlin Figgins.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).