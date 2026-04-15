---
name: clinical-metaproteomics-data-interpretation
description: This workflow performs taxonomic and functional annotation of quantified peptides using Unipept and conducts differential expression analysis on microbial and human proteins using MSstatsTMT. Use this skill when you need to characterize the microbial composition of clinical samples and identify statistically significant changes in protein abundance across different experimental conditions or patient groups.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# clinical-metaproteomics-data-interpretation

## Overview

This workflow facilitates the taxonomic and functional annotation of quantified peptides alongside rigorous statistical analysis of proteomic data. By integrating [Unipept](https://toolshed.g2.bx.psu.edu/repos/galaxyp/unipept/unipept/4.5.1) and [MSstatsTMT](https://toolshed.g2.bx.psu.edu/repos/galaxyp/msstatstmt/msstatstmt/2.0.0+galaxy1), it allows researchers to interpret complex metaproteomics datasets, specifically distinguishing between microbial and human protein contributions.

The process begins by performing taxonomic and functional annotations on quantified microbial peptides to generate InterPro, GO, and EC term outputs. Simultaneously, the workflow utilizes MaxQuant evidence and protein group files to perform differential expression analysis. It applies a statistical framework to account for systematic variations, providing estimates of fold changes and p-values across defined experimental conditions.

The final outputs include comprehensive visualizations such as volcano and comparison plots for both microbial and human proteins, as well as detailed taxonomic trees. For a step-by-step guide on configuring the experimental design and MSstats parameters, refer to the associated [GTN tutorial](https://training.galaxyproject.org/training-material/topics/proteomics/tutorials/clinical-mp-5-data-interpretation/tutorial.html).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Quantified Peptides | data_input | Quantified peptides from MaxQuant |
| 1 | MaxQuant Protein Groups | data_input | MaxQuant Protein Groups |
| 2 | MaxQuant Evidence | data_input | Evidence file from MaxQuant |
| 3 | Annotation | data_input | Annotation file for MSstatsTMT |
| 4 | Comparison Matrix | data_input | Comparison matrix for MSstatsTMT |


Ensure all five input files, including the MaxQuant outputs and quantified peptides, are uploaded in tabular format to ensure compatibility with Unipept and MSstatsTMT. While these inputs are typically handled as individual datasets, the Annotation and Comparison Matrix files must strictly adhere to the expected column structures for successful statistical modeling. Refer to the README.md for comprehensive details on the required experimental design headers and specific Unipept parameter configurations. You may use `planemo workflow_job_init` to create a `job.yml` for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | Unipept | toolshed.g2.bx.psu.edu/repos/galaxyp/unipept/unipept/4.5.1 |  |
| 6 | Select | Grep1 |  |
| 7 | Select | Grep1 |  |
| 8 | MSstatsTMT | toolshed.g2.bx.psu.edu/repos/galaxyp/msstatstmt/msstatstmt/2.0.0+galaxy1 | MSstatsTMT analysis for microbial proteins |
| 9 | Select | Grep1 |  |
| 10 | MSstatsTMT | toolshed.g2.bx.psu.edu/repos/galaxyp/msstatstmt/msstatstmt/2.0.0+galaxy1 | MSstatsTMT analysis for human proteins |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | Microbial InterPro Outputs | output_ipr_tsv |
| 5 | Microbial Taxonomy Tree | output_json |
| 5 | Microbial EC Proteins Tree | output_ec_json |
| 5 | Microbial EC Terms Output | output_ec_tsv |
| 5 | Microbial GO Terms Output | output_go_tsv |
| 5 | Unipept peptinfo | output_tsv |
| 6 | Microbial Proteins | out_file1 |
| 8 | Microbial Proteins Comparison Plot | out_group_comp_plot |
| 8 | Microbial Proteins Volcano Plot | out_group_volcano_plot |
| 9 | Human Proteins | out_file1 |
| 10 | Human Proteins Volcano Plot | out_group_volcano_plot |
| 10 | Human Proteins Comparison Plot | out_group_comp_plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run WF5_Data_Interpretation_Worklow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run WF5_Data_Interpretation_Worklow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run WF5_Data_Interpretation_Worklow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init WF5_Data_Interpretation_Worklow.ga -o job.yml`
- Lint: `planemo workflow_lint WF5_Data_Interpretation_Worklow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `WF5_Data_Interpretation_Worklow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)