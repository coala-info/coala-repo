---
name: merfin
description: Merfin (k-mer based variant filtering) is a specialized tool for improving the accuracy of genomic variant calls and assembly consensus.
homepage: https://github.com/arangrhie/merfin
---

# merfin

## Overview
Merfin (k-mer based variant filtering) is a specialized tool for improving the accuracy of genomic variant calls and assembly consensus. It works by comparing the k-mer multiplicity found in raw reads against the expected k-mer consequences of variant calls in a reference or assembly. It is primarily used to filter VCF files to ensure only high-confidence variants are used for polishing, and to generate quality metrics like QV* and K* completeness that account for both missing and excess k-mers.

## Common CLI Patterns

### 1. Filtering Variants for Polishing
To filter a VCF for assembly polishing where the reads and assembly come from the same individual:
```bash
merfin -polish \
  -sequence assembly.fasta \
  -readmers reads.meryl \
  -peak <haploid_peak> \
  -vcf input.vcf \
  -output merfin_polished
```
*Note: Use `-loose` instead of `-polish` if the variant call set is already highly curated.*

### 2. Assembly Quality Assessment (QV)
To calculate Merqury-style QV and the improved QV* (which accounts for excess k-mers):
```bash
merfin -hist \
  -sequence assembly.fasta \
  -readmers reads.meryl \
  -peak <haploid_peak> \
  -output assembly_qv
```

### 3. Assessing Collapses and Duplications
To generate a per-base k-mer multiplicity track to identify assembly errors:
```bash
merfin -dump \
  -sequence assembly.fasta \
  -readmers reads.meryl \
  -peak <haploid_peak> \
  -output assembly_dump
```

### 4. Variant Filtering for Genotyping
When the reference genome is from a different individual (e.g., GRCh38):
```bash
merfin -filter \
  -sequence reference.fasta \
  -readmers reads.meryl \
  -vcf input.vcf \
  -output filtered_genotypes
```

## Expert Tips and Best Practices

### Peak and Probability Selection
*   **The Peak Parameter:** The `-peak` value is mandatory for most modes. 
    *   Use the **haploid peak** for fully-phased or partially-phased assemblies.
    *   Use the **diploid peak** (2x haploid) for pseudo-haploid representations of diploid genomes.
*   **GenomeScope 2.0 Integration:** It is highly recommended to provide a lookup table using `-prob`. Generate this by running GenomeScope 2.0 with the `--fitted_hist` option on your k-mer histogram. This significantly improves accuracy by providing fitted copy-number probabilities.

### Polishing Modes
*   **-loose:** Removes variants only when missing (error) k-mers increase. It includes neutral alternate paths that score equally to the reference. Recommended for highly curated VCFs.
*   **-strict:** Only includes variants that actively decrease the number of missing k-mers.
*   **-polish:** The standard mode for general polishing tasks.

### Resource Management
*   **Memory:** Use `-memory <GB>` to limit RAM usage during k-mer lookup table construction.
*   **Threads:** Use `-threads <int>` to parallelize meryl lookups and VCF processing.

### Post-Processing Merfin Output
After running Merfin in a polishing mode, apply the filtered variants to your assembly using `bcftools`:
```bash
# Compress and index the merfin output
bcftools view -Oz output.polish.vcf > output.polish.vcf.gz
bcftools index output.polish.vcf.gz

# Apply consensus
bcftools consensus output.polish.vcf.gz -f assembly.fasta -H 1 > polished_assembly.fasta
```

## Reference documentation
- [Merfin GitHub Repository](./references/github_com_arangrhie_merfin.md)
- [Bioconda Merfin Package](./references/anaconda_org_channels_bioconda_packages_merfin_overview.md)