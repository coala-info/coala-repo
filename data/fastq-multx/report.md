# fastq-multx CWL Generation Report

## fastq-multx

### Tool Description
Demultiplexes FASTQ files based on barcodes. It can determine barcodes from indexed reads, a master list, or use provided barcodes directly. It handles paired-end reads and offers various options for matching and output control.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastq-multx:1.4.2--h9948957_5
- **Homepage**: https://github.com/brwnj/fastq-multx
- **Package**: https://anaconda.org/channels/bioconda/packages/fastq-multx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastq-multx/overview
- **Total Downloads**: 24.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brwnj/fastq-multx
- **Stars**: N/A
### Original Help Text
```text
Usage: fastq-multx [-g|-l|-B] <barcodes.fil> <read1.fq> [mate.fq] -o r1.%.fq [-o r2.%.fq] ...
Version: 1.4.2

Output files must contain a '%' sign which is replaced with the barcode id in the barcodes file.
Output file can be n/a to discard the corresponding data (use this for the barcode read)

The barcodes file (-B) looks like this [where '-NNNNNNNN' for a dual index is optional]:

sample1 ATGGTCCA-TTGAGGAC
sample2 GCCTAAGT-AAGCGTCA
...

The column delimiter may be a space or a tab.  The best matches in the index file(s) must be unique to a single sample's barcode(s) or the read(s) will be considered unmatched.

Default is to guess the -bol or -eol based on clear stats.

If -g is used, then it's parameter is an index lane, and frequently occuring sequences are used.

If -l is used then all barcodes in the file are tried, and the *group* with the *most* matches is chosen.

Grouped barcodes file (-l or -L) looks like this [where '-NNNNNNNN' for a dual index is optional]:

sample1 ATGGTCCA-TTGAGGAC group1
sample1 GCCTAAGT-AAGCGTCA group1
sample2 CTTAGTTC-CCAAGTAC group2
...

Mated reads, if supplied, are kept in-sync

Options:

-o FIL1     Output files (one per input, required)
-g SEQFIL   Determine barcodes from the indexed read SEQFIL
-l BCFIL    Determine barcodes from any read, using BCFIL as a master list
-L BCFIL    Determine barcodes from <read1.fq>, using BCFIL as a master list
-B BCFIL    Use barcodes from BCFIL, no determination step, codes in <read1.fq>
-H          Use barcodes from illumina's header, instead of a read
-b          Force beginning of line (5') for barcode matching
-e          Force end of line (3') for barcode matching
-t NUM      Divide threshold for auto-determine by factor NUM (1), > 1 = more sensitive
-G NAME     Use group(s) matching NAME only
-x          Don't trim barcodes off before writing out destination
-n          Don't execute, just print likely barcode list
-v C        Verify that mated id's match up to character C (Use ' ' for illumina)
-m N        Allow N mismatches in union of all indexes, unless -M is supplied. (1)
-M M        Allow N,M mismatches in indexes 1,2 respectively (see -m N) (not used)
-d N        Require a minimum distance of N between the best and next best (2)
-q N        Require a minimum phred quality of N to accept a barcode base (0)
```

