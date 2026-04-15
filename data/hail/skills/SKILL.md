---
name: hail
description: Hail is a high-performance Python framework for the scalable analysis and exploration of massive genomic datasets. Use when user asks to ingest genomic data, perform quality control, annotate variants, or run statistical analyses like GWAS and PCA.
homepage: https://hail.is
metadata:
  docker_image: "quay.io/biocontainers/hail:0.2.61--py311h9948957_3"
---

# hail

## Overview
Hail is a high-performance, Python-based framework designed for the exploration and analysis of massive genomic datasets. It replaces traditional coordinate-based tables with a specialized `MatrixTable` structure that efficiently handles the multi-dimensional nature of genetic data (samples x variants). Use this skill to streamline data ingestion, perform rigorous quality control, annotate variants with external databases, and run statistical tests like linear regression or gene burden tests at biobank scale.

## Core Concepts
- **MatrixTable (mt)**: The primary data structure. It contains four field types: `globals`, `rows` (variant data), `cols` (sample data), and `entries` (genotypes/DP/GQ).
- **Expressions**: Hail uses a declarative syntax. Operations on fields return expressions that are evaluated lazily across a cluster or local cores.
- **Keys**: Rows are typically keyed by `locus` and `alleles`; columns are keyed by sample ID (`s`).

## Common Workflows

### 1. Data Ingestion
Import standard genomic formats into Hail's native format for faster processing:
```python
import hail as hl
hl.init()

# Import from various formats
mt = hl.import_vcf('data/sample.vcf.bgz')
# mt = hl.import_plink(bed='data/test.bed', bim='data/test.bim', fam='data/test.fam')
# mt = hl.import_bgen('data/test.bgen', entry_fields=['GT', 'GP'], sample_file='data/test.sample')

# Always write to .mt format for production performance
mt.write('output/dataset.mt', overwrite=True)
mt = hl.read_matrix_table('output/dataset.mt')
```

### 2. Quality Control (QC)
Generate metrics and filter data:
```python
# Sample and Variant QC
mt = hl.sample_qc(mt)
mt = hl.variant_qc(mt)

# Filter samples: > 95% call rate
mt = mt.filter_cols(mt.sample_qc.call_rate >= 0.95)

# Filter variants: > 1% MAF and > 95% call rate
mt = mt.filter_rows((mt.variant_qc.AF[1] > 0.01) & (mt.variant_qc.call_rate > 0.95))

# Sex Check
imputed_sex = hl.impute_sex(mt.GT)
mt = mt.annotate_cols(sex_check = imputed_sex[mt.s])
```

### 3. Annotation and Manipulation
Add metadata to rows or columns:
```python
# Annotate rows with a separate table
ann_table = hl.read_table('annotations.ht')
mt = mt.annotate_rows(info = ann_table[mt.locus, mt.alleles])

# Update entry fields (e.g., set low GQ genotypes to missing)
mt = mt.annotate_entries(GT = hl.or_missing(mt.GQ >= 20, mt.GT))
```

### 4. Statistical Analysis (GWAS)
Run association tests with covariates:
```python
# PCA for population structure
eigenvalues, pcs, _ = hl.hwe_normalized_pca(mt.GT, k=5)
mt = mt.annotate_cols(pca = pcs[mt.s])

# Linear Regression
gwas = hl.linear_regression_rows(
    y=mt.pheno.height, 
    x=mt.GT.n_alt_alleles(),
    covariates=[1.0, mt.pheno.age, mt.pca.scores[0], mt.pca.scores[1]]
)

# Visualization
p = hl.plot.manhattan(gwas.p_value)
```

## Expert Tips
- **Lazy Evaluation**: Hail doesn't compute results until you call an action like `count()`, `show()`, `collect()`, or `write()`.
- **Avoid .entries()**: Converting a MatrixTable to a coordinate-form Table via `mt.entries()` is extremely memory-intensive. Use `annotate_rows` or `aggregate_rows` instead.
- **Storage**: Use `gs://` or `s3://` paths directly if working in the cloud; Hail handles the localization.
- **Memory**: Ensure Java 11 JRE is installed, as Hail runs on a Spark backend.

## Reference documentation
- [Hail Overview MatrixTable](./references/hail_is_docs_0.2_overview_matrix_table.html.md)
- [Hail Tutorial](./references/hail_is_tutorial.html.md)
- [Hail Getting Started](./references/hail_is_docs_0.2_getting_started.html.md)