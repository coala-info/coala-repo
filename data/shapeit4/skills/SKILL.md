---
name: shapeit4
description: SHAPEIT4 is a high-performance tool used for phasing large-scale genomic datasets to estimate haplotypes from unphased genotypes. Use when user asks to phase genomic data, estimate haplotypes from SNP arrays or sequencing data, or perform fast chromosome-scale phasing using multi-threading.
homepage: https://odelaneau.github.io/shapeit4/
---


# shapeit4

## Overview
SHAPEIT4 is a high-performance tool designed for phasing large-scale genomic datasets. It utilizes a Positional Burrows-Wheeler Transform (PBWT) to efficiently select informative conditioning haplotypes, making it significantly faster than previous versions while maintaining high accuracy. It is particularly effective for SNP arrays and sequencing data where multi-threading and hardware optimization (AVX2) are required for processing speed.

## Core Usage Patterns

### Basic Phasing Command
To phase a specific genomic region using default parameters:
```bash
shapeit4 --input unphased.vcf.gz \
         --map chr20.b37.gmap.gz \
         --region 20 \
         --output phased.vcf.gz
```
*Note: The input VCF/BCF file must be indexed (e.g., using `bcftools index`).*

### Phasing Specific Chunks
For large chromosomes, it is common to phase in smaller intervals:
```bash
shapeit4 --input input.vcf.gz --map map.gz --region 20:2000000-3000000 --output output.vcf.gz
```

### Multi-threading
Enable multi-threading to improve performance, especially for HTSlib I/O and HMM routines:
```bash
shapeit4 --input input.bcf --map map.gz --region 20 --output output.bcf --thread 8
```

## Advanced Configuration

### Sequencing Data Optimization
When working with high-density sequencing data, use the `--sequencing` flag to adjust internal parameters for better accuracy:
```bash
shapeit4 --input seq_data.bcf --map map.gz --region 20 --sequencing --output phased.bcf
```

### Using Haplotype Scaffolds
To account for pre-phased genotypes (from family data or large reference panels):
```bash
shapeit4 --input input.bcf --map map.gz --region 20 --scaffold scaffold.bcf --output phased.bcf
```

### Custom MCMC Iteration Scheme
You can define the number of burn-in (b), pruning (p), and main (m) iterations:
```bash
shapeit4 --input input.bcf --map map.gz --region 20 --mcmc-iterations 6b,1p,2b,1p,2b,8m --output phased.bcf
```

## Expert Tips & Best Practices
- **File Formats**: Use BCF instead of VCF for significantly faster I/O performance. SHAPEIT4 detects the format based on the file extension.
- **Chromosome Naming**: Ensure the chromosome ID in the `--region` argument matches the VCF header exactly (e.g., `20` vs `chr20`).
- **Pre-processing**: For sequencing data, it is recommended to use **WhatsHap** as a pre-processing step to extract phase information from BAM files before running SHAPEIT4.
- **Hardware**: Run SHAPEIT4 on CPUs supporting the AVX2 instruction set for optimal performance, as the HMM routines are heavily optimized for this architecture.
- **Missing Data**: Version 4.1.2+ includes improved algorithms for datasets with high missingness (>20%). Ensure you are using the latest version for these cases.

## Reference documentation
- [SHAPEIT4 Documentation](./references/odelaneau_github_io_shapeit4.md)
- [Bioconda shapeit4 Overview](./references/anaconda_org_channels_bioconda_packages_shapeit4_overview.md)