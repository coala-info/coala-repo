---
name: biomarker-screening-in-preeclampsia
description: "This Galaxy workflow performs biomarker screening for preeclampsia by processing RNA-sequencing data from the Sequence Read Archive using Bowtie2 for alignment, featureCounts for quantification, and DESeq2 for differential expression analysis. Use this skill when you need to identify diagnostic biomarkers or analyze differential gene expression patterns in patients with preeclampsia using transcriptomic data from multiple clinical studies."
homepage: https://workflowhub.eu/workflows/338
---

# Biomarker screening in preeclampsia

## Overview

This Galaxy workflow provides a standardized RNA-sequencing pipeline for identifying potential biomarkers in preeclampsia by analyzing data across multiple studies. The process begins with the automated retrieval and extraction of raw sequencing data from the Sequence Read Archive (SRA) using [fastq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fastq_dump/2.11.0+galaxy0).

Following data acquisition, the workflow performs quality control via [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0) and aligns the reads to a reference genome using [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.4.2+galaxy0). These steps ensure the integrity of the input data and generate the alignments necessary for transcript quantification.

The final stages of the pipeline focus on expression analysis. The workflow utilizes [featureCounts](https://toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/2.0.1+galaxy2) to calculate gene-level counts, which are then processed through [DESeq2](https://toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.7+galaxy1). This statistical analysis identifies differentially expressed genes and generates diagnostic plots, facilitating the screening of biomarkers associated with preeclampsia.

## Inputs and data preparation

_None listed._


To begin, ensure you provide valid SRA accessions for the initial download step or pre-loaded FASTQ files if bypassing the extraction tool. Organizing your sequencing reads into a paired-end collection is highly recommended to streamline processing through Bowtie2 and featureCounts. You will also need a reference genome index and a corresponding GTF annotation file to ensure accurate transcript quantification and differential expression analysis. Please refer to the README.md for comprehensive instructions on metadata formatting and experimental design setup required for the DESeq2 steps. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated configuration of these inputs.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Download and Extract Reads in FASTA/Q | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fastq_dump/2.11.0+galaxy0 |  |
| 1 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.4.2+galaxy0 |  |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.73+galaxy0 |  |
| 3 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/2.0.1+galaxy2 |  |
| 4 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/2.0.1+galaxy2 |  |
| 5 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.7+galaxy1 |  |
| 6 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.7+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Bowtie2 on input dataset(s): alignments | output |
| 2 | FastQC on input dataset(s): Webpage | html_file |
| 2 | FastQC on input dataset(s): RawData | text_file |
| 3 | featureCounts on input dataset(s): Summary | output_summary |
| 3 | featureCounts on input dataset(s): Counts | output_short |
| 4 | output_short | output_short |
| 4 | output_summary | output_summary |
| 5 | DESeq2 result file on input dataset(s) | deseq_out |
| 5 | DESeq2 plots on input dataset(s) | plots |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Biomarker_screening_in_preeclampsia.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Biomarker_screening_in_preeclampsia.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Biomarker_screening_in_preeclampsia.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Biomarker_screening_in_preeclampsia.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Biomarker_screening_in_preeclampsia.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Biomarker_screening_in_preeclampsia.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
