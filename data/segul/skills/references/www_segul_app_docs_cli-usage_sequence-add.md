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
* Sequence Addition

On this page

# Sequence Addition

Add sequences to existing sequence files/alignments. Allow adding sequences from multiple sources to multiple destinations. The file formats for the source and destinations can be different, but SEGUL requires matching file names for both to add the sequences. If the destination files are aligned, all the output sequences will be unaligned. We recommend using [MAFFT](https://mafft.cbrc.jp/alignment/software/) to align the resulting sequence files.

info

This feature is available in SEGUL v0.23.0 and later versions. To check your SEGUL version, run in your terminal:

```
segul --version
# Compatible version example:
# segul 0.23.0
```

## Quick Start[​](#quick-start "Direct link to Quick Start")

To add sequences, use the `add` command with the following options:

```
segul sequence add -d <source-sequence-dir> --destination-dir <destination-sequence-dir>
```

For example:

```
segul sequence add -d source-sequence/ --destination-dir destination-sequence/
```

## Specify the input format[​](#specify-the-input-format "Direct link to Specify the input format")

The command above will look for any FASTA, NEXUS, or PHYLIP format sequences in the source directory and add them to the destination directory. You can specify the input format using the `--input-format` option. For example, to add sequences in NEXUS format, use the command below:

```
segul sequence add -d <source-sequence-dir> --destination-dir <destination-sequence-dir> --input-format nexus
```

You can specify the destination format using the `--destination-format` option. For example, to add sequences in NEXUS format to the destination directory in FASTA format, use the command below:

```
segul sequence add -d <source-sequence-dir> --destination-dir <destination-sequence-dir> --input-format nexus --destination-format fasta
```

## Specify the output directory name and format[​](#specify-the-output-directory-name-and-format "Direct link to Specify the output directory name and format")

By default, the output directory will be named `Sequence-Addition`. You can change the output directory name using the `--output` or `-o` option. For example, to name the output directory `seq-add`, use the command below:

```
segul sequence add -d <source-sequence-dir> --destination-dir <destination-sequence-dir> --output seq-add
```

The output format will be in interleaved FASTA format. The other option is in sequential FASTA format. Use the `--output-format fasta` or `-F fasta` option to change the output to sequential FASTA format. For example:

```
segul sequence add -d <source-sequence-dir> --destination-dir <destination-sequence-dir> --output-format fasta
```

## Output only the added sequences[​](#output-only-the-added-sequences "Direct link to Output only the added sequences")

By default, SEGUL will output all sequences in the destination directory. If the destination directory format differs from the output format, all the output will be changed to the selected output format. If you only want to output files with the added sequences, use the `added-only` flag. For example:

```
segul sequence add -d <source-sequence-dir> --destination-dir <destination-sequence-dir> --added-only
```

[Edit this page](https://github.com/hhandika/segui/tree/main/website/docs/cli-usage/sequence-add.md)

[Previous

Genomic Summary](/docs/cli-usage/genomic-summary)[Next

Sequence Extraction](/docs/cli-usage/sequence-extract)

* [Quick Start](#quick-start)
* [Specify the input format](#specify-the-input-format)
* [Specify the output directory name and format](#specify-the-output-directory-name-and-format)
* [Output only the added sequences](#output-only-the-added-sequences)

Copyright © 2026 H. Handika & J. A. Esselstyn.