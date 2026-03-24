---
name: metatranscriptomics-analysis-using-microbiome-rna-seq-data-w
description: "This metatranscriptomics workflow processes forward and reverse microbiome RNA-seq reads to generate taxonomic community profiles using MetaPhlAn, Krona, and GraPhlAn. Use this skill when you need to characterize the taxonomic composition of a microbial community and visualize the relative abundance of species through hierarchical trees and interactive pie charts."
homepage: https://workflowhub.eu/workflows/1451
---

# Metatranscriptomics analysis using microbiome RNA-seq data - Workflow 2: Community profile

## Overview

This Galaxy workflow is designed for the taxonomic profiling of microbial communities using metatranscriptomic RNA-seq data. It serves as the second stage in a comprehensive metatranscriptomics analysis pipeline, taking paired-end forward and reverse reads as input to identify the microorganisms present in a sample and estimate their relative abundances.

The core analysis is performed by [MetaPhlAn](https://toolshed.g2.bx.psu.edu/repos/iuc/metaphlan/metaphlan/4.1.1+galaxy4), which maps reads against a database of clade-specific marker genes. The resulting taxonomic assignments are then processed through data manipulation tools like [Cut](https://usegalaxy.org/) to format the information for various visualization platforms.

To aid in the interpretation of the community structure, the workflow generates multiple visual outputs. It produces a [Krona pie chart](https://toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0) for interactive hierarchical exploration and utilizes the [GraPhlAn](https://toolshed.g2.bx.psu.edu/repos/iuc/graphlan/graphlan/1.1.3) suite to create sophisticated, publication-ready circular phylogenetic trees. The final outputs include the raw predicted taxon tables and the annotated GraPhlAn visualization.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Forward reads | data_input | Metatranscriptomics forward preprocessed reads |
| 1 | Reverse reads | data_input | Metatranscriptomics reverse preprocessed reads |


Ensure your input data consists of high-quality, pre-processed FASTQ files for both forward and reverse reads to achieve accurate taxonomic profiling. Organizing these files into paired-end data collections is highly recommended for efficient batch processing across multiple samples, though individual datasets are supported for single-sample runs. For a comprehensive guide on specific parameter configurations and database dependencies, please consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for automated input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | MetaPhlAn | toolshed.g2.bx.psu.edu/repos/iuc/metaphlan/metaphlan/4.1.1+galaxy4 |  |
| 3 | Cut | Cut1 |  |
| 4 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 5 | Export to GraPhlAn | toolshed.g2.bx.psu.edu/repos/iuc/export2graphlan/export2graphlan/0.20+galaxy0 |  |
| 6 | Generation, personalization and annotation of tree | toolshed.g2.bx.psu.edu/repos/iuc/graphlan_annotate/graphlan_annotate/1.1.3 |  |
| 7 | GraPhlAn | toolshed.g2.bx.psu.edu/repos/iuc/graphlan/graphlan/1.1.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | metaphlan_predicted_taxons | output_file |
| 7 | graphlan_output_image | png_output_image |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow2-community-profile.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow2-community-profile.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow2-community-profile.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow2-community-profile.ga -o job.yml`
- Lint: `planemo workflow_lint workflow2-community-profile.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow2-community-profile.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
