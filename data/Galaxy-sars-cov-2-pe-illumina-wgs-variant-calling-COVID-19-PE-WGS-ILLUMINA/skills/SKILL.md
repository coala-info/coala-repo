---
name: covid-19-variation-analysis-on-wgs-pe-data
description: "This workflow performs variation analysis on SARS-CoV-2 paired-end whole genome sequencing data using BWA-MEM for mapping, LoFreq for sensitive variant calling, and SnpEff for functional annotation. Use this skill when you need to identify low-frequency mutations and characterize the genetic diversity of COVID-19 samples from Illumina sequencing reads."
homepage: https://workflowhub.eu/workflows/113
---

# COVID-19: variation analysis on WGS PE data

## Overview

This workflow is designed for the variation analysis of SARS-CoV-2 paired-end (PE) whole-genome sequencing (WGS) data. It utilizes a paired collection of Illumina reads and the NC_045512.2 FASTA reference sequence to identify genomic variants with high sensitivity across a wide range of allele frequencies.

The pipeline begins with quality control and adapter trimming using [fastp](https://github.com/OpenGene/fastp), followed by read mapping with [BWA-MEM](https://github.com/lh3/bwa). To ensure high-quality alignments, the workflow performs filtering with Samtools, deduplication via Picard MarkDuplicates, and Viterbi realignment. Comprehensive reports are generated through [MultiQC](https://multiqc.info/) to summarize preprocessing and mapping statistics.

Variant detection is handled by the [LoFreq](https://csb5.github.io/lofreq/) suite, which incorporates indel quality insertion and soft filtering to maintain accuracy. The final stage involves functional annotation of the identified variants using [SnpEff](https://pcingola.github.io/SnpEff/) specifically configured for the SARS-CoV-2 genome.

This workflow is [emergen_validated](https://covid19.galaxyproject.org) and maintained by the Intergalactic Workflow Commission (IWC). It is released under the MIT license and follows best practices for [COVID-19](https://covid19.galaxyproject.org) genomic surveillance.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Paired Collection | data_collection_input | Illumina reads with fastqsanger encoding |
| 1 | NC_045512.2 FASTA sequence of SARS-CoV-2 | data_input | Fasta sequence for Severe acute respiratory syndrome coronavirus 2 isolate Wuhan-Hu-1, complete genome |


To prepare your data, upload paired-end Illumina reads as a Paired Collection (fastqsanger) and the SARS-CoV-2 reference genome in FASTA format. Ensure your read headers are compatible with BWA-MEM and that the reference sequence uses the NC_045512.2 accession for seamless integration with the SnpEff annotation step. For automated execution, you can initialize your configuration using `planemo workflow_job_init` to generate a `job.yml` file. Detailed instructions on data cleaning and specific parameter requirements are available in the README.md.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.20.1+galaxy0 |  |
| 3 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 4 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy2 |  |
| 5 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 |  |
| 6 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2 |  |
| 7 | Realign reads | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.5+galaxy0 |  |
| 8 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.9+galaxy1 |  |
| 9 | Insert indel qualities | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_indelqual/lofreq_indelqual/2.1.5+galaxy0 |  |
| 10 | Call variants | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.5+galaxy0 |  |
| 11 | Lofreq filter | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_filter/lofreq_filter/2.1.5+galaxy0 |  |
| 12 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff_sars_cov_2/snpeff_sars_cov_2/4.5covid19 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | fastp_pe | output_paired_coll |
| 2 | fastp_html_report | report_html |
| 3 | Map with BWA-MEM on input dataset(s) (mapped reads in BAM format) | bam_output |
| 4 | filtered_mapped_reads | outputsam |
| 5 | mapped_reads_stats | output |
| 6 | markduplicates_stats | metrics_file |
| 6 | markduplicates_reads | outFile |
| 7 | realigned_deduplicated_filtered_mapped_reads | realigned |
| 8 | preprocessing_and_mapping_reports | html_report |
| 9 | realigned_deduplicated_filtered_mapped_reads_with_indel_quals | output |
| 10 | called_variants | variants |
| 11 | soft_filtered_variants | outvcf |
| 12 | annotated_variants | snpeff_output |
| 12 | annotated_variants_stats | statsFile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run pe-wgs-variation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run pe-wgs-variation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run pe-wgs-variation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init pe-wgs-variation.ga -o job.yml`
- Lint: `planemo workflow_lint pe-wgs-variation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `pe-wgs-variation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
