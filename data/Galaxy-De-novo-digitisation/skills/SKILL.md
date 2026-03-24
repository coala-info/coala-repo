---
name: de-novo-digitisation
description: "This workflow processes specimen images and CSV metadata using Teklia tools for document layout analysis, handwritten text recognition, and named entity recognition to produce digital specimen objects in RO-Crate format. Use this skill when you need to automate the extraction of structured information from physical specimen labels to create searchable, standardized digital biodiversity records."
homepage: https://workflowhub.eu/workflows/373
---

# De novo digitisation

## Overview

This Galaxy workflow facilitates the *de novo* digitisation of biological specimens by transforming raw input into structured digital records. It is designed to handle multi-specimen inputs through a centralized `.csv` file, utilizing Galaxy collections to manage and process multiple datasets simultaneously.

The pipeline employs a series of [Teklia](https://www.teklia.com/) AI tools to perform comprehensive document analysis. The process begins with Document Layout Analysis (DLA) to identify regions of interest and specific text lines. This is followed by Handwritten Text Recognition (HTR) for optical character recognition and Named Entity Recognition (NER) to extract and classify key information from the text.

The final output is an Open Digital Specimen object packaged as an [RO-Crate](https://www.researchobject.org/ro-crate/). This ensures that the digitised data, including the extracted regions, OCR text, and identified entities, is stored in a standardized, machine-readable format suitable for long-term preservation and integration into biodiversity data infrastructures.

This workflow is tagged as **Revised** and **Default-SDR**, representing an unvalidated but functional example of automated specimen data extraction. Detailed documentation on configuration and tool parameters can be found in the [README.md](README.md) file in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset | data_input |  |


To begin, provide a CSV file containing specimen metadata alongside your image data to facilitate the creation of specimen data objects. Utilizing data collections is essential here, as the workflow automatically splits the input file to process multiple specimens in parallel through the Teklia DLA, HTR, and NER workers. For a successful run, verify that your CSV formatting matches the requirements specified in the README.md, which contains the full technical documentation. You may also use `planemo workflow_job_init` to create a `job.yml` file for streamlined job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Remove beginning | Remove beginning1 |  |
| 2 | Split file into collection | split_file |  |
| 3 | Create specimen data object from csv | sdr_create_sdo_from_csv |  |
| 4 | Filter failed datasets | __FILTER_FAILED_DATASETS__ |  |
| 5 | JQ | toolshed.g2.bx.psu.edu/repos/iuc/jq/jq/1.0 |  |
| 6 | SDR Teklia worker-dla | sdr_teklia_worker_dla |  |
| 7 | SDR Teklia worker-dla | sdr_teklia_worker_dla |  |
| 8 | SDR Teklia worker-htr | sdr_teklia_worker_htr |  |
| 9 | SDR Teklia worker-ner | sdr_teklia_worker_ner |  |
| 10 | Save as RO Crate | save_output_rocrate |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | out_file1 | out_file1 |
| 2 | split_files | split_files |
| 3 | output | output |
| 4 | input dataset(s) (filtered failed datasets) | output |
| 5 | output | output |
| 6 | output | output |
| 7 | output | output |
| 8 | output | output |
| 9 | Open Digital specimen object | output |
| 10 | ROCrate output | ROCrate |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-De_novo_digitisation (2).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-De_novo_digitisation (2).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-De_novo_digitisation (2).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-De_novo_digitisation (2).ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-De_novo_digitisation (2).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-De_novo_digitisation (2).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
