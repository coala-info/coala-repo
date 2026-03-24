---
name: ref-based-rad-seq
description: "This workflow performs reference-based RAD-Seq data analysis by processing FASTQ reads, barcodes, and population maps using Stacks and BWA. Use this skill when you need to identify single nucleotide polymorphisms and calculate population genetic statistics for organisms with an available reference genome."
homepage: https://workflowhub.eu/workflows/1662
---

# Ref Based Rad Seq

## Overview

This workflow performs reference-based Restriction site Associated DNA sequencing (RAD-Seq) data analysis, a popular method for discovering genetic markers in ecological and evolutionary studies. It is designed to process raw sequencing reads by aligning them to a known reference genome to identify SNPs and calculate population genetics statistics. The primary inputs include raw FASTQ reads, a barcode file for demultiplexing, a population map, and the reference genome.

The pipeline begins with multiple instances of [Stacks: process radtags](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0) to demultiplex, clean, and filter the raw data based on quality scores and barcode matches. Following this preprocessing, the reads are aligned to the reference genome using [BWA](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa_wrappers/bwa_wrapper/1.2.3). This alignment-based approach allows for precise locus identification and is particularly effective for species with available genomic resources.

In the final stages, the [Stacks: reference map](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks_refmap/stacks_refmap/1.46.0) tool integrates the alignment data to build loci and identify polymorphisms. The analysis concludes with [Stacks: populations](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks_populations/stacks_populations/1.46.0), which computes population-level statistics such as heterozygosity and F-statistics. This workflow follows established [GTN](https://training.galaxyproject.org/) best practices for ecological genomic analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | ref_genome_chromFa.tar | data_input |  |
| 1 | Population_map.txt | data_input |  |
| 2 | Barcodes_SRR034310.tabular | data_input |  |
| 3 | SRR034310.fastq | data_input |  |


Ensure your reference genome is provided as a compressed archive, while the population map and barcode files must be formatted as clean tabular data. For high-throughput analysis, consider organizing raw FASTQ files into data collections to simplify the batch processing required by Stacks. Refer to the `README.md` for precise details on the expected column structure for metadata files to ensure compatibility with the workflow steps. You can use `planemo workflow_job_init` to create a `job.yml` for managing these input parameters programmatically.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | Stacks: process radtags | toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0 |  |
| 5 | Stacks: process radtags | toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0 |  |
| 6 | Stacks: process radtags | toolshed.g2.bx.psu.edu/repos/iuc/stacks_procrad/stacks_procrad/1.46.0 |  |
| 7 | Map with BWA for Illumina | toolshed.g2.bx.psu.edu/repos/devteam/bwa_wrappers/bwa_wrapper/1.2.3 |  |
| 8 | Stacks: reference map | toolshed.g2.bx.psu.edu/repos/iuc/stacks_refmap/stacks_refmap/1.46.0 |  |
| 9 | Stacks: populations | toolshed.g2.bx.psu.edu/repos/iuc/stacks_populations/stacks_populations/1.46.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init workflow.ga -o job.yml`
- Lint: `planemo workflow_lint workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
