---
name: circos-for-e-coli
description: "This workflow generates a circular visualization of a microbial genome using Circos by integrating genomic sequences, GFF3 annotations, RNA-seq and DNA-seq coverage data, and variant information. Use this skill when you need to create a comprehensive circular plot to analyze the spatial distribution of sequencing depth, GC content, and gene annotations across a bacterial genome."
homepage: https://workflowhub.eu/workflows/1419
---

# Circos for E. Coli

## Overview

This workflow generates a comprehensive circular visualization of a microbial genome, such as *E. coli*, using the [Circos](https://toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy9) engine. It integrates diverse genomic datasets—including reference sequences, gene annotations (GFF3), RNA-seq and DNA-seq coverage (BigWig), and variant calls—to produce a high-quality publication-ready plot.

The pipeline automates several data transformation steps to prepare tracks for the final visualization. It calculates GC skew from the genome sequence, converts GFF3 annotations into BED format for tiling, and transforms BigWig coverage files into scatter plots. It also processes interval data into text labels and tiles to highlight specific genomic features and variants.

The final output is a multi-layered Circos plot that provides a global view of the microbial landscape, mapping sequencing depth and structural annotations across the circular chromosome. This workflow is particularly useful for comparative genomics and visualizing high-throughput sequencing distributions in a spatial context.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Genome | data_input |  |
| 1 | Genes | data_input |  |
| 2 | RNA Seq Coverage (1) | data_input |  |
| 3 | RNA Seq Coverage (2) | data_input |  |
| 4 | DNA Sequencing Coverage | data_input |  |
| 5 | Variants | data_input |  |


Ensure your inputs are correctly formatted, specifically using GFF3 for gene annotations and bigWig for sequencing coverage tracks to ensure compatibility with the Circos conversion tools. While this workflow processes individual datasets, ensure that your variant and interval files are properly cleaned and formatted as described in the tool requirements. Refer to the README.md for comprehensive details on data preparation and specific track configurations. You can also use `planemo workflow_job_init` to create a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | GC Skew | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos_gc_skew/0.69.8+galaxy9 |  |
| 7 | Circos: Interval to Circos Text Labels | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos_interval_to_text/0.69.8+galaxy9 |  |
| 8 | GFF-to-BED | gff2bed1 |  |
| 9 | Circos: bigWig to Scatter | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos_wiggle_to_scatter/0.69.8+galaxy9 |  |
| 10 | Circos: bigWig to Scatter | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos_wiggle_to_scatter/0.69.8+galaxy9 |  |
| 11 | Circos: bigWig to Scatter | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos_wiggle_to_scatter/0.69.8+galaxy9 |  |
| 12 | Cut | Cut1 |  |
| 13 | Circos: bigWig to Scatter | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos_wiggle_to_scatter/0.69.8+galaxy9 |  |
| 14 | Circos: Interval to Tiles | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos_interval_to_tile/0.69.8+galaxy9 |  |
| 15 | Circos | toolshed.g2.bx.psu.edu/repos/iuc/circos/circos/0.69.8+galaxy9 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 15 | plot | output_png |


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
