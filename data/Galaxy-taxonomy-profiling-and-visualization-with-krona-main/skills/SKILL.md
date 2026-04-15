---
name: taxonomy-profiling-and-visualization-with-krona
description: This Galaxy workflow performs taxonomic profiling on preprocessed sequencing read collections using Kraken2 and generates interactive visualizations with Krona pie charts. Use this skill when you need to identify the microbial composition of microbiome samples or detect specific foodborne pathogens and their relative abundances across multiple datasets.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# taxonomy-profiling-and-visualization-with-krona

## Overview

This workflow performs taxonomic profiling and visualization of microbiome data, identifying organisms from the kingdom down to the species level. It is designed to process collections of preprocessed sequencing reads (such as those from Nanopore data) to detect pathogens and investigate potential co-infections within samples.

The pipeline utilizes [Kraken2](https://github.com/DerrickWood/kraken2) for taxonomic assignment, allowing users to select from various standard databases available on Galaxy. The resulting reports are processed via [Krakentools](https://github.com/jenniferlu717/KrakenTools) and visualized using [Krona pie charts](https://github.com/marbl/Krona), which provide an interactive interface for exploring the taxonomic composition of the dataset.

This workflow is a component of the [PathoGFAIR](https://github.com/pathogfair) initiative and is featured in the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/training-material/topics/microbiome/tutorials/pathogen-detection-from-nanopore-foodborne-data/tutorial.html) for foodborne pathogen detection. It is released under the MIT license and is compatible with [IWC](https://github.com/galaxyproject/iwc) standards.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | collection_of_preprocessed_samples | data_collection_input | Output collection from the Nanopore Preprocessing workflow |
| 1 | kraken_database | parameter_input | kraken_database_for_user_to_choose |


Upload your preprocessed sequencing reads as a paired or single-end collection in `fastqsanger` or `fastqsanger.gz` format to ensure efficient batch processing through Kraken2. You must select a compatible Kraken2 database from the available Galaxy parameters that best matches your target organisms, such as the PlusPF or Standard databases. Using a data collection rather than individual datasets is essential for the downstream Krakentools conversion and multi-sample Krona visualization. For comprehensive instructions on database selection and sample preparation, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy1 |  |
| 3 | Krakentools: Convert kraken report file | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_kreport2krona/krakentools_kreport2krona/1.2+galaxy1 |  |
| 4 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | kraken2_with_pluspf_database_output | output |
| 2 | kraken2_with_pluspf_database_output_report | report_output |
| 3 | converted_kraken_report | output |
| 4 | krona_pie_chart | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Taxonomy-Profiling-and-Visualization-with-Krona.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Taxonomy-Profiling-and-Visualization-with-Krona.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Taxonomy-Profiling-and-Visualization-with-Krona.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Taxonomy-Profiling-and-Visualization-with-Krona.ga -o job.yml`
- Lint: `planemo workflow_lint Taxonomy-Profiling-and-Visualization-with-Krona.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Taxonomy-Profiling-and-Visualization-with-Krona.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)