---
name: gwas
description: This pipeline processes genotype data in VCF format alongside phenotype and covariate files to perform Genome Wide Association Studies and generate statistical results. Use when identifying genetic variants associated with specific traits across large cohorts while requiring integrated quality control via MultiQC.
homepage: https://github.com/nf-core/gwas
---

## Overview
The nf-core/gwas pipeline is designed for performing Genome Wide Association Studies (GWAS) to identify statistical associations between genetic variants and specific traits or phenotypes. It automates the processing of genomic data alongside phenotypic information to streamline large-scale association mapping across different study designs.

In practice, users provide genotype data in VCF format and corresponding phenotype files through a structured samplesheet. The pipeline generates comprehensive quality control reports and association statistics, allowing researchers to evaluate the significance of genetic markers and visualize results through standardized reporting tools.

## Data preparation
The pipeline requires a comma-separated (CSV) samplesheet specified with the `--input` parameter. This file must contain a header row and define the paths to the genetic data, phenotypes, and optional covariates for each sample.

`samplesheet.csv` example:
```csv
sample,vcf,pheno,cov
STUDY_GROUP_1,data/genotypes.vcf.gz,data/phenotypes.txt,data/covariates.txt
STUDY_GROUP_2,data/genotypes_alt.vcf.gz,data/phenotypes_alt.txt,
```

Required columns according to the input schema:
- `sample`: Unique identifier for the sample or group (cannot contain spaces).
- `vcf`: Path to the VCF file containing genetic variants.
- `pheno`: Path to the file containing phenotype data.
- `cov`: Path to the file containing covariate data (optional).

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to specify a container profile (e.g., `docker`, `singularity`, or `conda`) and a specific pipeline version using the `-r` flag.

```bash
nextflow run nf-core/gwas \
   -r 1.0.0 \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results
```

Use `-resume` to restart a run from the last successful step if the execution was interrupted. Pipeline parameters must be provided via the command line (using `--`) or a Nextflow `-params-file`; custom configuration files provided via `-c` should only be used for resource management and not for pipeline-specific parameters.

## Outputs
Results are saved in the directory specified by the `--outdir` parameter. The primary deliverable for assessing run quality is the MultiQC HTML report, which aggregates metrics from various stages of the analysis.

Key output categories include:
- **MultiQC**: A summary report (`multiqc_report.html`) containing quality control metrics.
- **Association Results**: Statistical outputs from the GWAS analysis.

For a complete list of output files and instructions on how to interpret them, refer to the [official output documentation](https://nf-co.re/gwas/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
