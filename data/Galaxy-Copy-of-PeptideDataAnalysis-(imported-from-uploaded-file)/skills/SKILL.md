---
name: copy-of-peptidedataanalysis-imported-from-uploaded-file
description: This proteomics workflow processes peptide library data using PDAUG tools to calculate sequence-based descriptors, perform comparative analysis, and generate statistical visualizations. Use this skill when you need to characterize the physicochemical properties of peptide sequences and identify distinguishing features between different functional classes of peptides for therapeutic or structural research.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# copy-of-peptidedataanalysis-imported-from-uploaded-file

## Overview

This Galaxy workflow provides a comprehensive pipeline for **Peptide Library Data Analysis**, specifically designed for proteomics research and sequence characterization. It utilizes the [PDAUG](https://toolshed.g2.bx.psu.edu/view/jay/) (Peptide Data Analysis Unified Group) toolset to process peptide sequences, starting from initial data access and format conversion (TSV to FASTA).

The core of the analysis involves calculating sequence property-based descriptors and performing detailed peptide sequence analysis. These steps allow researchers to extract critical biochemical and structural features from peptide libraries, which are essential for understanding functional properties and molecular interactions.

To facilitate data interpretation, the workflow includes steps for data management and visualization. It assigns class labels to datasets, merges dataframes for comparative study, and generates several graphical outputs, including Fisher's plots and basic statistical visualizations.

This workflow is particularly relevant for users following [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) protocols. It streamlines the transition from raw peptide data to categorized, feature-rich datasets ready for advanced proteomic modeling or bioinformatics study.

## Inputs and data preparation

_None listed._


Ensure your input data is primarily in TSV or FASTA format, as the PDAUG tools are specifically designed to process peptide sequences and metadata from these file types. While individual datasets are sufficient for basic runs, utilizing dataset collections is highly recommended when processing multiple peptide libraries to streamline the descriptor calculation and merging steps. Please refer to the README.md for exhaustive details on required column headers and class labeling conventions necessary for the downstream statistical plots. You can quickly generate a template for these parameters using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | PDAUG Peptide Data Access | toolshed.g2.bx.psu.edu/repos/jay/pdaug_peptide_data_access/pdaug_peptide_data_access/0.1.0 |  |
| 1 | PDAUG TSVtoFASTA | toolshed.g2.bx.psu.edu/repos/jay/pdaug_tsvtofasta/pdaug_tsvtofasta/0.1.0 |  |
| 2 | PDAUG Peptide Sequence Analysis | toolshed.g2.bx.psu.edu/repos/jay/pdaug_peptide_sequence_analysis/pdaug_peptide_sequence_analysis/0.1.0 |  |
| 3 | PDAUG Sequence Property Based Descriptors | toolshed.g2.bx.psu.edu/repos/jay/pdaug_sequence_property_based_descriptors/pdaug_sequence_property_based_descriptors/0.1.0 |  |
| 4 | PDAUG Sequence Property Based Descriptors | toolshed.g2.bx.psu.edu/repos/jay/pdaug_sequence_property_based_descriptors/pdaug_sequence_property_based_descriptors/0.1.0 |  |
| 5 | PDAUG Fisher's Plot | toolshed.g2.bx.psu.edu/repos/jay/pdaug_fishers_plot/pdaug_fishers_plot/0.1.0 |  |
| 6 | PDAUG Add Class Label | toolshed.g2.bx.psu.edu/repos/jay/pdaug_addclasslabel/pdaug_addclasslabel/0.1.0 |  |
| 7 | PDAUG Add Class Label | toolshed.g2.bx.psu.edu/repos/jay/pdaug_addclasslabel/pdaug_addclasslabel/0.1.0 |  |
| 8 | PDAUG Merge Dataframes | toolshed.g2.bx.psu.edu/repos/jay/pdaug_merge_dataframes/pdaug_merge_dataframes/0.1.0 |  |
| 9 | PDAUG Basic Plots | toolshed.g2.bx.psu.edu/repos/jay/pdaug_basic_plots/pdaug_basic_plots/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | output1 | output1 |
| 5 | output2 | output2 |
| 9 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run peptidedataanalysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run peptidedataanalysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run peptidedataanalysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init peptidedataanalysis.ga -o job.yml`
- Lint: `planemo workflow_lint peptidedataanalysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `peptidedataanalysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)