---
name: yleaf
description: `yleaf` infers human Y-chromosome haplogroups from sequencing data. Use when user asks to infer Y-chromosome haplogroups, predict Y-chromosome haplogroups, visualize Y-chromosome haplogroup trees, report private Y-chromosome mutations, or analyze ancient Y-chromosome DNA.
homepage: https://github.com/genid/Yleaf
metadata:
  docker_image: "quay.io/biocontainers/yleaf:3.2.1--pyh1286868_0"
---

# yleaf

## Overview
`yleaf` is a specialized bioinformatics tool designed to automate the inference of human Y-chromosome haplogroups from sequencing data. It bridges the gap between raw sequencing reads and phylogenetic placement by identifying informative SNPs and mapping them against the YFull tree (v10.01+). The tool is capable of handling raw FASTQ files by performing its own alignment, or processing pre-aligned BAM/CRAM files and VCFs.

## Command Line Patterns

### Basic Haplogroup Prediction
The primary command is `Yleaf`. You must specify the input type, an output directory, and the reference genome version (hg19 or hg38).

**From Raw FASTQ:**
```bash
Yleaf -fastq sample.fastq -o output_dir --reference_genome hg38
```

**From Aligned BAM/CRAM:**
```bash
Yleaf -bam sample.bam -o output_dir --reference_genome hg19
Yleaf -cram sample.cram -o output_dir --reference_genome hg38
```

### Advanced Analysis Options
To gain more insight into the prediction or handle specific sample types, use the following flags:

*   **Visualization (`-dh`)**: Generates a PDF/graph showing the position of the predicted haplogroup within the Y-chromosome tree.
*   **Private Mutations (`-p`)**: Reports mutations found in the sample that are not defining the assigned haplogroup.
*   **Ancient DNA (`--ancient_DNA`)**: Optimizes the algorithm for degraded samples typical in archaeogenetics.

**Example for Ancient DNA with Visualization:**
```bash
Yleaf -bam ancient_sample.bam -o aDNA_results --reference_genome hg19 -dh -p --ancient_DNA
```

## Expert Tips and Best Practices

### Reference Genome Consistency
Always ensure the `--reference_genome` flag matches the assembly used for your input BAM/CRAM files. Mixing hg19 and hg38 coordinates will result in incorrect haplogroup assignments.

### Resource Management
*   **Storage**: Ensure at least 8GB of free space for the initial run, as the tool may download reference files.
*   **Custom Paths**: You can avoid automatic downloads or use custom reference files by editing the `yleaf/config.txt` file. This is useful for air-gapped systems or clusters where internet access is restricted.

### Input Requirements
*   **Linux Only**: `yleaf` is designed for Linux environments.
*   **Dependencies**: The tool relies on `minimap2` for FASTQ alignment and `samtools` for processing. Ensure these are in your PATH if not using the Conda environment.

### Interpreting Results
Version 3.0+ uses the YFull tree structure. If comparing results to older studies using the ISOGG tree, expect differences in nomenclature and resolution.

## Reference documentation
- [Yleaf GitHub Repository](./references/github_com_genid_Yleaf.md)
- [Yleaf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_yleaf_overview.md)