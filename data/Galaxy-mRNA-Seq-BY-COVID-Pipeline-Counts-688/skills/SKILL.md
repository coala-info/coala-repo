---
name: mrna-seq-by-covid-pipeline-counts
description: "This mRNA-Seq transcriptomics workflow processes raw sequence reads and a UCSC genome using Cutadapt, HISAT2, and featureCounts to generate gene-level expression counts. Use this skill when you need to quantify transcript abundance from raw sequencing data to prepare for downstream differential expression analysis in infectious disease research."
homepage: https://workflowhub.eu/workflows/688
---

# mRNA-Seq BY-COVID Pipeline: Counts

## Overview

This workflow is part of the [BY-COVID](https://by-covid.org/) initiative, designed to transform raw mRNA-Seq sequencing reads into quantified feature counts. It provides a standardized path for processing transcriptomic data, taking a collection of reads and a UCSC reference genome as primary inputs to generate datasets ready for downstream differential expression analysis with tools like limma or DESeq2.

The pipeline follows a rigorous quality control and processing sequence. It begins with initial assessment via [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), followed by adapter trimming and filtering using [Cutadapt](https://cutadapt.readthedocs.io/). The processed reads are then aligned to the reference genome using [HISAT2](https://daehwankimlab.github.io/hisat2/), a fast and sensitive alignment program for mapping next-generation sequencing reads.

Following alignment, the workflow utilizes [featureCounts](https://subread.sourceforge.net/featureCounts.html) to quantify expression levels by assigning mapped reads to genomic features. To ensure the reliability of the results, the pipeline incorporates [RSeQC](https://rseqc.sourceforge.net/) modules to analyze read distribution and gene body coverage. 

All metrics, from initial QC to alignment statistics, are aggregated into a final [MultiQC](https://multiqc.info/) report. The primary outputs include the MultiQC HTML summary, feature lengths, and the count tables required for statistical modeling. This workflow is licensed under GPL-3.0-or-later.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mRNA-Seq Reads | data_collection_input | Input list of fastqsanger format sequencing data |
| 1 | UCSC Genome | data_input | Export of UCSC Genome, just the genes. |


Ensure your mRNA-Seq reads are provided as a paired-end or single-end collection of FASTQ files, while the UCSC genome should be supplied as a standard FASTA dataset. Using collections is essential for this pipeline to correctly batch process reads through Cutadapt and HISAT2 before aggregating results in MultiQC. Consult the `README.md` for comprehensive details on reference genome versions and specific tool parameter configurations. For automated execution or testing, you can use `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 3 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/4.4+galaxy0 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy0 |  |
| 5 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.2.1+galaxy1 |  |
| 6 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/2.0.3+galaxy1 |  |
| 7 | Read Distribution | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_read_distribution/5.0.1+galaxy2 |  |
| 8 | Gene Body Coverage (BAM) | toolshed.g2.bx.psu.edu/repos/nilesh/rseqc/rseqc_geneBody_coverage/5.0.1+galaxy2 |  |
| 9 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | output_feature_lengths | output_feature_lengths |
| 6 | output_short | output_short |
| 9 | html_report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Counts.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Counts.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Counts.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Counts.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Counts.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-mRNA-Seq_BY-COVID_Pipeline__Counts.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
