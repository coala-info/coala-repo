[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* [Genotypes](genotypes.html)
* Haplotypes
  + [Motivation](#motivation)
  + [Overview](#overview)
  + [`#` Comment line](#comment-line)
  + [Header line](#header-line)
    - [Metadata lines in the header](#metadata-lines-in-the-header)
    - [Declaring extra fields in the header](#declaring-extra-fields-in-the-header)
  + [`H` Haplotype](#h-haplotype)
  + [`R` Repeat](#r-repeat)
  + [`V` Variant](#v-variant)
  + [Examples](#examples)
  + [Compressing and indexing](#compressing-and-indexing)
  + [Querying an indexed file](#querying-an-indexed-file)
  + [Extra fields](#extra-fields)
    - [transform](#transform)
      * [`H` Haplotype](#id2)
      * [`V` Variant](#id3)
    - [simphenotype](#simphenotype)
      * [`H` Haplotype](#id5)
      * [`R` Repeat](#id6)
      * [`V` Variant](#id7)
  + [Changelog](#changelog)
    - [v0.2.0](#v0-2-0)
    - [v0.1.0](#v0-1-0)
    - [v0.0.1](#v0-0-1)
* [Phenotypes and Covariates](phenotypes.html)
* [Linkage disequilibrium](ld.html)
* [Summary Statistics](linear.html)
* [Causal SNPs](snplist.html)
* [Breakpoints](breakpoints.html)
* [Sample Info](sample_info.html)
* [Models](models.html)
* [Maps](maps.html)

Commands

* [simgenotype](../commands/simgenotype.html)
* [simphenotype](../commands/simphenotype.html)
* [karyogram](../commands/karyogram.html)
* [transform](../commands/transform.html)
* [index](../commands/index.html)
* [clump](../commands/clump.html)
* [ld](../commands/ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* Haplotypes
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/haplotypes.rst)

---

# Haplotypes[](#haplotypes "Link to this heading")

This document describes our custom file format specification for haplotypes: the `.hap` file.

![The .hap file format](https://github.com/CAST-genomics/haptools/assets/23412689/c4177e92-e1a3-4ed0-8d8c-bd179ee9f0e3)

## Motivation[](#motivation "Link to this heading")

`.hap` files are optimized to store information about haplotypes and the collections of alleles that they are composed of. Notably, they are not designed to store any kind of per-sample information. Instead, [the transform command](../commands/transform.html) can be used to encode each haplotype as a biallelic variant in a VCF, BCF, or PGEN file. Our intent is for the `.hap` file format to play a supporting role to these per-sample formats.

Our file format addresses unique challenges. As far as we know, the only file format to store equivalent kinds of information as our custom format is [PLINK 1.9 .blocks.det file](https://www.cog-genomics.org/plink/1.9/formats#blocks) file. However, it may also be possible to store the columns of a `.hap` file within the INFO fields of a VCF. Compared to both of these formats, our file format has a few key advantages:

1. Unlike `.blocks.det` files, our format is designed to be indexed and queried efficiently via tabix. Our design offers an additional level of querying that is not possible for haplotypes encoded within a VCF.
2. Our format is more flexible than a `.blocks.det` or VCF file. In addition to storing SNP alleles within a `.hap` file, our format allows for the storage of either haplotype-level metadata (e.g. local ancestry labels, effect sizes) or allele-level metadata (e.g. custom scores or other information).
3. Our format is easier to generate or parse using simple unix commands or ad-hoc scripts because it uses a single field delimiter and guarantees a consistent number of fields for each line in the file.

Please refer to the supplement of our manuscript for a thorough justification of our file format.

## Overview[](#overview "Link to this heading")

The `.hap` format describes a tab-separated file composed of different types of lines. The first field of each line is a single, uppercase character denoting the type of line. The following line types are supported.

| Type | Description |
| --- | --- |
| # | Comment/Header |
| H | Haplotype |
| R | Repeat |
| V | Variant |

Each line type (besides `#`) has a set of mandatory fields described below. Additional “extra” fields can be appended to these to customize the file.

## `#` Comment line[](#comment-line "Link to this heading")

Comment lines begin with `#` and are ignored. They can appear anywhere in a `.hap` file.

It is best practice to immediately follow all comment lines with a space. Otherwise, the line may be at risk of being interpreted as part of the header, especially if the file is sorted.

## Header line[](#header-line "Link to this heading")

Header lines begin with `#` and must precede all other line types, except for comment lines. Comment lines can be interleaved with the header lines in any order.

There are two types of header lines: those with file metadata and those that declare extra fields.

Header lines themselves can appear in any order. We recommend putting all of the metadata lines before the extra field declarations, as a best practice.

### Metadata lines in the header[](#metadata-lines-in-the-header "Link to this heading")

Metadata lines have the following, tab-separated fields:

1. A header symbol `#`
2. A unique metadata name
3. Value(s)

It is best practice to include a metadata line declaring the version of the haplotype format that your file uses. Otherwise, your file will be assumed to use the latest version of the specification.

```
#     version 0.1.0
```

If you are declaring any extra fields (see the next section), then you should include a metadata line that declares the order of the extra fields. For example, if the `H` haplotype lines in your file have two extra fields, “ancestry” and “beta”, that appear in that order, you would write

```
#     orderH  ancestry        beta
```

### Declaring extra fields in the header[](#declaring-extra-fields-in-the-header "Link to this heading")

Any extra fields in the file must be declared in the header. To declare an extra field, create a tab-separated line containing the following fields:

1. A header symbol followed by a line type symbol (ex: `#H`, `#R`, `#V`)
2. Field name
3. Python format string (ex: ‘d’ for int, ‘s’ for string, or ‘.3f’ for a float with 3 decimals)
4. Description

Note that the first field must follow the `#` symbol immediately (ex: `#H`, `#R`, `#V`).

## `H` Haplotype[](#h-haplotype "Link to this heading")

Haplotypes contain the following attributes:

| Column | Field | Type | Description |
| --- | --- | --- | --- |
| 1 | Chromosome | string | The contig that this haplotype belongs on |
| 2 | Start Position | int | The start position of this haplotype on this contig |
| 3 | End Position | int | The end position of this haplotype on this contig |
| 4 | Haplotype ID | string | Uniquely identifies a haplotype |

Note

It is not currently possible to encode haplotypes that span more than one contig.

## `R` Repeat[](#r-repeat "Link to this heading")

Repeats contain the following attributes:

| Column | Field | Type | Description |
| --- | --- | --- | --- |
| 1 | Chromosome | string | The contig that this repeat belongs on |
| 2 | Start Position | int | The start position of this repeat on this contig |
| 3 | End Position | int | The end position of this repeat on this contig |
| 4 | Repeat ID | string | Uniquely identifies a repeat |

Note

Repeats cannot store Variants and only encode for a single repeat per line.
Also, the set of Repeat IDs must be distinct from the set of Haplotype IDs. A Haplotype line can never have the same ID as a Repeat line, but a Haplotype (or Repeat) line *can* have the same ID as a Variant line.

## `V` Variant[](#v-variant "Link to this heading")

Each variant line belongs to a particular haplotype. These lines contain the following attributes:

| Column | Field | Type | Description |
| --- | --- | --- | --- |
| 1 | Haplotype ID | string | Identifies the haplotype to which this variant belongs |
| 2 | Start Position | int | The start position of this variant on its contig |
| 3 | End Position | int | The end position of this variant on its contig  Usually the same as the Start Position |
| 4 | Variant ID | string | The unique ID for this variant, as defined in the genotypes file |
| 5 | Allele | string | The allele of this variant within the haplotype |

## Examples[](#examples "Link to this heading")

You can find an example of a `.hap` file without any extra fields in [tests/data/basic.hap](https://github.com/cast-genomics/haptools/blob/main/tests/data/basic.hap):

```
#       version 0.2.0
H       21      26928472        26941960        chr21.q.3365*1
H       21      26938989        26941960        chr21.q.3365*10
H       21      26938353        26938989        chr21.q.3365*11
V       chr21.q.3365*1  26928472        26928472        21_26928472_C_A C
V       chr21.q.3365*1  26938353        26938353        21_26938353_T_C T
V       chr21.q.3365*1  26940815        26940815        21_26940815_T_C C
V       chr21.q.3365*1  26941960        26941960        21_26941960_A_G G
R       21      26941880        26941900        21_26941880_STR
V       chr21.q.3365*10 26938989        26938989        21_26938989_G_A A
V       chr21.q.3365*10 26940815        26940815        21_26940815_T_C T
V       chr21.q.3365*10 26941960        26941960        21_26941960_A_G A
R       21      26939000        26939010        21_26938989_STR
# this comment should be ignored
V       chr21.q.3365*11 26938353        26938353        21_26938353_T_C T
V       chr21.q.3365*11 26938989        26938989        21_26938989_G_A A
R       21      26938353        26938400        21_26938353_STR
```

You can find an example with extra fields added within [tests/data/simphenotype.hap](https://github.com/cast-genomics/haptools/blob/main/tests/data/simphenotype.hap):

```
#       orderH  ancestry        beta
#       version 0.2.0
#H      ancestry        s       Local ancestry
#H      beta    .2f     Effect size in linear model
#R      beta    .2f     Effect size in linear model
H       21      26928472        26941960        chr21.q.3365*1  ASW     0.73
R       21      26938353        26938400        21_26938353_STR 0.45
H       21      26938989        26941960        chr21.q.3365*10 CEU     0.30
H       21      26938353        26938989        chr21.q.3365*11 MXL     0.49
V       chr21.q.3365*1  26928472        26928472        21_26928472_C_A C
V       chr21.q.3365*1  26938353        26938353        21_26938353_T_C T
V       chr21.q.3365*1  26940815        26940815        21_26940815_T_C C
V       chr21.q.3365*1  26941960        26941960        21_26941960_A_G G
V       chr21.q.3365*10 26938989        26938989        21_26938989_G_A A
V       chr21.q.3365*10 26940815        26940815        21_26940815_T_C T
V       chr21.q.3365*10 26941960        26941960        21_26941960_A_G A
V       chr21.q.3365*11 26938353        26938353        21_26938353_T_C T
V       chr21.q.3365*11 26938989        26938989        21_26938989_G_A A
```

## Compressing and indexing[](#compressing-and-indexing "Link to this heading")

We encourage you to sort, bgzip compress, and index your `.hap` file whenever possible. This will reduce both disk usage and the time required to parse the file, but it is entirely optional. You can either use the [index command](../commands/index.html) or the `sort`, `bgzip`, and `tabix` commands.

```
awk '$0 ~ /^#/ {print; next} {print | "sort -k2,4"}' file.hap | bgzip > sorted.hap.gz
tabix -s 2 -b 3 -e 4 sorted.hap.gz
```

In order to properly index the file, the set of IDs in the haplotype lines must be distinct from the set of chromosome names. This is a best practice in unindexed `.hap` files but a requirement for indexed ones.

## Querying an indexed file[](#querying-an-indexed-file "Link to this heading")

You can query an indexed `.hap` file on both the haplotype and variant levels with the following syntax.

```
tabix file.hap.gz REGION
```

For example, to extract all haplotypes between positions 100 and 200 on chromosome `chr19`:

```
tabix file.hap.gz chr19:100-200
```

Or to get all alleles between positions 100 and 200 on the haplotype with ID `hap1`:

```
tabix file.hap.gz hap1:100-200
```

## Extra fields[](#extra-fields "Link to this heading")

Additional fields can be appended to the ends of the haplotype and variant lines as long as they are declared in the header.

### transform[](#transform "Link to this heading")

If you would like to simulate an ancestry-based effect, you should run `transform` with an *ancestry* extra field declared in your `.hap` file.

You can download an example header with an *ancestry* extra field from [tests/data/simphenotype.hap](https://github.com/cast-genomics/haptools/blob/main/tests/data/simphenotype.hap)

```
curl https://raw.githubusercontent.com/cast-genomics/haptools/main/tests/data/simphenotype.hap 2>/dev/null | head -n4
```

#### `H` Haplotype[](#id2 "Link to this heading")

| Column | Field | Type | Description |
| --- | --- | --- | --- |
| 5 | Local Ancestry | string | A population code denoting this haplotype’s ancestral origins |

#### `V` Variant[](#id3 "Link to this heading")

No extra fields are required here.

### simphenotype[](#simphenotype "Link to this heading")

The *beta* extra field should be declared for your `.hap` file to be compatible with the `simphenotype` subcommand.

You can download an example header with a *beta* extra field from [tests/data/simphenotype.hap](https://github.com/cast-genomics/haptools/blob/main/tests/data/simphenotype.hap)

```
curl https://raw.githubusercontent.com/cast-genomics/haptools/main/tests/data/simphenotype.hap 2>/dev/null | head -n4
```

#### `H` Haplotype[](#id5 "Link to this heading")

| Column | Field | Type | Description |
| --- | --- | --- | --- |
| 5 | Effect Size | float | The effect size of this haplotype; for use in `simphenotype` |

#### `R` Repeat[](#id6 "Link to this heading")

| Column | Field | Type | Description |
| --- | --- | --- | --- |
| 5 | Effect Size | float | The effect size of this repeat; for use in `simphenotype` |

#### `V` Variant[](#id7 "Link to this heading")

No extra fields are required here.

## Changelog[](#changelog "Link to this heading")

### v0.2.0[](#v0-2-0 "Link to this heading")

Support for tandem repeats in the specification via a new ‘R’ line type. See [PR #209](https://github.com/CAST-genomics/haptools/pull/209).

Also, `.hap` files no longer need to be sorted by their first field in order to be indexed. See [PR #208](https://github.com/CAST-genomics/haptools/pull/208). We have updated the recommended `sort` command to reflect this. The new command wraps `sort` in a call to `awk` to ensure header lines are kept at the beginning of the file.

All v0.1.0 `.hap`