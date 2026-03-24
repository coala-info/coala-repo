---
name: microbial-variant-calling
description: "This microbial variant calling workflow processes paired-end mutant reads against a wildtype reference genome using Snippy to identify variants and JBrowse for visualization. Use this skill when you need to identify single nucleotide polymorphisms, insertions, or deletions in a bacterial strain and visualize their genomic context relative to a reference sequence."
homepage: https://workflowhub.eu/workflows/1639
---

# Microbial Variant Calling

## Overview

This workflow is designed for microbial variant analysis, identifying genetic differences between a mutant strain and a reference genome. It processes paired-end sequencing reads (R1 and R2) against a provided reference genome in FASTA format, utilizing GenBank and GFF files for functional annotation of the detected variants.

The core analysis is performed using [snippy](https://toolshed.g2.bx.psu.edu/repos/iuc/snippy/snippy/3.2), a tool optimized for rapid bacterial SNP and indel calling. Snippy aligns the raw reads to the reference and generates both a tabular summary of variants and a FASTA alignment of the core genome.

For downstream exploration, the workflow integrates [JBrowse](https://toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/0.7.0.3) to create an interactive, web-based visualization. This allows researchers to inspect the called variants within their specific genomic context. This workflow is categorized under Variant-analysis and is part of the [GTN](https://training.galaxyproject.org/) (Galaxy Training Network) ecosystem.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mutant_R1 | data_input |  |
| 1 | mutant_R2 | data_input |  |
| 2 | wildtype.fna | data_input |  |
| 3 | wildtype.gbk | data_input |  |
| 4 | wildtype.gff | data_input |  |


Ensure your input reads are in FASTQ format and that the reference files—FASTA, GenBank, and GFF—are correctly assigned their respective data types to ensure compatibility with Snippy. While individual datasets are sufficient for single-sample runs, organizing paired-end reads into a dataset collection is highly recommended for scaling the analysis to multiple microbial isolates. Please refer to the `README.md` for comprehensive details on parameter configurations and specific data preparation requirements. You may also use `planemo workflow_job_init` to generate a `job.yml` file for streamlined execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 5 | snippy | toolshed.g2.bx.psu.edu/repos/iuc/snippy/snippy/3.2 |  |
| 6 | JBrowse | toolshed.g2.bx.psu.edu/repos/iuc/jbrowse/jbrowse/0.7.0.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | snippy_fasta | snpconsensus |
| 5 | snippy_tabular | snpsum |
| 6 | jbrowse_html | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run microbial-variant-calling.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run microbial-variant-calling.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run microbial-variant-calling.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init microbial-variant-calling.ga -o job.yml`
- Lint: `planemo workflow_lint microbial-variant-calling.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `microbial-variant-calling.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
