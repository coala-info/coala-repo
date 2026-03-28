Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[pysradb 3.0.0.dev0 documentation](index.html)

[![Logo](_static/pysradb_v3.png)

pysradb 3.0.0.dev0 documentation](index.html)

* [Installation](installation.html)
* [Quickstart](quickstart.html)
* [CLI](cmdline.html)
* [Python API](python-api-usage.html)
* [Case Studies](case_studies.html)
* [Tutorials & Notebooks](notebooks.html)
* [API Documentation](commands.html)
* [Contributing](contributing.html)
* [Credits](authors.html)
* History
* [pysradb](modules.html)[ ]

Back to top

[View this page](_sources/history.md.txt "View this page")

# History[¶](#history "Link to this heading")

2.5.1 (2025-10-29)

* Add prjna support in doi-to-identifiers [#249](https://github.com/saketkc/pysradb/pull/249)

2.5.0 (2025-10-19)

* Add pmid/doi-to-gse/srp conversion [#246](https://github.com/saketkc/pysradb/pull/246).

2.4.1 (2025-09-27)

* Add gse-to-pmid conversion [#241](https://github.com/saketkc/pysradb/pull/244).

2.4.0 (2025-09-27)

* Add sra-to-pmid conversion [#241](https://github.com/saketkc/pysradb/pull/241). Thanks [@andrewdavidsmith](https://github.com/andrewdavidsmith) for the idea.

2.3.0 (2025-08-24)

* Download logic improvements: remoted requests-ftp as requirement
* Fix for handling missing metadata keys [#223](https://github.com/saketkc/pysradb/pull/223). Thanks [@andrewdavidsmith](https://github.com/andrewdavidsmith)

2.2.2 (2024-10-03)

* Fix for handling ENA urls for paired end data

2.2.1 (2024-08-21)

* Fix for handling ENA urls
* Migrated to pyproject.toml

2.2.0 (2023-09-17)

* Add support for Biosamples and bioproject [#199](https://github.com/saketkc/pysradb/pull/198)
* Use retmode xml for Geo search [#200](https://github.com/saketkc/pysradb/pull/200)
* Documentation fixes

## 2.1.0 (2023-05-16)[¶](#id1 "Link to this heading")

* Fix for [gse-to-srp] returning unrequested GSEs [#186](https://github.com/saketkc/pysradb/issues/190)
* Fix for [download] using [public\_urls]
* Fix for [gsm-to-srx] returning false positives [#165](https://github.com/saketkc/pysradb/issues/165)
* Fix for delimiter not being consistent when metadata is printed on
  terminal [#147](https://github.com/saketkc/pysradb/issues/147)
* ENA search is currently broken because of an API change

## 2.0.2 (2023-04-09)[¶](#id2 "Link to this heading")

* Fix for [gse-to-srp] to handle cases where a project is
  missing but SRXs are returned [#186](https://github.com/saketkc/pysradb/issues/186)
* Fix gse-to-gsm [#187](https://github.com/saketkc/pysradb/issues/187)

## 2.0.1 (2023-03-18)[¶](#id3 "Link to this heading")

* Fix for [pysradb download] - using [public\_url]
* Fix for SRX -> SRR and related conversions [#183](https://github.com/saketkc/pysradb/pull/183)

## 2.0.0 (2023-02-23)[¶](#id4 "Link to this heading")

* BREAKING change: Overhaul of how urls and associated metadata are
  returned (not backward compatible); all column names are lower cased
  by default
* Fix extra space in “organism\_taxid” column
* Added support for Experiment attributes [#89](https://github.com/saketkc/pysradb/issues/89#issuecomment-1439319532)

## 1.4.2 (06-17-2022)[¶](#id5 "Link to this heading")

* Fix ENA fastq fetching [#163](https://github.com/saketkc/pysradb/issues/163)

## 1.4.1 (06-04-2022)[¶](#id6 "Link to this heading")

* Fix for fetching alternative URLs

## 1.4.0 (06-04-2022)[¶](#id7 "Link to this heading")

* Added ability to fetch alternative URLs (GCP/AWS) for metadata
  [#161](https://github.com/saketkc/pysradb/issues/161)
* Fix for xmldict 0.13.0 no longer defaulting to OrderedDict [#159](https://github.com/saketkc/pysradb/pull/159)
* Fix for missing experiment model and description in metadata [#160](https://github.com/saketkc/pysradb/issues/160)

## 1.3.0 (02-18-2022)[¶](#id8 "Link to this heading")

* Add [study\_title] to [–detailed] flag
  ([#152](https://github.com/saketkc/pysradb/issues/152))
* Fix [KeyError] in [metadata] where some new
  IDs do not have any metadata
  ([#151](https://github.com/saketkc/pysradb/issues/151))

## 1.2.0 (01-10-2022)[¶](#id9 "Link to this heading")

* Do not exit if a qeury returns no hits ([#149](https://github.com/saketkc/pysradb/pull/149))

## 1.1.0 (12-12-2021)[¶](#id10 "Link to this heading")

* Fixed [gsm-to-gse] failure
  ([#128](https://github.com/saketkc/pysradb/pull/128))
* Fixed case sensitivity bug for ENA search
  ([#144](https://github.com/saketkc/pysradb/pull/144))
* Fixed publication date bug for search
  ([#146](https://github.com/saketkc/pysradb/pull/146))
* Added support for downloading data from GEO [pysradb dowload -g
  GSE]
  ([#129](https://github.com/saketkc/pysradb/pull/129))

## 1.0.1 (01-10-2021)[¶](#id11 "Link to this heading")

* Dropped Python 3.6 since pandas 1.2 is not supported

## 1.0.0 (01-09-2021)[¶](#id12 "Link to this heading")

* Retired `metadb` and `SRAdb` based search through CLI - everything
  defaults to `SRAweb`
* `SRAweb` now supports
  [search](https://saket-choudhary.me/pysradb/quickstart.html#search)
* [N/A] is now replaced with [pd.NA]
* Two new fields in `–detailed`: [instrument\_model]
  and [instrument\_model\_desc]
  [#75](https://github.com/saketkc/pysradb/issues/75)
* Updated documentation

## 0.11.1 (09-18-2020)[¶](#id13 "Link to this heading")

* [library\_layout] is now outputted in metadata #56
* [-detailed] unifies columns for ENA fastq links instead
  of appending \_x/\_y #59
* bugfix for parsing namespace in xml outputs #65
* XML errors from NCBI are now handled more gracefully #69
* Documentation and dependency updates

## 0.11.0 (09-04-2020)[¶](#id14 "Link to this heading")

* [pysradb download] now supports multiple threads for
  paralle downloads
* [pysradb download] also supports ultra fast downloads of
  FASTQs from ENA using aspera-client

## 0.10.3 (03-26-2020)[¶](#id15 "Link to this heading")

* Added test cases for SRAweb
* API limit exceeding errors are automagically handled
* Bug fixes for GSE <=> SRR
* Bug fix for metadata - supports multiple SRPs

Contributors

* Dibya Gautam
* Marius van den Beek

## 0.10.2 (02-05-2020)[¶](#id16 "Link to this heading")

* Bug fix: Handle API-rate limit exceeding => Retries
* Enhancement: ‘Alternatives’ URLs are now part of
  [–detailed]

## 0.10.1 (02-04-2020)[¶](#id17 "Link to this heading")

* Bug fix: Handle Python3.6 for capture\_output in subprocess.run

## 0.10.0 (01-31-2020)[¶](#id18 "Link to this heading")

* All the subcommands (srx-to-srr, srx-to-srs) will now print
  additional columns where the first two columns represent the
  relevant conversion
* Fixed a bug where for fetching entries with single efetch record

## 0.9.9 (01-15-2020)[¶](#id19 "Link to this heading")

* Major fix: some SRRs would go missing as the experiment dict was
  being created only once per SRR (See #15)
* Features: More detailed metadata by default in the SRAweb mode
* See notebook: <https://colab.research.google.com/drive/1C60V->

## 0.9.7 (01-20-2020)[¶](#id20 "Link to this heading")

* Feature: instrument, run size and total spots are now printed in the
  metadata by default (SRAweb mode only)
* Issue: Fixed an issue with srapath failing on SRP. srapath is now
  run on individual SRRs.

## 0.9.6 (07-20-2019)[¶](#id21 "Link to this heading")

* Introduced [SRAweb] to perform queries over the web if
  the SQLite is missing or does not contain the relevant record.

## 0.9.0 (02-27-2019)[¶](#id22 "Link to this heading")

### Others[¶](#others "Link to this heading")

* This release completely changes the command line interface replacing
  click with argparse ([#3](https://github.com/saketkc/pysradb/pull/3))
* Removed Python 2 comptaible stale code

## 0.8.0 (02-26-2019)[¶](#id23 "Link to this heading")

### New methods/functionality[¶](#new-methods-functionality "Link to this heading")

* `srr-to-gsm`: convert SRR to GSM
* SRAmetadb.sqlite.gz file is deleted by default after extraction
* When SRAmetadb is not found a confirmation is seeked before
  downloading
* Confirmation option before SRA downloads

### Bugfix[¶](#bugfix "Link to this heading")

* download() works with wget

### Others[¶](#id24 "Link to this heading")

* [–out\_dir] is now [out-dir]

## 0.7.1 (02-18-2019)[¶](#id25 "Link to this heading")

Important: Python2 is no longer supported. Please consider moving to
Python3.

### Bugfix[¶](#id26 "Link to this heading")

* Included docs in the index whihch were missed out in the previous
  release

## 0.7.0 (02-08-2019)[¶](#id27 "Link to this heading")

### New methods/functionality[¶](#id28 "Link to this heading")

* `gsm-to-srr`: convert GSM to SRR
* `gsm-to-srx`: convert GSM to SRX
* `gsm-to-gse`: convert GSM to GSE

### Renamed methods[¶](#renamed-methods "Link to this heading")

The following commad line options have been renamed and the changes are
not compatible with 0.6.0 release:

* [sra-metadata] -> [metadata].
* [sra-search] -> [search].
* [srametadb] -> [metadb].

## 0.6.0 (12-25-2018)[¶](#id29 "Link to this heading")

### Bugfix[¶](#id30 "Link to this heading")

* Fixed bugs introduced in 0.5.0 with API changes where multiple
  redundant columns were output in [sra-metadata]

### New methods/functionality[¶](#id31 "Link to this heading")

* [download] now allows piped inputs

## 0.5.0 (12-24-2018)[¶](#id32 "Link to this heading")

### New methods/functionality[¶](#id33 "Link to this heading")

* Support for filtering by SRX Id for SRA downloads.
* `srr\_to\_srx`: Convert SRR to SRX/SRP
* `srp\_to\_srx`: Convert SRP to SRX
* Stripped down [sra-metadata] to give minimal information
* Added [–assay], [–desc],
  [–detailed] flag for [sra-metadata]
* Improved table printing on terminal

## 0.4.2 (12-16-2018)[¶](#id34 "Link to this heading")

### Bugfix[¶](#id35 "Link to this heading")

* Fixed unicode error in tests for Python2

## 0.4.0 (12-12-2018)[¶](#id36 "Link to this heading")

### New methods/functionality[¶](#id37 "Link to this heading")

* Added a new [BASEdb] class to handle common database
  connections
* Initial support for GEOmetadb through GEOdb class
* Initial support or a command line interface:

  + download Download SRA project (SRPnnnn)
  + gse-metadata Fetch metadata for GEO ID (GSEnnnn)
  + gse-to-gsm Get GSM(s) for GSE
  + gsm-metadata Fetch metadata for GSM ID (GSMnnnn)
  + sra-metadata Fetch metadata for SRA project (SRPnnnn)
* Added three separate notebooks for SRAdb, GEOdb, CLI usage

## 0.3.0 (12-05-2018)[¶](#id38 "Link to this heading")

### New methods/functionality[¶](#id39 "Link to this heading")

* [sample\_attribute] and
  [experiment\_attribute] are now included by default in
  the df returned by [sra\_metadata()]
* [expand\_sample\_attribute\_columns: expand metadata dataframe based on
  attributes in `sample\_attribute] column
* New methods to guess cell/tissue/strain:
  [guess\_cell\_type()]/[guess\_tissue\_type()]/[guess\_strain\_type()]
* Improved README and usage instructions

## 0.2.2 (12-03-2018)[¶](#id40 "Link to this heading")

### New methods/functionality[¶](#id41 "Link to this heading")

* [search\_sra()] allows full text search on SRA metadata.

## 0.2.0 (12-03-2018)[¶](#id42 "Link to this heading")

### Renamed methods[¶](#id43 "Link to this heading")

The following methods have been renamed and the changes are not
compatible with 0.1.0 release:

* [get\_query()] -> [query()].
* [sra\_convert()] -> [sra\_metadata()].
* [get\_table\_counts()] -> [all\_row\_counts()].

### New methods/functionality[¶](#id44 "Link to this heading")

* [download\_sradb\_file()] makes fetching [SRAmetadb.sqlite] file easy; wget is no longer required.
* [ftp] protocol is now supported besides [fsp] and hence [aspera-client] is now optional. We however, strongly recommend [aspera-client] for faster downloads.

### Bug fixes[¶](#bug-fixes "Link to this heading")

* Silenced [SettingWithCopyWarning] by excplicitly doing
  operations on a copy of the dataframe instead of the original.

Besides these, all methods now follow a [numpydoc]
compatible documentation.

## 0.1.0 (12-01-2018)[¶](#id45 "Link to this heading")

* First release on PyPI.

[Next

pysradb](modules.html)
[Previous

Credits](authors.html)

Copyright © 2023, Saket Choudhary

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* History
  + [2.1.0 (2023-05-16)](#id1)
  + [2.0.2 (2023-04-09)](#id2)
  + [2.0.1 (2023-03-18)](#id3)
  + [2.0.0 (2023-02-23)](#id4)
  + [1.4.2 (06-17-2022)](#id5)
  + [1.4.1 (06-04-2022)](#id6)
  + [1.4.0 (06-04-2022)](#id7)
  + [1.3.0 (02-18-2022)](#id8)
  + [1.2.0 (01-10-2022)](#id9)
  + [1.1.0 (12-12-2021)](#id10)
  + [1.0.1 (01-10-2021)](#id11)
  + [1.0.0 (01-09-2021)](#id12)
  + [0.11.1 (09-18-2020)](#id13)
  + [0.11.0 (09-04-2020)](#id14)
  + [0.10.3 (03-26-2020)](#id15)
  + [0.10.2 (02-05-2020)](#id16)
  + [0.10.1 (02-04-2020)](#id17)
  + [0.10.0 (01-31-2020)](#id18)
  + [0.9.9 (01-15-2020)](#id19)
  + [0.9.7 (01-20-2020)](#id20)
  + [0.9.6 (07-20-2019)](#id21)
  + [0.9.0 (02-27-2019)](#id22)
    - [Others](#others)
  + [0.8.0 (02-26-2019)](#id23)
    - [New methods/functionality](#new-methods-functionality)
    - [Bugfix](#bugfix)
    - [Others](#id24)
  + [0.7.1 (02-18-2019)](#id25)
    - [Bugfix](#id26)
  + [0.7.0 (02-08-2019)](#id27)
    - [New methods/functionality](#id28)
    - [Renamed methods](#renamed-methods)
  + [0.6.0 (12-25-2018)](#id29)
    - [Bugfix](#id30)
    - [New methods/functionality](#id31)
  + [0.5.0 (12-24-2018)](#id32)
    - [New methods/functionality](#id33)
  + [0.4.2 (12-16-2018)](#id34)
    - [Bugfix](#id35)
  + [0.4.0 (12-12-2018)](#id36)
    - [New methods/functionality](#id37)
  + [0.3.0 (12-05-2018)](#id38)
    - [New methods/functionality](#id39)
  + [0.2.2 (12-03-2018)](#id40)
    - [New methods/functionality](#id41)
  + [0.2.0 (12-03-2018)](#id42)
    - [Renamed methods](#id43)
    - [New methods/functionality](#id44)
    - [Bug fixes](#bug-fixes)
  + [0.1.0 (12-01-2018)](#id45)