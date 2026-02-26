# hapog CWL Generation Report

## hapog

### Tool Description
Hapo-G uses alignments produced by BWA (or any other aligner that produces SAM files) to polish the consensus of a genome assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/hapog:1.3.8--py39hb49fbdb_3
- **Homepage**: https://github.com/institut-de-genomique/HAPO-G
- **Package**: https://anaconda.org/channels/bioconda/packages/hapog/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hapog/overview
- **Total Downloads**: 17.6K
- **Last updated**: 2025-11-24
- **GitHub**: https://github.com/institut-de-genomique/HAPO-G
- **Stars**: N/A
### Original Help Text
```text
usage: hapog [-h] --genome INPUT_GENOME [--pe1 PE1] [--pe2 PE2]
             [--single LONG_READS] [-b BAM_FILE] [-u] [--output OUTPUT_DIR]
             [--threads THREADS] [--hapog-threads HAPOG_THREADS]
             [--bin HAPOG_BIN] [--samtools-mem SAMTOOLS_MEM]
             [--chunk-list CHUNK_LIST]

Hapo-G uses alignments produced by BWA (or any other aligner that produces SAM files) to polish the consensus of a genome assembly.

optional arguments:
  -h, --help            show this help message and exit

Mandatory arguments:
  --genome INPUT_GENOME, -g INPUT_GENOME
                        Input genome file to map reads to
  --pe1 PE1             Fastq.gz paired-end file (pair 1, can be given multiple times)
  --pe2 PE2             Fastq.gz paired-end file (pair 2, can be given multiple times)
  --single LONG_READS   Use long reads instead of short reads (can only be given one time, please concatenate all read files into one)

Optional arguments:
  -b BAM_FILE           Skip mapping step and provide a sorted bam file. Important: the BAM file must not contain secondary alignments, please use the 'secondary=no' option in Minimap2.
  -u                    Include unpolished sequences in final output
  --output OUTPUT_DIR, -o OUTPUT_DIR
                        Output directory name
  --threads THREADS, -t THREADS
                        Number of threads (used in BWA, Samtools and Hapo-G)
  --hapog-threads HAPOG_THREADS
                        Maximum number of Hapo-G jobs to launch in parallel (Defaults to the same value as --threads)
  --bin HAPOG_BIN       Use a different Hapo-G binary (for debug purposes)
  --samtools-mem SAMTOOLS_MEM
                        Amount of memory to use per samtools thread (Default: '5G')
  --chunk-list CHUNK_LIST
                        Comma-separated list of chunk numbers to process (e.g., '12,18'). Useful for rerunning failed chunks.
```

