---
name: workflow-2
description: "This synthetic biology workflow processes DNA assembly datasets and new sequences using tools for sequence sculpting, part domestication, and cloning simulation. Use this skill when you need to standardize genetic parts by removing internal restriction sites or incompatible sequences before virtually verifying a multi-fragment DNA assembly."
homepage: https://workflowhub.eu/workflows/1784
---

# workflow-2

## Overview

This workflow facilitates the domestication of new genetic parts followed by a comprehensive cloning simulation. It begins by retrieving sequence data from an external database using [seq_from_db](https://toolshed.g2.bx.psu.edu/repos/tduigou/seq_from_db/seq_form_db/0.1.0+galaxy0) based on user-defined parameters such as the DB URI, table names, and specific column identifiers.

Once the sequences are retrieved, the workflow utilizes [sculpt_sequences](https://toolshed.g2.bx.psu.edu/repos/tduigou/sculpt_sequences/sculpt_sequences/0.1.0+galaxy0) to refine the genetic material. The core [domestication_of_new_parts](https://toolshed.g2.bx.psu.edu/repos/tduigou/domestication_of_new_parts/domestication_of_new_parts/0.1.0+galaxy0) step then processes these sequences to ensure they are compatible for downstream assembly, generating domestication results and GenBank files.

The final stages involve a [cloning_simulation](https://toolshed.g2.bx.psu.edu/repos/tduigou/cloning_simulation/cloning_simulation/0.1.0+galaxy0) to validate the assembly of constructs and fragments. The workflow produces simulation results in both GenBank and ZIP formats, and provides the option to save the updated sequence data back to the database via [seq_to_db](https://toolshed.g2.bx.psu.edu/repos/tduigou/seq_to_db/seq_to_db/0.2.0+galaxy1).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Assembly dataset (constructs+fragments) | data_input | Without Header |
| 1 | new sequences to domestication | data_input |  |
| 2 | DB Table Name | parameter_input |  |
| 3 | DB Column Contains Sequence For gb Files | parameter_input |  |
| 4 | DB Column Contains Annotation For gb Files | parameter_input |  |
| 5 | DB IDs Column Name | parameter_input |  |
| 6 | DB URI | parameter_input |  |
| 7 | Enable Save to DB | parameter_input |  |


Ensure input sequences are provided in GenBank or FASTA format, specifically for the assembly and domestication datasets. Use dataset collections when handling multiple sequence files to streamline the sculpting and cloning simulation steps. Verify that database connection strings and column names match your SQL schema exactly to avoid retrieval errors during the initial data fetch. Consult the `README.md` for comprehensive details on configuring the database URI and specific parameter requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 8 | Get sequences Data From DB | toolshed.g2.bx.psu.edu/repos/tduigou/seq_from_db/seq_form_db/0.1.0+galaxy0 |  |
| 9 | Sculpt Sequences | toolshed.g2.bx.psu.edu/repos/tduigou/sculpt_sequences/sculpt_sequences/0.1.0+galaxy0 |  |
| 10 | Domestication Of New Parts | toolshed.g2.bx.psu.edu/repos/tduigou/domestication_of_new_parts/domestication_of_new_parts/0.1.0+galaxy0 |  |
| 11 | Cloning Simulation | toolshed.g2.bx.psu.edu/repos/tduigou/cloning_simulation/cloning_simulation/0.1.0+galaxy0 |  |
| 12 | Save Sequence Data In DB | toolshed.g2.bx.psu.edu/repos/tduigou/seq_to_db/seq_to_db/0.2.0+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | GenBank Files collection | output_gb |
| 9 | scul group | scul |
| 9 | unscul+scul gb | unscul |
| 10 | methprot_gb | methprot_gb |
| 10 | domestication results | domesticated_zip |
| 11 | simulation results (gb) | construct_gb |
| 11 | simulation results (zip) | output_zip |
| 12 | saving report | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-workflow-2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-workflow-2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-workflow-2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-workflow-2.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-workflow-2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-workflow-2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
