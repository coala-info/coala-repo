---
name: proteinid-sg-ps-tutorial-wf-datasetcollection
description: "This proteomics workflow processes a collection of mzML files and a protein FASTA database using PeakPickerHiRes, SearchGUI, and PeptideShaker to identify peptides and proteins. Use this skill when you need to perform high-throughput protein identification across multiple mass spectrometry datasets using standard search engines and post-processing tools."
homepage: https://workflowhub.eu/workflows/1399
---

# ProteinID SG PS Tutorial WF datasetCollection

## Overview

This Galaxy workflow automates the identification of peptides and proteins from mass spectrometry data using the [SearchGUI](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/2.9.0) and [PeptideShaker](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/1.11.0) toolset. Designed for high-throughput proteomics, it processes a collection of mzML files against a provided protein FASTA database to generate comprehensive identification results.

The pipeline begins with signal processing using OpenMS tools, specifically **PeakPickerHiRes** for peak detection and **FileConverter** for format standardization. These processed files are then analyzed by SearchGUI, which manages multiple search engines to match spectra against the protein database. PeptideShaker subsequently integrates these search results, providing validated protein and peptide identifications.

The workflow concludes by filtering the results through several selection steps to refine the output. The final results are exported as structured protein and peptide datasets, making it an essential tool for researchers following [GTN](https://training.galaxyproject.org/) tutorials or performing standard proteomics discovery workflows. Detailed documentation on specific parameters and usage can be found in the README.md within the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input protein FASTA database | data_input | Proteome Fasta database of organism of interest. Do not include decoys. |
| 1 | Input: List of mzML files | data_collection_input | Add all input files into a "List of files" first. |


Ensure the input mzML files are provided as a dataset collection to enable parallel processing across the PeakPickerHiRes and SearchGUI steps. The protein database must be in FASTA format, ideally containing common contaminants to ensure accurate PeptideShaker results. For a comprehensive list of search parameters and tool configurations, refer to the accompanying README.md file. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | PeakPickerHiRes | PeakPickerHiRes |  |
| 3 | FileConverter | FileConverter |  |
| 4 | Search GUI | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/2.9.0 |  |
| 5 | Peptide Shaker | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/1.11.0 |  |
| 6 | Select | Grep1 | Output: all identified contaminant proteins |
| 7 | Select | Grep1 | Output: all identified non-contaminant proteins |
| 8 | Select | Grep1 | Output: identified non-contaminant proteins, validated to be "Confident". |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | output_proteins | output_proteins |
| 5 | output_peptides | output_peptides |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf-proteinid-sg-ps-multiplefiles.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf-proteinid-sg-ps-multiplefiles.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf-proteinid-sg-ps-multiplefiles.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf-proteinid-sg-ps-multiplefiles.ga -o job.yml`
- Lint: `planemo workflow_lint wf-proteinid-sg-ps-multiplefiles.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf-proteinid-sg-ps-multiplefiles.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
