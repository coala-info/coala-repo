---
name: referee
description: Referee is a tool designed to assign empirical quality scores to genome assemblies.
homepage: https://github.com/gwct/referee
---

# referee

## Overview
Referee is a tool designed to assign empirical quality scores to genome assemblies. By analyzing the reads used to build the assembly (mapped back to the finished product), it calculates genotype likelihoods to determine the confidence of each base call. This allows for the identification of low-quality regions and provides a mechanism for reference base correction.

## Usage Instructions

### Core Workflow
1. **Map Reads**: Align the sequencing reads back to the reference assembly to produce a BAM file.
2. **Generate Input**: Create a pileup file (e.g., via `samtools mpileup`) or pre-calculate genotype log-likelihoods (e.g., via `ANGSD`).
3. **Run Referee**: Execute the scoring algorithm using the reference FASTA and the alignment data.

### Common CLI Patterns

**Score using a pileup file:**
```bash
python referee.py -gl input.pileup -ref reference.fasta --pileup
```

**Score using pre-calculated genotype likelihoods:**
```bash
python referee.py -gl input.gl.gz -ref reference.fasta
```

**Batch processing multiple files:**
Create a text file containing paths to multiple input files (one per line) and use the `-i` flag:
```bash
python referee.py -i file_list.txt -ref reference.fasta --pileup
```

### Key Options and Best Practices

*   **Haploid Species**: Use the `--haploid` flag when working with haploid organisms to restrict likelihood calculations to single base states (only compatible with `--pileup` input).
*   **Base Correction**: Use `--correct` to have Referee suggest higher-scoring bases where the reads do not support the reference call.
*   **Output Formats**:
    *   `--fastq`: Generates scores in FASTQ format (score + 35 = ASCII).
    *   `--bed`: Generates binned BED files for visualization in genome browsers.
    *   `--mapped`: Only reports scores for sites that actually have reads mapped to them.
*   **Mapping Quality**: If using pileup input, include the `--mapq` flag to incorporate mapping quality into the score. This requires the pileup to have mapping quality data (e.g., `samtools mpileup -s`).
*   **Performance Tuning**:
    *   Use `-p [int]` to specify the number of parallel processes.
    *   Adjust `-l [int]` (default 100,000) to change the number of lines read per process. Decrease this value if encountering memory constraints.

### Expert Tips
*   **Header Matching**: Ensure that the FASTA headers in your reference file exactly match the sequence IDs in the first column of your pileup or genotype likelihood file.
*   **Compression**: Referee can read gzip-compressed input files directly for both the reference and the likelihood/pileup data.
*   **Output Management**: By default, Referee creates a new directory named `referee-[timestamp]`. Use `-o` to specify a custom directory and `--overwrite` if you need to re-run analysis in an existing folder.

## Reference documentation
- [Referee GitHub Repository](./references/github_com_gwct_referee.md)
- [Bioconda Referee Overview](./references/anaconda_org_channels_bioconda_packages_referee_overview.md)