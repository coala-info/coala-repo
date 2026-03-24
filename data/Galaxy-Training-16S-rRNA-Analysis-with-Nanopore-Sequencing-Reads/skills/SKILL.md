---
name: training-16s-rrna-analysis-with-nanopore-sequencing-reads
description: "This Galaxy workflow processes Nanopore sequencing read collections for 16S rRNA microbiome analysis using Porechop for adapter trimming, fastp for quality control, and Kraken2 for taxonomic classification. Use this skill when you need to characterize the taxonomic composition of microbial communities from long-read sequencing data to identify bacterial species and visualize their relative abundance."
homepage: https://workflowhub.eu/workflows/1473
---

# Training: 16S rRNA Analysis with Nanopore Sequencing Reads

## Overview

This workflow provides a standardized pipeline for the taxonomic profiling of microbial communities using long-read Nanopore sequencing of the 16S rRNA gene. It begins with rigorous quality control and preprocessing, utilizing [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1) and [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.8+galaxy1) to assess the raw input collection. [Porechop](https://toolshed.g2.bx.psu.edu/repos/iuc/porechop/porechop/0.2.3) is employed to identify and remove sequencing adapters, while [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.20.1+galaxy0) performs additional filtering to ensure high-quality reads for downstream analysis.

Following cleanup, the workflow executes taxonomic classification using [Kraken2](https://toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.0.8_beta+galaxy0), which assigns biological labels to the sequences based on a reference database. The classification results are then processed through a series of text-manipulation tools—including [Datamash](https://toolshed.g2.bx.psu.edu/repos/iuc/datamash_reverse/datamash_reverse/1.1.0) and specific text replacement utilities—to format the data for visual interpretation.

The final stage focuses on data visualization and reporting. The workflow generates an interactive [Krona pie chart](https://toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1) to explore the hierarchical taxonomic distribution of the microbiome sample. This pipeline is a key resource for the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and is optimized for microbiome studies requiring rapid, long-read 16S analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |


Ensure your Nanopore sequencing reads are uploaded in FASTQ format and organized into a dataset collection to facilitate batch processing through the QC and Kraken2 classification steps. Utilizing collections instead of individual datasets is essential for generating aggregated reports in MultiQC and maintaining an organized history. Consult the README.md for specific guidance on Kraken2 database requirements and parameter configurations tailored to your study. For automated testing or execution, you can initialize your environment using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 2 | Porechop | toolshed.g2.bx.psu.edu/repos/iuc/porechop/porechop/0.2.3 |  |
| 3 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.8+galaxy1 |  |
| 4 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.20.1+galaxy0 |  |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 6 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.0.8_beta+galaxy0 |  |
| 7 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.8+galaxy1 |  |
| 8 | Reverse | toolshed.g2.bx.psu.edu/repos/iuc/datamash_reverse/datamash_reverse/1.1.0 |  |
| 9 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 10 | Remove beginning | Remove beginning1 |  |
| 11 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

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
