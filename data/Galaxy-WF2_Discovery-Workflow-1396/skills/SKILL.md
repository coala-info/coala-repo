---
name: wf2_discovery-workflow
description: "This metaproteomics workflow processes mass spectrometry RAW files against microbial and human protein databases using MaxQuant, SearchGUI, and PeptideShaker to identify and filter microbial peptides. Use this skill when you need to discover and validate novel microbial peptides within complex clinical samples by integrating results from multiple proteomic search engines to ensure high-confidence identifications."
homepage: https://workflowhub.eu/workflows/1396
---

# WF2_Discovery-Workflow

## Overview

The **WF2_Discovery-Workflow** is a Galaxy-based bioinformatics pipeline designed for the discovery of microbial peptides within clinical metaproteomics datasets. It integrates high-throughput mass spectrometry data processing with comprehensive protein database management to identify microbial signatures from complex biological samples.

The workflow utilizes a dual-search strategy, employing both [MaxQuant](https://toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/2.0.3.0+galaxy0) and the [Search GUI](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/4.0.41+galaxy1) / [Peptide Shaker](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/2.0.33+galaxy1) engine suite. It processes RAW mass spectrometry files against a combined database of Human UniProt sequences, microbial proteins (derived from MetaNovo), and common contaminants (cRAP). The pipeline includes automated steps for database downloading, FASTA merging, and sequence filtering to ensure a robust search space.

Following identification, the workflow performs extensive downstream processing to filter and refine results. It extracts and selects specific microbial peptides, filters for high-confidence Peptide-Spectrum Matches (PSMs), and concatenates findings from both search engines. The final outputs provide a consolidated list of distinct microbial peptides, facilitating the characterization of the microbiome in clinical contexts.

This workflow is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) and is associated with the **clinicalmp** and **GTN** (Galaxy Training Network) communities.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Human UniProt Microbial Proteins (from MetaNovo) and cRAP | data_input | FastaCLI: MetaNovo Human SwissProt cRAP with decoys on data 1 (MetaNovo Human SwissProt cRAP_concatenated_target_decoy) (49,076 sequences) |
| 2 | RAW files (Dataset Collection) | data_collection_input |  |
| 5 | Experimental Design Discovery MaxQuant | data_input |  |


Ensure your mass spectrometry RAW files are organized into a Dataset Collection to facilitate batch processing through msconvert and MaxQuant. The workflow requires protein databases in FASTA format and a specific experimental design file for MaxQuant to correctly map samples. For automated execution and testing, you can initialize a job configuration using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on parameter settings and specific database versioning. Practical success depends on ensuring the microbial protein FASTA from MetaNovo is properly formatted before merging with cRAP sequences.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Identification Parameters | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/ident_params/4.0.41+galaxy1 |  |
| 3 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.4 |  |
| 4 | Protein Database Downloader | toolshed.g2.bx.psu.edu/repos/galaxyp/dbbuilder/dbbuilder/0.3.4 |  |
| 6 | FastaCLI | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/fasta_cli/4.0.41+galaxy1 |  |
| 7 | msconvert | toolshed.g2.bx.psu.edu/repos/galaxyp/msconvert/msconvert/3.0.20287.2 |  |
| 8 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 9 | MaxQuant | toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/2.0.3.0+galaxy0 |  |
| 10 | Search GUI | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/4.0.41+galaxy1 |  |
| 11 | FASTA-to-Tabular | toolshed.g2.bx.psu.edu/repos/devteam/fasta_to_tabular/fasta2tab/1.1.0 |  |
| 12 | Select | Grep1 |  |
| 13 | Peptide Shaker | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/2.0.33+galaxy1 |  |
| 14 | Filter Tabular | toolshed.g2.bx.psu.edu/repos/iuc/filter_tabular/filter_tabular/3.3.0 |  |
| 15 | Cut | Cut1 |  |
| 16 | Select | Grep1 |  |
| 17 | Select | Grep1 |  |
| 18 | Remove beginning | Remove beginning1 |  |
| 19 | Filter | Filter1 |  |
| 20 | Filter | Filter1 |  |
| 21 | Group | Grouping1 |  |
| 22 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.3.0 |  |
| 23 | Cut | Cut1 |  |
| 24 | Group | Grouping1 |  |
| 25 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |
| 26 | Group | Grouping1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | Identification_Parameters_File | Identification_Parameters_File |
| 3 | Human SwissProt (reviewed only) | output_database |
| 8 | Human SwissProt+cRAP | output |
| 9 | proteinGroups | proteinGroups |
| 9 | peptides | peptides |
| 12 | Select microbial peptides (MQ) | out_file1 |
| 13 | output_proteins | output_proteins |
| 13 | output_peptides | output_peptides |
| 13 | mzidentML | mzidentML |
| 13 | output_psm | output_psm |
| 16 | Select microbial peptides (SGPS) | out_file1 |
| 19 | Filter confident microbial peptides | out_file1 |
| 20 | Filter confident microbial PSMs | out_file1 |
| 21 | MQ Peptides | out_file1 |
| 24 | SGPS Distinct Peptides | out_file1 |
| 25 | SGPS-MQ Peptides | out_file1 |
| 26 | Distinct Peptides | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf2-discovery-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf2-discovery-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf2-discovery-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf2-discovery-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint wf2-discovery-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf2-discovery-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
