---
name: assembly-of-metagenomic-sequencing-data
description: This metagenomics workflow processes QC-controlled sequencing reads to perform de novo assembly using metaSPAdes and MEGAHIT, followed by contig evaluation and visualization with Bowtie2, CoverM, Quast, and Bandage. Use this skill when you need to reconstruct microbial genomes from complex environmental samples to characterize the taxonomic diversity and functional potential of a microbiome.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# assembly-of-metagenomic-sequencing-data

## Overview

This Galaxy workflow provides a comprehensive pipeline for the assembly of metagenomic sequencing data, utilizing two of the most widely used assemblers: [metaSPAdes](https://toolshed.g2.bx.psu.edu/repos/nml/metaspades/metaspades/4.2.0+galaxy0) and [MEGAHIT](https://toolshed.g2.bx.psu.edu/repos/iuc/megahit/megahit/1.2.9+galaxy2). Starting from QC-controlled reads, the workflow performs parallel assemblies to allow for comparative analysis of contig generation and assembly quality.

To evaluate the results, the workflow integrates several assessment tools. [Quast](https://toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy0) is used to generate detailed assembly statistics, while [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1) and [CoverM](https://toolshed.g2.bx.psu.edu/repos/iuc/coverm_contig/coverm_contig/0.7.0+galaxy0) calculate mapping rates and contig coverage. Additionally, the pipeline employs [Bandage](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy4) to visualize the assembly graph, providing insights into the connectivity and complexity of the metagenomic community.

This workflow is based on established [GTN](https://training.galaxyproject.org/) materials for microbiome research and is licensed under the MIT license. It is designed to produce high-quality contigs and comprehensive reports necessary for downstream binning and functional annotation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | QC controlled reads | data_collection_input | Metagenomics reads that have been controlled for quality |


To run this workflow, provide your QC-controlled metagenomic reads as a paired-end list collection of fastq.gz files to ensure efficient batch processing through the metaSPAdes and MEGAHIT assemblers. Verify that your input collection is correctly organized to allow Bowtie2 to map reads back to contigs for coverage estimation. For automated testing or local execution, you can initialize your environment using `planemo workflow_job_init` to generate a `job.yml` file. Detailed parameter settings and specific tool configurations are documented in the accompanying README.md. Always check that your input data types match the expected fastqsanger format to avoid tool execution errors.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | metaSPAdes | toolshed.g2.bx.psu.edu/repos/nml/metaspades/metaspades/4.2.0+galaxy0 |  |
| 2 | MEGAHIT | toolshed.g2.bx.psu.edu/repos/iuc/megahit/megahit/1.2.9+galaxy2 |  |
| 3 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.3+galaxy1 |  |
| 4 | CoverM contig | toolshed.g2.bx.psu.edu/repos/iuc/coverm_contig/coverm_contig/0.7.0+galaxy0 |  |
| 5 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.3.0+galaxy0 |  |
| 6 | megahit contig2fastg | toolshed.g2.bx.psu.edu/repos/iuc/megahit_contig2fastg/megahit_contig2fastg/1.1.3+galaxy1 |  |
| 7 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy4 |  |
| 8 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy2 |  |
| 9 | Column join | toolshed.g2.bx.psu.edu/repos/iuc/collection_column_join/collection_column_join/0.0.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | out_ag | out_ag |
| 1 | out_ags | out_ags |
| 2 | output | output |
| 3 | mapping_stats | mapping_stats |
| 4 | output | output |
| 5 | report_html_meta | report_html_meta |
| 7 | outfile | outfile |
| 9 | tabular_output | tabular_output |


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