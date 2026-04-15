---
name: cluster_vcf_records
description: This tool consolidates variant records from multiple VCF files into non-redundant clusters by grouping physically close or overlapping variants. Use when user asks to cluster variants, merge VCF files, or normalize genomic records for pangenome graph construction.
homepage: https://github.com/iqbal-lab-org/cluster_vcf_records
metadata:
  docker_image: "quay.io/biocontainers/cluster_vcf_records:0.13.3--pyhdfd78af_0"
---

# cluster_vcf_records

## Overview
`cluster_vcf_records` is a specialized Python utility designed to consolidate variant records from one or more VCF files into non-redundant clusters. By grouping variants that are physically close or overlapping on a reference sequence, it facilitates the construction of pangenome graphs and ensures that complex genomic regions are represented accurately. It handles the heavy lifting of variant normalization and coordinate reconciliation across multiple samples.

## Installation and Environment Setup
The tool requires several external bioinformatics utilities to be present in your `$PATH`. Ensure these are installed before execution:

- **Mandatory**: `vt` and `vcflib` (specifically `vcfbreakmulti`, `vcfallelicprimitives`, and `vcfuniq`).
- **Optional**: `bcftools` (only required if you are processing `.bcf` files).

Install the package via Conda or Pip:
```bash
conda install -c bioconda cluster_vcf_records
# OR
pip install cluster_vcf_records
```

## Usage Patterns

### Python API Usage
The most common way to use this tool is within a Python script to merge multiple VCFs against a reference genome.

```python
import cluster_vcf_records

# List of input VCF files (supports .vcf and .vcf.gz)
input_vcfs = ['sample_a.vcf', 'sample_b.vcf.gz']
reference = 'genome_ref.fasta'
output = 'clustered_variants.vcf'

# Perform clustering
cluster_vcf_records.cluster(input_vcfs, reference, output)
```

### Advanced Clustering Control
For more complex workflows, you can interface with the `VcfClusterer` class directly to access optional parameters:

- **Parallelization**: The tool supports parallel clustering to improve performance on large datasets.
- **Allele Management**: You can configure the tool to avoid breaking alleles during the merging process.
- **Reference Calls**: Options are available to either keep or discard reference call records depending on the requirements of your downstream caller.

## Expert Tips and Best Practices
- **Reference Consistency**: Always ensure the reference FASTA file used for clustering is identical to the one used for the original variant calling to prevent coordinate shifts.
- **Handling Heterozygotes**: Ensure you are using version 0.13.3 or later for improved handling of heterozygous genotypes (GT fields).
- **Input Flexibility**: The tool automatically handles (b)gzipped VCF files and can simplify them before normalization.
- **Filtering**: The tool adds `PASS` to the FILTER column for all output records to ensure compatibility with `gramtools`.
- **Memory Safety**: For regions with extremely high variant density, the tool includes internal checks to prevent an explosion of allele combinations, which protects against memory exhaustion.

## Reference documentation
- [cluster_vcf_records GitHub Repository](./references/github_com_iqbal-lab-org_cluster_vcf_records.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cluster_vcf_records_overview.md)