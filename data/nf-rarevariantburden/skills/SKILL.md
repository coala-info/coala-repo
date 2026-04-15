---
name: rarevariantburden
description: This pipeline performs rare variant burden tests by comparing case-only joint-called VCFs against public summary count data like gnomAD, utilizing Annovar or VEP for annotation and R-based CoCoRV for statistical analysis. Use when matched control sequencing data is unavailable and you need to identify disease-predisposition genes through ethnicity-stratified or sex-stratified analysis of rare variants.
homepage: https://github.com/nf-core/rarevariantburden
---

# rarevariantburden

## Overview
nf-core/rarevariantburden (CoCoRV-nf) addresses the challenge of performing rare variant burden tests when only patient/case sequencing data is available. It leverages pre-processed public summary counts from gnomAD (v2 or v4.1) as a proxy for control groups to identify disease-predisposition genes.

The pipeline handles VCF normalization, multi-tool annotation, ethnicity prediction using random forest classifiers, and stratified association testing. It produces statistical reports including p-values, FDR controls, and visualization plots to highlight potential disease-associated genes while accounting for linkage disequilibrium and population stratification.

## Data preparation
The pipeline requires case-specific genomic data and external reference resources that must be staged locally.

*   **Case VCF**: A joint-called and VQSR-applied VCF file from the case cohort.
*   **Sample List**: A one-column text file containing sample IDs, one per line.
*   **Control Data**: Summary count datasets (gnomAD v2 exome for GRCh37, or v4.1 exome/genome for GRCh38) must be downloaded from `s3://cocorv-resource-files/`.
*   **Annotation Resources**: Local folders for Annovar and/or VEP resource files are required.

Example sample list (`samples.txt`):
```text
HG001
HG002
HG003
```

## How to run
Run the pipeline using `nextflow run`. You must specify the reference genome build and the corresponding gnomAD version.

```bash
nextflow run nf-core/rarevariantburden \
   -profile <docker/singularity/conda> \
   --caseJointVCF case_study.vcf.gz \
   --caseSample samples.txt \
   --controlDataFolder ./gnomADv4.1exome \
   --annovarFolder ./annovarFolder \
   --reference GRCh38 \
   --gnomADVersion v4exome \
   --outdir ./results
```

Key parameters include:
*   `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`).
*   `--caseJointVCF`: Path to the input VCF.
*   `--controlDataFolder`: Path to the downloaded gnomAD control files.
*   `--reference`: Genome build (`GRCh37` or `GRCh38`).
*   `--gnomADVersion`: Version of control data (`v2exome`, `v4exome`, or `v4genome`).
*   `-resume`: Use this to restart a run from the last cached step.

## Outputs
Results are saved in the directory specified by `--outdir`.

*   **Association Results**: Merged rare variant burden test results across all analyzed chromosomes.
*   **Statistical Reports**: QQ plots, lambda values for inflation factor estimation, and FDR calculations.
*   **Top Gene Details**: For the top K genes (default 1000), the pipeline generates lists of samples and associated variants with their specific annotations.
*   **Ancestry**: Ethnicity prediction results for the case samples based on gnomAD classifiers.

For a complete list of output files and interpretation guides, refer to the official [output documentation](https://nf-co.re/rarevariantburden/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)