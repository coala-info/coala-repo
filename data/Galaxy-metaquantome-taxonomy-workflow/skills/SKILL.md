---
name: metaquantome-taxonomy-workflow
description: This metaproteomics workflow processes taxonomic and intensity data using the metaQuantome suite to perform database mapping, statistical analysis, and comprehensive visualization. Use this skill when you need to quantify differential taxonomic abundance and visualize microbial community composition across experimental conditions in a metaproteomics study.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# metaquantome-taxonomy-workflow

## Overview

This Galaxy workflow is designed for the taxonomic analysis of metaproteomics data using the [metaQuantome](https://github.com/galaxyproteomics/metaquantome) software suite. It integrates taxonomic assignments with protein intensity data to quantify the distribution and abundance of microbial taxa across different experimental conditions.

The pipeline begins by generating a samples file and preparing the necessary taxonomic databases. It then executes a series of processing steps, including data expansion to map peptides to their respective taxonomic lineages and rigorous filtering to ensure data quality. Statistical tests are subsequently applied to identify significant taxonomic shifts between sample groups.

The final stages of the workflow focus on data visualization, producing multiple graphical outputs such as heatmaps and PCA plots. These visualizations allow researchers to interpret complex community structures and communicate the biological relevance of their proteomics findings.

Developed in alignment with [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) standards, this workflow provides a reproducible framework for proteomics researchers. It streamlines the transition from raw intensity tables to statistically validated taxonomic insights within the Galaxy ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 1 | Taxa | data_input |  |
| 2 | Intensity | data_input |  |


Ensure your Taxa and Intensity inputs are provided in tabular format, typically as TSV files, with the Taxa file containing valid NCBI TaxIDs and the Intensity file containing quantitative proteomics data. Verify that column headers match exactly between these files to allow the sample creation tool to correctly map experimental groups and conditions. Refer to the README.md for specific column requirements and detailed parameter configurations necessary for the metaQuantome database and expansion steps. You can use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | metaQuantome: create samples file | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_sample/metaquantome_sample/2.0.0-0 |  |
| 3 | metaQuantome: database | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_db/metaquantome_db/2.0.0-0 |  |
| 4 | metaQuantome: expand | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_expand/metaquantome_expand/2.0.0-0 |  |
| 5 | metaQuantome: filter | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_filter/metaquantome_filter/2.0.0-0 |  |
| 6 | metaQuantome: stat | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_stat/metaquantome_stat/2.0.0-0 |  |
| 7 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.0-0 |  |
| 8 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.0-0 |  |
| 9 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.0-0 |  |
| 10 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.0-0 |  |
| 11 | metaQuantome: visualize | toolshed.g2.bx.psu.edu/repos/galaxyp/metaquantome_viz/metaquantome_viz/2.0.0-0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | samples_file | samples_file |
| 3 | outfile | outfile |
| 4 | outfile | outfile |
| 5 | outfile | outfile |
| 6 | outfile | outfile |
| 7 | plotdata | plotdata |
| 7 | wrapped_outfile | wrapped_outfile |
| 8 | plotdata | plotdata |
| 8 | wrapped_outfile | wrapped_outfile |
| 9 | wrapped_outfile | wrapped_outfile |
| 9 | plotdata | plotdata |
| 10 | wrapped_outfile | wrapped_outfile |
| 10 | plotdata | plotdata |
| 11 | wrapped_outfile | wrapped_outfile |
| 11 | plotdata | plotdata |


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