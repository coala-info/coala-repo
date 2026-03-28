[changeo
![Logo](_static/changeo.png)](index.html)

* [Immcantation Portal](http://immcantation.readthedocs.io)

Getting Started

* [Overview](overview.html)
* [Download](install.html)
* [Installation](install.html#installation)
* [Contributing](contributing.html)
* [Data Standards](standard.html)
* Release Notes
  + [Version 1.3.4: July 31, 2025](#version-1-3-4-july-31-2025)
  + [Version 1.3.3: May 14, 2025](#version-1-3-3-may-14-2025)
  + [Version 1.3.1: March 27, 2025](#version-1-3-1-march-27-2025)
  + [Version 1.3.0: December 11, 2022](#version-1-3-0-december-11-2022)
  + [Version 1.2.0: October 29, 2021](#version-1-2-0-october-29-2021)
  + [Version 1.1.0: June 21, 2021](#version-1-1-0-june-21-2021)
  + [Version 1.0.2: January 18, 2021](#version-1-0-2-january-18-2021)
  + [Version 1.0.1: October 13, 2020](#version-1-0-1-october-13-2020)
  + [Version 1.0.0: May 6, 2020](#version-1-0-0-may-6-2020)
  + [Version 0.4.6: July 19, 2019](#version-0-4-6-july-19-2019)
  + [Version 0.4.5: January 9, 2019](#version-0-4-5-january-9-2019)
  + [Version 0.4.4: October 27, 2018](#version-0-4-4-october-27-2018)
  + [Version 0.4.3: October 19, 2018](#version-0-4-3-october-19-2018)
  + [Version 0.4.2: September 6, 2018](#version-0-4-2-september-6-2018)
  + [Version 0.4.1: July 16, 2018](#version-0-4-1-july-16-2018)
  + [Version 0.3.12: February 16, 2018](#version-0-3-12-february-16-2018)
  + [Version 0.3.11: February 6, 2018](#version-0-3-11-february-6-2018)
  + [Version 0.3.10: February 6, 2018](#version-0-3-10-february-6-2018)
  + [Version 0.3.9: October 17, 2017](#version-0-3-9-october-17-2017)
  + [Version 0.3.8: October 5, 2017](#version-0-3-8-october-5-2017)
  + [Version 0.3.7: June 30, 2017](#version-0-3-7-june-30-2017)
  + [Version 0.3.6: June 13, 2017](#version-0-3-6-june-13-2017)
  + [Version 0.3.5: May 12, 2017](#version-0-3-5-may-12-2017)
  + [Version 0.3.4: February 14, 2017](#version-0-3-4-february-14-2017)
  + [Version 0.3.3: August 8, 2016](#version-0-3-3-august-8-2016)
  + [Version 0.3.2: March 8, 2016](#version-0-3-2-march-8-2016)
  + [Version 0.3.1: December 18, 2015](#version-0-3-1-december-18-2015)
  + [Version 0.3.0: December 4, 2015](#version-0-3-0-december-4-2015)
  + [Version 0.2.5: August 25, 2015](#version-0-2-5-august-25-2015)
  + [Version 0.2.4: August 19, 2015](#version-0-2-4-august-19-2015)
  + [Version 0.2.3: July 22, 2015](#version-0-2-3-july-22-2015)
  + [Version 0.2.2: July 8, 2015](#version-0-2-2-july-8-2015)
  + [Version 0.2.1: June 18, 2015](#version-0-2-1-june-18-2015)
  + [Version 0.2.0: June 17, 2015](#version-0-2-0-june-17-2015)
  + [Version 0.2.0.beta-2015-05-31: May 31, 2015](#version-0-2-0-beta-2015-05-31-may-31-2015)
  + [Version 0.2.0.beta-2015-05-05: May 05, 2015](#version-0-2-0-beta-2015-05-05-may-05-2015)

Usage Documentation

* [Commandline Usage](usage.html)
* [API](api.html)

Examples

* [Using IgBLAST](examples/igblast.html)
* [Parsing IMGT output](examples/imgt.html)
* [Parsing 10X Genomics V(D)J data](examples/10x.html)
* [Filtering records](examples/filtering.html)
* [Clustering sequences into clonal groups](examples/cloning.html)
* [Reconstructing germline sequences](examples/germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](examples/genbank.html)

Methods

* [Clonal clustering methods](methods/clustering.html)
* [Reconstruction of germline sequences from alignment data](methods/germlines.html)

About

* [Contact](info.html)
* [Citation](info.html#citation)
* [License](info.html#license)

[changeo](index.html)

* Release Notes
* [View page source](_sources/news.rst.txt)

---

# Release Notes[](#release-notes "Link to this heading")

## Version 1.3.4: July 31, 2025[](#version-1-3-4-july-31-2025 "Link to this heading")

MakeDb:

* `MakeDb.py` is now parallelized across input files. The `--nproc` argument
  :   can be used to restrict the resources used.
* Added the flag `--partial` to `MakeDb igblast-aa` to pass incomplete alignment
  results. As `igblastp` (as at igblast 1.22.0) only uses the V germline
  database, all sequences will be missing the `junction` and `j_call` fields
  and be considered incomplete. Specifying `--partial` will allow these
  sequences to be processed ignoring the missing fields.

Documentation:

* Added a “Contributing” section to the documentation menu for community guidelines.
* Updated “Contact”.

## Version 1.3.3: May 14, 2025[](#version-1-3-3-may-14-2025 "Link to this heading")

* Updated dependencies to address deprecation warnings. Replaced `pkg_resources`
  with `packaging` and `importlib`.
* Bumped minimum Python version to 3.10.0 and updated requirements to: numpy>=1.23.2,
  scipy>=1.9.3, pandas>=1.5.0, biopython>=1.81, PyYAML>=6.0, setuptools>=65.5.0,
  presto>=0.7.1, airr>=1.3.1, packaging>=21.3, importlib-resources>=6.4.0.

## Version 1.3.1: March 27, 2025[](#version-1-3-1-march-27-2025 "Link to this heading")

* Active development has moved from Bitbucket to GitHub (<https://github.com/immcantation/changeo>).
* Documentation updates.
* Various updates to internals to avoid deprecation warnings.
* Updates in requirements: Python 3.7.0, biopython>=1.81 and packaging>=23.2.

## Version 1.3.0: December 11, 2022[](#version-1-3-0-december-11-2022 "Link to this heading")

* Various updates to internals and error messages.

AssignGenes:

* Added support for `.fastq` files. If a `.fastq` file is input, then a
  corresponding `.fasta` file will be created in output directory.
* Added support for C region alignment calls provide by IgBLAST v1.18+.

MakeDb:

* Added support for C region alignment calls provide by IgBLAST v1.18+.

## Version 1.2.0: October 29, 2021[](#version-1-2-0-october-29-2021 "Link to this heading")

* Updated dependencies to presto >= v0.7.0.

AssignGenes:

* Fixed reporting of IgBLAST output counts when specifying `--format airr`.

BuildTrees:

* Added support for specifying fixed omega and hotness parameters at the
  commandline.

CreateGermlines:

* Will now use the first allele in the reference database when duplicate
  allele names are provided. Only appears to affect mouse BCR light chains
  and TCR alleles in the IMGT database when the same allele name differs by
  strain.

MakeDb:

* Added support for changes in how IMGT/HighV-QUEST v1.8.4 handles special
  characters in sequence identifiers.
* Fixed the `imgt` subcommand incorrectly allowing execution without
  specifying the IMGT/HighV-QUEST output file at the commandline.

ParseDb:

* Added reporting of output file sizes to the console log of the `split`
  subcommand.

## Version 1.1.0: June 21, 2021[](#version-1-1-0-june-21-2021 "Link to this heading")

* Fixed gene parsing for IMGT temporary designation nomenclature.
* Updated dependencies to biopython >= v1.77, airr >= v1.3.1, PyYAML>=5.1.

MakeDb:

* Added the `--imgt-id-len` argument to accommodate changes introduced in how
  IMGT/HighV-QUEST truncates sequence identifiers as of v1.8.3 (May 7, 2021).
  The header lines in the fasta files are now truncated to 49 characters. In
  IMGT/HighV-QUEST versions older than v1.8.3, they were truncated to 50 characters.
  `--imgt-id-len` default value is 49. Users should specify `--imgt-id-len 50`
  to analyze IMGT results generated with IMGT/HighV-QUEST versions older than v1.8.3.
* Added the `--infer-junction` argument to `MakeDb igblast`, to enable the inference
  of the junction sequence when not reported by IgBLAST. Should be used with data from
  IgBLAST v1.6.0 or older; before igblast added the IMGT-CDR3 inference.

## Version 1.0.2: January 18, 2021[](#version-1-0-2-january-18-2021 "Link to this heading")

AlignRecords:

* Fixed a bug caused the program to exit when encountering missing sequence
  data. It will now fail the row or group with missing data and continue.

MakeDb:

* Added support for IgBLAST v1.17.0.

ParseDb:

* Added a relevant error message when an input field is missing from the data.

## Version 1.0.1: October 13, 2020[](#version-1-0-1-october-13-2020 "Link to this heading")

* Updated to support Biopython v1.78.
* Increased the biopython dependency to v1.71.
* Increased the presto dependency to 0.6.2.

## Version 1.0.0: May 6, 2020[](#version-1-0-0-may-6-2020 "Link to this heading")

* The default output in all tools is now the AIRR Rearrangement standard
  (`--format airr`). Support for the legacy Change-O data standard is still
  provided through the `--format changeo` argument to the tools.
* License changed to AGPL-3.

AssignGenes:

* Added the `igblast-aa` subcommand to run igblastp on amino acid input.

BuildTrees:

* Adjusted `RECORDS` to indicate all sequences in input file.
  `INITIAL_FILTER` now shows sequence count after initial
  `min_seq` filtering.
* Added option to skip codon masking: `--nmask`.
* Mask `:`, `,`, `)`, and `(` in IDs and metadata with `-`.
* Can obtain germline from `GERMLINE_IMGT` if `GERMLINE_IMGT_D_MASK`
  not specified.
* Can reconstruct intermediate sequences with IgPhyML using `--asr`.

ConvertDb:

* Fixed a bug in the `airr` subcommand that caused the `junction_length`
  field to be deleted from the output.
* Fixed a bug in the `genbank` subcommand that caused the junction CDS
  to be missing from the ASN output.

CreateGermlines:

* Added the `--cf` argument to allow specification of the clone field.

MakeDb:

* Added the `igblast-aa` subcommand to parse the output of igblastp.
* Changed the log entry `FUNCTIONAL` to `PRODUCTIVE` and removed the
  `IMGT_PASS` log entry in favor of an informative `ERROR` entry
  when sequences fail the junction region validation.
* Add –regions argument to the `igblast` and `igblast-aa` subcommands
  to allow specification of the IMGT CDR/FWR region boundaries. Currently,
  the supported specifications are `default` (human, mouse) and
  `rhesus-igl`.

## Version 0.4.6: July 19, 2019[](#version-0-4-6-july-19-2019 "Link to this heading")

BuildTrees:

* Added capability of running IgPhyML on outputted data (`--igphyml`) and
  support for passing IgPhyML arguments through BuildTrees.
* Added the `--clean` argument to force deletion of all intermediate files
  after IgPhyML execution.
* Added the `--format` argument to allow specification input and output of
  either the Change-O standard (`changeo`) or AIRR Rearrangement standard
  (`airr`).

CreateGermlines:

* Fixed a bug causing incorrect reporting of the germline format in the
  console log.

ConvertDb:

* Removed requirement for the `NP1_LENGTH` and `NP2_LENGTH` fields from
  the genbank subcommand.

DefineClones:

* Fixed a biopython warning arising when applying `--model aa` to junction
  sequences that are not a multiple of three. The junction will now be
  padded with an appropriate number of Ns (usually resulting in a translation
  to X).

MakeDb:

* Added the `--10x` argument to all subcommands to support merging of
  Cell Ranger annotation data, such as UMI count and C-region assignment,
  with the output of the supported alignment tools.
* Added inference of the receptor locus from the alignment data to all
  subcommands, which is output in the `LOCUS` field.
* Combined the extended field arguments of all subcommands (`--scores`,
  `--regions`, `--cdr3`, and `--junction`) into a single `--extended`
  argument.
* Removed parsing of old IgBLAST v1.5 CDR3 fields
  (`CDR3_IGBLAST`, `CDR3_IGBLAST_AA`).

## Version 0.4.5: January 9, 2019[](#version-0-4-5-january-9-2019 "Link to this heading")

* Slightly changed version number display in commandline help.

BuildTrees:

* Fixed a bug that caused malformed lineages.tsv output file.

CreateGermlines:

* Fixed a bug in the CreateGermlines log output causing incorrect missing
  D gene or J gene error messages.

DefineClones:

* Fixed a bug that caused a missing junction column to cluster sequences
  together.

MakeDb:

* Fixed a bug that caused failed germline reconstructions to be recorded as
  `None`, rather than an empty string, in the `GERMLINE_IMGT` column.

## Version 0.4.4: October 27, 2018[](#version-0-4-4-october-27-2018 "Link to this heading")

* Fixed a bug causing the values of `_start` fields to be off by one from
  the v1.2 AIRR Schema requirement when specifying `--format airr`.

## Version 0.4.3: October 19, 2018[](#version-0-4-3-october-19-2018 "Link to this heading")

* Updated airr library requirement to v1.2.1 to fix empty V(D)J start
  coordinate values when specifying `--format airr` to tools.
* Changed pRESTO dependency to v0.5.10.

BuildTrees:

* New tool.
* Converts tab-delimited database files into input for
  [IgPhyML](https://bitbucket.org/kbhoehn/igphyml)

CreateGermlines:

* Now verifies that all files/folder passed to the `-r` argument exist.

## Version 0.4.2: September 6, 2018[](#version-0-4-2-september-6-2018 "Link to this heading")

* Updated support for the AIRR Rearrangement schema to v1.2 and added the
  associated airr library dependency.

AssignGenes:

* New tool.
* Provides a simple IgBLAST wrapper as the `igblast` subcommand.

ConvertDb:

* The `genbank` subcommand will perform a check for some of the required
  columns in the input file and exit if they are not found.
* Changed the behavior of the `-y` argument in the `genbank` subcommand.
  This argument is now featured to sample features only, but allows
  for the inclusion of any BioSample attribute.

CreateGermlines:

* Will now perform a naive verification that the reference sequences provided
  to the `-r` argument are IMGT-gapped. A warning will be issued to standard
  error if the reference sequence fail the check.
* Will perform a check for some of the required columns in the input file and
  exit if they are not found.

MakeDb:

* Changed the output of `SEQUENCE_VDJ` from the igblast subcommand to retain
  insertions in the query sequence rather than delete them as is done in the
  `SEQUENCE_IMGT` field.
* Will now perform a naive verification that the reference sequences provided
  to the `-r` argument are IMGT-gapped. A warning will be issued to standard
  error if the reference sequence fail the check.

## Version 0.4.1: July 16, 2018[](#version-0-4-1-july-16-2018 "Link to this heading")

* Fixed installation incompatibility with pip 10.
* Fixed duplicate newline issue on Windows.
* All tools will no longer create empty pass or fail files if there are no
  records meeting the appropriate criteria for output.
* Most tools now allow explicit specification of the output file name via
  the optional `-o` argument.
* Added support for the AIRR standard TSV via the `--format airr` argument to
  all relevant tools.
* Replaced V, D and J `BTOP` columns with `CIGAR` columns in data standard.
* Numerous API changes and internal structural changes to commandline tools.

AlignRecords:

* Fixed a bug arising when space characters are present in the sequence
  identifiers.

ConvertDb:

* New tool.
* Includes the airr and changeo subcommand to convert between AIRR and Change-O
  formatted TSV files.
* The genbank subcommand creates MiAIRR com