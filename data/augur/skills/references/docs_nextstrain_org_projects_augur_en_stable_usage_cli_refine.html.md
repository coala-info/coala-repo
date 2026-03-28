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
    - [augur subsample](subsample.html)
    - [augur mask](mask.html)
    - [augur align](align.html)
    - [augur tree](tree.html)
    - augur refine
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
* [View page source](../../_sources/usage/cli/refine.rst.txt)

---

# augur refine[](#augur-refine "Link to this heading")

Table of Contents

* [Named Arguments](#augur-make_parser-named-arguments)
* [Guides](#guides)

---

Refine an initial tree using sequence metadata.

```
usage: augur refine [-h] [--alignment ALIGNMENT] --tree TREE [--metadata FILE]
                    [--metadata-delimiters METADATA_DELIMITERS [METADATA_DELIMITERS ...]]
                    [--metadata-id-columns METADATA_ID_COLUMNS [METADATA_ID_COLUMNS ...]]
                    [--output-tree OUTPUT_TREE]
                    [--output-node-data OUTPUT_NODE_DATA] [--use-fft]
                    [--max-iter MAX_ITER] [--timetree]
                    [--coalescent COALESCENT] [--gen-per-year GEN_PER_YEAR]
                    [--clock-rate CLOCK_RATE] [--clock-std-dev CLOCK_STD_DEV]
                    [--root ROOT [ROOT ...]] [--keep-root] [--remove-outgroup]
                    [--covariance] [--no-covariance]
                    [--keep-polytomies | --stochastic-resolve | --greedy-resolve]
                    [--precision {0,1,2,3}] [--date-format DATE_FORMAT]
                    [--date-confidence] [--date-inference {joint,marginal}]
                    [--branch-length-inference {auto,joint,marginal,input}]
                    [--clock-filter-iqd CLOCK_FILTER_IQD] [--keep-ids FILE]
                    [--vcf-reference VCF_REFERENCE]
                    [--year-bounds YEAR_BOUNDS [YEAR_BOUNDS ...]]
                    [--divergence-units {mutations,mutations-per-site}]
                    [--seed SEED] [--verbosity VERBOSITY]
```

## [Named Arguments](#id1)[](#augur-make_parser-named-arguments "Link to this heading")

`--alignment, -a`
:   alignment in fasta or VCF format

`--tree, -t`
:   prebuilt Newick

`--metadata`
:   sequence metadata

`--metadata-delimiters`
:   delimiters to accept when reading a metadata file. Only one delimiter will be inferred.

    Default: `(',', '\t')`

`--metadata-id-columns`
:   names of possible metadata columns containing identifier information, ordered by priority. Only one ID column will be inferred.

    Default: `('strain', 'name')`

`--output-tree`
:   file name to write tree to

`--output-node-data`
:   file name to write branch lengths as node data

`--use-fft`
:   produce timetree using FFT for convolutions

    Default: `False`

`--max-iter`
:   maximal number of iterations TreeTime uses for timetree inference

    Default: `2`

`--timetree`
:   produce timetree using treetime, requires tree where branch length is in units of average number of nucleotide or protein substitutions per site (and branch lengths do not exceed 4)

    Default: `False`

`--coalescent`
:   coalescent time scale in units of inverse clock rate (float), optimize as scalar (‘opt’), or skyline (‘skyline’)

`--gen-per-year`
:   number of generations per year, relevant for skyline output(‘skyline’)

    Default: `50`

`--clock-rate`
:   fixed clock rate

`--clock-std-dev`
:   standard deviation of the fixed clock\_rate estimate

`--root`
:   rooting mechanism (‘best’, ‘least-squares’, ‘min\_dev’, ‘oldest’, ‘mid\_point’) OR node to root by OR two nodes indicating a monophyletic group to root by. Run treetime -h for definitions of rooting methods.

    Default: `['best']`

`--keep-root`
:   do not reroot the tree; use it as-is. Overrides anything specified by –root.

    Default: `False`

`--remove-outgroup`
:   Remove the outgroup supplied via ‘–root’This is only valid when a single strain name has been supplied as the root.

    Default: `False`

`--covariance`
:   Account for covariation when estimating rates and/or rerooting. Use –no-covariance to turn off.

    Default: `True`

`--no-covariance`
:   Default: `True`

`--keep-polytomies`
:   Do not attempt to resolve polytomies

    Default: `False`

`--stochastic-resolve`
:   Resolve polytomies via stochastic subtree building rather than greedy optimization

    Default: `False`

`--greedy-resolve`
:   Default: `True`

`--precision`
:   Possible choices: 0, 1, 2, 3

    precision used by TreeTime to determine the number of grid points that are used for the evaluation of the branch length interpolation objects. Values range from 0 (rough) to 3 (ultra fine) and default to ‘auto’.

`--date-format`
:   date format

    Default: `'%Y-%m-%d'`

`--date-confidence`
:   calculate confidence intervals for node dates

    Default: `False`

`--date-inference`
:   Possible choices: joint, marginal

    assign internal nodes to their marginally most likely dates, not jointly most likely

    Default: `'joint'`

`--branch-length-inference`
:   Possible choices: auto, joint, marginal, input

    branch length mode of treetime to use

    Default: `'auto'`

`--clock-filter-iqd`
:   clock-filter: remove tips that deviate more than n\_iqd interquartile ranges from the root-to-tip vs time regression

`--keep-ids`
:   file containing ids to keep in tree regardless of clock filtering (one per line)

`--vcf-reference`
:   fasta file of the sequence the VCF was mapped to

`--year-bounds`
:   specify min or max & min prediction bounds for samples with XX in year

`--divergence-units`
:   Possible choices: mutations, mutations-per-site

    Units in which sequence divergences is exported.

    Default: `'mutations-per-site'`

`--s