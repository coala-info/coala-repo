---
name: scramble
description: SCRAMble detects non-reference mobile element insertions and structural deletions by analyzing soft-clipped read clusters in genomic alignment data. Use when user asks to identify retrotransposons, call mobile element insertions, or detect deletions from BAM files.
homepage: https://github.com/GeneDx/scramble
metadata:
  docker_image: "quay.io/biocontainers/scramble:1.0.2--h031d066_1"
---

# scramble

## Overview
SCRAMble (Soft Clipped Read Alignment Mapper) is a bioinformatics pipeline designed to detect non-reference mobile element insertions and deletions. It operates on the principle that reads spanning the junction of an insertion will be "soft-clipped" by standard aligners. The tool aggregates these clipped reads into clusters, generates a consensus sequence for the insertion, and uses BLAST to compare these sequences against known mobile element families. It is particularly effective for identifying active retrotransposons in human genomic data.

## Usage Instructions

### Two-Step Workflow
SCRAMble requires a two-stage execution process: first identifying clusters from the alignment, then analyzing those clusters to call variants.

#### 1. Cluster Identification
Use the `cluster_identifier` executable to scan a BAM file and output a tab-delimited file of soft-clipped clusters.
```bash
# Basic usage
cluster_identifier input.bam > output.clusters.txt
```
*   **Input**: A sorted and indexed BAM file.
*   **Output**: A text file containing coordinates, clipping side, read counts, and consensus sequences.

#### 2. MEI and Deletion Calling
Use the `SCRAMble.R` script to analyze the clusters. This step requires R and several Bioconductor packages.
```bash
Rscript --vanilla /path/to/scramble/cluster_analysis/bin/SCRAMble.R \
  --out-name project_output \
  --cluster-file output.clusters.txt \
  --install-dir /path/to/scramble/cluster_analysis/bin \
  --mei-refs /path/to/scramble/cluster_analysis/resources/MEI_consensus_seqs.fa \
  --ref reference_genome.fa \
  --eval-meis \
  --eval-dels
```

### Key Parameters
- `--ref`: Providing the reference genome FASTA is highly recommended; it enables the generation of VCF files.
- `--mei-refs`: Path to the FASTA file containing consensus sequences for L1, Alu, and SVA.
- `--eval-meis`: Flag to trigger Mobile Element Insertion calling.
- `--eval-dels`: Flag to trigger deletion calling.
- `--no-vcf`: Use this if you only require the tab-delimited text outputs and want to skip VCF generation.

### Interpreting Results
SCRAMble produces two primary result files:
1.  **`_MEIs.txt`**: Contains insertion coordinates and the specific MEI family identified.
    *   **Alignment_Score**: Higher scores indicate higher confidence in the MEI family assignment.
    *   **TSD / TSD_length**: Look for Target Site Duplication info to validate the biological signature of retrotransposition.
2.  **`_PredictedDeletions.txt`**: Contains structural deletion calls.
    *   Check `LEFT.CLUSTER.COUNTS` and `RIGHT.CLUSTER.COUNTS` to ensure the deletion is supported by clipping on both breakpoints.

## Best Practices
- **Resource Paths**: Always ensure `--install-dir` points to the directory containing the auxiliary R scripts (like `do.meis.R` and `make.vcf.R`), as the main script calls these internally.
- **Validation**: For high-confidence calls, filter the output based on `Alignment_Percent_Identity` (typically >90%) and `Clipped_Reads_In_Cluster` (depth of support).
- **Reference Matching**: Ensure the chromosome naming convention (e.g., "chr1" vs "1") in your BAM file matches the reference FASTA provided to the R script to avoid VCF header errors.

## Reference documentation
- [github_com_GeneDx_scramble.md](./references/github_com_GeneDx_scramble.md)
- [anaconda_org_channels_bioconda_packages_scramble_overview.md](./references/anaconda_org_channels_bioconda_packages_scramble_overview.md)