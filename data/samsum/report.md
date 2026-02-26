# samsum CWL Generation Report

## samsum_stats

### Tool Description
Calculate read coverage stats over reference sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/samsum:0.1.4--py39h918f1d6_7
- **Homepage**: https://github.com/hallamlab/samsum
- **Package**: https://anaconda.org/channels/bioconda/packages/samsum/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samsum/overview
- **Total Downloads**: 26.9K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/hallamlab/samsum
- **Stars**: N/A
### Original Help Text
```text
usage: samsum [-v] [-h] -f FASTA_FILE -a AM_FILE [-l MIN_ALN] [-p P_COV]
              [-q MAP_QUAL] [--multireads] [-o OUTPUT_TABLE] [-s SEP]

Calculate read coverage stats over reference sequences.

Required parameters:
  -f FASTA_FILE, --ref_fasta FASTA_FILE
                        Path to the reference file used to generate the
                        SAM/BAM file.
  -a AM_FILE, --alignments AM_FILE
                        Path to a SAM/BAM file containing the read alignments
                        to the reference FASTA.

Sequence operation arguments:
  -l MIN_ALN, --aln_percent MIN_ALN
                        The minimum percentage of a read's length that must be
                        aligned to be included. (DEFAULT = 10%)
  -p P_COV, --seq_coverage P_COV
                        The minimum percentage a reference sequence must be
                        covered for its coverage stats to be included; they
                        are set to zero otherwise. (DEFAULT = 50%)
  -q MAP_QUAL, --map_quality MAP_QUAL
                        The minimum mapping quality threshold for an alignment
                        to pass. (DEFAULT = 0)
  --multireads          Flag indicating whether reads that mapped ambiguously
                        to multiple positions (multireads) should be used in
                        the counts.

Optional options:
  -o OUTPUT_TABLE, --output_table OUTPUT_TABLE
                        Name of a file to write the alignment stats to.
                        (DEFAULT = ./samsum_table.csv)
  -s SEP, --sep SEP     Field-separator character to be used when writing the
                        output table. (DEFAULT = ',')

Miscellaneous options:
  -v, --verbose         Prints a more verbose runtime log
  -h, --help            Show this help message and exit
```


## samsum_info

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/samsum:0.1.4--py39h918f1d6_7
- **Homepage**: https://github.com/hallamlab/samsum
- **Package**: https://anaconda.org/channels/bioconda/packages/samsum/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
25/02 21:00:06 INFO:
samsum version 0.1.4.

25/02 21:00:06 INFO:
Python package dependency versions:
	numpy: 1.26.4

25/02 21:00:06 WARNING:
Unable to find executable for bwa in environment.

25/02 21:00:06 INFO:
Software versions used:

25/02 21:00:06 INFO:
samsum has finished successfully.
```

