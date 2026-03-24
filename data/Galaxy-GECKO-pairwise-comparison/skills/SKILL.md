---
name: gecko-pairwise-comparison
description: "This Galaxy workflow performs pairwise sequence comparison between query and reference sequences using GECKO to identify similarities and ClustalW for multiple sequence alignment. Use this skill when you need to detect repetitive elements, identify conserved genomic regions, or analyze structural variations between two biological sequences."
homepage: https://workflowhub.eu/workflows/1541
---

# GECKO pairwise comparison

## Overview

This workflow facilitates the pairwise comparison of genomic sequences to identify similarities and repeats. It takes two primary inputs—a query sequence and a reference sequence—making it a valuable tool for [genome-annotation](https://training.galaxyproject.org/training-material/topics/genome-annotation/) and comparative genomics projects.

The core analysis is performed using [GECKO](https://toolshed.g2.bx.psu.edu/repos/iuc/gecko/gecko/1.2), which identifies high-scoring segment pairs between the input datasets. Following the initial comparison, the workflow utilizes [awk-based text reformatting](https://toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2) to process the data for downstream analysis, culminating in a multiple sequence alignment conducted via [ClustalW](https://toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1).

The final outputs include GECKO alignments in CSV format, processed text files, and ClustalW alignment results (both clustal and dnd formats). For detailed configuration and usage instructions, please refer to the [README.md](./README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Query sequence | data_input |  |
| 1 | Reference sequence | data_input |  |


Ensure your query and reference sequences are in FASTA format to maintain compatibility with the GECKO and ClustalW tools. While this workflow typically processes individual datasets, you can utilize dataset collections if you intend to run multiple pairwise comparisons in parallel. Refer to the README.md file for comprehensive details on parameter tuning and specific sequence requirements. You can also automate the setup of your test environment using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Gecko | toolshed.g2.bx.psu.edu/repos/iuc/gecko/gecko/1.2 |  |
| 3 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.2 |  |
| 4 | ClustalW | toolshed.g2.bx.psu.edu/repos/devteam/clustalw/clustalw/2.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Gecko on input dataset(s): CSV | csv_output1 |
| 2 | alignments2 | alignments2 |
| 3 | outfile | outfile |
| 4 | ClustalW on input dataset(s): clustal | output |
| 4 | ClustalW on input dataset(s): dnd | dnd |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run gecko-pairwise-comparison.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run gecko-pairwise-comparison.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run gecko-pairwise-comparison.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init gecko-pairwise-comparison.ga -o job.yml`
- Lint: `planemo workflow_lint gecko-pairwise-comparison.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `gecko-pairwise-comparison.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
