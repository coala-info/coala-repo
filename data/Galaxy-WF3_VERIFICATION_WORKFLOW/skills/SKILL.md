---
name: wf3_verification_workflow
description: "This proteomics workflow validates peptide identifications from MGF mass spectrometry data and peptide reports using PepQuery2 and automated protein database construction tools. Use this skill when you need to perform rigorous spectrum-level verification of peptide candidates and generate a refined UniProt-based database for quantitative proteomics analysis."
homepage: https://workflowhub.eu/workflows/1464
---

# WF3_VERIFICATION_WORKFLOW

## Overview

The WF3_VERIFICATION_WORKFLOW is a specialized pipeline designed for the verification and validation of peptide identifications in clinical proteomics. It integrates mass spectrometry data in MGF format with peptide reports from SGPS and MaxQuant to rigorously confirm peptide sequences. The workflow is part of the [clinicalmp](https://galaxyproject.org/) initiative and adheres to [GTN](https://training.galaxyproject.org/) training standards.

The process begins by constructing a comprehensive reference database using the [Protein Database Downloader](https://toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.4), which fetches Human UniProt sequences, isoforms, and common contaminants (cRAP). The core validation engine is [PepQuery2](https://toolshed.g2.bx.psu.edu/repos/galaxyp/pepquery2/pepquery2/2.0.2+galaxy0), which performs targeted peptide searches against the input spectra to provide statistical confidence for specific peptide identifications.

Data manipulation steps, including [Query Tabular](https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.0) and various text processing tools, are used to filter results and map verified peptides to their corresponding protein accessions. The final outputs include a merged FASTA database for downstream quantitation in MaxQuant and a refined list of UniProt IDs derived from verified peptides. This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 2 | Input MGFs Dataset Collection | data_collection_input |  |
| 3 | SGPS_peptide-report | data_input |  |
| 4 | Distinct Peptides for PepQuery | data_input |  |
| 5 | MaxQuant-peptide-report | data_input |  |


Ensure your mass spectrometry data is organized as an MGF dataset collection, while peptide reports from SGPS and MaxQuant should be uploaded as tabular files. Using a collection for MGF files allows the PepQuery2 tool to process multiple spectra files simultaneously against the provided peptide lists. Verify that the distinct peptide list is formatted correctly for PepQuery input to avoid tool execution errors during the verification process. Refer to the README.md for comprehensive details on specific column requirements and database configuration. You can automate the setup of these inputs using `planemo workflow_job_init` to generate a `job.yml` file.

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
