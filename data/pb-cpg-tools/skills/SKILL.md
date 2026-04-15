---
name: pb-cpg-tools
description: pb-cpg-tools processes PacBio HiFi sequencing data to identify CpG methylation patterns and generate site-level scores. Use when user asks to extract 5mC base modifications from BAM or CRAM files, generate haplotype-specific methylation tracks, or create BigWig and BED files for methylation visualization.
homepage: https://github.com/PacificBiosciences/pb-CpG-tools
metadata:
  docker_image: "quay.io/biocontainers/pb-cpg-tools:3.0.0--h9ee0642_0"
---

# pb-cpg-tools

## Overview

The `pb-cpg-tools` package is a specialized suite designed to process PacBio HiFi sequencing data to identify CpG methylation patterns. Its primary tool, `aligned_bam_to_cpg_scores`, extracts 5mC base modification information from BAM/CRAM files (specifically the MM and ML tags) and aggregates them into site-level scores. It is particularly effective for diploid assembly workflows as it automatically generates haplotype-specific methylation tracks when reads are haplotagged.

## Installation

Install the tools via bioconda for the most stable environment:

```bash
conda create -n pb-cpg-tools -c bioconda pb-cpg-tools
conda activate pb-cpg-tools
```

## Core CLI Usage

The primary command is `aligned_bam_to_cpg_scores`. It requires a coordinate-sorted BAM or CRAM file with an associated index.

### Basic Execution
Run the tool with default settings (model-based pileup and de novo site detection):

```bash
aligned_bam_to_cpg_scores \
  --bam input.aligned.bam \
  --output-prefix sample_name \
  --threads 8
```

### Working with CRAM Files
When using CRAM input, you must provide the reference FASTA file:

```bash
aligned_bam_to_cpg_scores \
  --bam input.aligned.cram \
  --ref reference.fasta \
  --output-prefix sample_name
```

## Tool-Specific Best Practices

### Alignment Requirements
*   **Avoid Hard-Clipping**: Methylated reads must be mapped using methods that do not hard-clip supplementary alignments. Hard-clipping desynchronizes the MM/ML tags from the sequence.
    *   **Recommended**: Use `pbmm2`.
    *   **Alternative**: Use `minimap2` with the `-Y` flag.
*   **Tag Presence**: Ensure your input BAM contains `MM` (base modification) and `ML` (probability) tags. These are standard in PacBio HiFi "On-Instrument" or `pb-base-modification` outputs.

### Selecting Pileup Modes
Use the `--pileup-mode` argument to change how probabilities are calculated:
*   **model (Default)**: Uses a machine-learning model to calculate probabilities across CpG sites. This is the recommended mode for most biological analyses.
*   **count**: A simpler mode where bases with a 5mC probability > 0.5 are classified as modified. Use this if you require a deterministic, threshold-based count.

### Haplotype Analysis
If the input BAM contains `HP` tags (e.g., from `WhatsHap` or `pb-rectime`), the tool automatically generates:
1.  `[prefix].combined.bw/.bed.gz`: All reads.
2.  `[prefix].hap1.bw/.bed.gz`: Haplotype 1 specific methylation.
3.  `[prefix].hap2.bw/.bed.gz`: Haplotype 2 specific methylation.

## Output Interpretation

### BED File Columns
The output `.bed.gz` files contain the following key columns:
1.  **chrom**: Chromosome name.
2.  **begin/end**: Coordinates of the CpG site.
3.  **mod_score**: Methylation probability expressed as a percentage (0-100).
4.  **cov**: Read coverage at the site.
5.  **discretized_mod_score**: (Model mode only) Calculated from estimated modified/unmodified counts.

### Visualization
*   **BigWig (.bw)**: These files are optimized for genome browsers. Load the `.combined.bw`, `.hap1.bw`, and `.hap2.bw` files into IGV to visualize differential methylation between alleles.

## Reference documentation
- [pb-CpG-tools GitHub Repository](./references/github_com_PacificBiosciences_pb-CpG-tools.md)
- [Bioconda pb-cpg-tools Overview](./references/anaconda_org_channels_bioconda_packages_pb-cpg-tools_overview.md)