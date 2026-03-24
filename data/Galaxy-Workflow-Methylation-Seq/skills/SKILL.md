---
name: workflow-methylation-seq
description: "This epigenetics workflow processes FASTQ and bedGraph files to analyze DNA methylation patterns using bwameth for alignment, MethylDackel for extraction, and metilene for differential methylation analysis. Use this skill when you need to identify differentially methylated regions between samples or visualize the distribution of methylation levels across specific genomic features like CpG islands."
homepage: https://workflowhub.eu/workflows/1566
---

# Workflow Methylation Seq

## Overview

This workflow provides a comprehensive pipeline for DNA methylation data analysis, specifically tailored for epigenetic studies. It begins with quality control of paired-end FASTQ reads using [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.68) and proceeds to align sequences to a reference genome using [bwameth](https://toolshed.g2.bx.psu.edu/repos/iuc/bwameth/bwameth/0.2.0.3), a tool optimized for bisulfite-sequencing data.

Following alignment, the workflow utilizes [MethylDackel](https://toolshed.g2.bx.psu.edu/repos/bgruening/pileometh/pileometh/0.3.0) to extract methylation metrics and generate pileups. It integrates multiple sample bedGraph inputs to identify differentially methylated regions (DMRs) using [metilene](https://toolshed.g2.bx.psu.edu/repos/rnateam/metilene/metilene/0.2.6.1). Various text processing tools are employed throughout the process to reformat data and map chromosome identifiers between Ensembl and UCSC naming conventions.

The final stages focus on downstream visualization and data aggregation using [deepTools](https://toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/2.5.1.1.0). By calculating signal matrices over genomic features like CpG islands, the workflow generates a profile plot that summarizes methylation levels across the genome. This pipeline is highly relevant for researchers following [GTN](https://training.galaxyproject.org/) standards for epigenetics research.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | subset_1.fastq | data_input |  |
| 1 | subset_2.fastq | data_input |  |
| 2 | CpGIslands.bed | data_input |  |
| 3 | NB1_CpG.meth.bedGraph | data_input |  |
| 4 | GRCh38_ensembl2UCSC.txt | data_input |  |
| 5 | NB2_CpG.meth.bedGraph | data_input |  |
| 6 | BT089_CpG.meth.bedGraph | data_input |  |
| 7 | BT126_CpG.meth.bedGraph | data_input |  |
| 8 | BT198_CpG.meth.bedGraph | data_input |  |


Ensure raw sequencing reads are in FASTQ format and genomic features like CpG islands are provided in BED or bedGraph formats. While the workflow accepts individual datasets, using paired-end collections is recommended for managing multiple samples efficiently during the alignment and methylation calling stages. Please consult the README.md for specific instructions on formatting the chromosome mapping text file and other metadata. For automated testing or execution, `planemo workflow_job_init` can be used to create a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.68 |  |
| 10 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.68 |  |
| 11 | bwameth | toolshed.g2.bx.psu.edu/repos/iuc/bwameth/bwameth/0.2.0.3 |  |
| 12 | Replace column | toolshed.g2.bx.psu.edu/repos/bgruening/replace_column_by_key_value_file/replace_column_with_key_value_file/0.1 |  |
| 13 | metilene | toolshed.g2.bx.psu.edu/repos/rnateam/metilene/metilene/0.2.6.1 |  |
| 14 | MethylDackel | toolshed.g2.bx.psu.edu/repos/bgruening/pileometh/pileometh/0.3.0 |  |
| 15 | MethylDackel | toolshed.g2.bx.psu.edu/repos/bgruening/pileometh/pileometh/0.3.0 |  |
| 16 | Select last | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tail_tool/1.1.0 |  |
| 17 | Select last | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_tail_tool/1.1.0 |  |
| 18 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/2.5.1.1.0 |  |
| 19 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/1.1.0 |  |
| 20 | computeMatrix | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_compute_matrix/deeptools_compute_matrix/2.5.1.1.0 |  |
| 21 | plotProfile | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_plot_profile/deeptools_plot_profile/2.5.1.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 21 | plot_profile_tabular | output_outFileNameData |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run methylation-seq.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run methylation-seq.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run methylation-seq.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init methylation-seq.ga -o job.yml`
- Lint: `planemo workflow_lint methylation-seq.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `methylation-seq.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
