---
name: oncogemini
description: OncoGEMINI is a specialized framework for exploring and filtering tumor variants by integrating genomic annotations with allele frequency signatures across longitudinal samples. Use when user asks to identify variants driving tumor evolution, detect clonal bottlenecks, find loss of heterozygosity, or query cancer genomics databases.
homepage: https://github.com/fakedrtom/oncogemini
---


# oncogemini

## Overview

OncoGEMINI is a specialized adaptation of the GEMINI framework designed for cancer genomics. It enables researchers to explore and filter tumor variants by integrating genomic annotations with allele frequency signatures across multiple samples from the same individual. The tool is optimized for longitudinal studies, allowing for the identification of variants that drive tumor evolution or represent specific selective pressures like clonal bottlenecks.

## VCF Preparation and Database Creation

Before using OncoGEMINI, VCF files must be properly formatted and converted into a GEMINI-compatible SQLite database.

### 1. Normalization and Decomposition
Multi-allelic sites must be decomposed and normalized using `vt`.
```bash
# Decompose and normalize a VCF
zless input.vcf.gz \
  | sed 's/ID=AD,Number=./ID=AD,Number=R/' \
  | vt decompose -s - \
  | vt normalize -r reference.fasta - \
  | bgzip -c > normalized.vcf.gz

tabix -p vcf normalized.vcf.gz
```

### 2. Annotation
Annotate the VCF with functional information (SnpEff or VEP) and additional cancer-relevant data using `vcfanno`.
```bash
vcfanno config.toml normalized.vcf.gz > annotated.vcf
```

### 3. Sample Manifest Format
Create a tab-delimited manifest file. The `time` column is critical: `0` represents normal/baseline, and `>0` represents subsequent tumor sampling points.
| family_id | name | paternal_id | maternal_id | sex | phenotype | patient_id | time | purity |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Normal | 0 | 0 | 1 | 1 | PatientA | 0 | 0 |
| 1 | Tumor_T1 | 0 | 0 | 1 | 2 | PatientA | 1 | 0.3 |
| 1 | Tumor_T2 | 0 | 0 | 1 | 2 | PatientA | 2 | 0.6 |

### 4. Building the Database
Use `vcf2db.py` to generate the searchable database.
```bash
vcf2db.py annotated.vcf.gz sample.manifest study.db
```

## Analysis Commands

### General Queries
Use the `query` tool for SQL-based filtering of variants.
```bash
# Find high-impact variants on a specific chromosome
oncogemini query -q "select chrom, start, end, ref, alt, gene from variants where chrom == '13' and impact_severity == 'HIGH'" study.db
```

### Identifying Clonal Bottlenecks
The `bottleneck` tool identifies variants where allele frequencies increase across sampling timepoints, suggesting clonal expansion.
*   **--minSlope**: Minimum AF increase rate (default 0.05).
*   **--minR**: Minimum correlation coefficient (default 0.5).
*   **--maxNorm**: Maximum AF allowed in the normal sample (default 0).

```bash
# Find variants with a steep increase in AF across timepoints
oncogemini bottleneck --minSlope 0.4 --minR 0.8 study.db
```

### Loss of Heterozygosity (LOH)
The `loh` tool identifies variants that are heterozygous in the normal sample but become homozygous in tumor samples.
```bash
oncogemini loh study.db
```

## Best Practices
*   **Annotation Depth**: OncoGEMINI's power depends on the annotations present in the VCF. Ensure you include CADD scores, ClinVar, and population frequencies (ExAC/gnomAD) during the `vcfanno` step.
*   **Purity Adjustment**: If tumor purity is known, include it in the manifest. Some tools can use this to better estimate expected allele frequencies.
*   **Normal Samples**: Always include a normal sample (time=0) when possible to allow the tools to filter out germline variants and accurately detect LOH.

## Reference documentation
- [OncoGEMINI GitHub Repository](./references/github_com_fakedrtom_oncogemini.md)
- [Bioconda OncoGEMINI Overview](./references/anaconda_org_channels_bioconda_packages_oncogemini_overview.md)