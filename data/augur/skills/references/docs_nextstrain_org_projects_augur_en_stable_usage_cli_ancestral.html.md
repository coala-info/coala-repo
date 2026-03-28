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
    - [augur refine](refine.html)
    - augur ancestral
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
* [View page source](../../_sources/usage/cli/ancestral.rst.txt)

---

# augur ancestral[](#augur-ancestral "Link to this heading")

* [inputs](#augur-make_parser-inputs)
* [global options](#augur-make_parser-global-options)
* [nucleotide options](#augur-make_parser-nucleotide-options)
* [amino acid options](#augur-make_parser-amino-acid-options)
* [outputs](#augur-make_parser-outputs)
* [general](#augur-make_parser-general)
* [Example Node Data JSON](#example-node-data-json)

Infer ancestral sequences based on a tree.

The ancestral sequences are inferred using [TreeTime](https://academic.oup.com/ve/article/4/1/vex042/4794731).
Each internal node gets assigned a nucleotide sequence that maximizes a
likelihood on the tree given its descendants and its parent node.
Each node then gets assigned a list of nucleotide mutations for any position
that has a mismatch between its own sequence and its parent’s sequence.
The node sequences and mutations are output to a node-data JSON file.

If amino acid options are provided, the ancestral amino acid sequences for each
requested gene are inferred with the same method as the nucleotide sequences described above.
The inferred amino acid mutations will be included in the output node-data JSON
file, with the format equivalent to the output of augur translate.

The nucleotide and amino acid sequences are inferred separately in this command,
which can potentially result in mismatches between the nucleotide and amino
acid mutations. If you want amino acid mutations based on the inferred
nucleotide sequences, please use augur translate.

Note

The mutation positions in the node-data JSON are one-based.

```
usage: augur ancestral [-h] --tree TREE [--alignment ALIGNMENT]
                       [--vcf-reference FASTA | --root-sequence FASTA/GenBank]
                       [--inference {joint,marginal}] [--seed SEED]
                       [--keep-ambiguous | --infer-ambiguous]
                       [--keep-overhangs] [--annotation ANNOTATION]
                       [--genes GENES [GENES ...]]
                       [--translations TRANSLATIONS]
                       [--output-node-data OUTPUT_NODE_DATA]
                       [--output-sequences OUTPUT_SEQUENCES]
                       [--output-translations OUTPUT_TRANSLATIONS]
                       [--output-vcf OUTPUT_VCF]
                       [--validation-mode {error,warn,skip}]
                       [--skip-validation]
```

## [inputs](#id1)[](#augur-make_parser-inputs "Link to this heading")

Tree and sequences to use for ancestral reconstruction

`--tree, -t`
:   prebuilt Newick

`--alignment, -a`
:   alignment in FASTA or VCF format

`--vcf-reference`
:   [VCF alignment only] file of the sequence the VCF was mapped to. Differences between this sequence and the inferred root will be reported as mutations on the root branch.

`--root-sequence`
:   [FASTA alignment only] file of the sequence that is used as root for mutation calling. Differences between this sequence and the inferred root will be reported as mutations on the root branch.

## [global options](#id2)[](#augur-make_parser-global-options "Link to this heading")

Options to configure reconstruction of both nucleotide and amino acid sequences

`--inference`
:   Possible choices: joint, marginal

    calculate joint or marginal maximum likelihood ancestral sequence states

    Default: `'joint'`

`--seed`
:   seed for random number generation

## [nucleotide options](#id3)[](#augur-make_parser-nucleotide-options "Link to this heading")

Options to configure reconstruction of ancestral nucleotide sequences

`--keep-ambiguous`
:   do not infer nucleotides at ambiguous (N) sites on tip sequences (leave as N).

    Default: `False`

`--infer-ambiguous`
:   infer nucleotides at ambiguous (N,W,R,..) sites on tip sequences and replace with most likely state.

    Default: `True`

`--keep-overhangs`
:   do not infer nucleotides for gaps (-) on either side of the alignment

    Default: `False`

## [amino acid options](#id4)[](#augur-make_parser-amino-acid-options "Link to this heading")

Options to configure reconstruction of ancestral amino acid sequences. All arguments are required for ancestral amino acid sequence reconstruction.

`--annotation`
:   GenBank or GFF file containing the annotation

`--genes`
:   genes to translate (list or file containing list)

`--translations`
:   translated alignments for each CDS/Gene. Currently only supported for FASTA-input. Specify the file name via a template like ‘aa\_sequences\_%GENE.fasta’ where %GENE will be replaced by the gene name.

## [outputs](#id5)[](#augur-make_parser-outputs "Link to this heading")

Outputs supported for reconstructed ancestral sequences

`--output-node-data`
:   name of JSON file to save mutations and ancestral sequences to

`--output-sequences`
:   name of FASTA file to save ancestral nucleotide sequences to (FASTA alignments only)

`--output-translations`
:   name of the FASTA file(s) to save ancestral amino acid sequences to. Specify the file name via a template like ‘ancestral\_aa\_sequences\_%GENE.fasta’ where %GENE will be replaced bythe gene name.

`--output-vcf`
:   name of output VCF file which will include ancestral seqs

## [general](#id6)[](#augur-make_parser-general "Link to this heading")

`--validation-mode`
:  