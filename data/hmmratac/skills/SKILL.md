---
name: hmmratac
description: HMMRATAC is a peak caller specifically designed to identify open chromatin regions in paired-end ATAC-seq data using a Hidden Markov Model. Use when user asks to call peaks from ATAC-seq BAM files, identify nucleosome-free regions, or filter peak results by score.
homepage: https://github.com/LiuLabUB/HMMRATAC
---


# hmmratac

## Overview

HMMRATAC is a dedicated peak caller for ATAC-seq data that utilizes a Hidden Markov Model to identify open chromatin regions. Unlike general-purpose peak callers, it is specifically designed to handle the unique fragment distribution of ATAC-seq, including nucleosome-free regions (NFR) and various nucleosomal fragments (mono-, di-, and tri-nucleosomes). Use this skill to navigate the end-to-end workflow of ATAC-seq peak calling, from raw BAM preparation to post-processing score filtration.

## Prerequisites and Input Requirements

*   **Data Type**: Paired-end ATAC-seq data only. Single-end data is not supported.
*   **BAM Preparation**: Input BAM files must be sorted and indexed.
*   **Genome Info**: A tab-delimited file containing chromosome names and their respective lengths.
*   **Java Environment**: HMMRATAC is a Java-based tool; ensure a compatible JRE is installed.

## Standard Workflow

### 1. Prepare Input Files
Before running HMMRATAC, generate the required genome information file from your sorted BAM:

```bash
# Sort and index the BAM
samtools sort input.bam -o input.sorted.bam
samtools index input.sorted.bam

# Generate genome.info
samtools view -H input.sorted.bam | perl -ne 'if(/^@SQ.*?SN:(\w+)\s+LN:(\d+)/){print $1,"\t",$2,"\n"}' > genome.info
```

### 2. Execute Peak Calling
Run the HMMRATAC executable using the sorted BAM, the index, and the genome info file:

```bash
java -jar HMMRATAC_V1.2.10_exe.jar -b input.sorted.bam -i input.sorted.bam.bai -g genome.info
```

### 3. Filter Results
HMMRATAC reports all potential peaks, including weak ones. Use `awk` to filter the `gappedPeak` and `summits` files by score (column 13 for peaks, column 5 for summits). A score of 10 is a common starting threshold:

```bash
# Filter peaks
awk -v OFS="\t" '$13>=10 {print}' NAME_peaks.gappedPeak > NAME.filtered.gappedPeak

# Filter summits
awk -v OFS="\t" '$5>=10 {print}' NAME_summits.bed > NAME.filtered.summits.bed
```

## Advanced Parameters and Tips

*   **Model Training**: For small genomes or specific experimental setups, adjust `--window` (default 25000) and `--maxTrain` (maximum regions for training) to tune the HMM model building.
*   **Size Selection**: HMMRATAC works best on data without in silico size selection. If your data is already trimmed or size-selected, use the `--trim` option.
*   **Score Interpretation**: Lower scores increase sensitivity but decrease precision. Higher scores (e.g., >20) provide higher precision for strong open chromatin regions.
*   **Successor Tool**: Note that the standalone Java version of HMMRATAC is no longer actively maintained. For the most up-to-date implementation, use the `hmmratac` subcommand within the **MACS3** suite.

## Reference documentation

- [HMMRATAC GitHub Repository](./references/github_com_LiuLabUB_HMMRATAC.md)
- [HMMRATAC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hmmratac_overview.md)
- [HMMRATAC Issues and Troubleshooting](./references/github_com_LiuLabUB_HMMRATAC_issues.md)