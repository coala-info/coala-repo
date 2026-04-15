---
name: metagenomics-assembly-tutorial-workflow
description: This metagenomics workflow processes input dataset collections using metaSPAdes and MEGAHIT for de novo assembly, followed by Bowtie2 mapping and quality assessment with Quast and Bandage. Use this skill when you need to reconstruct microbial genomes from complex environmental samples and evaluate the quality and connectivity of the resulting contigs and scaffolds.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# metagenomics-assembly-tutorial-workflow

## Overview

This workflow provides a comprehensive pipeline for metagenomic *de novo* assembly, following standards established by the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/). It processes input dataset collections through two primary assembly engines: [metaSPAdes](https://github.com/ablab/spades), which is known for high-quality reconstructions, and [MEGAHIT](https://github.com/voutcn/megahit), which is optimized for large and complex metagenomic datasets.

To evaluate the quality of the resulting assemblies, the workflow utilizes [Bowtie2](https://bowtie-project.github.io/bowtie2/) to map original reads back to the contigs, providing insights into recruitment rates and assembly coverage. It also integrates [Bandage](https://rrwick.github.io/Bandage/) to generate visual representations and descriptive statistics of the assembly graphs, allowing users to inspect the connectivity of the metagenomic sequences.

The final stage of the pipeline focuses on rigorous quality assessment using [QUAST](https://quast.sourceforge.net/). It generates a suite of diagnostic outputs, including HTML reports, metrics in PDF and tabular formats, and Krona plots for taxonomic visualization. These results are consolidated into a final summary, offering a detailed comparison of assembly performance, N50 values, and contig statistics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Dataset Collection | data_collection_input |  |


For this metagenomics assembly, provide your raw sequencing reads as a paired-end dataset collection of fastq.gz files to ensure efficient processing through metaSPAdes and MEGAHIT. Ensure that your collection is correctly organized with forward and reverse reads paired appropriately to avoid errors during the mapping and assembly stages. Refer to the README.md for comprehensive details on data acquisition and specific parameter settings used in this tutorial. You can automate the setup of these inputs by using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | metaSPAdes | toolshed.g2.bx.psu.edu/repos/nml/metaspades/metaspades/3.15.4+galaxy2 |  |
| 2 | MEGAHIT | toolshed.g2.bx.psu.edu/repos/iuc/megahit/megahit/1.2.9+galaxy0 |  |
| 3 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.0+galaxy0 |  |
| 4 | megahit contig2fastg | toolshed.g2.bx.psu.edu/repos/iuc/megahit_contig2fastg/megahit_contig2fastg/1.1.3+galaxy1 |  |
| 5 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy0 |  |
| 6 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy4 |  |
| 7 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy2 |  |
| 8 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | metaSPAdes on input dataset(s): Scaffolds | out_sc |
| 1 | metaSPAdes on input dataset(s): Assembly graph | out_ag |
| 1 | metaSPAdes on input dataset(s): Assembly graph with scaffolds | out_ags |
| 1 | metaSPAdes on input dataset(s): Contigs | out_cn |
| 2 | output | output |
| 3 | mapping_stats | mapping_stats |
| 3 | output | output |
| 4 | fastg | fastg |
| 5 | log_meta | log_meta |
| 5 | krona | krona |
| 5 | metrics_tabular | metrics_tabular |
| 5 | report_tabular_meta | report_tabular_meta |
| 5 | report_html_meta | report_html_meta |
| 5 | metrics_pdf | metrics_pdf |
| 6 | outfile | outfile |
| 7 | outfile | outfile |
| 8 | tabular_output | tabular_output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run metagenomics-assembly-tutorial-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run metagenomics-assembly-tutorial-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run metagenomics-assembly-tutorial-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init metagenomics-assembly-tutorial-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint metagenomics-assembly-tutorial-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `metagenomics-assembly-tutorial-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)