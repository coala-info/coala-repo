---
name: checking-expected-species-and-contamination-in-bacterial-iso
description: This Galaxy workflow processes paired-end sequencing reads using Kraken2, Bracken, and Recentrifuge to perform taxonomic classification and abundance estimation for bacterial isolates. Use this skill when you need to verify that a sequenced sample contains the expected bacterial species and identify any potential microbial contaminants.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# checking-expected-species-and-contamination-in-bacterial-iso

## Overview

This Galaxy workflow is designed to verify the species identity of bacterial isolates and detect potential contamination. It processes paired-end sequencing reads to provide a comprehensive taxonomic profile, ensuring the purity and correctness of the sample before proceeding with downstream genomic analysis.

The pipeline begins with [Kraken2](https://toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.3+galaxy2) for rapid taxonomic classification, followed by [Bracken](https://toolshed.g2.bx.psu.edu/repos/iuc/bracken/est_abundance/3.1+galaxy0) to estimate species-level abundance more accurately. These tools work together to identify the primary organism and quantify any secondary genetic material present in the isolate.

To facilitate data interpretation, the workflow utilizes [Recentrifuge](https://toolshed.g2.bx.psu.edu/repos/iuc/recentrifuge/recentrifuge/1.16.1+galaxy0) to generate interactive HTML reports and detailed statistical summaries. This allows researchers to visualize the taxonomic distribution and assess sample contamination through an intuitive interface.

This workflow is associated with the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) and is licensed under GPL-3.0-or-later, making it a standardized tool for microbial ecology and quality control.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Paired End Reads Collection | data_collection_input |  |


Provide your input as a paired-end read collection in fastq or fastq.gz format to ensure the workflow correctly identifies forward and reverse sequences for taxonomic classification. Utilizing a dataset collection is essential for batch processing multiple bacterial isolates efficiently while maintaining the integrity of the paired data. Ensure your reads are high quality and properly formatted before upload to avoid errors in the Kraken2 and Bracken steps. For comprehensive details on database selection and specific parameter configurations, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.3+galaxy2 |  |
| 2 | Bracken | toolshed.g2.bx.psu.edu/repos/iuc/bracken/est_abundance/3.1+galaxy0 |  |
| 3 | Recentrifuge | toolshed.g2.bx.psu.edu/repos/iuc/recentrifuge/recentrifuge/1.16.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | kraken_report_reads | output |
| 1 | kraken_report_tabular | report_output |
| 2 | bracken_report_tsv | report |
| 2 | bracken_kraken_report | kraken_report |
| 3 | recentrifuge_stats_tabular | stat_tsv |
| 3 | recentrifuge_report_html | html_report |
| 3 | recentrifuge_data_tabular | data_tsv |
| 3 | recentrifuge_logfile | logfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run checking-expected-species-and-contamination-in-bacterial-isolate.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run checking-expected-species-and-contamination-in-bacterial-isolate.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run checking-expected-species-and-contamination-in-bacterial-isolate.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init checking-expected-species-and-contamination-in-bacterial-isolate.ga -o job.yml`
- Lint: `planemo workflow_lint checking-expected-species-and-contamination-in-bacterial-isolate.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `checking-expected-species-and-contamination-in-bacterial-isolate.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)