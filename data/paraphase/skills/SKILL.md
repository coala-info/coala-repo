---
name: paraphase
description: Paraphase is a specialized tool for genomic analysis using high-fidelity (HiFi) long reads.
homepage: https://github.com/PacificBiosciences/paraphase
---

# paraphase

## Overview

Paraphase is a specialized tool for genomic analysis using high-fidelity (HiFi) long reads. It addresses the challenge of "dark" regions by realigning all reads from a gene family to a single representative gene, bypassing the errors associated with multi-mapping to multiple similar regions. This gene-family-centered approach allows for accurate phasing, copy number estimation, and variant calling even when an individual's copy number differs from the reference genome.

## Core Workflows

### Basic Execution
To run Paraphase on a single sample, provide the aligned BAM, an output directory, and the reference fasta.
```bash
paraphase -b input.bam -o output_directory -r genome_reference.fasta
```

For processing multiple samples, use a text file containing a list of BAM paths (one per line):
```bash
paraphase -l bam_list.txt -o output_directory -r genome_reference.fasta
```

### Targeted Sequencing
When working with targeted data (e.g., PureTarget panels) where depth is not uniform across the genome, you must use the `--targeted` flag to ensure correct copy number estimation.
```bash
paraphase -b input.bam -o output_dir -r ref.fasta --targeted
```

### Analyzing Specific Regions
Paraphase supports 160 regions in GRCh38. To limit analysis to specific genes of interest (e.g., SMN1 and CYP21A2), use the `-g` flag with the region names.
```bash
paraphase -b input.bam -o output_dir -r ref.fasta -g SMN1,CYP21A2
```

## Technical Requirements and Best Practices

### Reference Genome Constraints
*   **Alignment Match**: The input BAM must be aligned to the same reference genome provided via `-r`.
*   **No ALT Contigs**: The reference genome should NOT include ALT contigs.
*   **Build Specification**: Use `--genome` to specify the build if it is not GRCh38 (default). Supported values: `38`, `37`, `19`, or `chm13`. Note that GRCh37/hg19 only supports 11 medically relevant regions.

### Input Data Quality
*   **Coverage**: For whole-genome sequencing (WGS), a minimum of 20X coverage is recommended; 30X is ideal for high-accuracy phasing.
*   **Index Files**: A BAI file must exist in the same directory as the input BAM.

### Optimization and Advanced Parameters
*   **Multi-threading**: Use `-t` to specify the number of threads for faster processing.
*   **Gene1Only Mode**: For specific genes (SMN1, PMS2, STRC, NCF1, IKBKG), use `--gene1only` to restrict variant calls to the main gene of interest rather than all paralogs.
*   **Frequency Cutoffs**: 
    *   `--min-variant-frequency`: Minimum frequency for a variant to be used for phasing (default: 0.11).
    *   `--min-haplotype-frequency`: Minimum frequency of unique supporting reads for a haplotype (default: 0.03).

## Interpreting Results

### Output Files
*   **VCFs**: Located in the `${prefix}_paraphase_vcfs` folder. One VCF is generated per gene family.
*   **Paraphase BAM**: The `.paraphase.bam` file is optimized for visualization. All haplotypes are realigned against the main gene.

### Visualization in IGV
To inspect the phasing results in the Integrative Genomics Viewer (IGV):
1. Load the `.paraphase.bam` file.
2. **Group alignments by**: `HP` tag (Haplotype).
3. **Color alignments by**: `YC` tag (Haplotype-specific color).

## Reference documentation
- [Paraphase Overview](./references/anaconda_org_channels_bioconda_packages_paraphase_overview.md)
- [Paraphase GitHub Repository](./references/github_com_PacificBiosciences_paraphase.md)