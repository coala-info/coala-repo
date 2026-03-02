[MACS3](../index.html)

* [INSTALL Guide For MACS3](INSTALL.html)
* [Subcommands](subcommands_index.html)
  + [callpeak](callpeak.html)
  + [callvar](callvar.html)
  + [hmmratac](hmmratac.html)
  + [bdgbroadcall](bdgbroadcall.html)
  + [bdgcmp](bdgcmp.html)
  + [bdgdiff](bdgdiff.html)
  + [bdgopt](bdgopt.html)
  + [bdgpeakcall](bdgpeakcall.html)
  + [cmbreps](cmbreps.html)
  + filterdup
    - [Overview](#overview)
    - [Detailed Description](#detailed-description)
    - [Command Line Options](#command-line-options)
    - [Example Usage](#example-usage)
  + [pileup](pileup.html)
  + [predictd](predictd.html)
  + [randsample](randsample.html)
  + [refinepeak](refinepeak.html)
* [File Formats](fileformats_index.html)
* [Tutorial](tutorial.html)
* [Common Q & A](qa.html)
* [Contributor Covenant Code of Conduct](../CODE_OF_CONDUCT.html)
* [Contributing to MACS project](../CONTRIBUTING.html)
* [MACS3 API reference](api/index.html)

[MACS3](../index.html)

* [Subcommands](subcommands_index.html)
* filterdup
* [View page source](../_sources/docs/filterdup.md.txt)

---

# filterdup[](#filterdup "Link to this heading")

## Overview[](#overview "Link to this heading")

The `filterdup` command is part of the MACS3 suite of tools and is
used on alignment files to remove duplicate reads.

## Detailed Description[](#detailed-description "Link to this heading")

The `filterdup` command takes an input alignment file and produces an
output file in BED format with duplicate reads removed according to
the setting. When the input is in BAMPE format (BAM file from aligning
paired-end data), it will produce a BEDPE format file where each row
represent a read-pair.

The `filteredup` command can also be used to convert any acceptable
format of MACS3 to BED or BEDPE (in case of `-f BAMPE`) format, if you
use `--keep-dup all` option.

Please note that, when writing BED format output for single-end
dataset, MACS3 assume all the reads having the same length either from
`-s` setting or from auto-detection.

## Command Line Options[](#command-line-options "Link to this heading")

Here is a brief overview of the command line options:

* `-i` or `--ifile`: The input alignment file. If multiple files are
  given as ‘-t A B C’, then they will all be read and pooled. REQUIRED.
* `-f`or `--format`: The format of the alignment file. Options
  include: “AUTO”, “BED” or “ELAND” or “ELANDMULTI” or “ELANDEXPORT”
  or “SAM” or “BAM” or “BOWTIE” or “BAMPE” or “BEDPE”. The default
  AUTO option will let `filterdup` decide which format the file
  is. Please check the [`callpeak`](callpeak.html) for detail. Choices
  can be `ELAND/ELANDMULTI/ELANDEXPORT/SAM/BAM/BOWTIE` or
  `BAMPE/BEDPE`. DEFAULT: `AUTO`
* `-g` or `--gsize`: Please check [`callpeak`](callpeak.html) for
  detail. DEFAULT:hs
* `-s` or `--tsize`: The tag size. This will override the auto
  detected tag size. DEFAULT: Not set
* `-p` or `--pvalue`: The pvalue cutoff for binomial distribution
  test. DEFAULT:1e-5
* `--keep-dup`: The number of duplicates to keep. It controls the
  ‘macs3 filterdup’ behavior towards duplicate tags/pairs at the exact
  same location – the same coordination and the same strand. If the
  value is `auto`, `filterdup` will calculate the maximum tags at the
  exact same location based on a binomal distribution using given `-p`
  as pvalue cutoff; and the `all` value will keep every tags (useful
  if you only want to convert formats). If an integer is given, at
  most this number of tags will be kept at the same location. Note,
  MACS3 `callpeak` function uses `--keep-dup=1` as default. Note, if
  you’ve used `samtools` or `picard` to flag reads as ‘PCR/Optical
  duplicate’ in bit 1024, MACS3 will still read them although the
  reads may be decided by MACS3 as duplicate later. Default: `auto`
* `--buffer-size`: The buffer size for incrementally increasing
  internal array size to store reads alignment information. In most
  cases, you don’t have to change this parameter. However, if there
  are large number of chromosomes/contigs/scaffolds in your alignment,
  it’s recommended to specify a smaller buffer size in order to
  decrease memory usage (but it will take longer time to read
  alignment files). Minimum memory requested for reading an alignment
  file is about `# of CHROMOSOME * BUFFER_SIZE * 8` Bytes. DEFAULT:
  100000
* `--verbose`: The verbose level. 0: only show critical message, 1:
  show additional warning message, 2: show process information, 3:
  show debug messages. If you want to know where are the duplicate
  reads, use 3. DEFAULT:2
* `--outdir`: If specified all output files will be written to that
  directory. Default: the current working directory
* `-o` or `--ofile`: The output BED file name. If not specified, will
  write to standard output. Note, if the input format is BAMPE or
  BEDPE, the output will be in BEDPE format. DEFAULT: stdout
* `-d` or `--dry-run`: When set, filterdup will only output numbers
  instead of writing output files, including maximum allowable
  duplicates, total number of reads before filtering, total number of
  reads after filtering, and redundant rate. Default: not set

## Example Usage[](#example-usage "Link to this heading")

Here is an example of how to use the `filterdup` command:

```
macs3 filterdup -i input.bam -o output.bed --gsize hs --format AUTO --keep-dup 1 --buffer-size 100000
```

In this example, the program will remove duplicate reads from the
`input.bam` file and write the result to `output.bed`. The mappable
genome size is set to `hs` (Homo Sapiens), the format of the input
file is determined automatically, and the program keeps only one
duplicate.

Here is an example to convert BAMPE file into BEDPE. Please note that
`-f BAMPE` and `--keep-dup all` are both necessary for format
conversion:

```
macs3 filterdup -i input.bam -o output.bedpe -f BAMPE --keep-dup all
```

[Previous](cmbreps.html "cmbreps")
[Next](pileup.html "pileup")

---

© Copyright 2025, Tao Liu, Philippa Doherty.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).