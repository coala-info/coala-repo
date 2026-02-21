---
name: hap.py
description: The `hap.py` suite provides specialized tools for comparing VCF files by resolving representational differences through graph-based haplotype matching.
homepage: https://github.com/Illumina/hap.py
---

# hap.py

## Overview

The `hap.py` suite provides specialized tools for comparing VCF files by resolving representational differences through graph-based haplotype matching. While standard tools might fail to match variants that are described differently (e.g., a single complex insertion vs. multiple atomic variants), `hap.py` enumerates possible haplotype paths to ensure accurate benchmarking. It is the industry standard for evaluating the performance of variant callers against reference sets like GIAB (Genome in a Bottle) or Platinum Genomes.

## Core CLI Patterns

### Standard Haplotype Comparison
Use the main `hap.py` executable for diploid samples where genotype-level matching is required.

```bash
hap.py truth.vcf.gz query.vcf.gz \
    -r reference.fasta \
    -f confident_regions.bed \
    -o output_prefix
```

### Somatic or Position-Based Comparison
Use `som.py` for somatic callsets or when you only want to verify that the same alleles were observed at the same positions without resolving haplotypes or genotypes.

```bash
som.py truth.vcf.gz query.vcf.gz \
    -r reference.fasta \
    -o output_prefix
```

### Variant Preprocessing
Use `pre.py` to normalize VCFs, atomize MNVs into individual SNPs, and perform left-shifting to ensure consistent counting.

```bash
pre.py input.vcf.gz output.vcf.gz -r reference.fasta
```

## Expert Tips and Best Practices

- **Reference FASTA**: Always provide the exact reference genome used for calling via the `-r` flag. Haplotype reconstruction is impossible without it.
- **Confident Regions**: Use the `-f` (or `--filter-regions`) flag with a BED file defining "high-confidence" regions. This prevents your precision/recall metrics from being skewed by "false positives" in regions where the truth set is intentionally silent.
- **Handling Complex Variants**: If your caller produces many complex or overlapping variants, `hap.py` will automatically attempt to decompose them. If you encounter corner cases, consider using the `--engine vcfeval` flag to utilize the RTG vcfeval engine within the `hap.py` workflow for more sophisticated path-finding.
- **Stratification**: To get granular performance data (e.g., performance in GC-rich regions or specific INDEL lengths), use the `--stratification` flag with GA4GH stratification BED files.
- **Input Requirements**: Ensure all input VCFs are block-gzipped (`.vcf.gz`) and indexed (`.tbi`).

## Common Output Files

- `output_prefix.summary.csv`: High-level precision and recall metrics.
- `output_prefix.extended.csv`: Detailed metrics including stratification breakdowns.
- `output_prefix.vcf.gz`: A merged VCF containing the truth and query calls with annotation tags (TP, FP, FN) for manual inspection in IGV.

## Reference documentation
- [hap.py GitHub Repository](./references/github_com_Illumina_hap.py.md)
- [hap.py Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hap.py_overview.md)