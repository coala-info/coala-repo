---
name: dosage_score
description: This tool estimates the dosage of genomic regions from NGS alignment data to analyze subgenome contributions in polyploid or hybrid organisms. Use when user asks to calculate dosage scores from BAM files, analyze genomic coverage across sliding windows, or visualize dosage metrics for specific chromosomes.
homepage: https://github.com/SegawaTenta/Dosage-score
metadata:
  docker_image: "quay.io/biocontainers/dosage_score:1.0.0--pyhdfd78af_0"
---

# dosage_score

## Overview
The `dosage_score` tool is a specialized bioinformatics pipeline designed to estimate the dosage of genomic regions from NGS alignment (BAM) data. It is especially effective for studying polyploid genomes (like *Brassica napus*) or hybrid lines where determining the relative contribution of different subgenomes is critical. The tool calculates a "Dosage-score" by analyzing coverage depth across sliding windows, applying filters for mapping quality, base quality, and optionally using repeat-masked references or synteny link files to refine the analysis.

## Core Commands

### 1. Calculating Dosage Scores
The primary command `dosage_score` processes alignment data to generate the dosage metrics.

```bash
dosage_score -r1 <ref.fa> -g <genome_info.txt> -b <bam_info.txt> -o <output_dir> [options]
```

**Key Parameters:**
- `-r1`: The standard reference FASTA file.
- `-g`: Genome information file (Tab-separated). Format: `GenomeName [Tab] Chr1,Chr2,Chr3`.
- `-b`: BAM information file (Tab-separated). Format: `SampleName [Tab] /path/to.bam [Tab] Control/Test [Tab] GenomeName`.
- `-r2` (Optional): Reference FASTA with repeats replaced by 'N'. Highly recommended for reducing noise in repetitive regions.
- `-l` (Optional): Link file for multi-genome synteny. Limits analysis to specified homologous areas.
- `-window_size`: Default is 2,000,000 (2Mb). Adjust based on the expected resolution of dosage changes.
- `-step_size`: Default is 500,000 (500kb).

### 2. Visualizing Results
The `dosage_score_plot` command generates PNG plots of the calculated scores.

```bash
dosage_score_plot -r1 <ref.fa> -b <bam_info.txt> -o <output_dir> [options]
```

**Key Parameters:**
- `-chr_position`: Focus on a specific region (e.g., `Chr01:1000000:5000000`).
- `-c`: Color file (Tab-separated) to specify HTML hex codes for each chromosome.
- `-min_rate`: Excludes windows where the ratio of analyzed positions to window size is below this threshold (default 0.05).

## Expert Tips and Best Practices

### Input File Preparation
- **BAM Info File Logic**: 
    - Mark ancestral or diploid species as `Control`. 
    - Mark the target samples as `Test`. 
    - The 4th column should list the genome name where the sample's dosage is expected to be 2 (diploid). For allotetraploids, use comma-separated names (e.g., `A,C`).
- **Genome Info File**: Ensure chromosome names in the second column exactly match the headers in your FASTA file.

### Filtering Strategy
- **Repeat Filtering**: If your species has high repeat content, always provide the `-r2` file. This prevents false dosage signals caused by multi-mapping in repetitive elements.
- **Mapping Quality**: The default `-minMQ` is 60. This is quite stringent and ensures only uniquely mapped reads are used. If coverage is too low, consider lowering this to 30 or 40, but be aware of potential artifacts.
- **Synteny Links**: When comparing subgenomes (e.g., A vs C subgenomes in *Brassica*), providing a link file (`-l`) ensures that the dosage is only calculated for regions where homology has been established, making the "dosage" comparison biologically meaningful.

### Output Interpretation
- **dosage_score.txt**: This is the primary data source. It contains the calculated score for every window.
- **filtered_dosage_score.txt**: Use this file for downstream analysis as it removes low-confidence windows based on the `min_rate` filter.

## Reference documentation
- [Dosage-score GitHub Repository](./references/github_com_SegawaTenta_Dosage-score.md)
- [Bioconda dosage_score Package](./references/anaconda_org_channels_bioconda_packages_dosage_score_overview.md)