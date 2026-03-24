---
name: erga-dataqc-illumina-v2601-wf0
description: "This ERGA workflow performs quality control on raw Illumina sequencing collections using FastQC, fastp, SeqKit, and MultiQC to assess read quality and generate comprehensive summary reports. Use this skill when you need to evaluate the integrity and quality of raw short-read genomic data to ensure it meets the standards required for high-quality reference genome assembly."
homepage: https://workflowhub.eu/workflows/601
---

# ERGA DataQC Illumina v2601 (WF0)

## Overview

This workflow is designed for the initial quality control and preprocessing of Illumina sequencing data, specifically tailored for the [ERGA](https://www.erga-biodiversity.eu/) (European Reference Genome Atlas) project. It accepts a raw Illumina data collection as input to assess and improve the quality of sequencing reads before they are used in downstream assembly or analysis.

The pipeline utilizes [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) for comprehensive quality assessment and [fastp](https://github.com/OpenGene/fastp) for automated adapter trimming and quality filtering. Additionally, [SeqKit statistics](https://bioinf.shenwei.me/seqkit/) are generated to provide detailed metrics on the sequence data, ensuring the reads meet the rigorous standards required for high-quality reference genome projects.

The final results are aggregated into a [MultiQC](https://multiqc.info/) report, providing a centralized visualization of the quality metrics across the entire dataset. Key outputs include the processed (trimmed) paired-end collections and consolidated statistical reports, facilitating a streamlined transition to subsequent stages of the ERGA genomic infrastructure.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Raw illumina collection | data_collection_input |  |


For this workflow, ensure your raw Illumina reads are organized into a paired-end data collection containing fastq.gz files to enable efficient batch processing through fastp and FastQC. Using a "list of pairs" collection is essential, as the pipeline is designed to handle multiple samples simultaneously and aggregate quality metrics via MultiQC. Refer to the accompanying README.md for specific naming conventions and detailed parameter configurations required to meet ERGA data standards. You can automate the configuration of these inputs by using `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 2 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy3 |  |
| 3 | SeqKit statistics | toolshed.g2.bx.psu.edu/repos/iuc/seqkit_stats/seqkit_stats/2.12.0+galaxy0 |  |
| 4 | Flatten collection | __FLATTEN__ |  |
| 5 | Flatten collection | __FLATTEN__ |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy4 |  |
| 7 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | output_paired_coll | output_paired_coll |
| 6 | html_report | html_report |
| 6 | stats | stats |
| 7 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ERGA_DataQC_Illumina_v2601_(WF0).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ERGA_DataQC_Illumina_v2601_(WF0).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ERGA_DataQC_Illumina_v2601_(WF0).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ERGA_DataQC_Illumina_v2601_(WF0).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ERGA_DataQC_Illumina_v2601_(WF0).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ERGA_DataQC_Illumina_v2601_(WF0).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
