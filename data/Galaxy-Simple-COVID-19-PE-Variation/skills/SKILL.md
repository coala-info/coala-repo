---
name: simple-covid-19-pe-variation
description: "This workflow processes paired-end Illumina COVID-19 sequencing data from SRA manifests using BWA-MEM for alignment, LoFreq for sensitive variant calling, and SnpEff for functional annotation against the NC_045512.2 reference. Use this skill when you need to identify low-frequency intra-host variations or characterize the mutational profile of SARS-CoV-2 samples to monitor viral evolution and lineage diversity."
homepage: https://workflowhub.eu/workflows/1642
---

# Simple COVID-19 - PE Variation

## Overview

This Galaxy workflow is designed for the analysis of genomic variation within individual COVID-19 samples using paired-end Illumina sequencing data. It automates the process of identifying variants relative to the SARS-CoV-2 reference genome ([NC_045512.2](https://www.ncbi.nlm.nih.gov/nuccore/NC_045512.2)), facilitating research into viral evolution and strain characterization.

The pipeline begins by retrieving raw sequencing data via an SRA Manifest using [fasterq-dump](https://github.com/ncbi/sra-tools), followed by quality control and adapter trimming with [fastp](https://github.com/OpenGene/fastp). Reads are then aligned to the reference genome using [BWA-MEM](http://bio-bwa.sourceforge.net/), with subsequent steps for marking duplicates and realigning reads to improve variant calling accuracy.

Variant detection is performed using the [LoFreq](https://csb5.github.io/lofreq/) suite, which is specifically optimized for identifying low-frequency variants in viral populations. The identified variants are then annotated using [SnpEff](https://pcingola.github.io/SnpEff/) to determine their functional impact on the viral genome.

The workflow concludes by generating comprehensive reports, including a tabular summary of variants via [SnpSift](https://pcingola.github.io/SnpEff/ss_extractfields/) and an integrated quality control report using [MultiQC](https://multiqc.info/). This structured approach ensures a reproducible path from raw SRA data to annotated variant calls.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | NC_045512.2 fasta file | data_input | Contains SARS-CoV-2 reference sequence |
| 1 | SRA Manifest | data_input |  |


Ensure the reference genome is provided in FASTA format and the SRA manifest is a plain text file containing valid accessions for the automated download step. Because the workflow generates a paired-end collection from the manifest, verify that your input list is correctly formatted to ensure proper data flow through the trimming and mapping tools. For comprehensive details on manifest structure and specific reference requirements, consult the README.md file. You may also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.7+galaxy1 |  |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.20.1+galaxy0 |  |
| 4 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 5 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2 |  |
| 6 | Realign reads | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.5+galaxy0 |  |
| 7 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 |  |
| 8 | Insert indel qualities | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_indelqual/lofreq_indelqual/2.1.5+galaxy0 |  |
| 9 | Call variants | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.5+galaxy0 |  |
| 10 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff_sars_cov_2/snpeff_sars_cov_2/4.5covid19 |  |
| 11 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 12 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.8+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | list_paired | list_paired |
| 8 | Realigned Alignments with Indel Qualities | output |
| 10 | snpeff_output | snpeff_output |
| 11 | SnpSift tabular output | output |
| 12 | MultiQC Report PE | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
