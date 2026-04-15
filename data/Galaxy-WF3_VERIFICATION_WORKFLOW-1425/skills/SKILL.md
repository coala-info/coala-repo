---
name: wf3_verification_workflow
description: This proteomics workflow validates peptide identifications from SGPS and MaxQuant reports against MGF mass spectrometry data using PepQuery2 and automated protein database construction tools. Use this skill when you need to statistically verify the presence of specific peptide sequences in clinical datasets and generate a refined protein database for downstream quantitation.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# wf3_verification_workflow

## Overview

The WF3_VERIFICATION_WORKFLOW is a specialized Galaxy pipeline designed for the verification and validation of peptide identifications. It integrates data from multiple sources, including SGPS and MaxQuant peptide reports, to confirm the presence of specific sequences within mass spectrometry datasets. This workflow is part of the [clinicalmp](https://training.galaxyproject.org/) project and follows [GTN](https://training.galaxyproject.org/) best practices for proteomics data analysis.

The process begins by constructing a comprehensive reference database. It utilizes the [Protein Database Downloader](https://toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.4) to fetch Human UniProt sequences, including isoforms, and merges them with cRAP contaminant sequences. This merged FASTA file serves as the foundation for subsequent validation steps, ensuring that peptide queries are matched against a complete and relevant proteome.

At the core of the workflow, [PepQuery2](https://toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy0) performs targeted peptide sequence validation against input MGF dataset collections. The workflow then employs a series of text processing and filtering tools, such as [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.0), to refine the results, extract verified UniProt IDs, and generate a specialized quantitation database for use in MaxQuant.

This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and provides a standardized approach for researchers to ensure the reliability of their peptide-spectrum matches before proceeding to downstream quantitative analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 2 | Input MGFs Dataset Collection | data_collection_input |  |
| 3 | SGPS_peptide-report | data_input |  |
| 4 | Distinct Peptides for PepQuery | data_input |  |
| 5 | MaxQuant-peptide-report | data_input |  |


Ensure your input MGF files are organized into a dataset collection to facilitate batch processing, while the SGPS, MaxQuant, and PepQuery peptide reports should be uploaded as individual tabular datasets. Verify that all tabular inputs use standard formatting to ensure compatibility with the Cut and Query Tabular tools. For automated execution and testing, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter settings and specific database requirements. Always check that your peptide sequences are correctly formatted to avoid errors during the PepQuery2 verification step.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.4 |  |
| 1 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.4 |  |
| 6 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 7 | Cut | Cut1 |  |
| 8 | Cut | Cut1 |  |
| 9 | PepQuery2 | toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy0 |  |
| 10 | Remove beginning | Remove beginning1 |  |
| 11 | Remove beginning | Remove beginning1 |  |
| 12 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |
| 13 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 14 | Filter | Filter1 |  |
| 15 | Remove beginning | Remove beginning1 |  |
| 16 | Cut | Cut1 |  |
| 17 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.0 |  |
| 18 | Remove beginning | Remove beginning1 |  |
| 19 | Group | Grouping1 |  |
| 20 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.0 |  |
| 21 | UniProt | toolshed.g2.bx.psu.edu/repos/galaxyp/uniprotxml_downloader/uniprotxml_downloader/2.4.0 |  |
| 22 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | Human UniProt+Isoforms FASTA | output_database |
| 1 | cRAP | output_database |
| 6 | Human UniProt+Isoforms+cRAP FASTA | output |
| 17 | Peptide and Protein from Peptide reports | output |
| 20 | Uniprot-ID from verified Peptides | output |
| 22 | Quantitation Database for MaxQuant | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf3-verification-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf3-verification-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf3-verification-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf3-verification-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint wf3-verification-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf3-verification-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)