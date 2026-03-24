---
name: cutamprun
description: "This epigenetics workflow processes CUT&RUN sequencing collections and reference ChIP-seq peaks using Trim Galore, Bowtie2, and MACS2 to perform alignment, peak calling, and motif discovery. Use this skill when you need to identify high-resolution protein-DNA interaction sites, analyze chromatin occupancy, or discover enriched sequence motifs in low-input genomic samples."
homepage: https://workflowhub.eu/workflows/1562
---

# CUT&amp;RUN

## Overview

This workflow is designed for the analysis of CUT&RUN (Cleavage Under Targets and Release Using Nuclease) data, a high-resolution method for profiling protein-DNA interactions. It begins with quality control and preprocessing of raw sequencing reads using [Trim Galore!](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/) and [Falco](https://github.com/s-andrews/Falco), followed by alignment to a reference genome using [Bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/index.shtml).

Following alignment, the pipeline performs rigorous data cleaning, including duplicate removal via [Picard MarkDuplicates](https://broadinstitute.github.io/picard/) and BAM filtering. It then utilizes [MACS2](https://github.com/macs3-project/MACS) for peak calling to identify enriched genomic regions. Quality metrics are aggregated throughout these steps using [MultiQC](https://multiqc.info/) and specialized [deepTools](https://deeptools.readthedocs.io/) utilities like `plotFingerprint` to assess signal strength and library complexity.

The final stages focus on functional characterization and visualization. The workflow integrates [bedtools](https://bedtools.readthedocs.io/) for interval intersection with reference datasets and employs `computeMatrix` and `plotHeatmap` to generate publication-ready figures. Additionally, it performs motif discovery using [MEME-ChIP](https://meme-suite.org/meme/tools/meme-chip) to identify specific binding sequences within the detected peaks.

This resource is adapted from the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) for epigenetics research and is provided under the MIT license. It is intended for non-commercial use.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |
| 1 | GATA1 ChIP-Seq peaks | data_input |  |
| 2 | I certify that I am not using this workflow for commercial purposes | parameter_input |  |


For this CUT&RUN analysis, ensure your raw sequencing reads are organized into a paired-end dataset collection of FASTQ files to facilitate automated batch processing through the trimming and alignment steps. The GATA1 ChIP-Seq peaks should be provided as a standard BED or interval file to enable accurate intersection and motif analysis. It is essential that all input datasets use a consistent reference genome build to ensure compatibility across tools like MACS2 and bedtools. Consult the README.md for comprehensive details on specific parameter settings and data preparation requirements. You can streamline the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` template for your environment.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Trim Galore! | toolshed.g2.bx.psu.edu/repos/bgruening/trim_galore/trim_galore/0.6.7+galaxy1 |  |
| 4 | Flatten collection | __FLATTEN__ |  |
| 5 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1 |  |
| 6 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 7 | plotFingerprint | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_fingerprint/deeptools_plot_fingerprint/3.5.4+galaxy0 |  |
| 8 | Filter BAM | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.5.2+galaxy2 |  |
| 9 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 10 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0 |  |
| 11 | Select | Grep1 |  |
| 12 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 13 | bedtools BAM to BED | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_bamtobed/2.31.1+galaxy0 |  |
| 14 | Paired-end histogram | toolshed.g2.bx.psu.edu/repos/iuc/pe_histogram/pe_histogram/1.0.2 |  |
| 15 | Transpose | toolshed.g2.bx.psu.edu/repos/iuc/datamash_transpose/datamash_transpose/1.8+galaxy1 |  |
| 16 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy3 |  |
| 17 | MACS2 callpeak | toolshed.g2.bx.psu.edu/repos/iuc/macs2/macs2_callpeak/2.2.9.1+galaxy0 |  |
| 18 | Extract dataset | __EXTRACT_DATASET__ |  |
| 19 | Extract dataset | __EXTRACT_DATASET__ |  |
| 20 | Wig/BedGraph-to-bigWig | wig_to_bigWig |  |
| 21 | bedtools Intersect intervals | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_intersectbed/2.31.1+galaxy0 |  |
| 22 | bedtools Intersect intervals | toolshed.g2.bx.psu.edu/repos/iuc/bedtools/bedtools_intersectbed/2.31.1+galaxy0 |  |
| 23 | Extract Genomic DNA | toolshed.g2.bx.psu.edu/repos/iuc/extract_genomic_dna/Extract genomic DNA 1/3.0.3+galaxy3 |  |
| 24 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/3.5.4+galaxy0 |  |
| 25 | MEME-ChIP | toolshed.g2.bx.psu.edu/repos/iuc/meme_chip/meme_chip/4.11.2+galaxy1 |  |
| 26 | plotHeatmap | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_heatmap/deeptools_plot_heatmap/3.5.4+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 25 | output | output |
| 26 | outFileName | outFileName |


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
