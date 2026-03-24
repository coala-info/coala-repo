---
name: quality-and-contamination-control-in-bacterial-isolate-using
description: "This Galaxy workflow processes paired-end Illumina MiSeq reads from bacterial isolates to perform quality assessment and taxonomic classification using Falco, fastp, Kraken2, Bracken, and Recentrifuge. Use this skill when you need to verify the purity of a bacterial sample, identify potential microbial contaminants, and estimate the relative abundance of species within an isolate."
homepage: https://workflowhub.eu/workflows/2043
---

# Quality and contamination control in bacterial isolate using Illumina MiSeq Data

## Overview

This workflow provides a comprehensive pipeline for assessing the quality and taxonomic purity of bacterial isolate sequencing data generated via Illumina MiSeq. It is designed to identify potential contamination and ensure that the raw reads meet the necessary standards for downstream genomic analysis.

The process begins with initial quality control and preprocessing using [Falco](https://github.com/fastqc/falco) and [fastp](https://github.com/OpenGene/fastp). These tools perform adapter trimming, quality filtering, and read pruning, generating detailed HTML reports that summarize the health of the input paired-end data.

Following preprocessing, the workflow performs taxonomic classification using [Kraken2](https://ccb.jhu.edu/software/kraken2/) to assign reads to specific taxa. These results are further refined by [Bracken](https://ccb.jhu.edu/software/bracken/), which estimates species-level abundance to provide a clearer picture of the sample composition and any non-target organisms present.

In the final stage, [Recentrifuge](https://github.com/khyox/recentrifuge) is used to generate interactive visualizations and statistical summaries of the taxonomic data. This allows researchers to easily inspect the distribution of reads and validate the isolate's identity. The workflow is tagged for [Sequence-analysis](https://training.galaxyproject.org/training-material/topics/sequence-analysis/) and follows [GTN](https://training.galaxyproject.org/) best practices under a GPL-3.0-or-later license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Paired Reads | data_collection_input |  |


Ensure your input data is organized as a paired-end collection (list:paired) containing FastQ files to ensure compatibility with the automated batch processing steps. Verify that your reads are correctly labeled as forward and reverse pairs to avoid errors during the fastp and Kraken2 stages. For streamlined execution and parameter configuration, you can use `planemo workflow_job_init` to generate a template `job.yml` file. Detailed instructions on required Kraken2/Bracken databases and specific tool parameters are available in the `README.md`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 2 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy3 |  |
| 3 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.3+galaxy2 |  |
| 4 | Bracken | toolshed.g2.bx.psu.edu/repos/iuc/bracken/est_abundance/3.1+galaxy0 |  |
| 5 | Recentrifuge | toolshed.g2.bx.psu.edu/repos/iuc/recentrifuge/recentrifuge/1.16.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Falco text_file (forward) | text_file |
| 1 | Falco html_file (forward) | html_file |
| 2 | fastp_json | report_json |
| 2 | fastp report_html | report_html |
| 3 | kraken_report_tabular | report_output |
| 3 | kraken_report_reads | output |
| 4 | bracken_kraken_report | kraken_report |
| 4 | bracken_report_tsv | report |
| 5 | recentrifuge_data_tabular | data_tsv |
| 5 | recentrifuge_report_html | html_report |
| 5 | recentrifuge_stats_tabular | stat_tsv |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run quality-and-contamination-control-in-bacterial-isolate-using-illumina-miseq-data.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run quality-and-contamination-control-in-bacterial-isolate-using-illumina-miseq-data.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run quality-and-contamination-control-in-bacterial-isolate-using-illumina-miseq-data.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init quality-and-contamination-control-in-bacterial-isolate-using-illumina-miseq-data.ga -o job.yml`
- Lint: `planemo workflow_lint quality-and-contamination-control-in-bacterial-isolate-using-illumina-miseq-data.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `quality-and-contamination-control-in-bacterial-isolate-using-illumina-miseq-data.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
