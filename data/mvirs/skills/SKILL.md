---
name: mvirs
description: The mvirs toolkit localizes inducible prophages within bacterial genomes by analyzing paired-end sequencing data for circularized or concatenated DNA segments. Use when user asks to index a reference genome, identify prophage boundaries using outward-oriented reads, or extract potential prophage sequences from sequencing data.
homepage: https://github.com/SushiLab/mVIRs
---


# mvirs

## Overview

The `mvirs` (mVIRs) toolkit is designed for the precise localization of inducible prophages within bacterial genomes. It utilizes paired-end sequencing data (typically Illumina) to identify DNA segments that exist in circularized or concatenated forms upon induction. By analyzing the orientation of reads aligned to a lysogenic host reference, the tool can pinpoint prophage boundaries that traditional homology-based tools might miss.

## Installation and Setup

The tool requires Python >= 3.7, BWA, and Samtools. The recommended installation is via Conda:

```bash
conda create -n mvirs python=3.7 pip bwa samtools pysam -c bioconda
conda activate mvirs
python -m pip install mvirs
```

## Command Workflow

### 1. Indexing the Reference
Before running the analysis, you must index your host genome FASTA file. This creates the necessary BWA index files.

```bash
mvirs index -f reference.fasta
```

### 2. Prophage Localization (oprs)
The core command `oprs` aligns reads and identifies Outward-Oriented paired-end Reads (OPRs) and soft-clipped alignments to find prophage regions.

```bash
mvirs oprs -f reads_1.fq.gz -r reads_2.fq.gz -db reference.fasta -o output_prefix
```

**Key Parameters:**
- `-t`: Number of threads (default: 1). Increase for faster alignment.
- `-ml`: Minimum sequence length for extraction (default: 4000 bp).
- `-ML`: Maximum sequence length for extraction (default: 800,000 bp).
- `-m`: Flag to allow reporting of full contigs if OPRs/clipped reads are found at the very ends of the sequence.

### 3. Testing the Installation
To verify the environment and tool functionality with a public dataset:

```bash
mvirs test -o ./test_results/
```

## Output Files

The tool generates four primary files using the specified prefix:
- `.bam`: The raw alignments to the reference.
- `.oprs`: Tab-separated file containing identified OPR positions.
- `.clipped`: Tab-separated file containing soft-clipped alignment positions.
- `.fasta`: The extracted potential prophage sequences.

## Expert Tips and Best Practices

- **Reference Selection**: Ensure the reference genome used in the `index` step is the exact same file passed to the `-db` parameter in the `oprs` step.
- **Read Quality**: While `mvirs` handles gzipped FastQ files, ensure your reads are adapter-trimmed. Excessive adapter contamination can lead to false-positive clipped read signals.
- **Downstream Analysis**: The `.fasta` output contains "putative" prophages. It is best practice to pipe these sequences into classification tools like VirSorter2, VIBRANT, or CheckV to confirm viral signatures and assess completeness.
- **Memory Management**: Recent versions of `mvirs` use a streaming mode that significantly reduces memory footprint (up to 90%) compared to earlier versions, making it suitable for large metagenomic reference sets.

## Reference documentation
- [GitHub - SushiLab/mVIRs](./references/github_com_SushiLab_mVIRs.md)
- [mvirs - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mvirs_overview.md)