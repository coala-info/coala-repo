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
  + [filterdup](filterdup.html)
  + [pileup](pileup.html)
  + [predictd](predictd.html)
  + [randsample](randsample.html)
  + refinepeak
    - [Overview](#overview)
    - [Detailed Description](#detailed-description)
    - [Command Line Options](#command-line-options)
    - [Example Usage](#example-usage)
* [File Formats](fileformats_index.html)
* [Tutorial](tutorial.html)
* [Common Q & A](qa.html)
* [Contributor Covenant Code of Conduct](../CODE_OF_CONDUCT.html)
* [Contributing to MACS project](../CONTRIBUTING.html)
* [MACS3 API reference](api/index.html)

[MACS3](../index.html)

* [Subcommands](subcommands_index.html)
* refinepeak
* [View page source](../_sources/docs/refinepeak.md.txt)

---

# refinepeak[](#refinepeak "Link to this heading")

## Overview[](#overview "Link to this heading")

The `refinepeak` command is part of the MACS3 suite of tools and is
used to refine peak summits. It is particularly useful in ChIP-Seq
analysis where refining the peak summits can lead to more accurate
results.

## Detailed Description[](#detailed-description "Link to this heading")

The `refinepeak` command takes in a BED file containing peaks and raw
reads alignment, then produces an output BED file with refined peak
summits. It will refine peak summits and give scores measuring the
balance of Watson/Crick tags, inspired by SPP. Basically, we assume
that a good summit in a peak region should have balanced Watson/Crick
tags around.

## Command Line Options[](#command-line-options "Link to this heading")

Here is a brief overview of the `refinepeak` options:

* `-b`: Candidate peak file in BED format. REQUIRED.
* `-i` or `--ifile`: ChIP-seq alignment file. If multiple files are
  given as ‘-t A B C’, then they will all be read and combined. Note
  that pair-end data is not supposed to work with this
  command. REQUIRED.
* `-f` or `--format`: Format of the tag file.

  + `AUTO`: MACS3 will pick a format from “AUTO”, “BED”, “ELAND”,
    “ELANDMULTI”, “ELANDEXPORT”, “SAM”, “BAM”, “BOWTIE”. Please check
    the definition in the README file if you choose
    ELAND/ELANDMULTI/ELANDEXPORT/SAM/BAM/BOWTIE. DEFAULT: “AUTO”
* `-c` or `--cutoff`: Cutoff. Regions with SPP wtd score lower than
  cutoff will not be considered. DEFAULT: 5
* `-w` or `--window-size`: Scan window size on both sides of the
  summit (default: 100bp)
* `--buffer-size`: Buffer size for incrementally increasing the
  internal array size to store read alignment information. In most
  cases, you don’t have to change this parameter. However, if there
  are a large number of chromosomes/contigs/scaffolds in your
  alignment, it’s recommended to specify a smaller buffer size in
  order to decrease memory usage (but it will take longer time to read
  alignment files). Minimum memory requested for reading an alignment
  file is about # of CHROMOSOME \* BUFFER\_SIZE \* 8 Bytes. DEFAULT:
  100000
* `--verbose`: Set the verbose level. 0: only show critical messages,
  1: show additional warning messages, 2: show process information, 3:
  show debug messages. If you want to know where the duplicate reads
  are, use 3. DEFAULT: 2
* `--outdir`: If specified, all output files will be written to that
  directory. Default: the current working directory
* `-o` or `--ofile`: Output file name. Mutually exclusive with
  –o-prefix.
* `--o-prefix`: Output file prefix. Mutually exclusive with
  -o/–ofile.

## Example Usage[](#example-usage "Link to this heading")

Here is an example of how to use the `refinepeak` command:

```
macs3 refinepeak -b peaks.bed -i alignment.bam -o refined_peaks.bed
```

In this example, the program will refine the peak summits in the
`peaks.bed` file taking in the alignment file `alignment.bam`, and
write the result to `refined_peaks.bed`.

[Previous](randsample.html "randsample")
[Next](fileformats_index.html "File Formats")

---

© Copyright 2025, Tao Liu, Philippa Doherty.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).