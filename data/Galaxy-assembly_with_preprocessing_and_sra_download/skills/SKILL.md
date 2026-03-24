---
name: assembly_with_preprocessing_and_sra_download
description: "This workflow automates the retrieval of Illumina and Oxford Nanopore sequencing data from the SRA to perform quality control, preprocessing with fastp and NanoPlot, and hybrid de novo assembly using Unicycler. Use this skill when you need to generate high-quality bacterial or small genome assemblies by combining short-read accuracy with long-read connectivity directly from public accessions."
homepage: https://workflowhub.eu/workflows/1616
---

# assembly_with_preprocessing_and_sra_download

## Overview

This Galaxy workflow automates the process of microbial genome assembly by integrating data retrieval, quality control, and hybrid assembly techniques. It begins by downloading raw sequencing data directly from the SRA using lists of Illumina and ONT accessions. The pipeline then performs comprehensive preprocessing, including read trimming and filtering with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1) and quality assessment via [NanoPlot](https://toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.25.0+galaxy1) and [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7).

The core of the workflow utilizes [Unicycler](https://toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.8.0) to generate high-quality assemblies from the processed short and long reads. To optimize performance, the workflow includes steps for mapping reads with [minimap2](https://toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy1) and [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0), as well as subsampling sequences with [seqtk](https://toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_sample/1.3.2).

Final outputs include the assembled contigs, assembly graphs, and visual reports. The workflow also provides structural insights into the assembly using [Bandage](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy2) and applies length-based filtering to the final sequences to ensure assembly integrity. This pipeline is tagged for [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) use, making it ideal for assembly tutorials and standardized bioinformatics training.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | List of Illumina accessions | data_input |  |
| 1 | List of ONT accessions | data_input |  |


Provide the input accessions as simple text files containing SRA identifiers, ensuring each accession is listed on a new line for proper parsing. Use data collections to organize these lists, as the workflow is optimized to process multiple Illumina and ONT datasets in parallel through the SRA download tools. Refer to the README.md for comprehensive instructions on configuring specific tool parameters and managing metadata for the assembly process. You can automate the configuration of these input parameters by generating a `job.yml` file using `planemo workflow_job_init`.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4+galaxy1 |  |
| 3 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4+galaxy1 |  |
| 4 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 5 | NanoPlot | toolshed.g2.bx.psu.edu/repos/iuc/nanoplot/nanoplot/1.25.0+galaxy1 |  |
| 6 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy1 |  |
| 7 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 8 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 9 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy1 |  |
| 10 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 |  |
| 11 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.9+galaxy1 |  |
| 12 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 13 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 14 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 15 | Zip Collection | __ZIP_COLLECTION__ |  |
| 16 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 17 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 18 | seqtk_sample | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_sample/1.3.2 |  |
| 19 | seqtk_sample | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_sample/1.3.2 |  |
| 20 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.8.0 |  |
| 21 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/0.8.1+galaxy1 |  |
| 22 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/0.8.1+galaxy2 |  |
| 23 | Filter sequences by length | toolshed.g2.bx.psu.edu/repos/devteam/fasta_filter_by_length/fasta_filter_by_length/1.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | list_paired | list_paired |
| 3 | output_collection | output_collection |
| 4 | output_paired_coll | output_paired_coll |
| 5 | output_html | output_html |
| 6 | alignment_output | alignment_output |
| 7 | html_report | html_report |
| 8 | output | output |
| 8 | mapping_stats | mapping_stats |
| 10 | output_collection | output_collection |
| 12 | nonspecific | nonspecific |
| 15 | output | output |
| 18 | default | default |
| 19 | default | default |
| 20 | assembly | assembly |
| 20 | assembly_graph | assembly_graph |
| 21 | outfile | outfile |
| 22 | outfile | outfile |
| 23 | output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run assembly-with-preprocessing-and-sra-download.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run assembly-with-preprocessing-and-sra-download.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run assembly-with-preprocessing-and-sra-download.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init assembly-with-preprocessing-and-sra-download.ga -o job.yml`
- Lint: `planemo workflow_lint assembly-with-preprocessing-and-sra-download.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `assembly-with-preprocessing-and-sra-download.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
