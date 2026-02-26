# eskrim CWL Generation Report

## eskrim

### Tool Description
ESKRIM: EStimate with K-mers the RIchness in a Microbiome

### Metadata
- **Docker Image**: quay.io/biocontainers/eskrim:1.0.9--pyhdfd78af_1
- **Homepage**: https://forgemia.inra.fr/metagenopolis/eskrim
- **Package**: https://anaconda.org/channels/bioconda/packages/eskrim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/eskrim/overview
- **Total Downloads**: 870
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: eskrim [-h] -i INPUT_FASTQ_FILES [INPUT_FASTQ_FILES ...]
              [-n SAMPLE_NAME] [-l READ_LENGTH] [-r TARGET_NUM_READS]
              [-k {17,19,21,23,25,27,29,31}] [-t NUM_THREADS]
              [-o OUTPUT_FASTQ_FILE] -s OUTPUT_STATS_FILE [--tmp-dir TEMP_DIR]
              [--seed RNG_SEED] [--version]

ESKRIM: EStimate with K-mers the RIchness in a Microbiome

options:
  -h, --help            show this help message and exit
  -i INPUT_FASTQ_FILES [INPUT_FASTQ_FILES ...]
                        INPUT_FASTQ_FILES with reads from a single metagenomic
                        sample (gzip and bzip2 compression accepted) (default:
                        None)
  -n SAMPLE_NAME        name of the metagenomic sample (default: NA)
  -l READ_LENGTH        discard reads shorter than READ_LENGTH bases and trim
                        those exceeding this length (default: 80)
  -r TARGET_NUM_READS   TARGET_NUM_READS to draw randomly from
                        INPUT_FASTQ_FILES (default: 10000000)
  -k {17,19,21,23,25,27,29,31}
                        length of kmers to count (default: 21)
  -t NUM_THREADS        NUM_THREADS to launch for kmers counting (default: 4)
  -o OUTPUT_FASTQ_FILE  OUTPUT_FASTQ_FILE with the randomly selected reads
                        (default: None)
  -s OUTPUT_STATS_FILE  OUTPUT_STATS_FILE with kmer richness estimates
                        (default: None)
  --tmp-dir TEMP_DIR    Temporary directory to store the jellyfish database
                        (default: /dev/shm)
  --seed RNG_SEED       Seed for random number generator (default: 0)
  --version             show program's version number and exit
```

