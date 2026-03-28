# seg-suite CWL Generation Report

## seg-suite_seg-import

### Tool Description
Read segments or alignments in various formats, and write them in SEG format.

### Metadata
- **Docker Image**: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
- **Homepage**: https://github.com/mcfrith/seg-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mcfrith/seg-suite
- **Stars**: N/A
### Original Help Text
```text
Usage:
  seg-import [options] bed inputFile(s)
  seg-import [options] chain inputFile(s)
  seg-import [options] genePred inputFile(s)
  seg-import [options] gff inputFile(s)
  seg-import [options] gtf inputFile(s)
  seg-import [options] lastTab inputFile(s)
  seg-import [options] maf inputFile(s)
  seg-import [options] psl inputFile(s)
  seg-import [options] rmsk inputFile(s)
  seg-import [options] sam inputFile(s)

Read segments or alignments in various formats, and write them in SEG format.

Options:
  -h, --help     show this help message and exit
  -V, --version  show version number and exit
  -f N           make the Nth segment in each seg line forward-stranded

Options for lastTab, maf, psl:
  -a             add alignment number and position to each seg line

Options for bed, genePred, gtf:
  -c             get CDS (coding regions)
  -5             get 5' untranslated regions (UTRs)
  -3             get 3' untranslated regions (UTRs)
  -i             get introns
  -p             get primary transcripts (exons plus introns)
```


## seg-suite_seg-sort

### Tool Description
Sort lines of text

### Metadata
- **Docker Image**: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
- **Homepage**: https://github.com/mcfrith/seg-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Validation**: PASS

### Original Help Text
```text
sort: unrecognized option '--help'
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: sort [-nrughMcszbdfiokt] [-o FILE] [-k START[.OFS][OPTS][,END[.OFS][OPTS]] [-t CHAR] [FILE]...

Sort lines of text

	-o FILE	Output to FILE
	-c	Check whether input is sorted
	-b	Ignore leading blanks
	-f	Ignore case
	-i	Ignore unprintable characters
	-d	Dictionary order (blank or alphanumeric only)
	-n	Sort numbers
	-g	General numerical sort
	-h	Sort human readable numbers (2K 1G)
	-M	Sort month
	-V	Sort version
	-t CHAR	Field separator
	-k N[,M] Sort by Nth field
	-r	Reverse sort order
	-s	Stable (don't sort ties alphabetically)
	-u	Suppress duplicate lines
	-z	NUL terminated input and output
```


## seg-suite_seg-join

### Tool Description
Read two SEG files, and write their JOIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
- **Homepage**: https://github.com/mcfrith/seg-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seg-join [options] file1.seg file2.seg

Read two SEG files, and write their JOIN.

Options:
  -h, --help     show this help message and exit
  -c FILENUM     only use complete/contained records of file FILENUM
  -f FILENUM     write complete records of file FILENUM, that overlap anything
                 in the other file
  -n PERCENT     write each record of file 2, if at least PERCENT of it is
                 covered by file 1
  -x PERCENT     write each record of file 2, if at most PERCENT of it is
                 covered by file 1
  -v FILENUM     only write unjoinable parts of file FILENUM
  -w             join on whole segment-tuples, not just first segments
  -V, --version  show version number and exit
```


## Metadata
- **Skill**: generated
