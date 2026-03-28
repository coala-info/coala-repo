[![Logo](../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Augur](../index.html)

version 33.0.1

Table of contents

* [Installation](../installation/installation.html)
* Using Augur
  + [Augur subcommands](cli/cli.html)
    - [augur parse](cli/parse.html)
    - [augur curate](cli/curate/index.html)
      * [passthru](cli/curate/passthru.html)
      * [normalize-strings](cli/curate/normalize-strings.html)
      * [format-dates](cli/curate/format-dates.html)
      * [titlecase](cli/curate/titlecase.html)
      * [apply-geolocation-rules](cli/curate/apply-geolocation-rules.html)
      * [apply-record-annotations](cli/curate/apply-record-annotations.html)
      * [abbreviate-authors](cli/curate/abbreviate-authors.html)
      * [parse-genbank-location](cli/curate/parse-genbank-location.html)
      * [transform-strain-name](cli/curate/transform-strain-name.html)
      * [rename](cli/curate/rename.html)
    - [augur merge](cli/merge.html)
    - [augur index](cli/index.html)
    - [augur filter](cli/filter.html)
    - [augur subsample](cli/subsample.html)
    - [augur mask](cli/mask.html)
    - [augur align](cli/align.html)
    - [augur tree](cli/tree.html)
    - [augur refine](cli/refine.html)
    - [augur ancestral](cli/ancestral.html)
    - [augur translate](cli/translate.html)
    - [augur reconstruct-sequences](cli/reconstruct-sequences.html)
    - [augur clades](cli/clades.html)
    - [augur traits](cli/traits.html)
    - [augur sequence-traits](cli/sequence-traits.html)
    - [augur lbi](cli/lbi.html)
    - [augur distance](cli/distance.html)
    - [augur titers](cli/titers.html)
    - [augur frequencies](cli/frequencies.html)
    - [augur export](cli/export.html)
    - [augur validate](cli/validate.html)
    - [augur version](cli/version.html)
    - [augur import](cli/import.html)
    - [augur measurements](cli/measurements.html)
    - [augur read-file](cli/read-file.html)
    - [augur write-file](cli/write-file.html)
  + [Format of augur output](json_format.html)
  + [Environment variables](envvars.html)
* [Augur Releases & Upgrading](../releases/releases.html)
  + [Changelog](../releases/changelog.html)
  + [Deprecated features](../releases/DEPRECATED.html)
  + [Augur v6 Release Notes](../releases/v6.html)
  + [Migrating from augur v5 to v6](../releases/migrating-v5-v6.html)
  + [Compatibility between Augur & Auspice versions](../releases/auspice-compatibility.html)
* [Frequently Asked Questions](../faq/faq.html)
  + [What is a “build”?](../faq/what-is-a-build.html)
  + [How do I prepare metadata?](../faq/metadata.html)
  + [How do I label `clades`?](../faq/clades.html)
  + [How do I specify `refine` rates?](../faq/refine.html)
  + [How do I use my own tree builder?](../faq/skip_augur_tree.html)
* [Examples of Augur in the wild](../examples/examples.html)
* [Python Public API](../api/public/index.html)
  + [augur.io](../api/public/augur.io.html)
* [Developer API](../api/developer/index.html)
  + [augur package](../api/developer/augur.html)
    - [augur.curate package](../api/developer/augur.curate.html)
      * [augur.curate.abbreviate\_authors module](../api/developer/augur.curate.abbreviate_authors.html)
      * [augur.curate.apply\_geolocation\_rules module](../api/developer/augur.curate.apply_geolocation_rules.html)
      * [augur.curate.apply\_record\_annotations module](../api/developer/augur.curate.apply_record_annotations.html)
      * [augur.curate.format\_dates module](../api/developer/augur.curate.format_dates.html)
      * [augur.curate.format\_dates\_directives module](../api/developer/augur.curate.format_dates_directives.html)
      * [augur.curate.normalize\_strings module](../api/developer/augur.curate.normalize_strings.html)
      * [augur.curate.parse\_genbank\_location module](../api/developer/augur.curate.parse_genbank_location.html)
      * [augur.curate.passthru module](../api/developer/augur.curate.passthru.html)
      * [augur.curate.rename module](../api/developer/augur.curate.rename.html)
      * [augur.curate.titlecase module](../api/developer/augur.curate.titlecase.html)
      * [augur.curate.transform\_strain\_name module](../api/developer/augur.curate.transform_strain_name.html)
    - [augur.data package](../api/developer/augur.data.html)
    - [augur.dates package](../api/developer/augur.dates.html)
      * [augur.dates.ambiguous\_date module](../api/developer/augur.dates.ambiguous_date.html)
      * [augur.dates.errors module](../api/developer/augur.dates.errors.html)
    - [augur.filter package](../api/developer/augur.filter.html)
      * [augur.filter.arguments module](../api/developer/augur.filter.arguments.html)
      * [augur.filter.constants module](../api/developer/augur.filter.constants.html)
      * [augur.filter.include\_exclude\_rules module](../api/developer/augur.filter.include_exclude_rules.html)
      * [augur.filter.io module](../api/developer/augur.filter.io.html)
      * [augur.filter.subsample module](../api/developer/augur.filter.subsample.html)
      * [augur.filter.validate\_arguments module](../api/developer/augur.filter.validate_arguments.html)
      * [augur.filter.weights\_file module](../api/developer/augur.filter.weights_file.html)
    - [augur.import\_ package](../api/developer/augur.import_.html)
      * [augur.import\_.beast module](../api/developer/augur.import_.beast.html)
    - [augur.io package](../api/developer/augur.io.html)
      * [augur.io.file module](../api/developer/augur.io.file.html)
      * [augur.io.json module](../api/developer/augur.io.json.html)
      * [augur.io.metadata module](../api/developer/augur.io.metadata.html)
      * [augur.io.print module](../api/developer/augur.io.print.html)
      * [augur.io.sequences module](../api/developer/augur.io.sequences.html)
      * [augur.io.shell\_command\_runner module](../api/developer/augur.io.shell_command_runner.html)
      * [augur.io.strains module](../api/developer/augur.io.strains.html)
    - [augur.measurements package](../api/developer/augur.measurements.html)
      * [augur.measurements.concat module](../api/developer/augur.measurements.concat.html)
      * [augur.measurements.export module](../api/developer/augur.measurements.export.html)
    - [augur.util\_support package](../api/developer/augur.util_support.html)
      * [augur.util\_support.auspice\_config module](../api/developer/augur.util_support.auspice_config.html)
      * [augur.util\_support.color\_parser module](../api/developer/augur.util_support.color_parser.html)
      * [augur.util\_support.color\_parser\_line module](../api/developer/augur.util_support.color_parser_line.html)
      * [augur.util\_support.node\_data module](../api/developer/augur.util_support.node_data.html)
      * [augur.util\_support.node\_data\_file module](../api/developer/augur.util_support.node_data_file.html)
      * [augur.util\_support.node\_data\_reader module](../api/developer/augur.util_support.node_data_reader.html)
      * [augur.util\_support.warnings module](../api/developer/augur.util_support.warnings.html)
    - [augur.align module](../api/developer/augur.align.html)
    - [augur.ancestral module](../api/developer/augur.ancestral.html)
    - [augur.argparse\_ module](../api/developer/augur.argparse_.html)
    - [augur.clades module](../api/developer/augur.clades.html)
    - [augur.debug module](../api/developer/augur.debug.html)
    - [augur.distance module](../api/developer/augur.distance.html)
    - [augur.errors module](../api/developer/augur.errors.html)
    - [augur.export module](../api/developer/augur.export.html)
    - [augur.export\_v1 module](../api/developer/augur.export_v1.html)
    - [augur.export\_v2 module](../api/developer/augur.export_v2.html)
    - [augur.frequencies module](../api/developer/augur.frequencies.html)
    - [augur.frequency\_estimators module](../api/developer/augur.frequency_estimators.html)
    - [augur.index module](../api/developer/augur.index.html)
    - [augur.lbi module](../api/developer/augur.lbi.html)
    - [augur.mask module](../api/developer/augur.mask.html)
    - [augur.merge module](../api/developer/augur.merge.html)
    - [augur.parse module](../api/developer/augur.parse.html)
    - [augur.read\_file module](../api/developer/augur.read_file.html)
    - [augur.reconstruct\_sequences module](../api/developer/augur.reconstruct_sequences.html)
    - [augur.refine module](../api/developer/augur.refine.html)
    - [augur.sequence\_traits module](../api/developer/augur.sequence_traits.html)
    - [augur.subsample module](../api/developer/augur.subsample.html)
    - [augur.titer\_model module](../api/developer/augur.titer_model.html)
    - [augur.titers module](../api/developer/augur.titers.html)
    - [augur.traits module](../api/developer/augur.traits.html)
    - [augur.translate module](../api/developer/augur.translate.html)
    - [augur.tree module](../api/developer/augur.tree.html)
    - [augur.types module](../api/developer/augur.types.html)
    - [augur.utils module](../api/developer/augur.utils.html)
    - [augur.validate module](../api/developer/augur.validate.html)
    - [augur.validate\_export module](../api/developer/augur.validate_export.html)
    - [augur.version module](../api/developer/augur.version.html)
    - [augur.write\_file module](../api/developer/augur.write_file.html)
* [Authors](../authors/authors.html)

[Augur](../index.html)

* [Home](https://docs.nextstrain.org)
* [Augur](../index.html)
* [View page source](../_sources/usage/usage.rst.txt)

---

# Using Augur[](#using-augur "Link to this heading")

Augur consists of a number of tools that allow the user to filter and align sequences, infer trees, and integrate the phylogenetic analysis with meta data.
The different tools are meant to be composable and the output of one command will serve as the input of other commands.
All of Augur’s commands are accessed through the `augur` program followed by the name of the command, e.g. `augur ancestral` to infer ancestral sequences.

Each command requires at least one input file and will produce one or more output files following the pattern

```
augur ancestral --tree my_tree.nwk --alignment my_alignment.fasta --output-node-data ancestral_sequences.json
```

Most commands admit additional arguments to modify how the analysis is run.
Each command is documented below, and we are continually adding more examples to each command and providing real-life examples of their usage.
For instance, the documentation for [augur filter](cli/filter.html) shows how we use this to subsample the [nextstrain zika analysis](https://nextstrain.org/zika).

Note that you can also run each command with the `--help` option, for example `augur tree --help`, for more information at the command-line.

* [Augur subcommands](cli/cli.html)
  + [augur parse](cli/parse.html)
  + [augur curate](cli/curate/index.html)
  + [augur merge](cli/merge.html)
  + [augur index](cli/index.html)
  + [augur filter](cli/filter.html)
  + [augur subsample](cli/subsample.html)
  + [augur mask](cli/mask.html)
  + [augur align](cli/align.html)
  + [augur tree](cli/tree.html)
  + [augur refine](cli/refine.html)
  + [augur ancestral](cli/ancestral.html)
  + [augur translate](cli/translate.html)
  + [augur reconstruct-sequences](cli/reconstruct-sequences.html)
  + [augur clades](cli/clades.html)
  + [augur traits](cli/traits.html)
  + [augur sequence-traits](cli/sequence-traits.html)
  + [augur lbi](cli/lbi.html)
  + [augur distance](cli/distance.html)
  + [augur titers](cli/titers.html)
  + [augur frequencies](cli/frequencies.html)
  + [augur export](cli/export.html)
  + [augur validate](cli/validate.html)
  + [augur version](cli/version.html)
  + [augur import](cli/import.html)
  + [augur measurements](cli/measurements.html)
  + [augur read-file](cli/read-file.html)
  + [augur write-file](cli/write-file.html)
* [Format of augur output](json_format.html)
* [Environment variables](envvars.html)

[Previous](../installation/installation.html "Installation")
[Next](cli/cli.html "Augur subcommands")

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
Jennifer Chang](https://bedford.io/team/jennifer-chang/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/james-hadfield.jpg)
James Hadfield](http://bedford.io/team/james-hadfield/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/emma-hodcroft.jpg)
Emma Hodcroft](http://emmahodcroft.com/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/john-huddleston.jpg)
John Huddleston](http://bedford.io/team/john-huddleston/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/jover-lee.jpg)
Jover Lee](http://bedford.io/team/jover-lee/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/victor-lin.png)
Victor Lin](https://bedford.io/team/victor-lin/)
,
[![](https://raw.githubusercontent.com/nextstrain/nextstrain.org/HEAD/static-site/static/team/cornelius-roemer.jpg)
Cornelius Roemer](https://neherlab.org/cornelius-roemer.html)

Please see the [team page](https://nextstrain.org/team) for more details.

All [source code for Nextstrain](https://github.com/nextstrain) is freely available under the terms of an [open-source license](https://opensource.org/osd), typically [AGPL-3.0](https://opensource.org/licenses/AGPL-3.0) or [MIT](https://opensource.org/licenses/MIT).
Refer to specific projects for details.
Screenshots may be used under a [CC-BY-4.0 license](https://creativecommons.org/licenses/by/4.0/) and attribution to nextstrain.org must be provided.

This work is made possible by the open sharing of genetic data by research groups from all over the world.
We gratefully acknowledge their contributions.
Special thanks to Kristian Andersen, Josh Batson, David Blazes, Jesse Bloom, Peter Bogner, Anderson Brito, Matt Cotten, Ana Crisan, Tulio de Oliveira, Gytis Dudas, Vivien Dugan, Karl Erlandson, Nuno Faria, Jennifer Gardy, Nate Grubaugh, Becky 