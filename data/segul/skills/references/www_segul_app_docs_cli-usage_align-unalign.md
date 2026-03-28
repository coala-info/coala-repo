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
* Unalign Alignments

On this page

# Unalign Alignments

Unalign alignments to produce unaligned sequence files.

Under the hood, SEGUL will read the alignment files and remove all gap characters to produce unaligned sequences. SEGUL can do it for thousands of files in a single command.

info

This feature is available in SEGUL v0.23.0 and later versions. To check your SEGUL version, run in your terminal:

```
segul --version
# Compatible version example:
# segul 0.23.0
```

Check the [Installation Guide](/docs/installation/update#segul-cli) to update SEGUL to the latest version.

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

To unalign the sequences, use the following command:

```
segul align unalign --dir alignments/
```

The output will be as follows, with all gap characters removed:

```
>seq1
ATGCATA
>seq2
ATGCATA
>seq3
ATGCAAA
>seq4
ATGCATA
```

## Detailed usage[​](#detailed-usage "Direct link to Detailed usage")

### Unaligning alignments (DNA)[​](#unaligning-alignments-dna "Direct link to Unaligning alignments (DNA)")

To unalign alignments, use the `align unalign` command with the following options. It will automatically detect the input format.

```
segul align unalign --dir <alignment-dir>
```

### Unaligning alignments (Amino Acid)[​](#unaligning-alignments-amino-acid "Direct link to Unaligning alignments (Amino Acid)")

To unalign amino acid alignments, use the `--amino-acid` flag as follows:

```
segul align unalign --dir <alignment-dir> --input-format aa
```

### Specifying output directory[​](#specifying-output-directory "Direct link to Specifying output directory")

By default, the output directory will be named `Align-Unalign` in the current working directory. You can change the output directory name using the `--output` or `-o` option. For example, to name the output directory `unalign-output`, use the command below:

```
segul align unalign --dir <alignment-dir> --output unalign-output
```

note

Due to the nature of unaligning, the output format will always be in FASTA format.

### More ways to specify input files[​](#more-ways-to-specify-input-files "Direct link to More ways to specify input files")

You can also specify input files using the `--input` or `-i` option. This option allows you to provide a single alignment file or multiple alignment files using [wildcards](https://en.wikipedia.org/wiki/Wildcard_character). For example:

```
segul align unalign --input alignments/*.fasta
```

[Edit this page](https://github.com/hhandika/segui/tree/main/website/docs/cli-usage/align-unalign.md)

[Previous

Alignment Trimming](/docs/cli-usage/align-trim)[Next

Multi Alignment Format Conversion](/docs/cli-usage/maf-convert)

* [Detailed usage](#detailed-usage)
  + [Unaligning alignments (DNA)](#unaligning-alignments-dna)
  + [Unaligning alignments (Amino Acid)](#unaligning-alignments-amino-acid)
  + [Specifying output directory](#specifying-output-directory)
  + [More ways to specify input files](#more-ways-to-specify-input-files)

Copyright © 2026 H. Handika & J. A. Esselstyn.