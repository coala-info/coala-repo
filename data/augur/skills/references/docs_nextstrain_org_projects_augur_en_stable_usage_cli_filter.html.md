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
    - augur filter
    - [augur subsample](subsample.html)
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
* [View page source](../../_sources/usage/cli/filter.rst.txt)

---

# augur filter[](#augur-filter "Link to this heading")

Table of Contents

* [inputs](#augur-make_parser-inputs)
* [metadata filters](#augur-make_parser-metadata-filters)
* [sequence filters](#augur-make_parser-sequence-filters)
* [subsampling](#augur-make_parser-subsampling)
* [outputs](#augur-make_parser-outputs)
* [other](#augur-make_parser-other)
* [deprecated](#augur-make_parser-deprecated)
* [Guides](#guides)

---

Filter and subsample a sequence set.

SeqKit is used behind the scenes to handle FASTA files, but this should be
considered an implementation detail that may change in the future. The CLI
program seqkit must be available. If it’s not on PATH (or you want to use a
version different from what’s on PATH), set the SEQKIT environment variable to
path of the desired seqkit executable.

VCFtools is used behind the scenes to handle VCF files, but this should be
considered an implementation detail that may change in the future. The CLI
program vcftools must be available on PATH.

```
usage: augur filter [-h] --metadata FILE [--sequences SEQUENCES]
                    [--sequence-index SEQUENCE_INDEX]
                    [--metadata-chunk-size METADATA_CHUNK_SIZE]
                    [--metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]]
                    [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                    [--skip-checks] [--query QUERY]
                    [--query-columns QUERY_COLUMNS [QUERY_COLUMNS ...]]
                    [--min-date MIN_DATE] [--max-date MAX_DATE]
                    [--exclude-ambiguous-dates-by {any,day,month,year}]
                    [--exclude EXCLUDE [EXCLUDE ...]]
                    [--exclude-where EXCLUDE_WHERE [EXCLUDE_WHERE ...]]
                    [--exclude-all] [--include INCLUDE [INCLUDE ...]]
                    [--include-where INCLUDE_WHERE [INCLUDE_WHERE ...]]
                    [--min-length MIN_LENGTH] [--max-length MAX_LENGTH]
                    [--non-nucleotide] [--group-by GROUP_BY [GROUP_BY ...]]
                    [--sequences-per-group SEQUENCES_PER_GROUP | --subsample-max-sequences SUBSAMPLE_MAX_SEQUENCES]
                    [--probabilistic-sampling | --no-probabilistic-sampling]
                    [--group-by-weights FILE] [--priority PRIORITY]
                    [--subsample-seed SUBSAMPLE_SEED]
                    [--output-sequences OUTPUT_SEQUENCES]
                    [--output-metadata OUTPUT_METADATA]
                    [--output-strains OUTPUT_STRAINS]
                    [--output-log OUTPUT_LOG]
                    [--output-group-by-sizes OUTPUT_GROUP_BY_SIZES]
                    [--empty-output-reporting {error,warn,silent}]
                    [--nthreads N] [--output FILE] [-o FILE]
```

## [inputs](#id1)[](#augur-make_parser-inputs "Link to this heading")

metadata and sequences to be filtered

`--metadata`
:   sequence metadata

`--sequences, -s`
:   sequences in FASTA or VCF format. For large inputs, consider using –sequence-index in addition to this option.

`--sequence-index`
:   sequence composition report generated by augur index. If not provided, an index will be created on the fly. This should be generated from the same file as –sequences.

`--metadata-chunk-size`
:   maximum number of metadata records to read into memory at a time. Increasing this number can speed up filtering at the cost of more memory used.

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

## [metadata filters](#id2)[](#augur-make_parser-metadata-filters "Link to this heading")

filters to apply to metadata

`--query`
:   Filter sequences by attribute. Uses [Pandas DataFrame query syntax](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#indexing-query).
    (e.g., “country == ‘Colombia’” or “(country == ‘USA’ & (division ==
    ‘Washington’))”)

`--query-columns`
:   Use alongside query to specify columns and data types in the format
    ‘column:type’, where type is one of
    (bool,float,int,str). Automatic type inference will be
    attempted on all unspecified columns used in the query. Example:
    region:str coverage:float.

`--min-date`
:   Minimal cutoff for date (inclusive). Supported formats:

    1. an Augur-style numeric date with the year as the integer part (e.g.
       2020.42) or
    2. a date in ISO 8601 date format (i.e. YYYY-MM-DD) (e.g. ‘2020-06-04’) or
    3. a backwards-looking relative date in ISO 8601 duration format with
       optional P prefix (e.g. ‘1W’, ‘P1W’)

`--max-date`
:   Maximal cutoff for date (inclusive). Supported formats:

    1. an Augur-styl