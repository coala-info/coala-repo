---
name: gtn-chip-seq-formation-of-super-structures-on-xi
description: This epigenetics workflow processes paired-end ChIP-seq reads and BAM files for histone marks and transcription factors using Trim Galore, Bowtie2, MACS2, and deepTools to analyze chromatin structures. Use this skill when investigating the formation of large-scale chromatin superstructures on the inactive X chromosome or identifying enrichment patterns of H3K4me3, H3K27me3, and CTCF.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# gtn-chip-seq-formation-of-super-structures-on-xi

## Overview

This Galaxy workflow is designed for the epigenetic analysis of ChIP-seq data, specifically focusing on the formation of superstructures on the inactive X chromosome (Xi). It provides a comprehensive pipeline for processing raw sequencing data, identifying protein-DNA interaction sites, and visualizing the distribution of epigenetic marks such as H3K4me3, CTCF, and H3K27me3.

The workflow begins with quality control and preprocessing using [Trim Galore!](https://github.com/FelixKrueger/TrimGalore) and [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/), followed by alignment and indexing via [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml) and [Samtools](http://www.htslib.org/). It utilizes the [deepTools](https://deeptools.readthedocs.io/) suite to generate normalized coverage tracks (BigWig) and perform comparative assessments between ChIP samples and input controls. [MACS2](https://github.com/macs3-project/MACS) is then employed to call peaks, identifying significant regions of enrichment across replicates.

To ensure biological consistency and data quality, the pipeline generates diagnostic visualizations including fingerprint plots and correlation heatmaps. Final steps involve using [bedtools](https://bedtools.readthedocs.io/) to sort and merge genomic intervals, culminating in high-resolution heatmaps that illustrate the spatial organization of chromatin markers. This workflow is categorized under **Epigenetics** and **GTN** (Galaxy Training Network) and is licensed under CC-BY-4.0.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Paired End Reads Collection | data_collection_input |  |
| 1 | wt_input_rep1.bam | data_input |  |
| 2 | wt_H3K4me3_rep1.bam | data_input |  |
| 3 | wt_CTCF_rep1.bam | data_input |  |
| 4 | wt_H3K27me3_rep1.bam | data_input |  |
| 5 | wt_input_rep2.bam | data_input |  |
| 6 | wt_H3K4me3_rep2.bam | data_input |  |
| 7 | wt_CTCF_rep2.bam | data_input |  |
| 8 | wt_H3K27me3_rep2.bam | data_input |  |


This workflow requires a combination of raw paired-end sequence data in FASTQ format and pre-aligned BAM files for various histone marks and CTCF replicates. Ensure the raw reads are organized into a paired-end data collection to facilitate batch processing, while the individual BAM files should be uploaded as distinct datasets for comparative analysis. It is critical that all BAM files are indexed and mapped to the same reference genome to ensure compatibility with deepTools and MACS2. Consult the accompanying README.md for comprehensive details on experimental design and specific parameter configurations. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.6.7+galaxy0 |  |
| 10 | Flatten collection | __FLATTEN__ |  |
| 11 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.4 |  |
| 12 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.5.1.0.0 |  |
| 13 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.5.1.0.0 |  |
| 14 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.5.1.0.0 |  |
| 15 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.4 |  |
| 16 | plotFingerprint | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_fingerprint/deeptools_plot_fingerprint/3.5.1.0.0 |  |
| 17 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.5.1.0.0 |  |
| 18 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.7.1+galaxy0 |  |
| 19 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.5.1.0.0 |  |
| 20 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.5.1.0.0 |  |
| 21 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.7.1+galaxy0 |  |
| 22 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.5.1.0.0 |  |
| 23 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.5.1.0.0 |  |
| 24 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.7.1+galaxy0 |  |
| 25 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.5.1.0.0 |  |
| 26 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.7.1+galaxy0 |  |
| 27 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.5.1.0.0 |  |
| 28 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.7.1+galaxy0 |  |
| 29 | multiBamSummary | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_multi_bam_summary/deeptools_multi_bam_summary/3.5.1.0.0 |  |
| 30 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.5.1.0.0 |  |
| 31 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.7.1+galaxy0 |  |
| 32 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 33 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 34 | Concatenate datasets | cat1 |  |
| 35 | plotCorrelation | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_correlation/deeptools_plot_correlation/3.5.1.0.0 |  |
| 36 | Concatenate datasets | cat1 |  |
| 37 | bedtools SortBED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_sortbed/2.30.0+galaxy2 |  |
| 38 | bedtools SortBED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_sortbed/2.30.0+galaxy2 |  |
| 39 | bedtools MergeBED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_mergebed/2.30.0 |  |
| 40 | bedtools MergeBED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_mergebed/2.30.0 |  |
| 41 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/3.5.1.0.0 |  |
| 42 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/3.5.1.0.0 |  |
| 43 | plotHeatmap | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_heatmap/deeptools_plot_heatmap/3.5.1.0.1 |  |
| 44 | plotHeatmap | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_heatmap/deeptools_plot_heatmap/3.5.1.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | wt_H3K4me3_rep1_trim_galore | report_file |
| 14 | wt_H3K4me3_rep1_bamcoverage | outFileName |
| 15 | wt_H3K4me3_rep1_idxstats | output |
| 18 | wt_H3K4me3_input_rep1_macs2 | output_narrowpeaks |
| 19 | wt_H3K4me3_input_rep1_bamcompare | outFileName |
| 33 | text_file | text_file |
| 39 | wt_H3K4me3_CTCF_rep1_mergebed | output |
| 40 | wt_all_mergebed | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run formation-of-super-structures-on-xi.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run formation-of-super-structures-on-xi.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run formation-of-super-structures-on-xi.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init formation-of-super-structures-on-xi.ga -o job.yml`
- Lint: `planemo workflow_lint formation-of-super-structures-on-xi.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `formation-of-super-structures-on-xi.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)