---
name: gtn_ena_upload_workflow
description: This Galaxy workflow automates the submission of SARS-CoV-2 genomic sequences and metadata to the European Nucleotide Archive using the ENA Upload tool. Use this skill when you need to share viral surveillance data with the global scientific community by depositing raw sequencing reads and study information into public repositories.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gtn_ena_upload_workflow

## Overview

This Galaxy workflow is designed to streamline the submission of SARS-CoV-2 sequence data to the European Nucleotide Archive (ENA). Developed in alignment with [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards, it provides a structured approach for researchers to upload genomic data and associated metadata to public repositories.

The process centers on the [ENA Upload tool](https://toolshed.g2.bx.psu.edu/repos/iuc/ena_upload/ena_upload/0.3.2), which manages the complexities of the ENA submission interface. The workflow automates the organization of data into the required hierarchical formats, ensuring that all technical requirements for sequence sharing are met.

Upon execution, the workflow generates comprehensive outputs including tables for studies, samples, experiments, and runs. These files serve as a record of the submission and confirm that the metadata has been correctly formatted and transmitted to the ENA.

## Inputs and data preparation

_None listed._


Ensure your sequence data is in FASTQ format and metadata is prepared as TSV files according to ENA standards. Using data collections is highly recommended for batching multiple samples to streamline the submission process within the ENA Upload tool. Refer to the included README.md for specific metadata field requirements and authentication credential setup. You can automate the configuration of these inputs by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | ENA Upload tool | toolshed.g2.bx.psu.edu/repos/iuc/ena_upload/ena_upload/0.3.2 |  |
| 1 | ENA Upload tool | toolshed.g2.bx.psu.edu/repos/iuc/ena_upload/ena_upload/0.3.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | output | output |
| 0 | runs_table_out | runs_table_out |
| 0 | experiments_table_out | experiments_table_out |
| 0 | samples_table_out | samples_table_out |
| 0 | studies_table_out | studies_table_out |


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