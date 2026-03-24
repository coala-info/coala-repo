---
name: ena-reads-and-assembly-submission-workflow
description: "This Galaxy workflow facilitates the submission of raw sequencing reads and consensus assemblies to the European Nucleotide Archive (ENA) using the ENA upload tool and Webin CLI based on Excel metadata and sample checklists. Use this skill when you need to archive genomic datasets and assemblies in a public repository to meet publication requirements and ensure data FAIRness."
homepage: https://workflowhub.eu/workflows/2008
---

# ENA Reads and Assembly Submission Workflow

## Overview

This two-step Galaxy workflow streamlines the submission of genomic data to the European Nucleotide Archive (ENA). Developed within the EVORA project, it provides a GUI-driven interface for submitting both raw sequencing reads and assembled consensus sequences. The workflow leverages Galaxy’s credential management and data handling while maintaining ENA’s rigorous validation standards.

The first stage utilizes the [ENA upload tool](https://github.com/usegalaxy-eu/ena-upload-cli) to handle raw reads. It supports metadata capture via tabular or Excel files and performs client-side validation against ENA checklists. This allows users to create or modify ENA objects such as studies, experiments, and samples directly within the Galaxy interface.

The second stage employs the [ENA Webin CLI](https://github.com/enasequence/webin-cli) wrapper to submit assembled sequences. It integrates seamlessly with the first stage to reuse metadata and supports various assembly levels, including contigs, scaffolds, and chromosomes. The workflow ensures that all submissions meet ENA requirements through interactive metadata validation and support for the ENA test server.

This workflow is licensed under the **MIT License** and is designed to support **FAIR** data principles and publication brokering. For detailed setup and usage instructions, please refer to the README.md in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ENA sample checklist | parameter_input |  |
| 1 | Excel file from template | data_input |  |
| 2 | Raw reads as dataset lists | data_collection_input |  |
| 3 | Affiliation center | parameter_input |  |
| 4 | Assembly type | parameter_input |  |
| 5 | Assembly program | parameter_input |  |
| 6 | Molecule type | parameter_input |  |
| 7 | Coverage | parameter_input | The estimated depth of sequencing coverage |
| 8 | Consensus sequences | data_input |  |
| 9 | Chromosome List file | data_input |  |
| 10 | Submit to ENA test server | parameter_input |  |


Ensure your metadata is prepared using the required Excel template or tabular format, and organize raw sequencing reads into a paired dataset collection to streamline the batch submission process. Use the ENA sample checklist to validate metadata locally before execution, and provide consensus sequences in FASTA format alongside any optional chromosome lists. For comprehensive guidance on filling out specific metadata fields and handling ENA credentials, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` for automated parameter configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 11 | ENA Upload tool | toolshed.g2.bx.psu.edu/repos/iuc/ena_upload/ena_upload/0.9.0+galaxy0 |  |
| 12 | ENA Webin CLI | ena_webin_cli |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ENA_Reads_and_Assembly_Submission_Workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ENA_Reads_and_Assembly_Submission_Workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ENA_Reads_and_Assembly_Submission_Workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ENA_Reads_and_Assembly_Submission_Workflow.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ENA_Reads_and_Assembly_Submission_Workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ENA_Reads_and_Assembly_Submission_Workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
