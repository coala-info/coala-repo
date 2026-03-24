---
name: peptide-and-protein-id-tutorial
description: "This proteomics workflow processes mzML mass spectrometry data and a protein database using PeakPickerHiRes, SearchGUI, and PeptideShaker to identify peptides and proteins. Use this skill when you need to perform automated protein identification and validation from raw mass spectrometry spectra to generate comprehensive lists of peptides and protein groups."
homepage: https://workflowhub.eu/workflows/1394
---

# Peptide And Protein ID Tutorial

## Overview

This workflow provides a standardized pipeline for proteomics research, specifically designed to identify peptides and proteins from mass spectrometry data. Based on [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) materials, it automates the transition from raw experimental spectra to validated biological results within the Galaxy ecosystem.

The process begins by preprocessing raw **mzML** files using **PeakPickerHiRes** and **FileConverter** to ensure high-quality peak data. These processed inputs are then analyzed against a provided **Protein Database** using **Search GUI**, which serves as a powerful interface for managing multiple search engines simultaneously to identify peptide-spectrum matches (PSMs).

Following the search phase, **Peptide Shaker** is utilized to aggregate and interpret the data, providing a comprehensive overview of identified peptides and proteins. The workflow concludes with several filtering steps to refine the results, ultimately generating outputs such as mzIdentML files, protein lists, and peptide summaries for downstream analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input: Protein Database | data_input |  |
| 1 | Input: mzML file | data_input |  |


Ensure your protein database is in FASTA format and your mass spectrometry data is provided as mzML files for compatibility with SearchGUI and PeptideShaker. While individual datasets work for single runs, using a dataset collection for multiple mzML files allows the workflow to process large batches efficiently. Refer to the README.md for specific parameter configurations and detailed database preparation instructions. You can use planemo workflow_job_init to generate a job.yml file for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | PeakPickerHiRes | PeakPickerHiRes |  |
| 3 | FileConverter | FileConverter |  |
| 4 | Search GUI | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/2.9.0 |  |
| 5 | Peptide Shaker | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/1.11.0 |  |
| 6 | Select | Grep1 | Output: all identified contaminants. |
| 7 | Select | Grep1 | Output: all identified proteins without common contaminants. CAVE: some proteins may be both! |
| 8 | Select | Grep1 | Output: only those non-contaminant proteins not evaluated to be "Doubtful". |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | output_proteins | output_proteins |
| 5 | mzidentML | mzidentML |
| 5 | output_psm | output_psm |
| 5 | output_zip | output_zip |
| 5 | output_peptides | output_peptides |
| 6 | out_file1 | out_file1 |
| 7 | out_file1 | out_file1 |
| 8 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wf-proteinid-sg-ps.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wf-proteinid-sg-ps.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wf-proteinid-sg-ps.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wf-proteinid-sg-ps.ga -o job.yml`
- Lint: `planemo workflow_lint wf-proteinid-sg-ps.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wf-proteinid-sg-ps.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
