[![Logo](../_static/nextstrain-logo.svg)](https://docs.nextstrain.org)

[Augur](../index.html)

version 33.0.1

Table of contents

* Installation
* [Using Augur](../usage/usage.html)
  + [Augur subcommands](../usage/cli/cli.html)
    - [augur parse](../usage/cli/parse.html)
    - [augur curate](../usage/cli/curate/index.html)
      * [passthru](../usage/cli/curate/passthru.html)
      * [normalize-strings](../usage/cli/curate/normalize-strings.html)
      * [format-dates](../usage/cli/curate/format-dates.html)
      * [titlecase](../usage/cli/curate/titlecase.html)
      * [apply-geolocation-rules](../usage/cli/curate/apply-geolocation-rules.html)
      * [apply-record-annotations](../usage/cli/curate/apply-record-annotations.html)
      * [abbreviate-authors](../usage/cli/curate/abbreviate-authors.html)
      * [parse-genbank-location](../usage/cli/curate/parse-genbank-location.html)
      * [transform-strain-name](../usage/cli/curate/transform-strain-name.html)
      * [rename](../usage/cli/curate/rename.html)
    - [augur merge](../usage/cli/merge.html)
    - [augur index](../usage/cli/index.html)
    - [augur filter](../usage/cli/filter.html)
    - [augur subsample](../usage/cli/subsample.html)
    - [augur mask](../usage/cli/mask.html)
    - [augur align](../usage/cli/align.html)
    - [augur tree](../usage/cli/tree.html)
    - [augur refine](../usage/cli/refine.html)
    - [augur ancestral](../usage/cli/ancestral.html)
    - [augur translate](../usage/cli/translate.html)
    - [augur reconstruct-sequences](../usage/cli/reconstruct-sequences.html)
    - [augur clades](../usage/cli/clades.html)
    - [augur traits](../usage/cli/traits.html)
    - [augur sequence-traits](../usage/cli/sequence-traits.html)
    - [augur lbi](../usage/cli/lbi.html)
    - [augur distance](../usage/cli/distance.html)
    - [augur titers](../usage/cli/titers.html)
    - [augur frequencies](../usage/cli/frequencies.html)
    - [augur export](../usage/cli/export.html)
    - [augur validate](../usage/cli/validate.html)
    - [augur version](../usage/cli/version.html)
    - [augur import](../usage/cli/import.html)
    - [augur measurements](../usage/cli/measurements.html)
    - [augur read-file](../usage/cli/read-file.html)
    - [augur write-file](../usage/cli/write-file.html)
  + [Format of augur output](../usage/json_format.html)
  + [Environment variables](../usage/envvars.html)
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
* [View page source](../_sources/installation/installation.rst.txt)

---

# Installation[](#installation "Link to this heading")

Note

This is an Augur-specific installation guide. If you wish to use Nextstrain as a whole, please refer to [the Nextstrain installation guide](https://docs.nextstrain.org/en/latest/install.html).

* [Install Augur](#install-augur)
* [Testing if it worked](#testing-if-it-worked)

## [Install Augur](#id1)[](#install-augur "Link to this heading")

Warning

There are some package managers that have entries with a similar name.

* [Augur on PyPI](https://pypi.org/project/Augur/). This is a different project. Use [nextstrain-augur](https://pypi.org/project/nextstrain-augur/) instead.
* [augur on Debian](https://tracker.debian.org/pkg/augur). This is an unofficial version not maintained by the Nextstrain core team. It may lag behind official Augur releases. We do not generally recommend its use.

There are several ways to install Augur, ordered from least to most complex.

NextstrainCondaPyPISourceDevelopment

Augur is part of the Nextstrain project and is available in all [Nextstrain runtimes](https://docs.nextstrain.org/en/latest/reference/glossary.html#term-runtime "(in Nextstrain)").

Continue by following the [Nextstrain installation guide](https://docs.nextstrain.org/en/latest/install.html "(in Nextstrain)").

Once installed, you can use [nextstrain shell](https://docs.nextstrain.org/projects/cli/en/stable/commands/shell/ "(in Nextstrain CLI v10.4.2)") to run `augur` directly.

Augur can be installed using Conda or another variant. This assumes you are familiar with how to [manage Conda environments](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).

```
conda install -c conda-forge -c bioconda augur
```

This installs Augur along with all dependencies.

Warning

Installing other Python packages after Augur may cause dependency incompatibilities. If this happens, re-install Augur using the command in step 1.

Augur is written in Python 3 and requires at least Python 3.10. It’s published on [PyPI](https://pypi.org) as [nextstrain-augur](https://pypi.org/project/nextstrain-augur).

1. Install Augur along with Python dependencies.

   ```
   python3 -m pip install nextstrain-augur
   ```
2. Install other dependencies.

   Augur uses some external bioinformatics programs that are not available on PyPI:

   * `augur align` requires [mafft](https://mafft.cbrc.jp/alignment/software/)
   * `augur tree` requires at least one of:

     > + [IQ-TREE](http://www.iqtree.org/) (used by default)
     > + [RAxML](https://cme.h-its.org/exelixis/web/software/raxml/) (optional alternative)
     > + [FastTree](http://www.microbesonline.org/fasttree/) (optional alternative)
   * `augur merge` requires `sqlite3` (the [SQLite](https://sqlite.org) CLI (version ≥3.39)) for metadata and [SeqKit](https://bioinf.shenwei.me/seqkit) for sequences.
   * Bacterial data (or any VCF usage) requires [vcftools](https://vcftools.github.io/)

   If you use Conda, you can install them in an active environment:

   ```
   conda install -c conda-forge -c bioconda mafft raxml fasttree iqtree vcftools seqkit sqlite --yes
   ```

   On macOS using [Homebrew](https://brew.sh/):

   ```
   brew tap brewsci/bio
   brew install mafft iqtree raxml fasttree vcftools seqkit sqlite
   ```

   On Debian/Ubuntu:

   ```
   sudo apt install mafft iqtree raxml fasttree vcftools seqkit sqlite3
   ```

   Other Linux distributions will likely have the same packages available, although the names may differ slightly.

Warning

Installing other Python packages after Augur may cause dependency incompatibilities. If this happens, re-install Augur using the command in step 1.

Augur can be installed from source. This is useful if you want to use unreleased changes. To develop Augur locally, see instructions in the “Development” tab.

1. Install Augur along with Python dependencies.

   ```
   git clone https://github.com/nextstrain/augur.git
   cd augur
   python3 -m pip install .
   ```
2. Install other dependencies.

   Augur uses some external bioinformatics programs that are not available on PyPI:

   * `augur align` requires [mafft](https://mafft.cbrc.jp/alignment/software/)
   * `augur tree` requires at least one of:

     > + [IQ-TREE](http://www.iqtree.org/) (used by default)
     > + [RAxML](https://cme.h-its.org/exelixis/web/software/raxml/) (optional alternative)
     > + [FastTree](http://www.microbesonline.org/fasttree/) (optional alternative)
   * `augur merge` requires `sqlite3` (the [SQLite](https://sqlite.org) CLI (version ≥3.39)) for metadata and [SeqKit](https://bioinf.shenwei.me/seqkit) for sequences.
   * Bacterial data (or any VCF usage) requires [vcftools](https://vcftools.github.io/)

   If you use Conda, you can install them in an active environment:

   ```
   conda install -c conda-forge -c bioconda mafft raxml fasttree iqtree vcftools seqkit sqlite --yes
   ```

   On macOS using [Homebrew](https://brew.sh/):

   ```
   brew tap brewsci/bio
   brew install mafft iqtree raxml fasttree vcftools seqkit sqlite
   ```

   On Debian/Ubuntu:

   ```
   sudo apt install mafft iqtree raxml fasttree 