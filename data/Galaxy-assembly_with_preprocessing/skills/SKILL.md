---
name: assembly_with_preprocessing
description: "This workflow performs hybrid genome assembly by preprocessing paired short-reads and long-reads using fastp and NanoPlot before generating assemblies with Unicycler and visualizing graphs with Bandage. Use this skill when you need to reconstruct complete and accurate microbial genomes by integrating high-fidelity short-read data with long-read sequences to resolve complex genomic repeats."
homepage: https://workflowhub.eu/workflows/1612
---

# assembly_with_preprocessing

## Overview

This Galaxy workflow performs hybrid genome assembly by integrating paired-end short-reads and long-read sequencing data. It begins with rigorous preprocessing and quality control, utilizing [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1) for short-read trimming and [NanoPlot](https://toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.25.0+galaxy1) for long-read assessment. [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7) is employed to aggregate various metrics into a comprehensive report.

The pipeline includes intermediate mapping and filtering steps using [minimap2](https://toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy1) and [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0). These are supported by a suite of [Samtools](https://toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy1) utilities to refine the datasets and [seqtk_sample](https://toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_sample/1.3.2) for subsampling, ensuring the data is optimized for the assembly engine.

The core assembly is executed by [Unicycler](https://toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.8.0), which leverages the accuracy of short reads and the connectivity of long reads to resolve complex genomic structures. Following assembly, the workflow generates visual representations and statistics of the assembly graph using [Bandage](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy2) and applies length-based filters to the final FASTA sequences.

This workflow is aligned with [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) standards, making it suitable for both production-level assembly and educational demonstrations of hybrid sequencing bioinformatics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Collection of paired short-reads data | data_collection_input |  |
| 1 | Collection of long-reads data | data_collection_input |  |


Ensure your input data are organized into paired-end collections for short reads (fastqsanger or fastqsanger.gz) and single-item collections for long reads to maintain proper workflow propagation. Using collections instead of individual datasets is essential for the downstream collapsing and zipping steps required by Unicycler. For automated execution, you can generate a template configuration using `planemo workflow_job_init` to create your `job.yml` file. Refer to the README.md for comprehensive details on parameter tuning and specific library preparation requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 3 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.25.0+galaxy1 |  |
| 4 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy1 |  |
| 5 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 6 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 7 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy1 |  |
| 8 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 |  |
| 9 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy1 |  |
| 10 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 11 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 12 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 13 | Zip Collection | __ZIP_COLLECTION__ |  |
| 14 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 15 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 16 | seqtk_sample | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_sample/1.3.2 |  |
| 17 | seqtk_sample | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_sample/1.3.2 |  |
| 18 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.8.0 |  |
| 19 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |
| 20 | Filter sequences by length | toolshed.g2.bx.psu.edu/repos/devteam/fasta_filter_by_length/fasta_filter_by_length/1.2 |  |
| 21 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | output_paired_coll | output_paired_coll |
| 3 | output_html | output_html |
| 4 | alignment_output | alignment_output |
| 5 | html_report | html_report |
| 6 | output | output |
| 6 | mapping_stats | mapping_stats |
| 8 | output_collection | output_collection |
| 10 | nonspecific | nonspecific |
| 13 | output | output |
| 16 | default | default |
| 17 | default | default |
| 18 | assembly | assembly |
| 18 | assembly_graph | assembly_graph |
| 19 | outfile | outfile |
| 20 | output | output |
| 21 | outfile | outfile |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run assembly-with-preprocessing.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run assembly-with-preprocessing.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run assembly-with-preprocessing.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init assembly-with-preprocessing.ga -o job.yml`
- Lint: `planemo workflow_lint assembly-with-preprocessing.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `assembly-with-preprocessing.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
