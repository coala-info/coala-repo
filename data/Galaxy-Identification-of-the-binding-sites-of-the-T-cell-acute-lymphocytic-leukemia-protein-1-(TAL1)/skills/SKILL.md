---
name: identification-of-the-binding-sites-of-the-t-cell-acute-lymp
description: This epigenetics workflow processes paired-end ChIP-seq FASTQ reads from multiple cell types to identify TAL1 transcription factor binding sites using BWA for alignment, MACS2 for peak calling, and deepTools for genomic visualization. Use this skill when you need to compare protein-DNA interaction profiles across different hematopoietic lineages or identify cell-type-specific regulatory elements and overlapping genomic binding regions.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# identification-of-the-binding-sites-of-the-t-cell-acute-lymp

## Overview

This Galaxy workflow identifies the binding sites of the T-cell acute lymphocytic leukemia protein 1 (TAL1) across different stages of hematopoiesis, specifically in G1E and Megakaryocyte cell lines. The analysis follows standard ChIP-seq best practices, beginning with raw sequence quality control using [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and adapter trimming via [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic). The processed reads are then aligned to the mouse reference genome (mm10) using [BWA](http://bio-bwa.sourceforge.net/).

Following alignment, the workflow performs extensive post-mapping assessment using [Samtools](http://www.htslib.org/) and [deepTools](https://deeptools.readthedocs.io/) to evaluate library complexity and sample correlation. It utilizes [MACS2](https://github.com/macs3-project/MACS) to call peaks by comparing TAL1 ChIP samples against their respective input controls, identifying regions of significant protein-DNA interaction.

The final stages focus on comparative epigenetics and visualization. [bedtools](https://bedtools.readthedocs.io/) is used to intersect peak sets, allowing for the identification of overlapping and cell-type-specific binding sites. The workflow generates normalized signal tracks and high-quality visualizations, including heatmaps and profile plots created with [computeMatrix](https://deeptools.readthedocs.io/en/develop/content/tools/computeMatrix.html) and [plotHeatmap](https://deeptools.readthedocs.io/en/develop/content/tools/plotHeatmap.html), to characterize TAL1 occupancy relative to RefSeq gene annotations.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | G1E_input_R1_downsampled_SRR507859.fastqsanger | data_input |  |
| 1 | G1E_input_R2_downsampled_SRR507860.fastqsanger | data_input |  |
| 2 | G1E_Tal1_R1_downsampled_SRR492444.fastqsanger | data_input |  |
| 3 | G1E_Tal1_R2_downsampled_SRR492445.fastqsanger | data_input |  |
| 4 | Megakaryocyte_input_R1_downsampled_SRR492453.fastqsanger | data_input |  |
| 5 | Megakaryocyte_input_R2_downsampled_SRR492454.fastqsanger | data_input |  |
| 6 | Megakaryocyte_Tal1_R1_downsampled_SRR549006.fastqsanger | data_input |  |
| 7 | Megakaryocytes_Tal1_R2_downsampled_SRR549007.fastqsanger | data_input |  |
| 8 | RefSeq_gene_annotations_mm10.bed | data_input |  |


This workflow requires paired-end ChIP-seq data in fastqsanger format for both TAL1-enriched samples and their corresponding genomic input controls across two cell types, alongside a RefSeq gene annotation file in BED format. Ensure all sequencing reads are correctly typed as fastqsanger to prevent tool errors during Trimmomatic and BWA mapping steps. While these inputs are provided as individual datasets, they can be organized into collections to streamline the numerous FastQC and mapping operations. For automated environment setup and job configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. Please refer to the README.md for comprehensive details on sample metadata and specific parameter settings.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 10 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 11 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 12 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 13 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 14 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 15 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 16 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 17 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 18 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 19 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 20 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 21 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 22 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 23 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 24 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 25 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 26 | Map with BWA | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa/0.7.17.4 |  |
| 27 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 28 | Map with BWA | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa/0.7.17.4 |  |
| 29 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 30 | Map with BWA | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa/0.7.17.4 |  |
| 31 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 32 | Map with BWA | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa/0.7.17.4 |  |
| 33 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 34 | Map with BWA | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa/0.7.17.4 |  |
| 35 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 36 | Map with BWA | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa/0.7.17.4 |  |
| 37 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 38 | Map with BWA | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa/0.7.17.4 |  |
| 39 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 40 | Map with BWA | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa/0.7.17.4 |  |
| 41 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.3 |  |
| 42 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.3 |  |
| 43 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.3 |  |
| 44 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.3.2.0.0 |  |
| 45 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.3 |  |
| 46 | plotFingerprint | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_fingerprint/deeptools_plot_fingerprint/3.3.2.0.0 |  |
| 47 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.1.1.20160309.6 |  |
| 48 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.3.2.0.0 |  |
| 49 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.3 |  |
| 50 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.3 |  |
| 51 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.3 |  |
| 52 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.3.2.0.0 |  |
| 53 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.3 |  |
| 54 | multiBamSummary | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_multi_bam_summary/deeptools_multi_bam_summary/3.3.2.0.0 |  |
| 55 | plotFingerprint | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_fingerprint/deeptools_plot_fingerprint/3.3.2.0.0 |  |
| 56 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.1.1.20160309.6 |  |
| 57 | bamCompare | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_compare/deeptools_bam_compare/3.3.2.0.0 |  |
| 58 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/3.3.2.0.0 |  |
| 59 | plotCorrelation | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_correlation/deeptools_plot_correlation/3.3.2.0.0 |  |
| 60 | bedtools Intersect intervals | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_intersectbed/2.29.0 |  |
| 61 | bedtools Intersect intervals | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_intersectbed/2.29.0 |  |
| 62 | bedtools Intersect intervals | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_intersectbed/2.29.0 |  |
| 63 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/3.3.2.0.0 |  |
| 64 | plotHeatmap | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_heatmap/deeptools_plot_heatmap/3.3.2.0.1 |  |
| 65 | plotHeatmap | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_heatmap/deeptools_plot_heatmap/3.3.2.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 60 | output_overlapping_peaks | output |
| 61 | output_g1e_peaks | output |
| 62 | output_megakaryocyte_peaks | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run tal1-binding-site-identification-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run tal1-binding-site-identification-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run tal1-binding-site-identification-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init tal1-binding-site-identification-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint tal1-binding-site-identification-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `tal1-binding-site-identification-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)