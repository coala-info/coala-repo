---
name: tb-variants-tutorial-main-workflow
description: "This workflow performs comprehensive variant analysis on Mycobacterium tuberculosis sequencing data using fastp, snippy, Kraken2, and TB-Profiler to identify mutations and drug resistance profiles from FASTQ collections and reference genomes. Use this skill when you need to characterize genetic diversity, detect antibiotic resistance markers, and generate clinical reports for Mycobacterium tuberculosis isolates."
homepage: https://workflowhub.eu/workflows/2049
---

# TB variants tutorial main workflow

## Overview

This Galaxy workflow is designed for the comprehensive identification and analysis of variants in *Mycobacterium tuberculosis* sequencing data. It follows the [GTN](https://training.galaxyproject.org/) tutorial standards for variant analysis, utilizing an ancestral reference genome (GBK) and H37Rv GFF3 annotations to process raw sequencing reads provided as a dataset collection.

The pipeline begins with rigorous quality control and preprocessing using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy3) and [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1). To ensure sample purity and confirm the presence of *M. tuberculosis*, [Kraken2](https://toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.17.1+galaxy0) is employed for taxonomic classification before variant calling is performed by [snippy](https://toolshed.g2.bx.psu.edu/repos/iuc/snippy/snippy/4.6.0+galaxy0).

Downstream analysis focuses on TB-specific insights using [TB-Profiler](https://toolshed.g2.bx.psu.edu/repos/iuc/tbprofiler/tb_profiler_profile/6.6.4+galaxy0) for drug resistance prediction and [TB Variant Filter](https://toolshed.g2.bx.psu.edu/repos/iuc/tb_variant_filter/tb_variant_filter/0.4.0+galaxy0) for refining results. The workflow concludes by generating interactive visualizations in [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1) and comprehensive summary reports via [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy4) and [TB Variant Report](https://toolshed.g2.bx.psu.edu/repos/iuc/tbvcfreport/tbvcfreport/1.0.1+galaxy0).

This resource is licensed under CC-BY-4.0 and is tagged for variant-analysis and GTN training applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Mycobacterium_tuberculosis_ancestral_reference.gbk | data_input |  |
| 1 | Mycobacterium_tuberculosis_h37rv.ASM19595v2.45.chromosome.Chromosome.gff3 | data_input |  |
| 2 | Input Dataset Collection | data_collection_input |  |


Ensure your input collection contains paired-end fastq files, while the reference genome and annotation must be in GBK and GFF3 formats respectively to satisfy the requirements of Snippy and JBrowse. Using a dataset collection for sequencing reads is essential here as the workflow flattens them for parallel processing across tools like Kraken2 and TB-Profiler. For automated testing and job configuration, you can generate a template using `planemo workflow_job_init` to create your `job.yml`. Refer to the `README.md` for comprehensive details on parameter settings and specific data preparation steps.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | seqret | toolshed.g2.bx.psu.edu/repos/devteam/emboss_5/EMBOSS: seqret84/5.0.0 |  |
| 4 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.0.1+galaxy3 |  |
| 5 | Flatten collection | __FLATTEN__ |  |
| 6 | snippy | toolshed.g2.bx.psu.edu/repos/iuc/snippy/snippy/4.6.0+galaxy0 |  |
| 7 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.17.1+galaxy0 |  |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 9 | TB Variant Filter | toolshed.g2.bx.psu.edu/repos/iuc/tb_variant_filter/tb_variant_filter/0.4.0+galaxy0 |  |
| 10 | TB-Profiler Profile | toolshed.g2.bx.psu.edu/repos/iuc/tbprofiler/tb_profiler_profile/6.6.4+galaxy0 |  |
| 11 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.27+galaxy4 |  |
| 12 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.11+galaxy1 |  |
| 13 | Text transformation | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_sed_tool/9.5+galaxy2 |  |
| 14 | TB Variant Report | toolshed.g2.bx.psu.edu/repos/iuc/tbvcfreport/tbvcfreport/1.0.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run tb-variants-tutorial-main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run tb-variants-tutorial-main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run tb-variants-tutorial-main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init tb-variants-tutorial-main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint tb-variants-tutorial-main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `tb-variants-tutorial-main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
