---
name: hdmi
description: HDMI (HGT Detection from MAGs in Individual) is a specialized bioinformatics pipeline for identifying genetic material exchange between microbial species within metagenomic samples.
homepage: https://github.com/HaoranPeng21/HDMI
---

# hdmi

## Overview

HDMI (HGT Detection from MAGs in Individual) is a specialized bioinformatics pipeline for identifying genetic material exchange between microbial species within metagenomic samples. Unlike simple similarity searches, HDMI validates HGT candidates by analyzing read-spanning data, ensuring that the detected events are supported by the actual sequencing reads of the sample. Use this skill to guide users through the end-to-end process of HGT identification, from raw MAGs to a filtered table of validated transfer events.

## Core Workflow

The HDMI pipeline is executed in four sequential steps. All steps require a mapping file (group info) that links MAGs to their respective species.

### 1. Candidate Detection
Identifies potential HGT events using BLAST-based similarity searches between genomes.

```bash
HDMI detect -i <genome_folder> -o <output_dir> -m <mapping_file> -t <threads>
```

*   **Expert Tip**: Always run with `--count-only` first. This estimates the number of genome pairs and total runtime without performing the heavy BLAST computation.
*   **Input**: A directory of MAGs in FASTA format.
*   **Requirement**: Use high-quality MAGs (e.g., those passing GUNC or CheckM quality control) to reduce false positives.

### 2. Indexing
Extracts HGT sequences and builds Bowtie2 indices for the identified regions.

```bash
HDMI index -g <genome_folder> -m <mapping_file> -o <output_dir> -t <threads>
```

*   **Note**: This step prepares the reference for read mapping in the next phase. It generates `elements_info_raw.csv`.

### 3. Read Profiling and Validation
Validates HGT candidates by mapping raw metagenomic reads to the HGT regions.

```bash
HDMI profile -r1 <R1.fq.gz> -r2 <R2.fq.gz> -o <output_dir> -g <genome_folder> -m <mapping_file> -t <threads>
```

*   **Validation Logic**: This step uses "read spanning" analysis. If reads map across the junction of the HGT element and the flanking genomic sequence, the event is considered validated.
*   **Parameter**: Adjust `--sth` (span threshold, default: 2) to change the stringency of read validation.

### 4. Summary and Filtering
Merges results across multiple samples and applies final abundance filters.

```bash
HDMI summary -o <output_dir> -group <mapping_file> --threshold <abundance_val>
```

*   **Output**: The primary result is `HGT_events.csv`, which contains the filtered and validated HGT events.
*   **Threshold**: The `--threshold` parameter (default: 1.0) sets the species abundance requirement for presence.

## Input File Formats

*   **Genome Folder**: A directory containing `.fa` or `.fasta` files for each MAG.
*   **Mapping File**: A tab-separated or space-separated file mapping MAG filenames to species names.
*   **Reads**: Standard paired-end FASTQ files (can be gzipped).

## Performance and Resource Management

*   **Memory**: Ensure at least 16GB of RAM is available; 32GB is recommended for large datasets or high thread counts.
*   **Storage**: HDMI generates significant intermediate data. Ensure disk space is 2-3x the size of the input FASTQ data.
*   **Parallelization**: For very large datasets, use the `-n` (batch number) and `--total` (total batches) flags in the `detect` step to split the workload across different nodes or runs.

## Reference documentation
- [HDMI GitHub Repository](./references/github_com_HaoranPeng21_HDMI.md)
- [HDMI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hdmi_overview.md)