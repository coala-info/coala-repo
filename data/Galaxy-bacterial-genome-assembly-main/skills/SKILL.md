---
name: bacterial-genome-assembly-using-shovill
description: "This bacterial genomics workflow assembles paired-end trimmed fastq reads into contigs using Shovill and generates assembly visualizations and summaries with Bandage and ToolDistillator. Use this skill when you need to reconstruct a bacterial genome from Illumina short-read data and evaluate the connectivity and quality of the resulting assembly graph."
homepage: https://workflowhub.eu/workflows/1043
---

# Bacterial Genome Assembly using Shovill

## Overview

This workflow provides an automated pipeline for the *de novo* assembly of bacterial genomes from paired-end Illumina short-read data. It is designed to take adapter-trimmed FASTQ files and generate high-quality genomic contigs while providing essential quality metrics and visualizations for downstream analysis.

The core assembly is performed by [Shovill](https://github.com/tseemann/shovill), which optimizes the SPAdes assembler for faster performance and reduced memory usage. Following assembly, the workflow utilizes [Bandage](https://rrwick.github.io/Bandage/) to generate both statistical reports and visual plots of the assembly graph, allowing users to assess the connectivity and complexity of the resulting contigs.

To facilitate data integration and reporting, the workflow incorporates [ToolDistillator](https://github.com/metagenomics/ToolDistillator). This tool extracts and aggregates metadata and results from the assembly process into a structured JSON format, ensuring that all relevant assembly statistics are easily parsable for large-scale genomic studies or database integration.

Key outputs include the assembled contigs in FASTA format, mapped reads in BAM format, and comprehensive assembly graphs. For detailed information on input preparation and file specifications, please refer to the [README.md](./README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input adapter trimmed sequence reads (forward) | data_input | Should be the adapter trimmed forward strand of the paired end reads. |
| 1 | Input adapter trimmed sequence reads (reverse) | data_input | Should be the adapter trimmed reverse strand of the paired end reads. |


Ensure your input files are in fastq or fastq.gz format, specifically using adapter-trimmed paired-end reads to achieve optimal assembly results. While the workflow accepts individual datasets, organizing your reads into a paired dataset collection can significantly streamline processing for multiple samples. Refer to the README.md for comprehensive details on parameter settings and specific tool outputs. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy2 | genome assembly with shovill tool |
| 3 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/2022.09+galaxy2 | bandage_contig_graph_stats |
| 4 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 | bandage_contig_graph_plot |
| 5 | ToolDistillator | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.4+galaxy0 | ToolDistillator extracts results from tools and creates a JSON file for each tool |
| 6 | ToolDistillator Summarize | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator_summarize/tooldistillator_summarize/1.0.4+galaxy0 | ToolDistillator summarize groups all JSON file into a unique JSON file |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | shovill_alignment_bam | bamfiles |
| 2 | shovill_contigs_graph | contigs_graph |
| 2 | shovill_logfile | shovill_std_log |
| 2 | shovill_contigs_fasta | contigs |
| 3 | bandage_contig_graph_stats | outfile |
| 4 | bandage_contig_graph_plot | outfile |
| 5 | tooldistillator_results_assembly | output_json |
| 6 | tooldistillator_summarize_assembly | summary_json |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run bacterial_genome_assembly.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run bacterial_genome_assembly.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run bacterial_genome_assembly.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init bacterial_genome_assembly.ga -o job.yml`
- Lint: `planemo workflow_lint bacterial_genome_assembly.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `bacterial_genome_assembly.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
