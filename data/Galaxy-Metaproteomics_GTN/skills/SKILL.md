---
name: metaproteomics_gtn
description: This metaproteomics workflow processes mass spectrometry MGF files and protein FASTA sequences using Search GUI and Peptide Shaker for protein identification, followed by Unipept for taxonomic and functional annotation. Use this skill when you need to characterize the taxonomic composition and functional profile of complex microbial communities from environmental or clinical proteomic samples.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# metaproteomics_gtn

## Overview

This Galaxy workflow provides a comprehensive pipeline for metaproteomics analysis, specifically designed to follow the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorial for identifying and characterizing proteins within complex environmental samples. It processes mass spectrometry data (MGF files) against protein FASTA sequences to perform peptide identification and taxonomic/functional annotation.

The analysis begins with peptide identification using [Search GUI](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/3.3.10.1) and [Peptide Shaker](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/1.16.36.3), which generate validated protein and peptide lists. These results are then processed through [Unipept](https://toolshed.g2.bx.psu.edu/repos/galaxyp/unipept/unipept/4.3.0) to retrieve taxonomic information and functional insights based on the identified sequences.

To manage and refine the large datasets generated, the workflow utilizes [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.0.0) and SQLite tools to filter, join, and transform data into structured formats. The final outputs include comprehensive tabular reports, JSON files for visualization, and SQLite databases that integrate protein identifications with Gene Ontology terms and taxonomic classifications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Sixgill generated protein FASTA File | data_input |  |
| 1 | Dataset Collection of Bering Strait MGF Files | data_collection_input |  |
| 2 | Gene Ontology Terms (Selected) | data_input |  |


Ensure your input protein FASTA and Gene Ontology terms are uploaded as individual datasets, while the Bering Strait MGF mass spectrometry files must be organized into a dataset collection to be processed correctly by Search GUI and Peptide Shaker. Verify that your FASTA headers are compatible with the Search GUI requirements to avoid downstream parsing errors. For comprehensive configuration details and parameter settings, refer to the README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Search GUI | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/3.3.10.1 |  |
| 4 | Peptide Shaker | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/1.16.36.3 |  |
| 5 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.0.0 |  |
| 6 | Unipept | toolshed.g2.bx.psu.edu/repos/galaxyp/unipept/unipept/4.3.0 |  |
| 7 | Unipept | toolshed.g2.bx.psu.edu/repos/galaxyp/unipept/unipept/4.3.0 |  |
| 8 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.0.0 |  |
| 9 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.0.0 |  |
| 10 | SQLite to tabular | toolshed.g2.bx.psu.edu/repos/iuc/sqlite_to_tabular/sqlite_to_tabular/2.0.0 |  |
| 11 | SQLite to tabular | toolshed.g2.bx.psu.edu/repos/iuc/sqlite_to_tabular/sqlite_to_tabular/2.0.0 |  |
| 12 | SQLite to tabular | toolshed.g2.bx.psu.edu/repos/iuc/sqlite_to_tabular/sqlite_to_tabular/2.0.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | Search GUI on input dataset(s) | searchgui_results |
| 4 | Peptide Shaker on input dataset(s): mzidentML file | mzidentML |
| 4 | output_psm | output_psm |
| 5 | output | output |
| 6 | output_tsv | output_tsv |
| 7 | output_json | output_json |
| 7 | output_tsv | output_tsv |
| 8 | output | output |
| 8 | sqlitedb | sqlitedb |
| 9 | sqlitedb | sqlitedb |
| 9 | output | output |
| 10 | query_results | query_results |
| 11 | query_results | query_results |
| 12 | query_results | query_results |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow.ga -o job.yml`
- Lint: `planemo workflow_lint workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)