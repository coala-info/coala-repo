---
name: bolt-lmm
description: BOLT-LMM is a high-performance statistical tool for genetic association analysis.
homepage: https://alkesgroup.broadinstitute.org/BOLT-LMM/
---

# bolt-lmm

## Overview
BOLT-LMM is a high-performance statistical tool for genetic association analysis. It excels at handling datasets with tens of thousands to millions of individuals by using a linear mixed model (LMM) approach that does not require the explicit computation of a Genetic Relationship Matrix (GRM). This skill provides the necessary command-line patterns and parameter optimizations to execute association tests, estimate heritability, and manage large-scale genotype data in PLINK or BGEN formats.

## Core Usage Patterns

### Basic Association Analysis
The standard execution requires genotype data for model fitting (usually filtered for high-quality SNPs) and the full set of SNPs to be tested.

```bash
bolt \
    --bfile=genotypes_for_model_fitting \
    --phenoFile=phenotypes.txt \
    --phenoCol=HEIGHT \
    --lmm \
    --LDscoresFile=tables/LDSCORE.1000G_EUR.gz \
    --statsFile=output.stats.gz
```

### Working with BGEN Data
For large cohorts like the UK Biobank, use BGEN files for the association testing step to save space and include imputed variants.

```bash
bolt \
    --bfile=model_fitting_snps \
    --bgenFile=data.bgen \
    --sampleFile=data.sample \
    --statsFileBgenSnps=output.bgen.stats.gz \
    --lmm
```

## Expert Tips and Best Practices

### Model Fitting vs. Testing
- **Model Fitting SNPs**: Use a subset of ~300,000 to 500,000 high-quality, independent SNPs (LD-pruned) for the `--bfile` argument to build the mixed model.
- **Testing SNPs**: Use the `--bgenFile` or `--statsFile` arguments to test the full set of millions of variants against the model.

### Handling Covariates
- Categorical covariates: Use `--covarFile` and `--covarCol`.
- Quantitative covariates: Use `--qCovarFile` and `--qCovarCol`.
- Always include age, sex, and the first 10-20 Principal Components (PCs) to further control for population structure.

### Computational Optimization
- **Threads**: Use `--numThreads` to match your CPU allocation.
- **Memory**: BOLT-LMM is memory-intensive. Ensure your environment has at least 100GB+ RAM for UK Biobank-scale analysis.
- **LD Scores**: Ensure the `--LDscoresFile` matches the ancestry of your study population (typically 1000 Genomes European for standard runs).

### Common Parameter Adjustments
- `--lmmForceNonInf`: Use this if the infinitesimal model fails to converge or if you suspect a non-infinitesimal genetic architecture.
- `--maxModelSnps`: If you have more than 500k SNPs in your model-fitting file, you may need to increase this limit (default is 500,000).

## Reference documentation
- [bolt-lmm Overview](./references/anaconda_org_channels_bioconda_packages_bolt-lmm_overview.md)