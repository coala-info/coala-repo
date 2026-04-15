---
name: galaxy-workflow-galaxy-hi-c
description: This workflow processes paired-end FASTQ reads and epigenetic tracks to analyze chromatin conformation in Drosophila melanogaster using BWA-MEM and the HiCExplorer suite. Use this skill when you need to identify Topologically Associating Domains (TADs), analyze A/B compartments via PCA, and visualize the spatial organization of the genome in relation to specific epigenetic modifications.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# galaxy-workflow-galaxy-hi-c

## Overview

This workflow provides a comprehensive pipeline for Hi-C data analysis in *Drosophila melanogaster* cells, utilizing the [HiCExplorer](https://hicexplorer.readthedocs.io/) suite within the Galaxy framework. It is designed to process raw sequencing reads to identify chromatin interactions, following best practices established by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/).

The analysis begins by mapping paired-end FASTQ reads to the reference genome using [BWA-MEM](https://github.com/lh3/bwa). Once mapped, the workflow constructs a contact matrix, merges bins to adjust resolution, and performs matrix correction to normalize the data. These steps are essential for removing biases and preparing the interaction data for structural interpretation.

In the final stages, the workflow identifies key genomic features such as Topologically Associating Domains (TADs) and performs Principal Component Analysis (PCA) to detect A/B compartments. By integrating epigenetic tracks (H3K27me3, H3K36me3, and H4K16ac) and gene annotations, the pipeline generates detailed visualizations of chromatin architecture and domain organization.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | R1.fastq | data_input |  |
| 1 | R2.fastq | data_input |  |
| 2 | H3K27me3.bw | data_input |  |
| 3 | H3K36me3.bw | data_input |  |
| 4 | H4K16ac.bw | data_input |  |
| 5 | dm3_genes.bed | data_input |  |


Ensure your input FASTQ files (R1 and R2) are correctly paired and that the reference genome matches the BED and BigWig files to avoid mapping errors in BWA-MEM. While this workflow uses individual datasets for the Hi-C reads and epigenetic tracks, you may consider using dataset collections for larger comparative studies to streamline execution. Refer to the `README.md` for specific parameter settings and detailed data preparation requirements. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 6 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/crs4/bwa_mem/bwa_mem/0.8.0 |  |
| 7 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/crs4/bwa_mem/bwa_mem/0.8.0 |  |
| 8 | hicBuildMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicbuildmatrix/hicexplorer_hicbuildmatrix/2.1.0 |  |
| 9 | hicMergeMatrixBins | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicmergematrixbins/hicexplorer_hicmergematrixbins/2.1.0 |  |
| 10 | hicCorrectMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hiccorrectmatrix/hicexplorer_hiccorrectmatrix/2.1.0 |  |
| 11 | hicCorrectMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hiccorrectmatrix/hicexplorer_hiccorrectmatrix/2.1.0 |  |
| 12 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/2.1.0 |  |
| 13 | hicPlotMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplotmatrix/hicexplorer_hicplotmatrix/2.1.0 |  |
| 14 | hicFindTADs | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicfindtads/hicexplorer_hicfindtads/2.1.0 |  |
| 15 | hicPCA | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicpca/hicexplorer_hicpca/2.1.0 |  |
| 16 | hicPlotTADs | toolshed.g2.bx.psu.edu/repos/bgruening/hicexplorer_hicplottads/hicexplorer_hicplottads/2.1.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-galaxy-hi-c.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-galaxy-hi-c.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-galaxy-hi-c.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-galaxy-hi-c.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-galaxy-hi-c.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-galaxy-hi-c.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)