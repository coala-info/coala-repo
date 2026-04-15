---
name: qiime2-iii-v-phylogeny-rarefaction-taxonomic-analysis
description: This QIIME2 workflow processes representative sequences, feature tables, and metadata to perform phylogenetic tree reconstruction via SEPP fragment insertion, alpha rarefaction analysis, and taxonomic classification using a pre-trained classifier. Use this skill when you need to determine the evolutionary relationships of microbial sequences, assess if sequencing depth is sufficient to capture community diversity, and visualize the taxonomic composition of your samples.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# qiime2-iii-v-phylogeny-rarefaction-taxonomic-analysis

## Overview

This Galaxy workflow performs downstream microbiome analysis using QIIME2, specifically focusing on phylogenetic reconstruction, alpha rarefaction, and taxonomic classification. It is modeled after the procedures in the [QIIME2 Parkinson’s Mouse Tutorial](https://docs.qiime2.org/2024.5/tutorials/pd-mice/). The workflow integrates three major subworkflow components to process feature tables and representative sequences into interpretable biological data.

The analysis begins by reconstructing a phylogenetic tree using the SEPP fragment insertion method, which places ASVs into a fixed reference phylogeny. Simultaneously, the workflow performs alpha rarefaction to evaluate richness relative to sampling depth and executes taxonomic classification using a pre-trained Naive Bayes classifier. These steps are essential for preparing data for subsequent diversity metrics and statistical testing.

Key outputs include a rooted phylogenetic tree, alpha rarefaction curves, and comprehensive taxonomic assignments provided in both tabular and interactive barplot formats. This workflow requires a feature table, representative sequences, and sample metadata, along with specific reference files for fragment insertion and taxonomic classification. For detailed information on input preparation and file requirements, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Representative sequences | data_input | Representative sequences, e.g. from DADA2 |
| 1 | Feature table | data_input | Feature table. e.g. from DADA2 |
| 2 | Metadata | data_input | Tab separated metadata file |
| 3 | Minimum depth | parameter_input | Minimum depth used for the rarefaction analysis (minimum value : 1) |
| 4 | Maximum depth | parameter_input | Maximum depth used for the rarefaction analysis (minimum value : 1) |
| 5 | SEPP fragment insertion reference | data_input | Reference data for the SEPP fragmentation insertion phylogenetic tree generation |
| 6 | Taxonomic classifier | data_input | Taxonomic classifier (e.g. Greengenes or SILVA) |


Ensure all sequence and table inputs are in `.qza` format, while the metadata should be a standard tab-separated text file. Use the SEPP reference and taxonomic classifier specific to your study's marker gene and region to ensure accurate phylogenetic placement and classification. For large-scale runs, consider organizing inputs into data collections to streamline the subworkflow execution. Refer to the `README.md` for comprehensive details on parameter selection and specific file requirements. You can automate the setup of these parameters using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | QIIME2 III: Phylogenetic tree for diversity analysis | (subworkflow) | Phylogenetic tree for diversity analysis |
| 8 | QIIME2 V: Taxonomic analysis | (subworkflow) | Taxonomic analysis |
| 9 | QIIME2 IV: Rarefaction | (subworkflow) | Rarefaction |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run QIIME2-III-V-Phylogeny-Rarefaction-Taxonomic-Analysis.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run QIIME2-III-V-Phylogeny-Rarefaction-Taxonomic-Analysis.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run QIIME2-III-V-Phylogeny-Rarefaction-Taxonomic-Analysis.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init QIIME2-III-V-Phylogeny-Rarefaction-Taxonomic-Analysis.ga -o job.yml`
- Lint: `planemo workflow_lint QIIME2-III-V-Phylogeny-Rarefaction-Taxonomic-Analysis.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `QIIME2-III-V-Phylogeny-Rarefaction-Taxonomic-Analysis.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)