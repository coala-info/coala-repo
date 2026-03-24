---
name: taxonomic-profiling-and-visualization-of-metagenomic-data
description: "This metagenomics workflow processes raw sequencing reads and metadata to perform taxonomic profiling and community visualization using Kraken2, Bracken, and MetaPhlAn. Use this skill when you need to characterize the microbial composition of a sample and generate interactive visualizations to compare taxonomic distributions across different datasets."
homepage: https://workflowhub.eu/workflows/1470
---

# Taxonomic Profiling and Visualization of Metagenomic Data

## Overview

This workflow provides a comprehensive pipeline for the taxonomic profiling and visualization of metagenomic sequencing data. Starting from raw sequencing reads and associated metadata, it identifies and quantifies the microbial species present in a sample using two complementary approaches: k-mer based classification and marker-gene identification.

The core analysis is driven by [Kraken2](https://github.com/google/kraken2) for rapid taxonomic assignment, followed by [Bracken](https://ccb.jhu.edu/software/bracken/) to estimate highly accurate species-level abundances. In parallel, the workflow utilizes [MetaPhlAn](https://github.com/biobakery/MetaPhlAn) to profile microbial communities using unique clade-specific marker genes, providing a robust cross-validation of the taxonomic results.

To facilitate data exploration, the pipeline integrates several interactive visualization tools. It generates [Krona](https://github.com/marbl/Krona) pie charts for hierarchical browsing of community structure and utilizes [Pavian](https://github.com/fbreitwieser/pavian) and [Phinch](https://github.com/PitchInteractiveInc/Phinch) for comparative metagenomics. These tools allow researchers to analyze microbial diversity and composition across multiple samples effectively.

This workflow is tagged for **Microbiome** research and follows [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards, making it suitable for both production analysis and educational purposes under the MIT license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | raw-reads | data_collection_input |  |
| 1 | metadata | data_input |  |


Ensure your metagenomic sequencing data is uploaded as a fastq.gz dataset collection to enable efficient batch processing through the Kraken2 and MetaPhlAn steps. The metadata input should be a tabular (TSV) or CSV file with sample names matching your collection entries to ensure compatibility with the Pavian and Phinch visualization tools. Using collections rather than individual datasets is required for this workflow to correctly trigger the unzipping and parallel analysis stages. Please consult the README.md for comprehensive details on metadata formatting and specific database versioning. You may also use `planemo workflow_job_init` to create a `job.yml` for automated input configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Unzip collection | __UNZIP_COLLECTION__ |  |
| 3 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.3+galaxy2 |  |
| 4 | MetaPhlAn | toolshed.g2.bx.psu.edu/repos/iuc/metaphlan/metaphlan/4.1.1+galaxy4 |  |
| 5 | Krakentools: Convert kraken report file | toolshed.g2.bx.psu.edu/repos/iuc/krakentools_kreport2krona/krakentools_kreport2krona/1.2+galaxy2 |  |
| 6 | Kraken-biom | toolshed.g2.bx.psu.edu/repos/iuc/kraken_biom/kraken_biom/1.2.0+galaxy1 |  |
| 7 | Pavian | interactive_tool_pavian |  |
| 8 | Bracken | toolshed.g2.bx.psu.edu/repos/iuc/bracken/est_abundance/3.1+galaxy0 |  |
| 9 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 10 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 11 | Phinch Visualisation | interactive_tool_phinch |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | metaphlan_output | output_file |
| 5 | krakentool_report | output |


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
