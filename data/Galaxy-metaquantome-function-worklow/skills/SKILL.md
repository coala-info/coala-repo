---
name: metaquantome-function-worklow
description: "This metaproteomics workflow integrates functional and intensity data using the metaQuantome suite to perform database mapping, statistical filtering, and differential expression analysis. Use this skill when you need to quantify and visualize the functional landscape of microbial communities to identify significant biological processes or enzymatic activities across different experimental conditions."
homepage: https://workflowhub.eu/workflows/1453
---

# metaquantome-function-worklow

## Overview

This Galaxy workflow is designed for the functional analysis of metaproteomics data using the [metaQuantome](https://github.com/galaxyproteomics/metaquantome) software suite. It integrates functional annotation data with protein intensity files to quantify and analyze the functional profiles of microbial communities. The pipeline is structured to facilitate a seamless transition from raw quantitative data to statistically significant biological insights.

The process begins by preparing the necessary databases and sample metadata. It then utilizes the **expand** tool to map peptides to functional categories, followed by a **filter** step to ensure data quality. The **stat** module is subsequently employed to perform differential expression analysis or other statistical tests, allowing researchers to identify key functional shifts across different experimental conditions.

The final stages of the workflow focus on comprehensive data visualization. It generates multiple graphical outputs, including heatmaps and distribution plots, to represent the functional landscape of the samples. Developed in alignment with [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards, this workflow provides a robust and reproducible framework for proteomics researchers.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 2 | Functional file | data_input |  |
| 3 | Intensity file | data_input |  |


Ensure your functional and intensity files are in tabular format (TSV) and contain consistent identifiers to allow for successful expansion and filtering. While this workflow accepts individual datasets, using Galaxy collections can streamline the management of multiple sample replicates during the sample file creation step. Refer to the README.md for specific column header requirements and database configuration details. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | metaQuantome: database | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_db/metaquantome_db/2.0.2+galaxy0 |  |
| 1 | metaQuantome: create samples file | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_sample/metaquantome_sample/2.0.2+galaxy0 |  |
| 4 | metaQuantome: expand | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_expand/metaquantome_expand/2.0.2+galaxy0 |  |
| 5 | metaQuantome: filter | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_filter/metaquantome_filter/2.0.2+galaxy0 |  |
| 6 | metaQuantome: stat | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_stat/metaquantome_stat/2.0.2+galaxy0 |  |
| 7 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.2+galaxy0 |  |
| 8 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.2+galaxy0 |  |
| 9 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.2+galaxy0 |  |
| 10 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.2+galaxy0 |  |
| 11 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.2+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | outfile | outfile |
| 1 | samples_file | samples_file |
| 4 | outfile | outfile |
| 5 | outfile | outfile |
| 6 | outfile | outfile |
| 7 | plotdata | plotdata |
| 7 | wrapped_outfile | wrapped_outfile |
| 8 | plotdata | plotdata |
| 8 | wrapped_outfile | wrapped_outfile |
| 9 | plotdata | plotdata |
| 9 | wrapped_outfile | wrapped_outfile |
| 10 | plotdata | plotdata |
| 10 | wrapped_outfile | wrapped_outfile |
| 11 | plotdata | plotdata |
| 11 | wrapped_outfile | wrapped_outfile |


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
