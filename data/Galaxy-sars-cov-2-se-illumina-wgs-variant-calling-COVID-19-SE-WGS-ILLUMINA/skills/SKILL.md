---
name: covid-19-variation-analysis-on-wgs-se-data
description: "This workflow processes single-end Illumina whole genome sequencing reads by mapping them to the SARS-CoV-2 reference genome using Bowtie2 and performing sensitive variant calling and annotation with LoFreq and SnpEff. Use this skill when you need to identify low-frequency viral mutations and assess their functional impact in COVID-19 samples to track intra-host diversity or evolutionary trends."
homepage: https://workflowhub.eu/workflows/112
---

# COVID-19: variation analysis on WGS SE data

## Overview

This Galaxy workflow is designed for the variation analysis of SARS-CoV-2 single-end (SE) Illumina whole-genome sequencing (WGS) data. It automates the process of transforming raw sequencing reads into annotated variant calls, utilizing the NC_045512.2 FASTA sequence as the reference genome. The pipeline is optimized for high sensitivity, capable of detecting variants across a wide range of allele frequencies.

The analysis begins with quality control and preprocessing using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.24.0+galaxy4), followed by read mapping with [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1). To ensure data integrity, the workflow employs Picard's [MarkDuplicates](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0) and generates comprehensive quality reports via [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3).

Variant calling is performed using the [LoFreq](https://toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.5+galaxy3) suite, which includes Viterbi realignment and indel quality insertion to improve call accuracy. The resulting variants are then filtered and annotated using [SnpEff](https://toolshed.g2.bx.psu.edu/repos/iuc/snpeff_sars_cov_2/snpeff_sars_cov_2/4.5covid19), specifically configured for the SARS-CoV-2 genome.

This workflow is released under the **MIT** license and is part of the [covid19.galaxyproject.org](https://covid19.galaxyproject.org) initiative. For detailed information on input preparation and file structures, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Single End Collection | data_collection_input | Illumina reads with fastqsanger encoding |
| 1 | NC_045512.2 FASTA sequence of SARS-CoV-2 | data_input | Fasta sequence for Severe acute respiratory syndrome coronavirus 2 isolate Wuhan-Hu-1, complete genome |


Ensure your single-end sequencing reads are uploaded as a list collection of FASTQ files and the SARS-CoV-2 reference is in FASTA format. Using a collection allows the workflow to parallelize mapping and variant calling across all samples simultaneously. Consult the README.md for specific instructions on data cleaning and metadata requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.24.0+galaxy4 |  |
| 3 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1 |  |
| 4 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0 |  |
| 5 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 6 | Realign reads | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.5+galaxy0 |  |
| 7 | Insert indel qualities | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_indelqual/lofreq_indelqual/2.1.5+galaxy1 |  |
| 8 | Call variants | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.5+galaxy3 |  |
| 9 | Lofreq filter | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_filter/lofreq_filter/2.1.5+galaxy0 |  |
| 10 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff_sars_cov_2/snpeff_sars_cov_2/4.5covid19 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | preprocessed_reads | out1 |
| 2 | fastp_html_report | report_html |
| 3 | mapped_reads | output |
| 4 | markduplicates_stats | metrics_file |
| 4 | markduplicates_reads | outFile |
| 5 | preprocessing_and_mapping_reports | html_report |
| 6 | realigned_deduplicated_mapped_reads | realigned |
| 7 | realigned_deduplicated_mapped_reads_with_indel_quals | output |
| 8 | called_variant | variants |
| 9 | soft_filtered_variants | outvcf |
| 10 | annotated_variants | snpeff_output |
| 10 | annotated_variants_stats | statsFile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run se-wgs-variation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run se-wgs-variation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run se-wgs-variation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init se-wgs-variation.ga -o job.yml`
- Lint: `planemo workflow_lint se-wgs-variation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `se-wgs-variation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
