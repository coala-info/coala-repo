[![Logo](../../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Augur](../../index.html)

version 33.0.1

Table of contents

* [Installation](../../installation/installation.html)
* [Using Augur](../usage.html)
  + [Augur subcommands](cli.html)
    - [augur parse](parse.html)
    - [augur curate](curate/index.html)
      * [passthru](curate/passthru.html)
      * [normalize-strings](curate/normalize-strings.html)
      * [format-dates](curate/format-dates.html)
      * [titlecase](curate/titlecase.html)
      * [apply-geolocation-rules](curate/apply-geolocation-rules.html)
      * [apply-record-annotations](curate/apply-record-annotations.html)
      * [abbreviate-authors](curate/abbreviate-authors.html)
      * [parse-genbank-location](curate/parse-genbank-location.html)
      * [transform-strain-name](curate/transform-strain-name.html)
      * [rename](curate/rename.html)
    - [augur merge](merge.html)
    - [augur index](index.html)
    - [augur filter](filter.html)
    - augur subsample
    - [augur mask](mask.html)
    - [augur align](align.html)
    - [augur tree](tree.html)
    - [augur refine](refine.html)
    - [augur ancestral](ancestral.html)
    - [augur translate](translate.html)
    - [augur reconstruct-sequences](reconstruct-sequences.html)
    - [augur clades](clades.html)
    - [augur traits](traits.html)
    - [augur sequence-traits](sequence-traits.html)
    - [augur lbi](lbi.html)
    - [augur distance](distance.html)
    - [augur titers](titers.html)
    - [augur frequencies](frequencies.html)
    - [augur export](export.html)
    - [augur validate](validate.html)
    - [augur version](version.html)
    - [augur import](import.html)
    - [augur measurements](measurements.html)
    - [augur read-file](read-file.html)
    - [augur write-file](write-file.html)
  + [Format of augur output](../json_format.html)
  + [Environment variables](../envvars.html)
* [Augur Releases & Upgrading](../../releases/releases.html)
  + [Changelog](../../releases/changelog.html)
  + [Deprecated features](../../releases/DEPRECATED.html)
  + [Augur v6 Release Notes](../../releases/v6.html)
  + [Migrating from augur v5 to v6](../../releases/migrating-v5-v6.html)
  + [Compatibility between Augur & Auspice versions](../../releases/auspice-compatibility.html)
* [Frequently Asked Questions](../../faq/faq.html)
  + [What is a “build”?](../../faq/what-is-a-build.html)
  + [How do I prepare metadata?](../../faq/metadata.html)
  + [How do I label `clades`?](../../faq/clades.html)
  + [How do I specify `refine` rates?](../../faq/refine.html)
  + [How do I use my own tree builder?](../../faq/skip_augur_tree.html)
* [Examples of Augur in the wild](../../examples/examples.html)
* [Python Public API](../../api/public/index.html)
  + [augur.io](../../api/public/augur.io.html)
* [Developer API](../../api/developer/index.html)
  + [augur package](../../api/developer/augur.html)
    - [augur.curate package](../../api/developer/augur.curate.html)
      * [augur.curate.abbreviate\_authors module](../../api/developer/augur.curate.abbreviate_authors.html)
      * [augur.curate.apply\_geolocation\_rules module](../../api/developer/augur.curate.apply_geolocation_rules.html)
      * [augur.curate.apply\_record\_annotations module](../../api/developer/augur.curate.apply_record_annotations.html)
      * [augur.curate.format\_dates module](../../api/developer/augur.curate.format_dates.html)
      * [augur.curate.format\_dates\_directives module](../../api/developer/augur.curate.format_dates_directives.html)
      * [augur.curate.normalize\_strings module](../../api/developer/augur.curate.normalize_strings.html)
      * [augur.curate.parse\_genbank\_location module](../../api/developer/augur.curate.parse_genbank_location.html)
      * [augur.curate.passthru module](../../api/developer/augur.curate.passthru.html)
      * [augur.curate.rename module](../../api/developer/augur.curate.rename.html)
      * [augur.curate.titlecase module](../../api/developer/augur.curate.titlecase.html)
      * [augur.curate.transform\_strain\_name module](../../api/developer/augur.curate.transform_strain_name.html)
    - [augur.data package](../../api/developer/augur.data.html)
    - [augur.dates package](../../api/developer/augur.dates.html)
      * [augur.dates.ambiguous\_date module](../../api/developer/augur.dates.ambiguous_date.html)
      * [augur.dates.errors module](../../api/developer/augur.dates.errors.html)
    - [augur.filter package](../../api/developer/augur.filter.html)
      * [augur.filter.arguments module](../../api/developer/augur.filter.arguments.html)
      * [augur.filter.constants module](../../api/developer/augur.filter.constants.html)
      * [augur.filter.include\_exclude\_rules module](../../api/developer/augur.filter.include_exclude_rules.html)
      * [augur.filter.io module](../../api/developer/augur.filter.io.html)
      * [augur.filter.subsample module](../../api/developer/augur.filter.subsample.html)
      * [augur.filter.validate\_arguments module](../../api/developer/augur.filter.validate_arguments.html)
      * [augur.filter.weights\_file module](../../api/developer/augur.filter.weights_file.html)
    - [augur.import\_ package](../../api/developer/augur.import_.html)
      * [augur.import\_.beast module](../../api/developer/augur.import_.beast.html)
    - [augur.io package](../../api/developer/augur.io.html)
      * [augur.io.file module](../../api/developer/augur.io.file.html)
      * [augur.io.json module](../../api/developer/augur.io.json.html)
      * [augur.io.metadata module](../../api/developer/augur.io.metadata.html)
      * [augur.io.print module](../../api/developer/augur.io.print.html)
      * [augur.io.sequences module](../../api/developer/augur.io.sequences.html)
      * [augur.io.shell\_command\_runner module](../../api/developer/augur.io.shell_command_runner.html)
      * [augur.io.strains module](../../api/developer/augur.io.strains.html)
    - [augur.measurements package](../../api/developer/augur.measurements.html)
      * [augur.measurements.concat module](../../api/developer/augur.measurements.concat.html)
      * [augur.measurements.export module](../../api/developer/augur.measurements.export.html)
    - [augur.util\_support package](../../api/developer/augur.util_support.html)
      * [augur.util\_support.auspice\_config module](../../api/developer/augur.util_support.auspice_config.html)
      * [augur.util\_support.color\_parser module](../../api/developer/augur.util_support.color_parser.html)
      * [augur.util\_support.color\_parser\_line module](../../api/developer/augur.util_support.color_parser_line.html)
      * [augur.util\_support.node\_data module](../../api/developer/augur.util_support.node_data.html)
      * [augur.util\_support.node\_data\_file module](../../api/developer/augur.util_support.node_data_file.html)
      * [augur.util\_support.node\_data\_reader module](../../api/developer/augur.util_support.node_data_reader.html)
      * [augur.util\_support.warnings module](../../api/developer/augur.util_support.warnings.html)
    - [augur.align module](../../api/developer/augur.align.html)
    - [augur.ancestral module](../../api/developer/augur.ancestral.html)
    - [augur.argparse\_ module](../../api/developer/augur.argparse_.html)
    - [augur.clades module](../../api/developer/augur.clades.html)
    - [augur.debug module](../../api/developer/augur.debug.html)
    - [augur.distance module](../../api/developer/augur.distance.html)
    - [augur.errors module](../../api/developer/augur.errors.html)
    - [augur.export module](../../api/developer/augur.export.html)
    - [augur.export\_v1 module](../../api/developer/augur.export_v1.html)
    - [augur.export\_v2 module](../../api/developer/augur.export_v2.html)
    - [augur.frequencies module](../../api/developer/augur.frequencies.html)
    - [augur.frequency\_estimators module](../../api/developer/augur.frequency_estimators.html)
    - [augur.index module](../../api/developer/augur.index.html)
    - [augur.lbi module](../../api/developer/augur.lbi.html)
    - [augur.mask module](../../api/developer/augur.mask.html)
    - [augur.merge module](../../api/developer/augur.merge.html)
    - [augur.parse module](../../api/developer/augur.parse.html)
    - [augur.read\_file module](../../api/developer/augur.read_file.html)
    - [augur.reconstruct\_sequences module](../../api/developer/augur.reconstruct_sequences.html)
    - [augur.refine module](../../api/developer/augur.refine.html)
    - [augur.sequence\_traits module](../../api/developer/augur.sequence_traits.html)
    - [augur.subsample module](../../api/developer/augur.subsample.html)
    - [augur.titer\_model module](../../api/developer/augur.titer_model.html)
    - [augur.titers module](../../api/developer/augur.titers.html)
    - [augur.traits module](../../api/developer/augur.traits.html)
    - [augur.translate module](../../api/developer/augur.translate.html)
    - [augur.tree module](../../api/developer/augur.tree.html)
    - [augur.types module](../../api/developer/augur.types.html)
    - [augur.utils module](../../api/developer/augur.utils.html)
    - [augur.validate module](../../api/developer/augur.validate.html)
    - [augur.validate\_export module](../../api/developer/augur.validate_export.html)
    - [augur.version module](../../api/developer/augur.version.html)
    - [augur.write\_file module](../../api/developer/augur.write_file.html)
* [Authors](../../authors/authors.html)

[Augur](../../index.html)

* [Home](https://docs.nextstrain.org)
* [Augur](../../index.html)
* [Using Augur](../usage.html)
* [Augur subcommands](cli.html)
* [View page source](../../_sources/usage/cli/subsample.rst.txt)

---

# augur subsample[](#augur-subsample "Link to this heading")

Table of Contents

* [Command line reference](#command-line-reference)

  + [Input options](#augur-make_parser-input-options)
  + [Configuration options](#augur-make_parser-configuration-options)
  + [Output options](#augur-make_parser-output-options)
* [Terminology](#terminology)
* [Configuration](#configuration)

  + [defaults](#defaults)
  + [samples](#samples)
* [Implementation details](#implementation-details)

## [Command line reference](#id3)[](#command-line-reference "Link to this heading")

Subsample sequences from an input dataset.

The input dataset can consist of a metadata file, a sequences file, or both.

See documentation page for details on configuration.

```
usage: augur subsample [-h] [--metadata FILE] [--sequences FILE]
                       [--sequence-index FILE] [--metadata-chunk-size N]
                       [--metadata-id-columns COLUMN [COLUMN ...]]
                       [--metadata-delimiters CHARACTER [CHARACTER ...]]
                       [--skip-checks] --config FILE
                       [--config-section KEY [KEY ...]]
                       [--search-paths DIR [DIR ...]] [--nthreads N]
                       [--seed N] [--output-metadata FILE]
                       [--output-sequences FILE] [--output-log OUTPUT_LOG]
```

### [Input options](#id4)[](#augur-make_parser-input-options "Link to this heading")

options related to input files

`--metadata`
:   sequence metadata

`--sequences`
:   sequences in FASTA or VCF format. For large inputs, consider using –sequence-index in addition to this option.

`--sequence-index`
:   sequence composition report generated by augur index. If not provided, an index will be created on the fly. This should be generated from the same file as –sequences.

`--metadata-chunk-size`
:   maximum number of metadata records to read into memory at a time. Increasing this number can reduce run times at the cost of more memory used.

    Default: `100000`

`--metadata-id-columns`
:   names of possible metadata columns containing identifier information, ordered by priority. Only one ID column will be inferred.

    Default: `('strain', 'name')`

`--metadata-delimiters`
:   delimiters to accept when reading a metadata file. Only one delimiter will be inferred.

    Default: `(',', '\t')`

`--skip-checks`
:   use this option to skip checking for duplicates in sequences and whether ids in metadata have a sequence entry. Can improve performance on large files. Note that this should only be used if you are sure there are no duplicate sequences or mismatched ids since they can lead to errors in downstream Augur commands.

    Default: `False`

### [Configuration options](#id5)[](#augur-make_parser-configuration-options "Link to this heading")

options related to configuration

`--config`
:   augur subsample config file. The expected config options must be defined at the top level, or within a specific section using –config-section.

`--config-section`
:   Use a section of the file given to –config by listing the keys leading to the section. Provide one or more keys. (default: use the entire file)

`--search-paths, --search-path`
:   One or more directories to search for relative filepaths specified
    in the config file. If a file exists in multiple directories, only
    the file from the first directory will be used. This can also be set
    via the environment variable ‘AUGUR\_SEARCH\_PATHS’. Specified
    directories will be considered before the defaults, which are:
    (1) directory containing the config file
    (2) current working directory

`--nthreads`
:   Number of CPUs/cores/threads/jobs to utilize at once. For augur subsample, this means the number of samples to run simultaneously. Individual samples are limited to a single thread. The final augur filter call can take advantage of multiple threads.

    Default: `1`

`--seed`
:   random number generator seed for reproducible outputs (with same input data).

### [Output options](#id6)[](#augur-make_parser-output-options "Link to this heading")

options related to output files

`--output-metadata`
:   output metadata file

`--output-sequences`
:   output sequences file

`--output-log`
:   Tab-delimited file to debug sequence inclusion in samples. All sequences have a row with filter=filter\_by\_exclude\_all. The sequences included in the output each have an additional row per sample that included it (there may be multiple). These rows have filter=force\_include\_strains with kwargs pointing to a temporary file that hints at the intermediate sample it came from.

## [Terminology](#id7)[](#terminology "Link to this heading")

sample[](#term-sample "Link to this term")
:   This term can refer to either the process of creating a subset or the
    subset itself:

    1. **Process**: Selecting a subset of sequences from a dataset according
       to specific parameters for filtering and subsampling (e.g.
       minimum/maximum date, minimum/maximum sequence length, sample size).

       Example: *Run the focal sample …*
    2. **Resulting subset**: The set of sequences obtained from the process
       described in (1).

       Example: *The contextual sample consisted of …*

## [Configuration](#id8)[