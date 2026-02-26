# bctools CWL Generation Report

## bctools_extract_bcs.py

### Tool Description
Exract barcodes from a FASTQ file according to a user-specified pattern. Starting from the 5'-end, positions marked by X will be moved into a separate FASTQ file. Positions marked bv N will be kept.

### Metadata
- **Docker Image**: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
- **Homepage**: https://github.com/dmaticzka/bctools
- **Package**: https://anaconda.org/channels/bioconda/packages/bctools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bctools/overview
- **Total Downloads**: 12.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dmaticzka/bctools
- **Stars**: N/A
### Original Help Text
```text
usage: extract_bcs.py [-h] [-o OUTFILE] [-b OUT_BC_FASTA] [--fasta-barcodes]
                      [-a] [-v] [-d]
                      infile pattern

Exract barcodes from a FASTQ file according to a user-specified pattern. Starting from the 5'-end, positions marked by X will be moved into a separate FASTQ file. Positions marked bv N will be kept.

By default output is written to stdout.

Example usage:
- remove barcode nucleotides at positions 1-3 and 6-7 from FASTQ; write modified
  FASTQ entries to output.fastq and barcode nucleotides to barcodes.fa:
fastq_extract_barcodes.py barcoded_input.fastq XXXNNXX --out output.fastq --bcs barcodes.fastq

positional arguments:
  infile                Path to fastq file.
  pattern               Pattern of barcode nucleotides starting at 5'-end. X
                        positions will be moved to the header, N positions
                        will be kept.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write results to this file.
  -b OUT_BC_FASTA, --bcs OUT_BC_FASTA
                        Write barcodes to this file in FASTQ format.
  --fasta-barcodes      Save extracted barcodes in FASTA format.
  -a, --add-bc-to-fastq
                        Append extracted barcodes to the FASTQ headers.
  -v, --verbose         Be verbose.
  -d, --debug           Print lots of debugging information
```


## bctools_merge_pcr_duplicates.py

### Tool Description
Merge PCR duplicates according to random barcode library. All alignments with same outer coordinates and barcode will be merged into a single crosslinking event.

Barcodes containing uncalled base 'N' are removed.

### Metadata
- **Docker Image**: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
- **Homepage**: https://github.com/dmaticzka/bctools
- **Package**: https://anaconda.org/channels/bioconda/packages/bctools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: merge_pcr_duplicates.py [-h] -o OUTFILE [-v] [-d] alignments bclib

Merge PCR duplicates according to random barcode library. All alignments with
same outer coordinates and barcode will be merged into a single crosslinking
event.

Barcodes containing uncalled base 'N' are removed.

Input:
* bed6 file containing alignments with fastq read-id in name field
* fastq library of random barcodes

Output:
* bed6 file with a read id from a representative alignment in the name field and
  number of PCR duplicates as score, sorted by fields chrom, start, stop,
  strand, name

Example usage:
- read PCR duplicates from file duplicates.bed and write merged results to file
  merged.bed:
merge_pcr_duplicates.py duplicates.bed bclibrary.fa --outfile merged.bed

positional arguments:
  alignments            Path to bed6 file containing alignments.
  bclib                 Path to fastq barcode library.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write results to this file.
  -v, --verbose         Be verbose.
  -d, --debug           Print lots of debugging information
```


## bctools_rm_spurious_events.py

### Tool Description
Remove spurious events originating from errors in random sequence tags.

This script compares all events sharing the same coordinates. Among each group
of events the maximum number of PCR duplicates is determined. All events that
are supported by less than 10 percent of this maximum count are removed.

### Metadata
- **Docker Image**: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
- **Homepage**: https://github.com/dmaticzka/bctools
- **Package**: https://anaconda.org/channels/bioconda/packages/bctools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rm_spurious_events.py [-h] -o OUTFILE [-t THRESHOLD] [-v] [-d] events

Remove spurious events originating from errors in random sequence tags.

This script compares all events sharing the same coordinates. Among each group
of events the maximum number of PCR duplicates is determined. All events that
are supported by less than 10 percent of this maximum count are removed.

Input:
* bed6 file containing crosslinking events with score field set to number of PCR
  duplicates

Output:
* bed6 file with spurious crosslinking events removed, sorted by fields chrom,
  start, stop, strand

Example usage:
- remove spurious events from spurious.bed and write results to file cleaned.bed
rm_spurious_events.py spurious.bed --oufile cleaned.bed

positional arguments:
  events                Path to bed6 file containing alignments.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write results to this file. (default: None)
  -t THRESHOLD, --threshold THRESHOLD
                        Threshold for spurious event removal. (default: 0.1)
  -v, --verbose         Be verbose. (default: False)
  -d, --debug           Print lots of debugging information (default: False)
```


## bctools_remove_tail.py

### Tool Description
Remove a certain number of nucleotides from the 3'-tails of sequences in FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
- **Homepage**: https://github.com/dmaticzka/bctools
- **Package**: https://anaconda.org/channels/bioconda/packages/bctools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: remove_tail.py [-h] [-o OUTFILE] [-v] [-d] infile length

Remove a certain number of nucleotides from the 3'-tails of sequences in FASTQ
format.

Example usage:
- remove the last 7 nucleotides from file input.fastq, write result to file
  output.fastq:
remove_tail.py input.fastq 7 --out output.fastq

positional arguments:
  infile                Path to fastq file.
  length                Remove this many nts.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write results to this file.
  -v, --verbose         Be verbose.
  -d, --debug           Print lots of debugging information
```


## bctools_convert_bc_to_binary_RY.py

### Tool Description
Convert standard nucleotides in FASTQ or FASTA format to IUPAC nucleotide codes used for binary RY-space barcodes.
A and G are converted to R. T, U and C are converted to Y. By default output is written to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
- **Homepage**: https://github.com/dmaticzka/bctools
- **Package**: https://anaconda.org/channels/bioconda/packages/bctools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: convert_bc_to_binary_RY.py [-h] [-o OUTFILE] [-f] [-v] [-d] infile

Convert standard nucleotides in FASTQ or FASTA format to IUPAC nucleotide codes
used for binary RY-space barcodes.

A and G are converted to R. T, U and C are converted to Y. By default output is
written to stdout.

Example usage:
- write converted sequences from file in.fa to file file out.fa:
convert_bc_to_binary_RY.py in.fastq --outfile out.fastq

positional arguments:
  infile                Path to fastq input file.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        Write results to this file.
  -f, --fasta-format    Read and write fasta instead of fastq format.
  -v, --verbose         Be verbose.
  -d, --debug           Print lots of debugging information
```

