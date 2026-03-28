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
2. seqfu count

# seqfu count

*count* (or *cnt*) is one of the core subprograms of *SeqFu*. It’s used to count the sequences in FASTA/FASTQ files, and it’s *paired-end* aware so it will print the count of both files in a single line, but checking that both files have the same number of sequences.

In version 1.5 the program has been redesigned to parse multiple files simultaneously.

```
Usage: count [options] [<inputfile> ...]

Options:
  -a, --abs-path         Print absolute paths
  -b, --basename         Print only filenames
  -u, --unpair           Print separate records for paired end files
  -f, --for-tag R1       Forward tag [default: auto]
  -r, --rev-tag R2       Reverse tag [default: auto]
  -s, --sort MODE        Sort output: input|name|counts|none [default: input]
      --reverse-sort     Reverse selected sort order
  -T, --interactive-table  Open interactive table view (TUI)
  -t, --threads INT      Working threads [default: 8]
  -v, --verbose          Verbose output
  -h, --help             Show this help
```

### Streaming

Input from stream (`-`) is supported.

### Example output

Output is a TSV text with three columns: sample name, number of reads and type (“SE” for Single End, “Paired” for Paired End)

```
data/test.fastq       3  SE
data/comments.fastq   5  SE
data/test2.fastq      3  SE
data/qualities.fq     5  SE
data/illumina_1.fq.gz 7  Paired
```

With `-T/--interactive-table`, `seqfu count` opens an interactive table viewer (TUI) instead of printing TSV to stdout.
 Inside the viewer you can sort columns, filter rows and save the visible table to file.

In case of pairing/count errors, `seqfu count` prints error diagnostics to stderr and returns a non-zero exit code.

### Sorting

Sorting can be controlled with `--sort`:

* `input`: preserve input argument order (default)
* `name`: sort by filename
* `counts`: sort by read count (descending)
* `none`: emit rows in completion order (first completed worker first)

Use `--reverse-sort` to reverse the selected sort order.

### Error handling

Examples of explicit error diagnostics:

* mismatched paired-end counts (R1 vs R2)
* reverse-only input without matching R1
* unreadable/corrupted input files

Error rows are also represented in table/stdout output with `<Error:...>` labels.

### Multithreading

Performance improvement measured on the *MiSeq SOP* dataset from [mothur](https://mothur.org):

| Command | Mean [ms] | Min [ms] | Max [ms] | Relative |
| --- | --- | --- | --- | --- |
| `seqfu count ../mothur-sop/*.fastq -t 4` | 142.5 ± 5.8 | 127.3 | 152.3 | 1.00 |
| `seqfu count ../mothur-sop/*.fastq -t 1` | 416.5 ± 15.2 | 397.8 | 440.9 | 2.92 ± 0.16 |
| `seqfu count-legacy ../mothur-sop/*.fastq` | 539.2 ± 16.6 | 519.6 | 577.4 | 3.78 ± 0.19 |

## Legacy algorithm

```
Usage: count-legacy [options] [<inputfile> ...]

Options:
  -a, --abs-path         Print absolute paths
  -b, --basename         Print only filenames
  -u, --unpair           Print separate records for paired end files
  -f, --for-tag R1       Forward string, like _R1 [default: auto]
  -r, --rev-tag R2       Reverse string, like _R2 [default: auto]
  -m, --multiqc FILE     Save report in MultiQC format
  -v, --verbose          Verbose output
  -h, --help             Show this help
```

### MultiQC output

Using the `--multiqc OUTPUTFILE` option it’s possible to save a MultiQC compatible file (we recommend to use the *projectname\_mqc.tsv* filename format). After coolecting all the MultiQC files in a directory, using `multiqc -f .` will generate the MultiQC report. MultiQC itself can be installed via Bioconda with `conda install -y -c bioconda multiqc`.

To understand how to use MultiQC, if you never did so, check their excellent [documentation](https://multiqc.info).

### Screenshot

![Screenshot of "seqfu count"](/seqfu2/img/screenshot-count.svg "SeqFu cat")

---

[Back to top](#top)

Copyright © 2019-2025 Andrea Telatin. Distributed by an [MIT license](https://github.com/telatin/seqfu2/blob/main/LICENSE).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.