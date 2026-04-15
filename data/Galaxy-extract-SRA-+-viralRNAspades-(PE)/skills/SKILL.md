---
name: extract-sra-spades
description: This workflow downloads raw sequencing data from the NCBI Sequence Read Archive using fasterq-dump and performs de novo assembly of viral genomes using rnaviralSPAdes. Use this skill when you need to reconstruct viral transcripts or assemble complete viral genomes from publicly available short-read sequencing datasets.
homepage: https://www.gembloux.ulg.ac.be/phytopathologie/
metadata:
  docker_image: "N/A"
---

# extract-sra-spades

## Overview

This workflow automates the retrieval of raw sequencing data from the Sequence Read Archive (SRA) and performs specialized de novo assembly for viral discovery. It streamlines the transition from public accessions to assembled genomic sequences, making it ideal for researchers analyzing viral RNA datasets.

The process begins with the [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.11.0+galaxy1) tool, which downloads and extracts reads into FASTQ format. This step is configured to handle various library types, producing paired-end, single-end, or other data formats along with detailed execution logs.

The extracted reads are then processed by [rnaviralSPAdes](https://toolshed.g2.bx.psu.edu/repos/iuc/spades_rnaviralspades/spades_rnaviralspades/3.15.4+galaxy2), an assembly tool specifically optimized for the unique challenges of viral RNA genomes. The final output provides the assembled contigs, which serve as the primary data for downstream phylogenetic or functional analysis.

## Inputs and data preparation

_None listed._


To initiate this workflow, provide valid SRA accession numbers as the primary input rather than pre-downloaded FASTQ files. When processing multiple samples, organize accessions into a list collection to ensure the downstream rnaviralSPAdes tool handles each sample pair correctly. Consult the `README.md` for comprehensive details on tool parameters and specific resource requirements. For automated testing or command-line execution, use `planemo workflow_job_init` to generate a template `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.11.0+galaxy1 |  |
| 1 | rnaviralSPAdes | toolshed.g2.bx.psu.edu/repos/iuc/spades_rnaviralspades/spades_rnaviralspades/3.15.4+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | Pair-end data (fasterq-dump) | list_paired |
| 0 | Single-end data (fasterq-dump) | output_collection |
| 0 | Other data (fasterq-dump) | output_collection_other |
| 0 | fasterq-dump log | log |
| 1 | rnaviralSPAdes on input dataset(s): Contigs | out_cn |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-extract_SRA___spades.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-extract_SRA___spades.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-extract_SRA___spades.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-extract_SRA___spades.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-extract_SRA___spades.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-extract_SRA___spades.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)