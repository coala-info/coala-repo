---
name: microbecensus
description: MicrobeCensus is a specialized bioinformatics tool that estimates the average genome size (AGS) of a microbial community from metagenomic data.
homepage: https://github.com/snayfach/MicrobeCensus
---

# microbecensus

## Overview

MicrobeCensus is a specialized bioinformatics tool that estimates the average genome size (AGS) of a microbial community from metagenomic data. It works by aligning reads to a set of universal single-copy gene families that are present in nearly all cellular microbes. Because these genes occur once per genome, the fraction of reads hitting them is inversely proportional to the average genome size. This metric is critical for calculating "genome equivalents" (total base pairs sequenced divided by AGS), which provides a robust method for normalizing gene abundances across samples with different community structures.

## Installation

The most reliable way to install MicrobeCensus is via Bioconda:

```bash
conda install -c bioconda microbecensus
```

## Command Line Usage

The primary script is `run_microbe_census.py`. It accepts FASTA or FASTQ files, including compressed formats (.gz or .bz2).

### Basic Execution
To estimate AGS from a single metagenome file:
```bash
run_microbe_census.py input.fastq.gz ags_report.txt
```

### Paired-End Data
For paired-end metagenomes, provide the files as a comma-separated list without spaces:
```bash
run_microbe_census.py read_1.fq.gz,read_2.fq.gz ags_report.txt
```

### Performance and Sampling
*   **Subsampling (-n):** By default, the tool samples 2,000,000 reads. For higher precision in complex communities or very large genomes, increase this value. To use all reads, set it to a very high number.
    ```bash
    run_microbe_census.py -n 10000000 input.fq output.txt
    ```
*   **Multi-threading (-t):** Increase the number of threads for the database search.
    ```bash
    run_microbe_census.py -t 8 input.fq output.txt
    ```
*   **Quick Test (-e):** Use this flag to quit immediately after obtaining the AGS estimate without calculating genome equivalents.
    ```bash
    run_microbe_census.py -e -n 100000 input.fq output.txt
    ```

## Quality Control and Filtering

MicrobeCensus includes internal QC options, though defaults are generally recommended:
*   **-l:** Trim all reads to a specific length (default is the median read length).
*   **-q / -m:** Set minimum base-level or read-level PHRED quality scores.
*   **-d:** Filter duplicate reads.
*   **-u:** Set maximum percent of unknown bases per read.

## Expert Tips and Best Practices

*   **Normalization Strategy:** If you are using MicrobeCensus to calculate genome equivalents for normalizing gene abundances, **do not** use the quality filtering options (-q, -m, -d, -u). The tool should be run on the exact same metagenome used for your abundance estimations to ensure the normalization factor is accurate.
*   **Temporary Files:** MicrobeCensus generates several temporary files. Ensure your `TMPDIR` environment variable points to a location with sufficient space, or the process may fail during the alignment phase.
*   **Read Length:** The tool is optimized for short-read Illumina data. If working with variable read lengths, the `-l` parameter ensures consistency across the alignment.
*   **Verbose Output:** Use `-v` to monitor progress, especially when processing large datasets or using high subsampling values.

## Python Module Integration

MicrobeCensus can be imported directly into Python scripts for pipeline integration:

```python
from microbe_census import microbe_census

args = {
    'seqfiles': ['sample_R1.fq.gz', 'sample_R2.fq.gz'],
    'nreads': 2000000,
    'threads': 4,
    'verbose': True
}

# Returns estimated AGS and a dictionary of arguments used
average_genome_size, used_args = microbe_census.run_pipeline(args)

# Calculate genome equivalents manually if needed
count_bases = microbe_census.count_bases(args['seqfiles'])
genome_equivalents = count_bases / average_genome_size
```

## Reference documentation
- [MicrobeCensus GitHub Repository](./references/github_com_snayfach_MicrobeCensus.md)
- [Bioconda MicrobeCensus Package](./references/anaconda_org_channels_bioconda_packages_microbecensus_overview.md)