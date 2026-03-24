---
name: 16s_biodiversity_biom
description: "This workflow processes 16S rRNA count tables and metadata into BIOM format to perform differential abundance analysis with DESeq2 and generate comprehensive biodiversity visualizations using Phyloseq. Use this skill when you need to identify significantly different microbial taxa across experimental conditions and visualize community richness, taxonomic abundance, and ecological networks from metagenomic datasets."
homepage: https://workflowhub.eu/workflows/142
---

# 16S_biodiversity_BIOM

## Overview

This workflow is designed for the downstream analysis of 16S rRNA sequencing data, focusing on microbial biodiversity and differential abundance. It begins by converting raw count tables into the BIOM format and integrating essential metadata, establishing a standardized dataset for ecological statistics.

The core analysis utilizes [DESeq2](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6807170/) to identify differentially abundant taxa across experimental conditions. This allows researchers to determine which microbial features are significantly enriched or depleted between sample groups within the MetaDEGalaxy framework.

To visualize these biological insights, the workflow leverages the Phyloseq package to generate a comprehensive suite of plots. These include alpha diversity (richness) estimates, abundance plots categorized by experimental factors or taxonomy, symmetric plots, and microbial network diagrams. The final outputs are rendered as interactive HTML files for detailed exploration of community structures.

## Inputs and data preparation

_None listed._


Ensure the input count table and metadata are provided in tabular (TSV) format to facilitate the initial BIOM conversion and metadata integration steps. Use individual datasets for these primary inputs to ensure compatibility with the specific tool parameters required for DESeq2 and Phyloseq analysis. For comprehensive instructions on formatting requirements and parameter settings, refer to the README.md file. You can streamline the execution process by generating a template configuration using `planemo workflow_job_init` to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Convert BIOM | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.5.0 |  |
| 1 | BIOM metadata | toolshed.g2.bx.psu.edu/repos/iuc/biom_add_metadata/biom_add_metadata/2.1.5.0 |  |
| 2 | DESeq2 | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_deseq2/phyloseq_DESeq2/1.22.3 |  |
| 3 | Phyloseq Richness | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_richness/phyloseq_richness/1.22.3.2 |  |
| 4 | Phyloseq Abundance plot | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_abundance_factor/phyloseq_abundance/1.22.3.3 |  |
| 5 | Phyloseq Abundance Taxonomy | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_abundance_taxonomy/phyloseq_taxonomy/1.22.3.3 |  |
| 6 | Symmetric Plot | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_symmetric_plot/symmetricPlot/1.0.1 |  |
| 7 | Phyloseq Network Plot | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_net/phyloseq_net/1.24.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | htmlfile | htmlfile |
| 4 | htmlfile | htmlfile |
| 5 | htmlfile | htmlfile |
| 6 | htmlfile | htmlfile |
| 7 | htmlfile | htmlfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 16S_biodiversity_BIOM.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 16S_biodiversity_BIOM.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 16S_biodiversity_BIOM.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 16S_biodiversity_BIOM.ga -o job.yml`
- Lint: `planemo workflow_lint 16S_biodiversity_BIOM.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `16S_biodiversity_BIOM.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
