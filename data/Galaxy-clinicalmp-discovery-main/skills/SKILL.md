---
name: clinical-metaproteomics-discovery-workflow
description: This clinical metaproteomics workflow processes tandem mass spectrometry data and curated protein databases using MaxQuant, SearchGUI, and PeptideShaker to identify microbial and human peptides. Use this skill when you need to discover biomarkers or characterize host-microbiome interactions in clinical samples by searching MS/MS spectra against a streamlined database of MetaNovo-generated microbial proteins, Human SwissProt, and common contaminants.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# clinical-metaproteomics-discovery-workflow

## Overview

The [Clinical Metaproteomics Discovery Workflow](https://training.galaxyproject.org/training-material/topics/proteomics/tutorials/clinical-mp-2-discovery/tutorial.html) is designed to identify microbial and human proteins from clinical tandem mass spectrometry (MS/MS) data. It utilizes a streamlined database approach to reduce search space complexity, focusing on clinically relevant sequences to improve biomarker discovery and reduce false discovery rates.

The workflow integrates two primary search engines, [MaxQuant](https://toolshed.g2.bx.psu.edu/repos/galaxyp/maxquant/maxquant/2.0.3.0+galaxy0) and [SearchGUI/PeptideShaker](https://toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/4.0.41+galaxy1), to process raw MS/MS datasets. It requires three main inputs: a collection of MS/MS files, an experimental design file for MaxQuant, and a curated FASTA database. This database typically combines microbial proteins generated via MetaNovo with reviewed Human SwissProt sequences and the [cRAP](https://www.thegpm.org/crap/) contaminant list.

Following protein identification, the workflow employs a series of text-processing and filtering tools to extract and refine microbial peptides. It performs sequence merging, removes duplicates, and filters for high-confidence Peptide Spectrum Matches (PSMs). The final outputs provide a comprehensive list of distinct peptides and confident microbial identifications, facilitating downstream quantitative and functional analysis in clinical research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Human UniProt Microbial Proteins from MetaNovo and cRAP | data_input |  |
| 2 | Tandem Mass Spectrometry MSMS files | data_collection_input | Input Raw files |
| 5 | Experimental Design Discovery MaxQuant | data_input | File for experimental design containing Name, Fraction, Experiment, and PTM, where the name refers to the dataset filename, with each dataset listed on a separate line. |


Ensure your MSMS data is organized into a dataset collection of RAW files, while the protein database should be provided in FASTA format, ideally merging MetaNovo-generated microbial sequences with Human SwissProt and cRAP entries. The experimental design for MaxQuant must be supplied as a tabular file to correctly map samples. For automated execution, you can initialize the environment using `planemo workflow_job_init` to generate a `job.yml` template. Refer to the README.md for comprehensive details on configuring tool-specific parameters like peptide length and variable modifications. One final check of your input labels ensures the text-processing tools correctly filter and group microbial peptides during the discovery phase.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Identification Parameters | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/ident_params/4.0.41+galaxy1 | identification parameters for SGPS |
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
| 3 | Human SwissProt | output_database |
| 8 | Human SwissProt+cRAP | output |
| 12 | Select microbial peptides MQ | out_file1 |
| 14 | Filtering Accessions | output |
| 15 | MQ Peptide Sequences | out_file1 |
| 16 | Select microbial peptides SGPS | out_file1 |
| 17 | Select microbial PSMs SGPS | out_file1 |
| 18 | Header removed MQ Peptides | out_file1 |
| 19 | Filter confident microbial Peptides | out_file1 |
| 20 | Filter confident microbial PSMs | out_file1 |
| 21 | MQ Distinct Peptides | out_file1 |
| 22 | Extracting peptides SGPS from PSM | output |
| 23 | SGPS Peptides | out_file1 |
| 24 | SGPS Distinct Peptides | out_file1 |
| 25 | SGPS MQ Peptides | out_file1 |
| 26 | Distinct Peptides | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run iwc-clinicalmp-discovery-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run iwc-clinicalmp-discovery-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run iwc-clinicalmp-discovery-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init iwc-clinicalmp-discovery-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint iwc-clinicalmp-discovery-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `iwc-clinicalmp-discovery-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)