# how_are_we_stranded_here CWL Generation Report

## how_are_we_stranded_here_check_strandedness

### Tool Description
Check if fastq files are stranded

### Metadata
- **Docker Image**: quay.io/biocontainers/how_are_we_stranded_here:1.0.1--pyhfa5458b_0
- **Homepage**: https://github.com/betsig/how_are_we_stranded_here
- **Package**: https://anaconda.org/channels/bioconda/packages/how_are_we_stranded_here/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/how_are_we_stranded_here/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/betsig/how_are_we_stranded_here
- **Stars**: N/A
### Original Help Text
```text
usage: check_strandedness [-h] -g GTF [-fa TRANSCRIPTS] [-n NREADS] -r1
                          READS_1 -r2 READS_2 [-k KALLISTO_INDEX] [-p]

Check if fastq files are stranded

optional arguments:
  -h, --help            show this help message and exit
  -g GTF, --gtf GTF     Genome annotation GTF file
  -fa TRANSCRIPTS, --transcripts TRANSCRIPTS
                        .fasta file with transcript sequences
  -n NREADS, --nreads NREADS
                        number of reads to sample
  -r1 READS_1, --reads_1 READS_1
                        fastq.gz file (R1)
  -r2 READS_2, --reads_2 READS_2
                        fastq.gz file (R2)
  -k KALLISTO_INDEX, --kallisto_index KALLISTO_INDEX
                        name of kallisto index (will build under this name if
                        file not found)
  -p, --print_commands  Print bash commands as they occur?
```

