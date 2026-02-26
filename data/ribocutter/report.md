# ribocutter CWL Generation Report

## ribocutter

### Tool Description
ribocutter

### Metadata
- **Docker Image**: quay.io/biocontainers/ribocutter:0.1.1--pyh5e36f6f_0
- **Homepage**: https://github.com/Delayed-Gitification/ribocutter.git
- **Package**: https://anaconda.org/channels/bioconda/packages/ribocutter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ribocutter/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Delayed-Gitification/ribocutter
- **Stars**: N/A
### Original Help Text
```text
usage: ribocutter [-h] -i INPUT [INPUT ...] -o OUTPUT [-r MAX_READS]
                  [-g MAX_GUIDES] [--min_read_length MIN_READ_LENGTH]
                  [--max_read_length MAX_READ_LENGTH] [--save_stats] [--a5 A5]
                  [--a3 A3] [-b BACKGROUND] [--t7 T7] [--overlap OVERLAP]
                  [--stats_frac STATS_FRAC]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        Input fastq(s)
  -o OUTPUT, --output OUTPUT
                        output filename
  -r MAX_READS, --max_reads MAX_READS
                        max reads to examine
  -g MAX_GUIDES, --max_guides MAX_GUIDES
                        The number of guides to design
  --min_read_length MIN_READ_LENGTH
  --max_read_length MAX_READ_LENGTH
  --save_stats          Save a CSV of copy numbers for the most abundant
                        sequences
  --a5 A5               Include an adaptor sequence for the 5' end containing
                        a PAM motif (in reverse complement, i.e. 5'-CCN-3').
                        This must be less than 20 nt, and ideally should be
                        less than 10 nt
  --a3 A3               Include an adaptor sequence for the 3' end containing
                        a PAM motif (i.e. 5'-NGG-3'). This must be less than
                        20 nt, and ideally should be less than 10 nt
  -b BACKGROUND, --background BACKGROUND
                        A fasta file of background sequences that you do not
                        wish to target
  --t7 T7               T7 promoter sequence
  --overlap OVERLAP     The overlap, compatible with EnGen NEB kit
  --stats_frac STATS_FRAC
                        When using save_stats mode, this is the minimum
                        fractional abundance of a sequence for it to be
                        recorded in the csv. Default = 0.0001 (0.01percent)
```

