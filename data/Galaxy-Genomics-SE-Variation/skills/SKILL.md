---
name: covid-19-genomics-4-se-variation
description: This COVID-19 genomics workflow processes single-end sequencing data and the NC_045512 reference genome using fastp, Bowtie2, LoFreq, and SnpEff to identify and annotate genetic variations. Use this skill when you need to detect low-frequency intra-host variants and assess their functional impact on the SARS-CoV-2 genome to understand viral evolution or transmission patterns.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-genomics-4-se-variation

## Overview

This Galaxy workflow is designed for the analysis of genomic variation within individual COVID-19 samples using single-end (SE) sequencing data. It automates the process of identifying genetic variants by comparing sample sequences against the NC_045512 reference genome. The pipeline integrates quality control, read mapping, and variant calling to provide a comprehensive view of viral evolution and diversity within a dataset.

The process begins with raw data preprocessing using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1) for adapter trimming and quality filtering, followed by alignment to the reference genome using [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0). To ensure high-quality results, the workflow includes duplicate removal via [MarkDuplicates](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2) and local read realignment using [lofreq](https://toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.3.1+galaxy1).

Variant calling is performed by [lofreq](https://toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.3.1+galaxy1), with subsequent functional annotation provided by [SnpEff](https://toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1). The workflow generates multiple [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7.1) reports at various stages to monitor data quality and alignment statistics, ultimately producing a collapsed collection of extracted variant fields for downstream analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input |  |
| 1 | NC_045512 | data_input |  |


Ensure your single-end sequencing reads are uploaded as a dataset collection of fastq files, while the NC_045512 reference genome should be provided as a single dataset in GenBank or FASTA format. Utilizing a collection is essential for batch processing multiple samples through the trimming and alignment stages of the workflow. Please refer to the README.md for exhaustive documentation on data formatting and specific tool configurations. For streamlined execution, you may use `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 3 | SnpEff build: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff_build_gb/4.3+T.galaxy4 |  |
| 4 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7.1 |  |
| 5 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7.1 |  |
| 7 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2 |  |
| 8 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7.1 |  |
| 9 | Realign reads | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.3.1+galaxy1 |  |
| 10 | Call variants | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.3.1+galaxy1 |  |
| 11 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1 |  |
| 12 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 13 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | FASTP_report | html_report |
| 6 | bowtie_report | html_report |
| 8 | dedup_report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genomics-4-SE_Variation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genomics-4-SE_Variation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genomics-4-SE_Variation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genomics-4-SE_Variation.ga -o job.yml`
- Lint: `planemo workflow_lint Genomics-4-SE_Variation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genomics-4-SE_Variation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)