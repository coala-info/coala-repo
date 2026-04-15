---
name: covid-19-genomics-4-pe-variation
description: This COVID-19 genomics workflow processes paired-end sequencing reads and a GenBank reference using fastp, BWA-MEM, LoFreq, and SnpEff to identify and annotate genetic variations within individual viral samples. Use this skill when you need to detect low-frequency variants, assess viral evolution, or characterize the mutational landscape of SARS-CoV-2 samples from raw sequencing data.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-genomics-4-pe-variation

## Overview

This Galaxy workflow is designed for the analysis of genomic variation within individual COVID-19 samples using paired-end sequencing data. It automates the process of identifying single nucleotide polymorphisms (SNPs) and small indels by comparing raw sequencing reads against a reference GenBank file. The pipeline is optimized for high-throughput processing, ensuring consistent variant calling across multiple samples.

The process begins with data preprocessing using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1) for quality control and adapter trimming, followed by read mapping with [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1). To ensure high-quality results, the workflow incorporates [Samtools](https://toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1) for filtering, [Picard MarkDuplicates](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2) to remove PCR artifacts, and [LoFreq Viterbi](https://toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.3.1+galaxy1) for read realignment.

Variant calling is performed by [LoFreq](https://toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.3.1+galaxy0), which is specifically sensitive to low-frequency variants. The identified variants are then annotated using [SnpEff](https://toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1) to determine their functional impact on the viral genome. Comprehensive quality reports are generated at multiple stages via [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7.1), providing a detailed overview of the mapping and deduplication statistics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | GenBank file | data_input |  |
| 1 | Paired Collection (fastqsanger) | data_collection_input |  |


Ensure your reference is a valid GenBank file and your sequencing data is organized as a Paired Collection of fastqsanger files to match the workflow's requirements. Using a Paired Collection is essential for the downstream batch processing and collection collapsing steps. Consult the README.md for comprehensive details on parameter settings and data formatting. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | SnpEff build: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff_build_gb/4.3+T.galaxy4 |  |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 4 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 5 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7.1 |  |
| 6 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 7 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 |  |
| 8 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2 |  |
| 9 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7.1 |  |
| 10 | Realign reads | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.3.1+galaxy1 |  |
| 11 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7.1 |  |
| 12 | Call variants | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.3.1+galaxy0 |  |
| 13 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1 |  |
| 14 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 15 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | snpeff_output | snpeff_output |
| 2 | output_fasta | output_fasta |
| 3 | output_paired_coll | output_paired_coll |
| 3 | report_html | report_html |
| 4 | bam_output | bam_output |
| 5 | FASTP_report | html_report |
| 6 | output1 | output1 |
| 7 | output | output |
| 8 | metrics_file | metrics_file |
| 8 | outFile | outFile |
| 9 | mapping_report | html_report |
| 10 | realigned | realigned |
| 11 | DeDup_Report | html_report |
| 12 | variants | variants |
| 13 | statsFile | statsFile |
| 13 | snpeff_output | snpeff_output |
| 14 | output | output |
| 15 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Genomics-4-PE_Variation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Genomics-4-PE_Variation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Genomics-4-PE_Variation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Genomics-4-PE_Variation.ga -o job.yml`
- Lint: `planemo workflow_lint Genomics-4-PE_Variation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Genomics-4-PE_Variation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)