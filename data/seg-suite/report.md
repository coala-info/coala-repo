# seg-suite CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seg-suite_seg-import | PASS | 11 repo test cases (bed, genePred, gtf, maf, chain, sam, rmsk, psl with -i/-c/-p/-5/-3/-a/-f) give output identical to seg-test.txt |
| seg-suite_seg-join | PASS | 9 repo test cases (-c, -f, -n, -x, -v, -w) give output identical to seg-test.txt; the repeated -c option of two tests is not wrapped |
| seg-suite_seg-mask | PASS | repo tests with chrM (default, -c, -x n) identical to expected output |
| seg-suite_seg-merge | PASS | repo test (hg38Yrg.seg first 3 columns) identical to expected output |
| seg-suite_seg-seq | PASS | repo test with chrM.seg and chrM.fa identical to expected output |
| seg-suite_seg-shift | PASS | -g 5 on the repo chrM.seg widened every segment by 5 at both ends (286/29 became 281/39) |
| seg-suite_seg-sort | PASS | sorted the repo cutqry.seg; output identical to host LC_ALL=C sort -b -k2,2 -k3n |
| seg-suite_seg-swap | PASS | repo tests (default, -n3, -s) on hg38Yaln3.seg identical to expected output |

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


## seg-suite_seg-sort

### Tool Description
Sort segments in SEG format by sequence name, then start coordinate.

### Metadata
- **Docker Image**: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
- **Homepage**: https://github.com/mcfrith/seg-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Validation**: PASS

### Original Help Text
```text
seg-sort file(s)

Sort segments in SEG format, in alphabetical order of sequence name,
then ascending order of start coordinate. Script: LC_ALL=C sort -b -k2,2 -k3n "$@"
```

## seg-suite_seg-seq

### Tool Description
Get segments of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
- **Homepage**: https://github.com/mcfrith/seg-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seg-seq [-h] [-n N] segFile fastaFile [fastaFile ...]

Get segments of sequences.

positional arguments:
  segFile
  fastaFile

options:
  -h, --help  show this help message and exit
  -n N        use the Nth segment in each segment-tuple (default: 1)
```

## seg-suite_seg-shift

### Tool Description
Expand or shrink each seg at either end.

### Metadata
- **Docker Image**: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
- **Homepage**: https://github.com/mcfrith/seg-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Validation**: PASS

### Original Help Text
```text
usage: seg-shift [-h] [-b INT] [-e INT] [-g INT] segFile [segFile ...]

Expand or shrink each seg at either end. Don't expand past coordinate 0, and
omit segs whose length would become negative.

positional arguments:
  segFile

options:
  -h, --help          show this help message and exit
  -b INT, --beg INT   expand by this amount at the 5'-end
  -e INT, --end INT   expand by this amount at the 3'-end
  -g INT, --grow INT  expand by this amount at both ends
```

## seg-suite_seg-merge

### Tool Description
Merge overlapping and touching segment-tuples.

### Metadata
- **Docker Image**: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
- **Homepage**: https://github.com/mcfrith/seg-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seg-merge seg-file(s)

Merge overlapping and touching segment-tuples.

Options:
  -h, --help  show this help message and exit
```

## seg-suite_seg-mask

### Tool Description
Mask segments in sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
- **Homepage**: https://github.com/mcfrith/seg-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seg-mask [options] seg-file fasta-or-fastq-file

Mask segments in sequences.

Options:
  -h, --help  show this help message and exit
  -x X        letter to use for masking, instead of lowercase
  -c          preserve uppercase/lowercase in non-masked regions
```

## seg-suite_seg-swap

### Tool Description
Swap the order of segments in segment-tuples.

### Metadata
- **Docker Image**: quay.io/biocontainers/seg-suite:98--py310h184ae93_0
- **Homepage**: https://github.com/mcfrith/seg-suite
- **Package**: https://anaconda.org/channels/bioconda/packages/seg-suite/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: seg-swap [options] seg-file(s)

Swap the order of segments in segment-tuples.

Options:
  -h, --help  show this help message and exit
  -n N        swap the Nth segment with the first segment (default=2)
  -s          do not canonicalize strands
```

## Metadata
- **Skill**: generated
