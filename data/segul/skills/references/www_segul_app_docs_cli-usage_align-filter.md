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
* Alignment Filtering

On this page

# Alignment Filtering

In a typical phylogenomic workflow, you may want to filter problematic alignments before running a phylogenetic analysis. This feature provides multiple ways to filter alignments.

Available filtering methods (required SEGUL v0.23.0 and later):

1. Min or max alignment length
2. Data matrix completeness
3. Min, max, or percentage of parsimony informative sites
4. Proportion of missing data
5. Minimum taxon counts
6. Taxon ID

info

For versions prior to v0.23.0, SEGUL only support these filtering methods:

* Minimal alignment length
* Data matrix completeness
* Minimum parsimony informative sites
* Proportion of missing data

To update SEGUL to the latest version, follow the [Installation Guide](/docs/installation/update#segul-cli).

tip

This page is quite long due to the detailed explanations and examples for each filtering method. You can use the table of contents on the right side (desktop) or the dropdown menu at the top (mobile) of the page to navigate to specific sections.

## Quick example[​](#quick-example "Direct link to Quick example")

The command is structured as below:

```
segul align filter <input-option> [alignment-path] <filtering-option> <value>
```

To filter alignments in the `alignments/` directory with a minimal length of 500 bp, use the command below:

```
segul align filter --dir alignments/ --input-format nexus --min-len 500
```

All command examples:

```
# Minimum alignment length
segul align filter --dir alignments/ --input-format nexus --min-len 500

# Maximum alignment length
segul align filter --dir alignments/ --input-format nexus --max-len 800

# Data matrix completeness
segul align filter --dir alignments/ --input-format nexus --percent 0.8

# Using multiple data matrix completeness values
segul align filter --dir segul --dir alignments/ --input-format nexus --npercent 0.9 0.8 0.75

# Minimum parsimony informative sites
segul align filter --dir alignments/ --input-format nexus --min-pinf 50

# Maximum parsimony informative sites
segul align filter --dir alignments/ --input-format nexus --max-pinf 200

# Percentage of minimal parsimony informative sites
segul align filter --dir alignments/ --input-format nexus --percent-inf 0.8

# Proportion of missing data
segul align filter --dir alignments/ --missing-data 0.3

# Minimum taxon counts
segul align filter --dir alignments/ --min-ntax 100

# Taxon ID
segul align filter --dir alignments/ --taxon-id path/to/taxon_ids.txt
```

To check the available filtering options and other command arguments, use the `--help` option:

```
segul align filter --help
```

info

SEGUL will never overwrite your original datasets. When filtering alignments, it will copy the alignments that match the filtering parameters to its output directory. You can also concatenate the resulting alignments instead. This is particularly useful for quickly estimating a species tree based on the filtered alignments.

tip

We recommend starting with [the sequence filtering method](/docs/cli-usage/sequence-filter) before using the alignment filtering method. This step will help clean your alignments from problematic sequences, which could result in alignments containing low sample coverage. You can then use the alignment filtering method with the `--percent` option ([see below](#filtering-based-on-data-matrix-completeness)) to filter out those alignments.

## Detailed usage[​](#detailed-usage "Direct link to Detailed usage")

### Filtering based on alignment length[​](#filtering-based-on-alignment-length "Direct link to Filtering based on alignment length")

#### Minimum alignment length[​](#minimum-alignment-length "Direct link to Minimum alignment length")

You can filter alignments based on their length using the `--min-len` option. For example, if you want to filter alignments in the `alignments/` below:

```
alignments/
├── locus_1.nexus
├── locus_2.nexus
└── locus_3.nexus
```

To filter alignments with a minimum length of 200 bp, use the command below:

```
segul align filter --dir alignments/ --input-format nexus --min-len 200
```

#### Maximum alignment length[​](#maximum-alignment-length "Direct link to Maximum alignment length")

To filter alignments based on the maximum length, use the `--max-len` option. For example:

```
segul align filter --dir alignments/ --input-format nexus --max-len 800
```

info

For versions prior to v0.23.0, Use the following command:

```
segul align filter --dir alignments/ --len 500
```

### Filtering based on data matrix completeness[​](#filtering-based-on-data-matrix-completeness "Direct link to Filtering based on data matrix completeness")

This filtering method is based on the percentage of minimal taxa present in your alignments, similar to `phyluce_align_get_only_loci_with_min_taxa` in [Phyluce pipeline](https://phyluce.readthedocs.io/en/latest/tutorials/tutorial-1.html#final-data-matrices). For example, given a collection of alignments with 100 taxa with 90 percent completeness, SEGUL will filter alignments containing at least 90 taxa.

We use the `--percent` option with input in decimals to filter alignments based on data matrix completeness. For example, here we will filter alignments in the `alignments` directory with 80 percent data matrix completeness:

```
segul align filter --dir alignments/ --input-format nexus --percent 0.8
```

You can also write the percentage as `.8`, and it will parse the same way you write it with 0.

#### Using multiple data matrix completeness values[​](#using-multiple-data-matrix-completeness-values "Direct link to Using multiple data matrix completeness values")

Sometimes, we want to build phylogenetic trees with different data matrix completeness. Using `segul`, we can do it in a single command using the `npercent` option:

```
segul align filter --dir segul --dir alignments/ --input-format nexus --npercent 0.9 0.8 0.75
```

SEGUL will create an output directory for each data matrix completeness value, with the percentage values suffixed on the directory names. For the example above, it will create three directories named `alignments_90p`, `alignments_80p`, and `alignments_75p`.

### Filtering based on parsimony informative sites[​](#filtering-based-on-parsimony-informative-sites "Direct link to Filtering based on parsimony informative sites")

SEGUL provides two ways of filtering based on parsimony informative sites:

#### Minimum informative sites[​](#minimum-informative-sites "Direct link to Minimum informative sites")

This option filters alignments that contain at least the specified number of informative sites.

For example, in the command below, we will filter alignments in the `alignments` directory with a minimum containing 50 parsimony informative sites:

info

For versions prior to v0.23.0, use the following command:

```
segul align filter --dir alignments/ --input-format nexus --pinf 50
```

#### Maximum informative sites[​](#maximum-informative-sites "Direct link to Maximum informative sites")

info

Supported in SEGUL v0.23.0 and later versions.

To filter alignments based on the maximum number of informative sites, use the `--max-pinf` option. For example:

```
segul align filter --dir alignments/ --input-format nexus --max-pinf 200
```

#### Percentage of minimal parsimony informative sites[​](#percentage-of-minimal-parsimony-informative-sites "Direct link to Percentage of minimal parsimony informative sites")

This value is counted based on the highest number of informative sites on your alignments. It is similar to computing data matrix completeness but based on the number of informative sites. You only need to input the percentage value. SEGUL will determine the highest number of informative sites across all input alignments.

For example, the highest number of informative sites in the input alignments is 100. We will filter with a minimal 80 percent of the highest parsimony informative value. Using the `--percent-inf .8` option, SEGUL will filter alignments with at least containing 80 parsimony informative sites:

```
segul align filter --dir alignments/ --percent-inf 0.8
```

### Filtering based on the proportion of missing data[​](#filtering-based-on-the-proportion-of-missing-data "Direct link to Filtering based on the proportion of missing data")

The proportion of missing data is calculated using the following formula:

```
Proportion of missing data = (Total missing data in alignment) / (Total number of characters in alignment)
```

It works at per alignment level. For example, if an alignment has 1000 characters and 300 of them are missing (gaps or ambiguous characters), the proportion of missing data would be 0.3 (or 30%).

SEGUL will will copy the matching alignments to the output directory. To filter alignments based on the proportion of missing data, use the `--missing-data` option. For example:

```
segul align filter --dir alignments/ --missing-data 0.3
```

### Filtering based on minimum taxon counts[​](#filtering-based-on-minimum-taxon-counts "Direct link to Filtering based on minimum taxon counts")

To filter alignments based on the minimum number of taxa present in each alignment, use the `--min-ntax` option. For example, to filter alignments with at least 100 taxa, use the command below:

```
segul align filter --dir alignments/ --min-ntax 100
```

info

Available in SEGUL v0.23.0 and later versions.

### Filtering based on taxon ID[​](#filtering-based-on-taxon-id "Direct link to Filtering based on taxon ID")

The taxon ID is the same as your sequence ID. To use this feature, you need to provide a text file containing a list of taxon IDs (one taxon ID per line). SEGUL will filter alignments that contain the taxon IDs specified in the file. For example, if you have a file named `taxon_ids.txt` with the following content:

```
taxon_1
taxon_2
taxon_3
```

You can use the following command to filter alignments in the `alignments/` directory that contain these taxon IDs:

```
segul align filter --dir alignments/ --taxon-id path/to/taxon_ids.txt
```

info

Available in SEGUL v0.23.0 and later versions.

### Specifying output directories[​](#specifying-output-directories "Direct link to Specifying output directories")

By default, SEGUL output directories for filtering are based on the input directory names suffixed with filtering values. The format is as follows:

```
[input-dir](underscore)[filtering-values]
```

For example, if your input directory is named `alignments/` and the filtering option is a minimal alignment length of 500 bp, the output directory will be `alignments_500bp`.

The `--output` or `-o` option allows you to change the prefix names of the output directory.

### Concatenating the results[​](#concatenating-the-results "Direct link to Concatenating the results")

By default, SEGUL copies the alignments that match the filtering option. Instead of copying the files, you can concatenate them using the `--concat` flag. All options for the [`align concat`](/docs/cli-usage/align-concat) subcommand are available for this task. You are, however, required to specify the `--output` or `-o` name and the partition format `--partition-format` or `-p` option.

For example, in the command below, we will filter based on alignments with a length of 500 bp and will concat the result:

```
segul align filter --dir alignments/ --input-format nexus --min-len 500 --concat --partition-format raxml -o concat_alignment
```

note

For versions prior to v0.23.0, use `--part` to specify the partition format:

```
segul align filter --dir alignments/ --input-format nexus --len 500 --concat --part raxml -output concat_alignment
```

### Other input options[​](#other-input-options "Direct link to Other input options")

You can use `--input` or `-i` to specify a single alignment file or multiple alignments using [wildcards](https://en.wikipedia.org/wiki/Wildcard_character). For example:

```
segul align filter --input alignments/*.fasta --min-len 300
```

### For Amino Acid alignments[​](#for-amino-acid-alignments "Direct link to For Amino Acid alignments")

By default, SEGUL assumes the input alignments are DNA sequences. It will fails to run if the data is amino acid sequences. To filter amino acid alignments, use the `--datatype aa` option. For example:

```
segul align filter --dir alignments/ --input-format fasta --datatype aa --min-len 300
```

[Edit this page](https://github.com/hhandika/segui/tree/main/website/docs/cli-usage/align-filter.md)

[Previous

Alignment Conversion](/docs/cli-usage/align-convert)[Next

Alignment Partition Conversion](/docs/cli-usage/align-partition)

* [Quick example](#quick-example)
* [Detailed usage](#detailed-usage)
  + [Filtering based on alignment length](#filtering-based-on-alignment-length)
  + [Filtering based on data matrix completeness](#filtering-based-on-data-matrix-completeness)
  + [Filtering based on parsimony informative sites](#filtering-based-on-parsimony-informative-sites)
  + [Filtering based on the proportion of missing data](#filtering-based-on-the-proportion-of