---
name: 16s_biodiversity_for_nonoverlap_paired_end
description: "This Galaxy workflow processes non-overlapping paired-end 16S metagenomic data through quality control, VSearch clustering, and Phyloseq-based statistical analysis to determine microbial biodiversity. Use this skill when you need to identify differentially abundant taxa, calculate richness indices, and visualize community composition from environmental or clinical samples where sequencing reads do not overlap."
homepage: https://workflowhub.eu/workflows/233
---

# 16S_biodiversity_for_nonoverlap_paired_end

## Overview

This workflow is part of the MetaDEGalaxy suite, designed for the differential abundance analysis of 16S metagenomic data. It is specifically configured to handle non-overlapping paired-end reads, providing a standardized pipeline from raw sequence processing to ecological statistics as described in [PMC6807170](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6807170/).

The pipeline begins with quality control and preprocessing using FastQC and Trimmomatic. Sequences are aligned with BWA-MEM and filtered to ensure high-quality inputs for the VSearch suite. VSearch is then utilized for dereplication, chimera detection, and OTU clustering. The resulting data is transformed into OTU tables and converted to the BIOM format, incorporating necessary metadata for downstream analysis.

The final stage of the workflow focuses on statistical evaluation and visualization using Phyloseq and DESeq2. It generates comprehensive outputs, including differential abundance tables, alpha-diversity richness estimates, and various visualizations such as taxonomic abundance plots, network diagrams, and symmetric plots to characterize microbial biodiversity.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | "Input Dataset Collection" | data_collection_input |  |


This workflow requires a paired-end dataset collection containing raw sequencing reads in FASTQ format, typically as .fastq or .fastq.gz files. Ensure your collection is correctly structured as a list of pairs to facilitate the initial Trimmomatic and BWA-MEM processing steps for non-overlapping reads. You must also provide appropriate reference databases for mapping and taxonomic assignment within the specific tool parameters. Consult the README.md for comprehensive details on metadata formatting and the specific parameter configurations required for the Phyloseq analysis steps. For automated execution, you can use `planemo workflow_job_init` to generate a template `job.yml` file for your input data.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 2 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.36.6 |  |
| 3 | Concatenate multiple datasets | toolshed.g2.bx.psu.edu/repos/artbio/concatenate_multiple_datasets/cat_multi_datasets/1.0 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 5 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 6 | FilterSamReads | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_FilterSamReads/2.18.2.1 |  |
| 7 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 8 | VSearch search | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_search/2.8.3.1 |  |
| 9 | VSearch dereplication | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_dereplication/1.9.7.0 |  |
| 10 | VSearch chimera detection | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_chimera_detection/1.9.7.0 |  |
| 11 | VSearch clustering | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_clustering/1.9.7.0 |  |
| 12 | VSearch search | toolshed.g2.bx.psu.edu/repos/iuc/vsearch/vsearch_search/2.8.3.1 |  |
| 13 | Add column | addValue |  |
| 14 | Cut | Cut1 |  |
| 15 | Cut | Cut1 |  |
| 16 | Concatenate datasets | cat1 |  |
| 17 | OTUTable | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_uc2otutable/uclust2otutable/1.0.0 |  |
| 18 | Convert BIOM | toolshed.g2.bx.psu.edu/repos/iuc/biom_convert/biom_convert/2.1.5.0 |  |
| 19 | BIOM metadata | toolshed.g2.bx.psu.edu/repos/iuc/biom_add_metadata/biom_add_metadata/2.1.5.0 |  |
| 20 | Phyloseq DESeq2 | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_deseq2/phyloseq_DESeq2/1.22.3 |  |
| 21 | Phyloseq Richness | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_richness/phyloseq_richness/1.22.3.2 |  |
| 22 | Phyloseq Abundance plot | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_abundance_factor/phyloseq_abundance/1.22.3.3 |  |
| 23 | Phyloseq Abundance Taxonomy | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_abundance_taxonomy/phyloseq_taxonomy/1.22.3.3 |  |
| 24 | Phyloseq Network Plot | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_phyloseq_net/phyloseq_net/1.24.2 |  |
| 25 | Symmetric Plot | toolshed.g2.bx.psu.edu/repos/qfabrepo/metadegalaxy_symmetric_plot/symmetricPlot/1.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | out_file1 | out_file1 |
| 7 | output | output |
| 8 | uc | uc |
| 12 | uc | uc |
| 17 | output | output |
| 18 | output_table | output_table |
| 19 | output_table | output_table |
| 20 | normalised_table | normalised_table |
| 20 | DE_table | DE_table |
| 21 | htmlfile | htmlfile |
| 22 | htmlfile | htmlfile |
| 23 | htmlfile | htmlfile |
| 24 | htmlfile | htmlfile |
| 25 | htmlfile | htmlfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 16S_biodiversity_for_nonoverlap_paired_end.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 16S_biodiversity_for_nonoverlap_paired_end.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 16S_biodiversity_for_nonoverlap_paired_end.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 16S_biodiversity_for_nonoverlap_paired_end.ga -o job.yml`
- Lint: `planemo workflow_lint 16S_biodiversity_for_nonoverlap_paired_end.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `16S_biodiversity_for_nonoverlap_paired_end.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
