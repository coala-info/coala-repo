---
name: genome-assembly-of-mrsa-using-illumina-miseq-data
description: "This workflow performs de novo genome assembly of MRSA from paired-end Illumina MiSeq data using fastp for preprocessing, Shovill for assembly, and Quast and Bandage for quality evaluation. Use this skill when you need to reconstruct a bacterial genome from short-read sequencing data and assess the structural integrity and quality of the resulting assembly."
homepage: https://workflowhub.eu/workflows/1602
---

# Genome Assembly of MRSA using Illumina MiSeq Data

## Overview

This Galaxy workflow is designed for the *de novo* genome assembly of Methicillin-resistant *Staphylococcus aureus* (MRSA) using Illumina MiSeq paired-end data. The process begins with rigorous quality control and preprocessing using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0) and [Falco](https://toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0) to trim adapters and filter low-quality reads, ensuring high-quality input for the assembly stage.

The core assembly is performed by [Shovill](https://toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy2), a specialized pipeline that optimizes the SPAdes assembler for faster performance and reduced memory usage on bacterial isolates. This step converts the processed short-read sequences into genomic contigs.

To assess the success of the assembly, the workflow utilizes [Quast](https://toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy1) for technical evaluation, providing metrics such as N50, contig count, and total assembly length. Finally, [Bandage](https://toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4) is used to visualize the assembly graph and provide structural information, allowing researchers to inspect the connectivity of the assembled genome.

This workflow is tagged under **Microgalaxy** and **GTN**, following best practices for microbial genomics. It is released under the **MIT** license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input Paired End Collection | data_collection_input |  |


Ensure your input data consists of raw Illumina MiSeq reads in FASTQ format, organized into a paired-end list collection to facilitate efficient batch processing through the Shovill assembly pipeline. Using collections instead of individual datasets ensures that forward and reverse reads remain correctly associated during the quality control and assembly stages. For comprehensive instructions on data organization and specific tool parameters, refer to the accompanying README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and automated testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0 |  |
| 2 | Falco | toolshed.g2.bx.psu.edu/repos/iuc/falco/falco/1.2.4+galaxy0 |  |
| 3 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy2 |  |
| 4 | Quast | toolshed.g2.bx.psu.edu/repos/iuc/quast/quast/5.2.0+galaxy1 |  |
| 5 | Bandage Image | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_image/2022.09+galaxy4 |  |
| 6 | Bandage Info | toolshed.g2.bx.psu.edu/repos/iuc/bandage/bandage_info/2022.09+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | fastp_json | report_json |
| 3 | shovill_log | shovill_std_log |
| 4 | quast_output | report_html |
| 6 | bandage_info_output | outfile |


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
