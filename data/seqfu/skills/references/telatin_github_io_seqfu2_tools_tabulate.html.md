[Skip to main content](#main-content)   Link      Menu      Expand       (external link)    Document      Search       Copy       Copied

* [Home](/seqfu2/)
* [Installation](/seqfu2/installation)
* [Overview](/seqfu2/intro)
* [Core Tools](/seqfu2/tools/README.html)
  + [seqfu bases](/seqfu2/tools/bases.html)
  + [seqfu cat](/seqfu2/tools/cat.html)
  + [seqfu check](/seqfu2/tools/check.html)
  + [seqfu count](/seqfu2/tools/count.html)
  + [seqfu deinterleave](/seqfu2/tools/deinterleave.html)
  + [seqfu derep](/seqfu2/tools/derep.html)
  + [seqfu grep](/seqfu2/tools/grep.html)
  + [seqfu head](/seqfu2/tools/head.html)
  + [seqfu interleave](/seqfu2/tools/interleave.html)
  + [seqfu lanes](/seqfu2/tools/lanes.html)
  + [seqfu less](/seqfu2/tools/less.html)
  + [seqfu list](/seqfu2/tools/list.html)
  + [seqfu merge](/seqfu2/tools/merge.html)
  + [seqfu metadata](/seqfu2/tools/metadata.html)
  + [seqfu qual](/seqfu2/tools/qual.html)
  + [seqfu rc](/seqfu2/tools/rc.html)
  + [seqfu rotate](/seqfu2/tools/rotate.html)
  + [seqfu sort](/seqfu2/tools/sort.html)
  + [seqfu stats](/seqfu2/tools/stats.html)
  + [seqfu tabulate](/seqfu2/tools/tabulate.html)
  + [seqfu tail](/seqfu2/tools/tail.html)
  + [seqfu tofasta](/seqfu2/tools/tofasta.html)
  + [seqfu trim](/seqfu2/tools/trim.html)
  + [seqfu view](/seqfu2/tools/view.html)
  + [seqfu orf](/seqfu2/tools/orf.html)
  + [seqfu tabcheck](/seqfu2/tools/tabcheck.html)
* [Usage Guide](/seqfu2/usage)
* [Utilities](/seqfu2/utilities/README.html)
  + [fu-16Sregion](/seqfu2/utilities/fu-16Sregion.html)
  + [fu-cov](/seqfu2/utilities/fu-cov.html)
  + [fu-homocom](/seqfu2/utilities/fu-homocomp.html)
  + [fu-index](/seqfu2/utilities/fu-index.html)
  + [fu-msa](/seqfu2/utilities/fu-msa.html)
  + [fu-multirelabel](/seqfu2/utilities/fu-multirelabel.html)
  + [fu-nanotags](/seqfu2/utilities/fu-nanotags.html)
  + [fu-orf](/seqfu2/utilities/fu-orf.html)
  + [fu-primers](/seqfu2/utilities/fu-primers.html)
  + [fu-shred](/seqfu2/utilities/fu-shred.html)
  + [fu-sw](/seqfu2/utilities/fu-sw.html)
  + [fu-tabcheck](/seqfu2/utilities/fu-tabcheck.html)
  + [fu-virfilter](/seqfu2/utilities/fu-virfilter.html)
* [Helper Utilities](/seqfu2/scripts/README.html)
  + [fu-pecheck](/seqfu2/scripts/fu-pecheck.html)
  + [fu-split](/seqfu2/scripts/fu-split.html)
* [About](/seqfu2/about)
* [Releases](/seqfu2/releases/README.html)
  + [History](/seqfu2/releases/history.html)

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.

Search SeqFu Documentation

* [GitHub Repository](https://github.com/telatin/seqfu2)
* [Report Issue](https://github.com/telatin/seqfu2/issues)

1. [Core Tools](/seqfu2/tools/README.html)
2. seqfu tabulate

# seqfu tabulate

```
This tool has been introduced with seqfu 1.2.2
```

This program converts a sequence file (FASTA or FASTQ) to a tabular file, and vice versa.

Several Unix tools can process a stream of information line-by-line, and tabular file can be easily modified and filtered piping serveral programs.

This tool will allow to **tabulate** (convert to TSV) and **detabulate** (convert to FASTX) sequences.

```
Usage: tabulate [options] [<file>]

Convert FASTQ to TSV and viceversa. Single end is a 4 columns table (name, comment, seq, qual),
paired end have 4 columns for the R1 and 4 columns for the R2.
Paired end reads need to be supplied as interleaved.

Options:
  -i, --interleaved        Input is interleaved (paired-end)
  -d, --detabulate         Convert TSV to FASTQ (if reading from file is autodetected)
  -c, --comment-sep CHAR   Separator between name and comment (default: tab)
  -s, --field-sep CHAR     Field separator (default: tab)
  -v, --verbose            Verbose output
  -h, --help               Show this help
```

## Tabular format

The conversion works as follows:

* FASTA files are converted to a 3 columns table: name, comments and sequence
* Single-End FASTQ files are converted to a 4 columns table: name, comments, sequence and quality
* Paired-End FASTQ (interleaved) files are converted to 8 colums table: R1 name, comments, sequence and quality and R2 name, comments, sequence and quality

To allow an efficient use of streams, paired-end datasets need to be interleaved (see: *seqfu interleave*).

To make an example this FASTQ file:

```
@read_1 tag=A
ATTACAATTACAATTACAA
+
EAFFFFFABBBAAAAAAAC
@read_2 tag=B
GGACAGAATTACAATTTTT
+
FFFFFFFFABBBAAAAAAA
```

will become:

```
read_1    tag=A    ATTACAATTACAATTACAA    EAFFFFFABBBAAAAAAAC
read_2    tag=B    GGACAGAATTACAATTTTT    FFFFFFFFABBBAAAAAAA
```

## Conversions

### Sequence to table

A single file can be converted to tabular format.

*NOTE*: If the file is automatically detected as interleaved (the first and second read have the same name) you can omit `-i` (or `--interleave`), but we recommend to use it to make the command clearer.

```
seqfu tabulate file.fastq | gzip -c > tabular.tab.gz
```

### Table to sequences

When a file is provided, the input format is automatically detected. Otherwise specify `-d` (or `--detabulate` to convert from table to FASTX).

```
seqfu tabulate file.tab > sequences.fq
```

or, via *stream*:

```
cat file.tab.gz | seqfu tabulate  --detabulate > sequences.fq
```

### Pipeline

We designed the tool to provide a simple way to make ad hoc modifications via tabular lines, so a full workflow could be:

```
seqfu interleave ... | seqfu tabulate | CUSTOM_STEP | seqfu tabulate --detabulate | seqfu deinterleave -o basename -
```

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.