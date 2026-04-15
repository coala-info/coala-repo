---
name: sneep
description: SNEEP prioritizes non-coding variants by analyzing their impact on transcription factor binding sites using epigenetic data. Use when user asks to prioritize non-coding variants, detect disruptions in transcription factor binding sites, or perform functional annotation of disease-associated SNPs.
homepage: https://github.com/SchulzLab/SNEEP
metadata:
  docker_image: "quay.io/biocontainers/sneep:1.1--py311ha48eb5d_3"
---

# sneep

## Overview
SNEEP (SNp Exploration and Analysis using EPigenomics data) is a specialized bioinformatics tool designed to prioritize non-coding variants by their regulatory potential. It integrates user-provided SNP/SNV lists with epigenetic datasets to detect variations that disrupt or create transcription factor binding sites. Use this skill when you need to perform high-throughput functional annotation of variants, particularly in the context of disease-associated SNPs (like those from GWAS) where the mechanism of action is likely regulatory rather than protein-coding.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the necessary channels.

```bash
conda install bioconda::sneep
```

## Core CLI Usage
SNEEP processes variant data (VCF or coordinate-based formats) against TF motifs and epigenetic tracks.

### Input Requirements
Before running SNEEP, ensure you have the following resources prepared:
- **Variant Files**: A VCF file or a list of SNPs.
- **TF Motifs**: Position Weight Matrices (PWMs) for the transcription factors of interest.
- **Epigenetic Data**: Peak files (BED format) or signal tracks (BigWig) representing chromatin accessibility (ATAC-seq/DNase-seq) or histone marks (H3K27ac).
- **Gene Annotations**: To link rSNVs to target genes.

### Common Command Patterns
While specific flags depend on the version, the general execution flow involves:

1. **Running the Analysis**:
   Execute the main binary (typically `sneep`) pointing to your variant file and the directory containing necessary epigenomic reference files.
   
2. **VCF Integration**:
   Use the VCF option for standard genomic pipelines. SNEEP calculates the difference in binding affinity (affinity change score) between the reference and alternative alleles.

3. **Parameter Tuning**:
   - **Epsilon**: Adjust the epsilon parameter to control the sensitivity of the statistical approach for identifying significant binding site modifications.
   - **Background Sampling**: For disease-gene association, use background sampling (e.g., SNPSNAP) to validate the enrichment of regulatory potential.

## Best Practices and Expert Tips
- **Model vs. Non-Model Organisms**: SNEEP is optimized for model organisms (Human/Mouse) where TF motifs and epigenetic data are abundant. For non-model organisms, you must manually provide the `necessaryInputFiles` including genome-specific TF motifs and gene name mappings.
- **Memory Management**: When processing large-scale GWAS datasets, ensure OpenMP is enabled (supported in v1.0+) to utilize multi-threading for the affinity calculation step.
- **Affinity Scores**: Focus on the "delta" or change in binding affinity. A high absolute change indicates a high probability that the SNP disrupts a regulatory element.
- **Validation**: Cross-reference identified rSNVs with the `ensemblID_GeneName.txt` mapping file provided in the repository to ensure correct gene-variant linking.

## Reference documentation
- [Anaconda Bioconda SNEEP Overview](./references/anaconda_org_channels_bioconda_packages_sneep_overview.md)
- [GitHub Repository - SchulzLab/SNEEP](./references/github_com_SchulzLab_SNEEP.md)