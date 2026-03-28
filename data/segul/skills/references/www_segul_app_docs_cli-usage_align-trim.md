[Skip to main content](#__docusaurus_skipToContent_fallback)

[![SEGUL Logo](/img/logo.svg)![SEGUL Logo](/img/logo.svg)

**SEGUL**](/)[Docs](/docs/intro)[News](/blog)

[GitHub](https://github.com/hhandika/segul)

* [Introduction](/docs/intro)
* [Quick Start](/docs/quick_start)
* [CLI vs GUI](/docs/cli_gui)
* [Features](/docs/features)
* [Installation](/docs/category/installation)
* [GUI Usages](/docs/category/gui-usages)
* [CLI Usages](/docs/category/cli-usages)

  + [Introduction](/docs/cli-usage/intro)
  + [Command Options](/docs/cli-usage/command_options)
  + [Alignment Concatenation](/docs/cli-usage/align-concat)
  + [Alignment Conversion](/docs/cli-usage/align-convert)
  + [Alignment Filtering](/docs/cli-usage/align-filter)
  + [Alignment Partition Conversion](/docs/cli-usage/align-partition)
  + [Alignment Splitting](/docs/cli-usage/align-split)
  + [Alignment Summary](/docs/cli-usage/align-summary)
  + [Alignment Trimming](/docs/cli-usage/align-trim)
  + [Unalign Alignments](/docs/cli-usage/align-unalign)
  + [Multi Alignment Format Conversion](/docs/cli-usage/maf-convert)
  + [Genomic Summary](/docs/cli-usage/genomic-summary)
  + [Sequence Addition](/docs/cli-usage/sequence-add)
  + [Sequence Extraction](/docs/cli-usage/sequence-extract)
  + [Sequence Filtering](/docs/cli-usage/sequence-filter)
  + [Sequence ID Extraction](/docs/cli-usage/sequence-id)
  + [Sequence ID Mapping](/docs/cli-usage/sequence-map)
  + [Sequence Removal](/docs/cli-usage/sequence-remove)
  + [Sequence ID Renaming](/docs/cli-usage/sequence-rename)
  + [Sequence Translation](/docs/cli-usage/sequence-translate)
  + [Log File](/docs/cli-usage/log)
* [API Usages](/docs/category/api-usages)
* [Advanced Guides](/docs/category/advanced-guides)
* [Tutorials](/docs/category/tutorials)
* [Terms and Conditions](/docs/terms)
* [Privacy Policy](/docs/privacy)
* [Support](/docs/support)

* [CLI Usages](/docs/category/cli-usages)
* Alignment Trimming

On this page

# Alignment Trimming

Trim alignments based on the proportion of missing data or the number of parsimony informative sites. This feature will filter sites based on the specified parameters.

info

This feature is available in SEGUL v0.23.0 and later versions. To check your SEGUL version, run in your terminal:

```
segul --version
# Compatible version example:
# segul 0.23.0
```

Check the [Installation Guide](/docs/installation/update#segul-cli) to update SEGUL to the latest version.

## Quick example[​](#quick-example "Direct link to Quick example")

Assume we have an alignment file in FASTA format as follows:

```
>seq1
ATGCAT--A
>seq2
ATGCATA--
>seq3
ATGCAA-A-
>seq4
ATGCATA--
```

If we set the proportion of missing data to 0.5. It will generate an output without the last two sites using the following command:

```
segul align trim --dir alignments/ --missing-data 0.5
```

The output as follows. Note that the last two sites were removed because they had more than 50% missing data.

```
>seq1
ATGCAT-
>seq2
ATGCATA
>seq3
ATGCAA-
>seq4
ATGCATA
```

## Detailed usage[​](#detailed-usage "Direct link to Detailed usage")

### Filtering based on the proportion of missing data[​](#filtering-based-on-the-proportion-of-missing-data "Direct link to Filtering based on the proportion of missing data")

To trim alignments, use the `align trim` command with the following options:

```
segul align trim --dir <alignment-dir> --missing-data <value>
```

For example:

```
segul align trim --dir alignments/ --missing-data 0.5
```

### Filtering based on parsimony informative sites[​](#filtering-based-on-parsimony-informative-sites "Direct link to Filtering based on parsimony informative sites")

To trim based on the minimum threshold of parsimony informative sites, use the `--pinf` option:

```
segul align trim --dir <alignment-dir> --pinf <value>
```

For example, this command will retain sites with at least 50 parsimony informative sites:

```
segul align trim --dir alignments/ --pinf 50
```

### Amino acid alignment trimming[​](#amino-acid-alignment-trimming "Direct link to Amino acid alignment trimming")

If the input is amino acid sequences, you need to use the `datatype aa` option. For example:

```
segul align trim --dir alignments/ --missing-data 0.5 --datatype aa
```

### Specifying the output directory and format[​](#specifying-the-output-directory-and-format "Direct link to Specifying the output directory and format")

By default, the output directory is `Align-Trim`. You can change the output directory name using the `--output` or `-o` option. For example, to name the output directory `align-trim`, use the command below:

```
segul align trim --dir alignments/ --output align-trim
```

To specify the output format, use the `--output-format` or `-F` option. The default output format is NEXUS. For example, to change the output format to FASTA, use the command below:

```
segul align trim --dir alignments/ --output-format fasta
```

[Edit this page](https://github.com/hhandika/segui/tree/main/website/docs/cli-usage/align-trim.md)

[Previous

Alignment Summary](/docs/cli-usage/align-summary)[Next

Unalign Alignments](/docs/cli-usage/align-unalign)

* [Quick example](#quick-example)
* [Detailed usage](#detailed-usage)
  + [Filtering based on the proportion of missing data](#filtering-based-on-the-proportion-of-missing-data)
  + [Filtering based on parsimony informative sites](#filtering-based-on-parsimony-informative-sites)
  + [Amino acid alignment trimming](#amino-acid-alignment-trimming)
  + [Specifying the output directory and format](#specifying-the-output-directory-and-format)

Copyright © 2026 H. Handika & J. A. Esselstyn.