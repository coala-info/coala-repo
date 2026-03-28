# [BEDOPS v2.4.41](../../../../index.html%20)

* ←
  [6.3.2. Compression](../compression.html "Previous document")
* [6.3.2.2. unstarch](unstarch.html "Next document")
  →

* [Home](../../../../index.html)
* [6. Reference](../../../reference.html)
* [6.3. File management](../../file-management.html)
* [6.3.2. Compression](../compression.html)

# 6.3.2.1. starch[¶](#starch "Permalink to this headline")

With high-throughput sequencing generating large amounts of genomic data, archiving can be a critical part of an analysis toolkit. BEDOPS includes the `starch` utility to provide a method for efficient and lossless compression of [UCSC BED-formatted data](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) into the [Starch v2 format](starch-specification.html#starch-specification).

Starch v2 archives can be extracted with [unstarch](unstarch.html#unstarch) to recover the original BED input, or processed as inputs to [bedops](../../set-operations/bedops.html#bedops) and [bedmap](../../statistics/bedmap.html#bedmap), where set operations and element calculations can be performed directly and without the need for intermediate file extraction.

The [starch](#starch) utility includes [large file support](http://en.wikipedia.org/wiki/Large_file_support) on 64-bit operating systems, enabling compression of more than 2 GB of data (a common restriction on 32-bit systems).

Data can be stored with one of two open-source backend compression methods, either `bzip2` or `gzip`, providing the end user with a reasonable tradeoff between speed and storage performance that can be useful for working with constrained storage situations or slower hardware.

## 6.3.2.1.1. Inputs and outputs[¶](#inputs-and-outputs "Permalink to this headline")

### 6.3.2.1.1.1. Input[¶](#input "Permalink to this headline")

As with other BEDOPS utilities, [starch](#starch) takes in [sorted](../sorting/sort-bed.html#sort-bed) BED data as input. You can use [sort-bed](../sorting/sort-bed.html#sort-bed) to sort BED data, piping it into [starch](#starch) as standard input (see [Example](#starch-example) section below).

Note

While more than three columns may be specified, most of the space savings in the Starch format are derived from from a pre-processing step on the coordinates. Therefore, minimizing or removing unnecessary columnar data from the fourth column on (*e.g.*, with `cut -f1-3` or similar) can help improve compression efficiency considerably.

### 6.3.2.1.1.2. Output[¶](#output "Permalink to this headline")

This utility outputs a [Starch v2-formatted](starch-specification.html#starch-specification) archive file.

## 6.3.2.1.2. Requirements[¶](#requirements "Permalink to this headline")

The [starch](#starch) tool requires data in a relaxed variation of the BED format as described by [UCSC’s browser documentation](http://genome.ucsc.edu/FAQ/FAQformat.html#format1). BED data should be sorted before compression, *i.e.* with BEDOPS [sort-bed](../sorting/sort-bed.html#sort-bed).

At a minimum, three columns are required to specify the chromosome name and start and stop positions. Additional columns may be specified, containing up to 128 kB of data per row (including tab delimiters).

## 6.3.2.1.3. Usage[¶](#usage "Permalink to this headline")

Use the `--help` option to list all options:

```
starch
 citation: http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract
 binary version: 2.4.41 (typical) (creates archive version: 2.2.0)
 authors:  Alex Reynolds and Shane Neph

USAGE: starch [ --note="foo bar..." ]
              [ --bzip2 | --gzip ]
              [ --omit-signature ]
              [ --report-progress=N ]
              [ --header ] [ <unique-tag> ] <bed-file>

    * BED input must be sorted lexicographically (e.g., using BEDOPS sort-bed).
    * Please use '-' to indicate reading BED data from standard input.
    * Output must be directed to a regular file.
    * The bzip2 compression type makes smaller archives, while gzip extracts
      faster.

    Process Flags
    --------------------------------------------------------------------------
    --note="foo bar..."   Append note to output archive metadata (optional).

    --bzip2 | --gzip      Specify backend compression type (optional, default
                          is bzip2).

    --omit-signature      Skip generating per-chromosome data integrity signature
                          (optional, default is to generate signature).

    --report-progress=N   Report compression progress every N elements per
                          chromosome to standard error stream (optional)

    --header              Support BED input with custom UCSC track, SAM or VCF
                          headers, or generic comments (optional).

    <unique-tag>          Optional. Specify unique identifier for transformed
                          data.

    --version             Show binary version.

    --help                Show this usage message.
```

## 6.3.2.1.4. Options[¶](#options "Permalink to this headline")

### 6.3.2.1.4.1. Backend compression type[¶](#backend-compression-type "Permalink to this headline")

Use the `--bzip2` or `--gzip` operators to use the `bzip2` or `gzip` compression algorithms on transformed BED data. By default, [starch](#starch) uses the `bzip2` method.

### 6.3.2.1.4.2. Note[¶](#note "Permalink to this headline")

Use the `--note="xyz..."` option to add a custom string that describes the archive. This data can be retrieved with `unstarch --note`.

Tip

Examples of usage might include a description of the experiment associated with the data, a URL to a UCSC Genome Browser session, or a bar code or other unique identifier for internal lab or LIMS use.

Note

The only limitation on the length of a note is the command-line shell’s maximum argument length parameter (as found on most UNIX systems with the command `getconf ARG_MAX`) minus the length of the non- `--note="..."` command components. On most desktop systems, this value will be approximately 256 kB.

### 6.3.2.1.4.3. Per-chromosome data integrity signature[¶](#per-chromosome-data-integrity-signature "Permalink to this headline")

By default, a data integrity signature is generated for each chromosome. This can be used to verify if chromosome streams from two or more Starch archives are identical, or used to test the integrity of a chromosome, to identify potential data corruption.

Generating this signature adds to the computational cost of compression, or an integrity signature may not be useful for all archives. Add the `--omit-signature` option, if the compression time is too high or the data integrity signature is not needed.

### 6.3.2.1.4.4. Compression progress[¶](#compression-progress "Permalink to this headline")

To optionally track the progress of compression, use the `--report-progress=N` option, specifying a positive integer `N` to report the compression of the *N* -th element for the current chromosome. The report is printed to the standard error stream.

Note

For instance, specifying a value of `1` reports the compression of every input element of all chromosomes, while a value of `1000` would report the compression of every 1000th element of the current chromosome.

### 6.3.2.1.4.5. Headers[¶](#headers "Permalink to this headline")

Add the `--header` flag if the BED data being compressed contain [extra header data](http://genome.ucsc.edu/FAQ/FAQformat.html#format1.7) that are exported from a UCSC Genome Browser session.

Note

If the BED data contain custom headers and `--header` is not specified, [starch](#starch) will be unable to read chromosome data correctly and exit with an error state.

### 6.3.2.1.4.6. Unique tag[¶](#unique-tag "Permalink to this headline")

Adding a `<unique-tag>` string replaces portions of the filename key in the archive’s [stream metadata](starch-specification.html#starch-archive-metadata-stream).

Note

This feature is largely obsolete and included for legacy support. It is better to use the `--note="xyz..."` option to add identifiers or other custom data.

## 6.3.2.1.5. Example[¶](#example "Permalink to this headline")

To compress unsorted BED data (or data of unknown sort order), we feed [starch](#starch) a [sorted](../sorting/sort-bed.html#sort-bed) stream, using the hyphen (`-`) to specify standard input:

```
$ sort-bed unsorted.bed | starch - > sorted.starch
```

This creates the file `sorted.starch`, which uses the `bzip2` algorithm to compress transformed BED data from a sorted permutation of data in `unsorted.bed`. No note or custom tag data is added.

It is possible to speed up the compression of a BED file by using a cluster. Start by reviewing our [starchcluster](../../../usage-examples/starchcluster.html#starchcluster) script.

[![Logo](../../../../_static/logo_with_label_v3.png)](../../../../index.html)

### [Table of Contents](../../../../index.html)

* 6.3.2.1. starch
  + [6.3.2.1.1. Inputs and outputs](#inputs-and-outputs)
    - [6.3.2.1.1.1. Input](#input)
    - [6.3.2.1.1.2. Output](#output)
  + [6.3.2.1.2. Requirements](#requirements)
  + [6.3.2.1.3. Usage](#usage)
  + [6.3.2.1.4. Options](#options)
    - [6.3.2.1.4.1. Backend compression type](#backend-compression-type)
    - [6.3.2.1.4.2. Note](#note)
    - [6.3.2.1.4.3. Per-chromosome data integrity signature](#per-chromosome-data-integrity-signature)
    - [6.3.2.1.4.4. Compression progress](#compression-progress)
    - [6.3.2.1.4.5. Headers](#headers)
    - [6.3.2.1.4.6. Unique tag](#unique-tag)
  + [6.3.2.1.5. Example](#example)

* ←
  [6.3.2. Compression](../compression.html "Previous document")
* [6.3.2.2. unstarch](unstarch.html "Next document")
  →

* [Home](../../../../index.html)
* [6. Reference](../../../reference.html)
* [6.3. File management](../../file-management.html)
* [6.3.2. Compression](../compression.html)

© 2011-2022, Shane Neph, Alex Reynolds.
Created using [Sphinx](http://sphinx-doc.org/)
1.8.6
with the [better](http://github.com/irskep/sphinx-better-theme) theme.