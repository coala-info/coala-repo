---
name: infinium-human-methylation-beadchip
description: "This epigenetics workflow processes paired Red and Green IDAT files and phenotype data using the minfi-based Infinium Human Methylation BeadChip tool, ChIPpeakAnno, and Cluster Profiler. Use this skill when you need to identify differentially methylated positions or regions from microarray data and characterize their biological significance through genomic annotation and Gene Ontology enrichment analysis."
homepage: https://workflowhub.eu/workflows/1624
---

# Infinium Human Methylation BeadChip

## Overview

This Galaxy workflow provides a comprehensive pipeline for analyzing Infinium Human Methylation BeadChip data, specifically designed to detect somatic genetic alterations and differential methylation patterns. It processes raw intensity data (`.idat` files) in both Red and Green channels, alongside phenotype information and UCSC human genome annotations, to perform high-throughput epigenetic profiling.

The core analysis is driven by the [minfi](https://toolshed.g2.bx.psu.edu/repos/kpbioteam/ewastools/minfi_analysis/2.1.0) suite, which generates quality control reports, SNP information, and identifies both Differentially Methylated Positions (DMPs) and Regions (DMRs). Following the primary methylation analysis, the workflow utilizes [ChIPpeakAnno](https://toolshed.g2.bx.psu.edu/repos/kpbioteam/chipeakanno_annopeaks/chipeakanno_annopeaks/0.1.0) to annotate peaks and map them to genomic features.

The final stages focus on functional interpretation using [Cluster Profiler](https://toolshed.g2.bx.psu.edu/repos/kpbioteam/clusterprofiler_go/clusterprofiler_go/0.1.0). The pipeline translates gene IDs and performs Gene Ontology (GO) enrichment analysis, producing both tabular results and visualizations to help researchers understand the biological significance of the methylation changes. This workflow is tagged for Epigenetics and [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) applications under an AGPL-3.0-or-later license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | R01C02_Red.idat | data_input |  |
| 1 | R02C02_Red.idat | data_input |  |
| 2 | R05C02_Red.idat | data_input |  |
| 3 | R06C02_Red.idat | data_input |  |
| 4 | R01C02_Green.idat | data_input |  |
| 5 | R02C02_Green.idat | data_input |  |
| 6 | R05C02_Green.idat | data_input |  |
| 7 | R06C02_Green.idat | data_input |  |
| 8 | phenotype Table txt file | data_input |  |
| 9 | UCSC Main on Human | data_input |  |


Ensure all raw intensity data are uploaded as `.idat` files, specifically pairing the Red and Green channels for each sample to allow for proper normalization. While individual datasets are listed here, organizing these into paired collections can significantly streamline the execution of the `minfi` analysis tool. You must also provide a phenotype table in `.txt` format and a genomic annotation file (e.g., from UCSC) to facilitate differential methylation and peak annotation. For automated testing or command-line execution, consider using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on sample naming conventions and metadata requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 10 | Infinium Human Methylation BeadChip | toolshed.g2.bx.psu.edu/repos/kpbioteam/ewastools/minfi_analysis/2.1.0 |  |
| 11 | ChIPpeakAnno annoPeaks | toolshed.g2.bx.psu.edu/repos/kpbioteam/chipeakanno_annopeaks/chipeakanno_annopeaks/0.1.0 |  |
| 12 | Cut | Cut1 |  |
| 13 | Remove beginning | Remove beginning1 |  |
| 14 | Cluster Profiler Bitr | toolshed.g2.bx.psu.edu/repos/kpbioteam/clusterprofiler_bitr/clusterprofiler_bitr/0.1.0 |  |
| 15 | Cluster Profiler GO | toolshed.g2.bx.psu.edu/repos/kpbioteam/clusterprofiler_go/clusterprofiler_go/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 10 | SNPInfo Table | table |
| 10 | Differentially Methylated Regions | dmr |
| 10 | Differentially Methylated Positions | dmp |
| 10 | Quality Control Report | qctab |
| 10 | Quality Control Plot | qcpng |
| 11 | Table of Annotated Peaks | tab |
| 12 | Cut on Table of Annotated Peaks | out_file1 |
| 13 | Remove beginning on the cut output | out_file1 |
| 14 | Table of Translated Gene ID's | translation |
| 15 | GO Enrichment Analysis of a Gene Set | table |
| 15 | GO Enrichment Analysis Visualization | plot |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run infinium-human-methylation-beadchip.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run infinium-human-methylation-beadchip.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run infinium-human-methylation-beadchip.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init infinium-human-methylation-beadchip.ga -o job.yml`
- Lint: `planemo workflow_lint infinium-human-methylation-beadchip.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `infinium-human-methylation-beadchip.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
