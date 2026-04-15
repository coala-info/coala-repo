---
name: kleborate
description: Kleborate performs genomic screening of *Klebsiella pneumoniae* assemblies to identify species, sequence types, virulence factors, and antimicrobial resistance genes. Use when user asks to characterize Klebsiella genomic data, perform MLST typing, identify resistance and virulence determinants, or predict K and O antigen types.
homepage: https://github.com/katholt/Kleborate
metadata:
  docker_image: "quay.io/biocontainers/kleborate:3.2.4--pyhdfd78af_0"
---

# kleborate

## Overview
Kleborate is a specialized genomic screening tool designed for the *Klebsiella pneumoniae* species complex. It transforms raw or assembled genomic data into actionable biological insights by identifying the specific species, sequence type (MLST), and the presence of critical virulence and resistance determinants. It is particularly effective for clinical microbiology and genomic surveillance, providing a standardized way to characterize "high-risk" clones that combine multidrug resistance with enhanced virulence.

## Common CLI Patterns

### Basic Screening
To run a standard analysis on a set of assemblies (FASTA format):
```bash
kleborate --assemblies *.fasta --output results.txt
```

### Comprehensive Typing (Virulence + Resistance + Kaptive)
To include K (capsule) and O (LPS) antigen prediction via Kaptive, use the `--kaptive` flag. This is essential for full strain characterization:
```bash
kleborate --assemblies *.fasta --kaptive --output comprehensive_results.txt
```

### Species-Specific Considerations
While optimized for *K. pneumoniae*, Kleborate supports other species with limited functionality (primarily MLST):
- **KpSC**: Full functionality (Species, MLST, Virulence, AMR, K/O typing).
- **K. oxytoca complex**: MLST support.
- **E. coli**: MLST support.

## Expert Tips and Best Practices

- **Input Quality**: Kleborate is designed for assemblies. While it can run on poor assemblies, fragmented genomes may lead to truncated gene detections or missed loci, especially for large virulence plasmids.
- **Resistance vs. Phenotype**: Use the `--resistance` flag (enabled by default in most versions) to get acquired gene profiles. Note that Kleborate v3 includes improved ciprofloxacin resistance prediction based on both SNPs and acquired genes.
- **Interpreting Virulence Scores**: Kleborate provides a virulence score (0-5) and an AMR score (0-3). These are categorical summaries that help quickly identify "convergent" strains (high virulence + high AMR).
- **Performance**: Kleborate v3 uses `minimap2` instead of BLAST, making it significantly faster for large datasets. If processing hundreds of genomes, ensure `minimap2` is in your PATH.
- **Output Analysis**: The output is a tab-delimited file. The `species` column should be checked first to confirm the assembly belongs to the KpSC before relying heavily on the K/O typing or virulence scores.

## Reference documentation
- [Kleborate GitHub Repository](./references/github_com_klebgenomics_Kleborate.md)
- [Bioconda Kleborate Overview](./references/anaconda_org_channels_bioconda_packages_kleborate_overview.md)