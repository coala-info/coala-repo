---
name: createpanelrefs
description: This pipeline generates Panel of Normals and reference models for CNVkit, GATK GermlineCNVCaller, GENS, and Mutect2 using BAM or CRAM alignment files and a reference genome. Use when building baseline references from a large cohort of normal samples to improve the accuracy of somatic mutation calling or germline copy number variation analysis.
homepage: https://github.com/nf-core/createpanelrefs
---

# createpanelrefs

## Overview
nf-core/createpanelrefs is a bioinformatics helper pipeline designed to create the necessary background models and "Panel of Normals" (PoN) required by various variant calling and copy number analysis tools. It processes multiple input samples to establish a baseline, which is then used in downstream analyses to filter out systematic noise and artifacts.

The pipeline supports several analysis routes including building ploidy and CNV calling models for GATK, and PoNs for somatic calling or visualization. It also performs standard read quality control using FastQC and aggregates results into a MultiQC report.

## Data preparation
The pipeline requires a comma-separated samplesheet provided via the `--input` parameter. This file must contain a header and specify the paths to alignment files and their corresponding indices.

Required columns:
- `sample`: Unique sample identifier (cannot contain spaces).
- `bam` or `cram`: Path to the alignment file.
- `bai` or `crai`: Path to the index file.

Example `samplesheet.csv`:
```csv
sample,bam,bai,cram,crai
sample1,sample1.bam,sample1.bai,,
sample2,,,sample2.cram,sample2.crai
```

**Constraints and References:**
- **Tool Compatibility:** `cnvkit` requires BAM files, while `germlinecnvcaller` supports BAM, CRAM, or a mix.
- **Genome:** A reference genome is required via `--genome` (using iGenomes) or by providing `--fasta`.
- **Tool-specific files:** Depending on the tool selected, additional files may be required such as `--gcnv_ploidy_priors`, `--gcnv_mappable_regions` (BED), or `--gens_interval_list`.

## How to run
Run the pipeline using the `nextflow run` command. You must specify the input samplesheet, the tools to be used, and the output directory.

```bash
nextflow run nf-core/createpanelrefs \
   -profile <docker/singularity/conda> \
   --input samplesheet.csv \
   --tools cnvkit,mutect2 \
   --genome GRCh38 \
   --outdir ./results
```

Common parameters:
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `test`).
- `--tools`: Comma-separated list of tools to run (`cnvkit`, `germlinecnvcaller`, `gens`, `mutect2`).
- `-r`: Pin a specific version of the pipeline (e.g., `-r 1.0.0`).
- `-resume`: Restart a pipeline from the last cached step.

## Outputs
Results are saved in the directory specified by `--outdir`. The structure includes tool-specific subdirectories containing the generated models or PoNs.

- `multiqc/`: Contains the `multiqc_report.html` which should be inspected first for an overview of read quality.
- `cnvkit/`: Reference models for CNVkit.
- `gatk/`: Ploidy and CNV models for GermlineCNVCaller or PoNs for Mutect2.
- `gens/`: Panel of Normals for GENS.
- `fastqc/`: Quality control reports for individual samples.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/createpanelrefs/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)