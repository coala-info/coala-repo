---
name: wgs-part-in-analyses-of-metagenomics-data-the-global-picture
description: "This metagenomics workflow processes FASTA sequencing reads to perform taxonomic and functional profiling using MetaPhlAn2, HUMAnN2, and Krona visualization. Use this skill when you need to identify the microbial species present in a sample and quantify the abundance of metabolic pathways and gene families within that community."
homepage: https://workflowhub.eu/workflows/1472
---

# WGS Part In "Analyses Of Metagenomics Data - The Global Picture"

## Overview

This workflow is designed for the taxonomic and functional characterization of Whole Genome Sequencing (WGS) metagenomics data. It is a core component of the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorial "Analyses of metagenomics data - The global picture," focusing on identifying "who is there" and "what they are doing" within a microbial community.

The pipeline begins by performing taxonomic profiling using [MetaPhlAn2](https://toolshed.g2.bx.psu.edu/repos/iuc/metaphlan2/metaphlan2/2.6.0.0) on input FASTA sequences. To facilitate biological interpretation, the results are processed through [Krona pie chart](https://toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.6.1) tools, providing an interactive visualization of the relative abundance of microbial clades.

Functional analysis is conducted via [HUMAnN2](https://toolshed.g2.bx.psu.edu/repos/iuc/humann2/humann2/0.9.9.0), which profiles the presence and abundance of metabolic pathways and gene families. The workflow includes specialized post-processing steps to regroup gene families into higher-level categories and renormalize the data, ensuring that functional profiles are comparable across different samples and sequencing depths.

This workflow is tagged under **Microbiome** and **GTN**, serving as a standardized approach for researchers to move from raw sequence data to comprehensive ecological and functional insights.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SRR606451_pampa.fasta | data_input |  |


Ensure your input sequences are in FASTA format and represent high-quality metagenomic reads suitable for taxonomic and functional profiling. While this workflow processes a single dataset, you should organize multiple samples into dataset collections to streamline batch processing through MetaPhlAn2 and HUMAnN2. Refer to the README.md for comprehensive details on database requirements and specific tool parameters. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | MetaPhlAn2 | toolshed.g2.bx.psu.edu/repos/iuc/metaphlan2/metaphlan2/2.6.0.0 |  |
| 2 | Format MetaPhlAn2 | toolshed.g2.bx.psu.edu/repos/iuc/metaphlan2krona/metaphlan2krona/2.6.0.0 |  |
| 3 | HUMAnN2 | toolshed.g2.bx.psu.edu/repos/iuc/humann2/humann2/0.9.9.0 |  |
| 4 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.6.1 |  |
| 5 | Renormalize | toolshed.g2.bx.psu.edu/repos/iuc/humann2_renorm_table/humann2_renorm_table/0.9.9.0 |  |
| 6 | Regroup | toolshed.g2.bx.psu.edu/repos/iuc/humann2_regroup_table/humann2_regroup_table/0.9.9.0 |  |
| 7 | Renormalize | toolshed.g2.bx.psu.edu/repos/iuc/humann2_renorm_table/humann2_renorm_table/0.9.9.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run wgs-worklow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run wgs-worklow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run wgs-worklow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init wgs-worklow.ga -o job.yml`
- Lint: `planemo workflow_lint wgs-worklow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `wgs-worklow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
