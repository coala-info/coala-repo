[![Logo](../../../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Augur](../../../index.html)

version 33.0.1

Table of contents

* [Installation](../../../installation/installation.html)
* [Using Augur](../../usage.html)
  + [Augur subcommands](../cli.html)
    - [augur parse](../parse.html)
    - [augur curate](index.html)
      * [passthru](passthru.html)
      * [normalize-strings](normalize-strings.html)
      * [format-dates](format-dates.html)
      * [titlecase](titlecase.html)
      * [apply-geolocation-rules](apply-geolocation-rules.html)
      * [apply-record-annotations](apply-record-annotations.html)
      * [abbreviate-authors](abbreviate-authors.html)
      * [parse-genbank-location](parse-genbank-location.html)
      * [transform-strain-name](transform-strain-name.html)
      * rename
    - [augur merge](../merge.html)
    - [augur index](../index.html)
    - [augur filter](../filter.html)
    - [augur subsample](../subsample.html)
    - [augur mask](../mask.html)
    - [augur align](../align.html)
    - [augur tree](../tree.html)
    - [augur refine](../refine.html)
    - [augur ancestral](../ancestral.html)
    - [augur translate](../translate.html)
    - [augur reconstruct-sequences](../reconstruct-sequences.html)
    - [augur clades](../clades.html)
    - [augur traits](../traits.html)
    - [augur sequence-traits](../sequence-traits.html)
    - [augur lbi](../lbi.html)
    - [augur distance](../distance.html)
    - [augur titers](../titers.html)
    - [augur frequencies](../frequencies.html)
    - [augur export](../export.html)
    - [augur validate](../validate.html)
    - [augur version](../version.html)
    - [augur import](../import.html)
    - [augur measurements](../measurements.html)
    - [augur read-file](../read-file.html)
    - [augur write-file](../write-file.html)
  + [Format of augur output](../../json_format.html)
  + [Environment variables](../../envvars.html)
* [Augur Releases & Upgrading](../../../releases/releases.html)
  + [Changelog](../../../releases/changelog.html)
  + [Deprecated features](../../../releases/DEPRECATED.html)
  + [Augur v6 Release Notes](../../../releases/v6.html)
  + [Migrating from augur v5 to v6](../../../releases/migrating-v5-v6.html)
  + [Compatibility between Augur & Auspice versions](../../../releases/auspice-compatibility.html)
* [Frequently Asked Questions](../../../faq/faq.html)
  + [What is a “build”?](../../../faq/what-is-a-build.html)
  + [How do I prepare metadata?](../../../faq/metadata.html)
  + [How do I label `clades`?](../../../faq/clades.html)
  + [How do I specify `refine` rates?](../../../faq/refine.html)
  + [How do I use my own tree builder?](../../../faq/skip_augur_tree.html)
* [Examples of Augur in the wild](../../../examples/examples.html)
* [Python Public API](../../../api/public/index.html)
  + [augur.io](../../../api/public/augur.io.html)
* [Developer API](../../../api/developer/index.html)
  + [augur package](../../../api/developer/augur.html)
    - [augur.curate package](../../../api/developer/augur.curate.html)
      * [augur.curate.abbreviate\_authors module](../../../api/developer/augur.curate.abbreviate_authors.html)
      * [augur.curate.apply\_geolocation\_rules module](../../../api/developer/augur.curate.apply_geolocation_rules.html)
      * [augur.curate.apply\_record\_annotations module](../../../api/developer/augur.curate.apply_record_annotations.html)
      * [augur.curate.format\_dates module](../../../api/developer/augur.curate.format_dates.html)
      * [augur.curate.format\_dates\_directives module](../../../api/developer/augur.curate.format_dates_directives.html)
      * [augur.curate.normalize\_strings module](../../../api/developer/augur.curate.normalize_strings.html)
      * [augur.curate.parse\_genbank\_location module](../../../api/developer/augur.curate.parse_genbank_location.html)
      * [augur.curate.passthru module](../../../api/developer/augur.curate.passthru.html)
      * [augur.curate.rename module](../../../api/developer/augur.curate.rename.html)
      * [augur.curate.titlecase module](../../../api/developer/augur.curate.titlecase.html)
      * [augur.curate.transform\_strain\_name module](../../../api/developer/augur.curate.transform_strain_name.html)
    - [augur.data package](../../../api/developer/augur.data.html)
    - [augur.dates package](../../../api/developer/augur.dates.html)
      * [augur.dates.ambiguous\_date module](../../../api/developer/augur.dates.ambiguous_date.html)
      * [augur.dates.errors module](../../../api/developer/augur.dates.errors.html)
    - [augur.filter package](../../../api/developer/augur.filter.html)
      * [augur.filter.arguments module](../../../api/developer/augur.filter.arguments.html)
      * [augur.filter.constants module](../../../api/developer/augur.filter.constants.html)
      * [augur.filter.include\_exclude\_rules module](../../../api/developer/augur.filter.include_exclude_rules.html)
      * [augur.filter.io module](../../../api/developer/augur.filter.io.html)
      * [augur.filter.subsample module](../../../api/developer/augur.filter.subsample.html)
      * [augur.filter.validate\_arguments module](../../../api/developer/augur.filter.validate_arguments.html)
      * [augur.filter.weights\_file module](../../../api/developer/augur.filter.weights_file.html)
    - [augur.import\_ package](../../../api/developer/augur.import_.html)
      * [augur.import\_.beast module](../../../api/developer/augur.import_.beast.html)
    - [augur.io package](../../../api/developer/augur.io.html)
      * [augur.io.file module](../../../api/developer/augur.io.file.html)
      * [augur.io.json module](../../../api/developer/augur.io.json.html)
      * [augur.io.metadata module](../../../api/developer/augur.io.metadata.html)
      * [augur.io.print module](../../../api/developer/augur.io.print.html)
      * [augur.io.sequences module](../../../api/developer/augur.io.sequences.html)
      * [augur.io.shell\_command\_runner module](../../../api/developer/augur.io.shell_command_runner.html)
      * [augur.io.strains module](../../../api/developer/augur.io.strains.html)
    - [augur.measurements package](../../../api/developer/augur.measurements.html)
      * [augur.measurements.concat module](../../../api/developer/augur.measurements.concat.html)
      * [augur.measurements.export module](../../../api/developer/augur.measurements.export.html)
    - [augur.util\_support package](../../../api/developer/augur.util_support.html)
      * [augur.util\_support.auspice\_config module](../../../api/developer/augur.util_support.auspice_config.html)
      * [augur.util\_support.color\_parser module](../../../api/developer/augur.util_support.color_parser.html)
      * [augur.util\_support.color\_parser\_line module](../../../api/developer/augur.util_support.color_parser_line.html)
      * [augur.util\_support.node\_data module](../../../api/developer/augur.util_support.node_data.html)
      * [augur.util\_support.node\_data\_file module](../../../api/developer/augur.util_support.node_data_file.html)
      * [augur.util\_support.node\_data\_reader module](../../../api/developer/augur.util_support.node_data_reader.html)
      * [augur.util\_support.warnings module](../../../api/developer/augur.util_support.warnings.html)
    - [augur.align module](../../../api/developer/augur.align.html)
    - [augur.ancestral module](../../../api/developer/augur.ancestral.html)
    - [augur.argparse\_ module](../../../api/developer/augur.argparse_.html)
    - [augur.clades module](../../../api/developer/augur.clades.html)
    - [augur.debug module](../../../api/developer/augur.debug.html)
    - [augur.distance module](../../../api/developer/augur.distance.html)
    - [augur.errors module](../../../api/developer/augur.errors.html)
    - [augur.export module](../../../api/developer/augur.export.html)
    - [augur.export\_v1 module](../../../api/developer/augur.export_v1.html)
    - [augur.export\_v2 module](../../../api/developer/augur.export_v2.html)
    - [augur.frequencies module](../../../api/developer/augur.frequencies.html)
    - [augur.frequency\_estimators module](../../../api/developer/augur.frequency_estimators.html)
    - [augur.index module](../../../api/developer/augur.index.html)
    - [augur.lbi module](../../../api/developer/augur.lbi.html)
    - [augur.mask module](../../../api/developer/augur.mask.html)
    - [augur.merge module](../../../api/developer/augur.merge.html)
    - [augur.parse module](../../../api/developer/augur.parse.html)
    - [augur.read\_file module](../../../api/developer/augur.read_file.html)
    - [augur.reconstruct\_sequences module](../../../api/developer/augur.reconstruct_sequences.html)
    - [augur.refine module](../../../api/developer/augur.refine.html)
    - [augur.sequence\_traits module](../../../api/developer/augur.sequence_traits.html)
    - [augur.subsample module](../../../api/developer/augur.subsample.html)
    - [augur.titer\_model module](../../../api/developer/augur.titer_model.html)
    - [augur.titers module](../../../api/developer/augur.titers.html)
    - [augur.traits module](../../../api/developer/augur.traits.html)
    - [augur.translate module](../../../api/developer/augur.translate.html)
    - [augur.tree module](../../../api/developer/augur.tree.html)
    - [augur.types module](../../../api/developer/augur.types.html)
    - [augur.utils module](../../../api/developer/augur.utils.html)
    - [augur.validate module](../../../api/developer/augur.validate.html)
    - [augur.validate\_export module](../../../api/developer/augur.validate_export.html)
    - [augur.version module](../../../api/developer/augur.version.html)
    - [augur.write\_file module](../../../api/developer/augur.write_file.html)
* [Authors](../../../authors/authors.html)

[Augur](../../../index.html)

* [Home](https://docs.nextstrain.org)
* [Augur](../../../index.html)
* [Using Augur](../../usage.html)
* [Augur subcommands](../cli.html)
* [augur curate](index.html)
* [View page source](../../../_sources/usage/cli/curate/rename.rst.txt)

---

# rename[](#rename "Link to this heading")

Renames fields / columns of the input data

```
usage: augur curate rename [-h] [--metadata METADATA] [--id-column ID_COLUMN]
                           [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                           [--fasta FASTA] [--seq-id-column SEQ_ID_COLUMN]
                           [--seq-field SEQ_FIELD]
                           [--unmatched-reporting {error_first,error_all,warn,silent}]
                           [--duplicate-reporting {error_first,error_all,warn,silent}]
                           [--output-metadata OUTPUT_METADATA]
                           [--output-fasta OUTPUT_FASTA]
                           [--output-id-field OUTPUT_ID_FIELD]
                           [--output-seq-field OUTPUT_SEQ_FIELD] --field-map
                           FIELD_MAP [FIELD_MAP ...] [--force]
```

## INPUTS[](#augur-make_parser-inputs "Link to this heading")

> Input options shared by all augur curate commands.
> If no input options are provided, commands will try to read NDJSON records from stdin.

`--metadata`
:   Input metadata file. May be plain text (TSV, CSV) or an Excel or OpenOffice spreadsheet workbook file. When an Excel or OpenOffice workbook, only the first visible worksheet will be read and initial empty rows/columns will be ignored. Accepts ‘-’ to read plain text from stdin.

`--id-column`
:   Name of the metadata column that contains the record identifier for reporting duplicate records. Uses the first column of the metadata file if not provided. Ignored if also providing a FASTA file input.

`--metadata-delimiters`
:   Delimiters to accept when reading a plain text metadata file. Only one delimiter will be inferred.

    Default: `(',', '\t')`

`--fasta`
:   Plain or gzipped FASTA file. Headers can only contain the sequence id used to match a metadata record. Note that an index file will be generated for the FASTA file as <filename>.fasta.fxi

`--seq-id-column`
:   Name of metadata column that contains the sequence id to match sequences in the FASTA file.

`--seq-field`
:   The name to use for the sequence field when joining sequences from a FASTA file.

`--unmatched-reporting`
:   Possible choices: error\_first, error\_all, warn, silent

    How unmatched records from combined metadata/FASTA input should be reported.

    Default: `error_first`

`--duplicate-reporting`
:   Possible choices: error\_first, error\_all, warn, silent

    How should duplicate records be reported.

    Default: `error_first`

## OUTPUTS[](#augur-make_parser-outputs "Link to this heading")

> Output options shared by all augur curate commands.
> If no output options are provided, commands will output NDJSON records to stdout.

`--output-metadata`
:   Output metadata TSV file. Accepts ‘-’ to output TSV to stdout.

`--output-fasta`
:   Output FASTA file.

`--output-id-field`
:   The record field to use as the sequence identifier in the FASTA output.

`--output-seq-field`
:   The record field that contains the sequence for the FASTA output. This field will be deleted from the metadata output.

## REQUIRED[](#augur-make_parser-required "Link to this heading")

`--field-map`
:   Rename fields/columns via ‘{old\_field\_name}={new\_field\_name}’. If the new field already exists, then the renaming of the old field will be skipped. Multiple entries with the same ‘{old\_field\_name}’ will duplicate the field/column. Skips the field if the old field name is the same as the new field name (case-sensitive).

## OPTIONAL[](#augur-make_parser-optional "Link to this heading")

`--force`
:   Force renaming of old field even if the new field already exists. Please keep in mind this will overwrite the value of the new field.

    Default: `False`

[Previous](transform-strain-name.html "transform-strain-name")
[Next](../merge.html "augur merge")

---

Hadfield *et al.,*
[Nextstrain: real-time tracking of pathogen evolution](https://doi.org/10.1093/bioinformatics/bty407)
*, Bioinformatics* (2018)

The core Nextstrain team is

[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/trevor-bedford.jpg)
Trevor Bedford](http://bedford.io/team/trevor-bedford/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/richard-neher.jpg)
Richard Neher](https://neherlab.org/richard-neher.html)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/ivan-aksamentov.jpg)
Ivan Aksamentov](https://neherlab.org/ivan-aksamentov.html)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/kim-andrews.jpg)
Kim Andrews](https://bedford.io/team/kim-andrews/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/jennifer-chang.jpg)
Jennifer Chang](https://bedford.io/team/jennifer-chan