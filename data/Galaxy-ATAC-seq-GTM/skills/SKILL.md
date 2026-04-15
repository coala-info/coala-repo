---
name: atac-seq-gtm
description: This Galaxy workflow processes paired-end ATAC-seq data through adapter trimming with Cutadapt, alignment via Bowtie2, peak calling with MACS2, and visualization using deepTools and pyGenomeTracks. Use this skill when you need to identify open chromatin regions, analyze transcription factor binding sites like CTCF, and generate heatmaps or genomic track plots to assess epigenetic accessibility across the genome.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# atac-seq-gtm

## Overview

This workflow provides a comprehensive pipeline for analyzing ATAC-seq (Assay for Transposase-Accessible Chromatin using sequencing) data, following [Galaxy Training Network](https://training.galaxyproject.org/) (GTN) standards for epigenetics research. It begins by processing raw paired-end sequencing reads through [Cutadapt](https://cutadapt.readthedocs.io/) for adapter trimming and [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) for quality assessment, ensuring the data is suitable for precise alignment.

Reads are mapped to the reference genome using [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml), followed by rigorous post-alignment filtering. The pipeline utilizes [Bamtools](https://github.com/pezmaster31/bamtools) to filter low-quality alignments and [Picard MarkDuplicates](https://broadinstitute.github.io/picard/) to remove PCR artifacts. To validate the experimental quality, it generates a paired-end fragment size histogram, which is essential for identifying the nucleosomal patterning characteristic of successful ATAC-seq libraries.

The core analysis identifies regions of open chromatin using [MACS2](https://github.com/macs3-project/MACS) for peak calling. These peaks are then intersected with genomic features, such as CTCF binding sites or gene annotations, using [bedtools](https://bedtools.readthedocs.io/). This allows for the functional characterization of accessible regions relative to known regulatory elements.

Final results are prepared for visualization and publication using [pyGenomeTracks](https://pygenometracks.readthedocs.io/) and [deepTools](https://deeptools.readthedocs.io/). The workflow generates bigWig signal tracks and produces heatmaps and density profiles via `computeMatrix` and `plotHeatmap`, providing a clear visual representation of chromatin accessibility across the genome. This resource is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Paired End Collection | data_collection_input |  |
| 1 | ctcf peaks | data_input |  |
| 2 | bed file with genes | data_input |  |


Ensure your sequencing reads are organized into a Paired End Collection of fastqsanger files, while the CTCF peaks and gene annotations must be provided in BED format. Utilizing a collection for the raw reads is essential for the workflow to correctly handle sample pairs through the trimming and mapping stages. Refer to the README.md for comprehensive details on reference genome requirements and specific parameter configurations. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` template.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.1+galaxy0 |  |
| 4 | Flatten collection | __FLATTEN__ |  |
| 5 | Filter | Filter1 |  |
| 6 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.4.2+galaxy0 |  |
| 7 | Flatten collection | __FLATTEN__ |  |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 9 | bedtools Intersect intervals | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_intersectbed/2.30.0 |  |
| 10 | Filter | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.4.1 |  |
| 11 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 12 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2 |  |
| 13 | Paired-end histogram | toolshed.g2.bx.psu.edu/repos/iuc/pe_histogram/pe_histogram/1.0.1 |  |
| 14 | bedtools BAM to BED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_bamtobed/2.30.0 |  |
| 15 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.1.1.20160309.6 |  |
| 16 | Wig/BedGraph-to-bigWig | wig_to_bigWig |  |
| 17 | pyGenomeTracks | toolshed.g2.bx.psu.edu/repos/iuc/pygenometracks/pygenomeTracks/3.6 |  |
| 18 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/3.3.2.0.0 |  |
| 19 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/3.3.2.0.0 |  |
| 20 | plotHeatmap | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_heatmap/deeptools_plot_heatmap/3.3.2.0.1 |  |
| 21 | plotHeatmap | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_heatmap/deeptools_plot_heatmap/3.3.2.0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | report | report |
| 5 | out_file1 | out_file1 |
| 6 | output | output |
| 6 | mapping_stats | mapping_stats |
| 8 | html_file | html_file |
| 9 | output | output |
| 10 | out_file2 | out_file2 |
| 10 | out_file1 | out_file1 |
| 11 | html_file | html_file |
| 12 | metrics_file | metrics_file |
| 12 | outFile | outFile |
| 13 | output1 | output1 |
| 14 | output | output |
| 15 | output_narrowpeaks | output_narrowpeaks |
| 15 | output_summits | output_summits |
| 15 | output_treat_pileup | output_treat_pileup |
| 16 | out_file1 | out_file1 |
| 17 | outFileName | outFileName |
| 18 | outFileName | outFileName |
| 19 | computeMatrix on input dataset(s): Matrix | outFileName |
| 20 | outFileName | outFileName |
| 21 | plotHeatmap on input dataset(s): Image | outFileName |


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