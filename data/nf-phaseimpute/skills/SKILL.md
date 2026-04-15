---
name: phaseimpute
description: This pipeline phases and imputes genetic data using BAM, CRAM, or VCF inputs alongside a reference panel and optional genetic maps to produce unified, imputed VCF files. Use when performing low-pass sequencing imputation, preparing reference panels with Shapeit5, or validating imputation accuracy against a truth set using tools like GLIMPSE, QUILT, or STITCH.
homepage: https://github.com/nf-core/phaseimpute
---

# phaseimpute

## Overview
nf-core/phaseimpute is a bioinformatics pipeline designed to estimate missing genotypes and determine chromosomal phasing. It addresses the challenges of low-coverage sequencing by leveraging reference panels to fill in missing genetic information, supporting multiple imputation engines such as GLIMPSE, QUILT, STITCH, Beagle5, and Minimac4.

The pipeline provides a modular framework that can handle the entire analysis lifecycle, including simulating low-pass data from high-depth files, preparing and phasing reference panels, performing the primary imputation, and validating results against a truth set. Users can run the full workflow or execute specific modules independently based on their data requirements.

## Data preparation
The pipeline requires a samplesheet and reference files. All paths in samplesheets must be absolute or relative to the execution directory.

**Input Samplesheet (`--input`)**
A CSV, TSV, YAML, or JSON file containing the target samples.
```csv
sample,file,index
SAMPLE_1,/path/to/data.bam,/path/to/data.bam.bai
SAMPLE_2,/path/to/data.vcf.gz,/path/to/data.vcf.gz.csi
```

**Reference Panel Samplesheet (`--panel`)**
Required for panel preparation or imputation steps.
```csv
panel,chr,vcf,index
Phase3,1,ref_chr1.vcf.gz,ref_chr1.vcf.gz.csi
Phase3,2,ref_chr2.vcf.gz,ref_chr2.vcf.gz.csi
```

**Reference Genome and Metadata**
- **FASTA**: Path to the reference genome (`--fasta`) is mandatory if not using a pre-configured `--genome`.
- **Genetic Map**: An optional recombination map (`--map`) can be provided to refine the imputation process.
- **Regions**: An optional regions file (`--input_region`) with `chr,start,end` columns can restrict analysis to specific genomic areas.

## How to run
The pipeline is executed using `nextflow run`. It is recommended to use a specific version with `-r` and a container profile.

```bash
# Basic imputation run with GLIMPSE2
nextflow run nf-core/phaseimpute \
    -profile <docker/singularity/conda> \
    --input samplesheet.csv \
    --panel panel.csv \
    --fasta genome.fasta \
    --steps impute \
    --tools glimpse2 \
    --outdir ./results

# Run simulation and validation
nextflow run nf-core/phaseimpute \
    -profile <profile> \
    --input high_depth_samples.csv \
    --steps simulate,impute,validate \
    --depth 1.0 \
    --outdir ./benchmark_results
```

Key parameters:
- `--steps`: Defines which parts of the pipeline to run (`simulate`, `panelprep`, `impute`, `validate`, or `all`).
- `--tools`: Specifies the imputation engine (e.g., `glimpse1`, `glimpse2`, `quilt`, `stitch`, `beagle5`, `minimac4`).
- `-resume`: Restarts the pipeline from the last successful step if interrupted.

## Outputs
Results are saved in the directory specified by `--outdir`.

- **Imputed Data**: The primary output is a set of VCF or BCF files containing the imputed and phased genotypes, typically ligated into a single file per sample.
- **Reports**: A MultiQC report is generated to summarize quality control metrics across the run.
- **Validation**: If the validation step is enabled, the pipeline produces concordance summaries and R-squared computations comparing imputed data to the truth set.
- **Panel Prep**: If panel preparation is run, phased and normalized reference VCFs and their corresponding indices are provided.

For a complete list of output files and their formats, refer to the [official output documentation](https://nf-co.re/phaseimpute/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/development.md`](references/docs/development.md)
- [`references/docs/images/metro/filtermetro.md`](references/docs/images/metro/filtermetro.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)