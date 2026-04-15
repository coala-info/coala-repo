---
name: understanding-barcodes
description: This single-cell sequencing workflow processes FastQ data and filter lists using FastQC, sequence filtering, and UMI-tools extract to prepare reads for downstream analysis. Use this skill when you need to perform quality control on raw single-cell sequencing reads and extract barcode or UMI information while filtering out unwanted sequences.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# understanding-barcodes

## Overview

This workflow provides a streamlined approach for processing single-cell sequencing data, specifically focusing on the identification and extraction of cell barcodes and Unique Molecular Identifiers (UMIs). Based on [GTN (Galaxy Training Network)](https://training.galaxyproject.org/) materials, it serves as a foundational pipeline for understanding how raw sequence data is prepared for downstream single-cell analysis.

The process begins by performing quality control on raw FastQ data collections using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/). It then filters the sequences by ID to isolate specific reads of interest before utilizing [UMI-tools extract](https://umi-tools.readthedocs.io/en/latest/reference/extract.html). This final step removes the barcode and UMI sequences from the reads and relocates them to the read headers, ensuring they are preserved for cell-level quantification after alignment.

The workflow outputs include detailed quality reports and a processed collection of paired-end reads. This setup is essential for single-cell workflows where accurate barcode extraction is a prerequisite for distinguishing individual cells within a complex library. This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | FastQ data | data_collection_input |  |
| 1 | Reads filter list | data_input |  |


Ensure your input FastQ data is organized as a paired-end collection to maintain read associations throughout the UMI extraction and filtering process. The reads filter list must be a plain text file containing the specific sequence IDs required for the filtering step. Refer to the `README.md` for comprehensive instructions on configuring the specific barcode patterns and metadata required for this single-cell analysis. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and parameter specification.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 3 | Filter sequences by ID | toolshed.g2.bx.psu.edu/repos/peterjc/seq_filter_by_id/seq_filter_by_id/0.2.9 |  |
| 4 | UMI-tools extract | toolshed.g2.bx.psu.edu/repos/iuc/umi_tools_extract/umi_tools_extract/1.1.6+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | text_file | text_file |
| 2 | html_file | html_file |
| 3 | output_pos | output_pos |
| 4 | out_paired_collection | out_paired_collection |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run understanding-barcodes.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run understanding-barcodes.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run understanding-barcodes.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init understanding-barcodes.ga -o job.yml`
- Lint: `planemo workflow_lint understanding-barcodes.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `understanding-barcodes.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)