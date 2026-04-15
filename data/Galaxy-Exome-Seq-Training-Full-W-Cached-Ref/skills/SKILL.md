---
name: exome-seq-training-full-w-cached-ref
description: This workflow processes trio-based exome sequencing data using BWA-MEM, FreeBayes, and GEMINI to identify candidate mutations associated with genetic diseases. Use this skill when you need to analyze family-based genomic data to discover inherited or de novo variants that may explain a clinical phenotype.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# exome-seq-training-full-w-cached-ref

## Overview

This workflow provides a comprehensive pipeline for exome sequencing (WES) data analysis, specifically tailored for diagnosing genetic diseases within a family trio. It processes paired-end FASTQ inputs from a father, mother, and proband, utilizing a PEDigree file to guide inheritance-based variant filtering.

The analysis begins with quality control using [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0) and [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1). Sequence reads are aligned to a reference genome using [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2), followed by data refinement steps including [Samtools](https://toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0) filtering and duplicate removal via [RmDup](https://toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1).

Variant calling is performed by [FreeBayes](https://toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.6+galaxy0), with subsequent normalization through [bcftools norm](https://toolshed.g2.bx.psu.edu/repos/iuc/bcftools_norm/bcftools_norm/1.15.1+galaxy3). Functional annotation is applied using [SnpEff](https://toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy2) to predict the biological impact of identified variants.

In the final stages, the workflow employs the [GEMINI](https://toolshed.g2.bx.psu.edu/repos/iuc/gemini_load/gemini_load/0.20.1+galaxy2) framework to integrate the variants into a searchable database. By applying [inheritance pattern](https://toolshed.g2.bx.psu.edu/repos/iuc/gemini_inheritance/gemini_inheritance/0.20.1) filters, the pipeline isolates candidate mutations relevant to the clinical case. This workflow is released under the MIT license and is frequently used in Galaxy Training Network (GTN) materials for variant analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | father_R1 | data_input | forward reads of the father sample |
| 1 | father_R2 | data_input | reverse reads of the father sample |
| 2 | mother_R1 | data_input | forward reads of the mother sample |
| 3 | mother_R2 | data_input | reverse reads of the mother sample |
| 4 | proband_R1 | data_input | forward reads of the child/proband sample |
| 5 | proband_R2 | data_input | reverse reads of the child/proband sample |
| 6 | PEDigree data | data_input | Family tree with sex and phenotype information in PED format |


Ensure all sequencing reads are provided in fastqsanger format, specifically as paired-end datasets for the father, mother, and proband to maintain proper mapping orientation. The pedigree information must be supplied as a valid PED file to enable GEMINI to correctly interpret inheritance patterns during variant filtering. While this workflow uses individual datasets, you can streamline execution by organizing paired reads into collections before launching. For automated job configuration and parameter staging, consider using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on reference genome versions and specific tool configurations.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 9 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2 |  |
| 10 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 11 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 12 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2 |  |
| 13 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 14 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 15 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2 |  |
| 16 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 17 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 18 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |
| 19 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.15.1+galaxy0 |  |
| 20 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 21 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 22 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 23 | FreeBayes | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.6+galaxy0 |  |
| 24 | bcftools norm | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_norm/bcftools_norm/1.15.1+galaxy3 |  |
| 25 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy2 |  |
| 26 | GEMINI load | toolshed.g2.bx.psu.edu/repos/iuc/gemini_load/gemini_load/0.20.1+galaxy2 |  |
| 27 | GEMINI inheritance pattern | toolshed.g2.bx.psu.edu/repos/iuc/gemini_inheritance/gemini_inheritance/0.20.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 18 | multiqc_input_data | html_report |
| 25 | snpeff_variant_stats | statsFile |
| 25 | normalized_snpeff_annotated_variants | snpeff_output |
| 27 | candidate_mutations | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow-exome-seq-full.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow-exome-seq-full.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow-exome-seq-full.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow-exome-seq-full.ga -o job.yml`
- Lint: `planemo workflow_lint workflow-exome-seq-full.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow-exome-seq-full.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)