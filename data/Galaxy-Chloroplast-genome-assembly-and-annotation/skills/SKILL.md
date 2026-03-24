---
name: chloroplast-genome-assembly-and-annotation
description: "This workflow performs hybrid assembly and annotation of chloroplast genomes using Illumina and Nanopore sequencing data through tools like Flye, Pilon, and Prokka. Use this skill when you need to reconstruct a complete, polished, and annotated circular organelle genome from a combination of long and short sequencing reads."
homepage: https://workflowhub.eu/workflows/1617
---

# Chloroplast-genome-assembly-and-annotation

## Overview

This workflow provides a comprehensive pipeline for the *de novo* assembly and functional annotation of chloroplast genomes using a hybrid sequencing approach. It primarily utilizes long-read data (Nanopore) for the initial assembly via [Flye](https://github.com/fenderglass/Flye), which is particularly effective at resolving the large inverted repeats and complex structures characteristic of plastid genomes.

Quality control and structural validation are integrated throughout the process. The workflow uses [NanoPlot](https://github.com/wdecoster/NanoPlot) to assess long-read statistics and [Bandage](https://rrwick.github.io/Bandage/) to visualize the assembly graph, ensuring the circularity and integrity of the genome. To achieve high base-level accuracy, the pipeline includes a polishing step where [Pilon](https://github.com/broadinstitute/pilon) uses high-accuracy Illumina short reads to correct insertions, deletions, and single-nucleotide errors in the draft assembly.

The final stage focuses on the functional characterization of the polished sequence. The genome is annotated using [Prokka](https://github.com/tseemann/prokka), which identifies genes and features to produce standard outputs such as GFF, GenBank, and FASTA files. For data exploration, the workflow generates [JBrowse](https://jbrowse.org/) instances, allowing users to interactively visualize the assembly, mapped reads, and gene models. This pipeline is based on established [GTN](https://training.galaxyproject.org/) best practices for organelle assembly.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Illumina_reads | data_input |  |
| 1 | Nanopore_reads | data_input |  |
| 2 | Tiny_set_illumina_read | data_input |  |
| 3 | Tiny_set_nanopore_reads | data_input |  |


Ensure your input Illumina and Nanopore reads are in fastq.gz format to optimize storage and processing speed within the Flye and Pilon steps. While this workflow accepts individual datasets, using paired-end collections for Illumina data can streamline the mapping stages with BWA-MEM. Refer to the README.md for specific parameter configurations and detailed guidance on interpreting the Bandage assembly graphs. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible testing. Always verify that your read headers are compatible with Prokka’s annotation requirements to avoid downstream errors.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Flye assembly | toolshed.g2.bx.psu.edu/repos/bgruening/flye/flye/2.6 |  |
| 5 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.28.2+galaxy1 |  |
| 6 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 7 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 8 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |
| 9 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy2 |  |
| 10 | pilon | toolshed.g2.bx.psu.edu/repos/iuc/pilon/pilon/1.20.1 |  |
| 11 | Fasta Statistics | toolshed.g2.bx.psu.edu/repos/iuc/fasta_stats/fasta-stats/2.0 |  |
| 12 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 13 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 14 | Prokka | toolshed.g2.bx.psu.edu/repos/crs4/prokka/prokka/1.14.5 |  |
| 15 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.9+galaxy0 |  |
| 16 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/1.16.9+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | assembly_info | assembly_info |
| 4 | flye_log | flye_log |
| 4 | consensus | consensus |
| 4 | assembly_graph | assembly_graph |
| 4 | assembly_gfa | assembly_gfa |
| 5 | log_read_length | log_read_length |
| 5 | nanostats_post_filtering | nanostats_post_filtering |
| 5 | nanostats | nanostats |
| 5 | read_length | read_length |
| 5 | output_html | output_html |
| 6 | bam_output | bam_output |
| 7 | stats_output | stats_output |
| 8 | outfile | outfile |
| 9 | outfile | outfile |
| 10 | output_changes | output_changes |
| 10 | output_fasta | output_fasta |
| 11 | stats_output | stats_output |
| 12 | bam_output | bam_output |
| 13 | bam_output | bam_output |
| 14 | out_err | out_err |
| 14 | out_fna | out_fna |
| 14 | out_faa | out_faa |
| 14 | out_tbl | out_tbl |
| 14 | out_fsa | out_fsa |
| 14 | out_ffn | out_ffn |
| 14 | out_tsv | out_tsv |
| 14 | out_txt | out_txt |
| 14 | out_sqn | out_sqn |
| 14 | out_log | out_log |
| 14 | out_gff | out_gff |
| 14 | out_gbk | out_gbk |
| 15 | output | output |
| 16 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run galaxy-workflow-chloroplast-genome-assembly-and-annotation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run galaxy-workflow-chloroplast-genome-assembly-and-annotation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run galaxy-workflow-chloroplast-genome-assembly-and-annotation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init galaxy-workflow-chloroplast-genome-assembly-and-annotation.ga -o job.yml`
- Lint: `planemo workflow_lint galaxy-workflow-chloroplast-genome-assembly-and-annotation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `galaxy-workflow-chloroplast-genome-assembly-and-annotation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
