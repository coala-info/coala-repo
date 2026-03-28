[DIMSPy](index.html)

latest

* [Installation](installation.html)
* [API reference](api-reference.html)
  + [tools](dimspy.tools.html)
  + metadata
  + [models](dimspy.models.html)
  + [portals](dimspy.portals.html)
  + [process](dimspy.process.html)
* [Command Line Interface](cli.html)
* [Credits](credits.html)
* [Bugs and Issues](bugs-and-issues.html)
* [Changelog](changelog.html)
* [Citation](citation.html)
* [License](license.html)

[DIMSPy](index.html)

* [Docs](index.html) »
* [API reference](api-reference.html) »
* metadata
* [Edit on GitHub](https://github.com/computational-metabolomics/dimspy/blob/master/docs/source/dimspy.metadata.rst)

---

# metadata[¶](#module-dimspy.metadata "Permalink to this headline")

`dimspy.metadata.``count_ms_types`(*hs: list*) → int[[source]](_modules/dimspy/metadata.html#count_ms_types)[¶](#dimspy.metadata.count_ms_types "Permalink to this definition")
:   Count the number of unique ms types

    Parameters
    :   **hs** – List of headers or filter strings

    Returns
    :   Count

`dimspy.metadata.``count_scan_types`(*hs: list*) → int[[source]](_modules/dimspy/metadata.html#count_scan_types)[¶](#dimspy.metadata.count_scan_types "Permalink to this definition")
:   Count the number of unique scan types

    Parameters
    :   **hs** – List of headers or filter strings

    Returns
    :   Count

`dimspy.metadata.``idxs_reps_from_filelist`(*replicates: list*)[[source]](_modules/dimspy/metadata.html#idxs_reps_from_filelist)[¶](#dimspy.metadata.idxs_reps_from_filelist "Permalink to this definition")
:   Parameters
    :   **replicates** –

    Returns

`dimspy.metadata.``interpret_method`(*mzrs: list*)[[source]](_modules/dimspy/metadata.html#interpret_method)[¶](#dimspy.metadata.interpret_method "Permalink to this definition")
:   Interpret and define type of method

    Parameters
    :   **mzrs** – Nested list of m/z ranges / windows

    Returns
    :   Type of MS method

`dimspy.metadata.``mode_type_from_header`(*h: str*) → str[[source]](_modules/dimspy/metadata.html#mode_type_from_header)[¶](#dimspy.metadata.mode_type_from_header "Permalink to this definition")
:   Extract scan mode from the header of filter string

    Parameters
    :   **h** – header or filter string

    Returns
    :   Scan type (e.g. p = profile, c = centroid)

`dimspy.metadata.``ms_type_from_header`(*h: str*) → str[[source]](_modules/dimspy/metadata.html#ms_type_from_header)[¶](#dimspy.metadata.ms_type_from_header "Permalink to this definition")
:   Extract the ms type from header or filter string

    Parameters
    :   **h** – header or filter string

    Returns
    :   ms type (e.g. FTMS and ITMS)

`dimspy.metadata.``mz_range_from_header`(*h: str*) → Sequence[float][[source]](_modules/dimspy/metadata.html#mz_range_from_header)[¶](#dimspy.metadata.mz_range_from_header "Permalink to this definition")
:   Extract m/z range from header or filter string

    Parameters
    :   **h** – Header or filter string

    Returns
    :   m/z range

`dimspy.metadata.``scan_type_from_header`(*h: str*) → str[[source]](_modules/dimspy/metadata.html#scan_type_from_header)[¶](#dimspy.metadata.scan_type_from_header "Permalink to this definition")
:   Extract the scan type from the header of filter string

    Parameters
    :   **h** – header or filter string

    Returns
    :   Scan type (e.g. full or sim)

`dimspy.metadata.``to_int`(*x*)[[source]](_modules/dimspy/metadata.html#to_int)[¶](#dimspy.metadata.to_int "Permalink to this definition")
:   Parameters
    :   **x** – Value to convert to int

    Returns
    :   Value as int (or False if conversion not possible)

`dimspy.metadata.``update_labels`(*pm: [dimspy.models.peak\_matrix.PeakMatrix](dimspy.models.html#dimspy.models.peak_matrix.PeakMatrix "dimspy.models.peak_matrix.PeakMatrix")*, *fn\_tsv: str*) → [dimspy.models.peak\_matrix.PeakMatrix](dimspy.models.html#dimspy.models.peak_matrix.PeakMatrix "dimspy.models.peak_matrix.PeakMatrix")[[source]](_modules/dimspy/metadata.html#update_labels)[¶](#dimspy.metadata.update_labels "Permalink to this definition")
:   Update Sample labels PeakMatrix object
    :param pm: peakMatrix Object
    :param fn\_tsv: Path to tab-separated file
    :return: peakMatrix Object

`dimspy.metadata.``update_metadata_and_labels`(*peaklists: Sequence[[dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")]*, *fl: Dict*)[[source]](_modules/dimspy/metadata.html#update_metadata_and_labels)[¶](#dimspy.metadata.update_metadata_and_labels "Permalink to this definition")
:   Update metadata

    Parameters
    :   * **peaklists** – List of peaklist Objects
        * **fl** – Dictionary with meta data

    Returns
    :   List of peaklist objects

`dimspy.metadata.``validate_metadata`(*fn\_tsv: str*) → collections.OrderedDict[[source]](_modules/dimspy/metadata.html#validate_metadata)[¶](#dimspy.metadata.validate_metadata "Permalink to this definition")
:   Check and validate metadata within a tab-separated file

    Parameters
    :   **fn\_tsv** – Path to tab-separated file

    Returns
    :   Dictionary

[Next](dimspy.models.html "models")
 [Previous](dimspy.tools.html "tools")

---

© Copyright 2019, Ralf Weber, Jiarui (Albert) Zhou
Revision `4a0b8982`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).