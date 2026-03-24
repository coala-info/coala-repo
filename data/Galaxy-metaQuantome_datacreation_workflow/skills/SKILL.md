---
name: metaquantome_datacreation_workflow
description: "This proteomics workflow processes raw mass spectrometry data collections using Search GUI, Peptide Shaker, and FlashLFQ to generate quantified peptide and protein datasets integrated with taxonomic information from Unipept. Use this skill when you need to perform metaproteomic data analysis to quantify protein expression and assign taxonomic or functional annotations across different experimental conditions."
homepage: https://workflowhub.eu/workflows/1450
---

# metaQuantome_datacreation_workflow

## Overview

This Galaxy workflow is designed to streamline the processing of metaproteomics data, specifically tailored to generate the necessary input files for [metaQuantome](https://github.com/galaxyproteomics/metaquantome). It automates the transition from raw mass spectrometry data to structured taxonomic, functional, and quantitative tables. The process requires three primary inputs: a dataset collection of mass spectrometry files, an experimental design file, and a FASTA protein database.

The pipeline begins with data conversion via [msconvert](https://proteowizard.sourceforge.io/tools/msconvert.html), followed by peptide identification using [Search GUI](https://compomics.github.io/projects/searchgui.html) and [Peptide Shaker](https://compomics.github.io/projects/peptide-shaker.html). To provide biological context, the workflow integrates [Unipept](https://unipept.ugent.be/) for taxonomic and functional annotation of the identified peptides. Simultaneously, label-free quantification is performed using [FlashLFQ](https://github.com/smith-chem-wisc/FlashLFQ) to determine peptide and protein abundances across the experimental samples.

In the final stages, the workflow employs a series of text processing and filtering tools—including Query Tabular and Regex Find and Replace—to clean and format the results. These steps ensure that the output files meet the specific tabular requirements for downstream statistical analysis. This workflow is a key component of [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) proteomics tutorials, providing a standardized approach to metaproteomics data creation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input | metaquantome-data-creation |
| 1 | Experiment_Design | data_input |  |
| 2 | FASTA_db | data_input |  |


Ensure your raw mass spectrometry files are organized into a dataset collection (typically in mzML or RAW format) to facilitate batch processing through msconvert and FlashLFQ. The experiment design file must be a tabular dataset mapping samples to conditions, while the FASTA database should contain the relevant protein sequences for Search GUI. For automated job configuration and parameter testing, consider using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the README.md for comprehensive details on specific column headers and tool-specific configuration requirements. One paragraph only.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | msconvert | toolshed.g2.bx.psu.edu/repos/galaxyp/msconvert/msconvert/3.0.19052.0 |  |
| 4 | Search GUI | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/search_gui/3.3.10.1 |  |
| 5 | Peptide Shaker | toolshed.g2.bx.psu.edu/repos/galaxyp/peptideshaker/peptide_shaker/1.16.36.3 |  |
| 6 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_column/1.1.3 |  |
| 7 | Remove beginning | Remove beginning1 |  |
| 8 | Unipept | toolshed.g2.bx.psu.edu/repos/galaxyp/unipept/unipept/4.0.0 |  |
| 9 | FlashLFQ | toolshed.g2.bx.psu.edu/repos/galaxyp/flashlfq/flashlfq/1.0.3.0 |  |
| 10 | Unipept | toolshed.g2.bx.psu.edu/repos/galaxyp/unipept/unipept/4.5.0 |  |
| 11 | Replace Text | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_replace_in_line/1.1.2 |  |
| 12 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.0 |  |
| 13 | Cut | Cut1 |  |
| 14 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.0.0 |  |
| 15 | Query Tabular | toolshed.g2.bx.psu.edu/repos/iuc/query_tabular/query_tabular/3.0.0 |  |
| 16 | Filter | Filter1 |  |
| 17 | Filter | Filter1 |  |
| 18 | Filter | Filter1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output | output |
| 5 | output_peptides | output_peptides |
| 5 | output_psm | output_psm |
| 6 | outfile | outfile |
| 9 | log | log |
| 9 | quantifiedPeptides | quantifiedPeptides |
| 9 | quantifiedProteins | quantifiedProteins |
| 9 | toml | toml |
| 9 | foldChange | foldChange |
| 9 | quantifiedPeaks | quantifiedPeaks |
| 11 | outfile | outfile |
| 12 | out_file1 | out_file1 |
| 14 | output | output |
| 15 | output | output |
| 16 | out_file1 | out_file1 |
| 17 | out_file1 | out_file1 |
| 18 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
