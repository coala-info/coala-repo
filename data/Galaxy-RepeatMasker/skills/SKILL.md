---
name: repeatmasker
description: "This Galaxy workflow processes raw genome sequences to identify and mask repetitive elements using the Red and RepeatMasker tools. Use this skill when you need to annotate repetitive DNA sequences or mask them to improve the accuracy of gene prediction and comparative genomics."
homepage: https://workflowhub.eu/workflows/1538
---

# RepeatMasker

## Overview

This Galaxy workflow is designed for genome annotation, specifically focusing on the identification and masking of repetitive DNA elements. It takes a raw genome sequence as input and employs a two-stage approach to ensure both *de novo* discovery and library-based screening of repeats.

The process begins with [Red](https://toolshed.g2.bx.psu.edu/repos/iuc/red/red/2018.09.10+galaxy1) (REpeats Detector), which performs automated *de novo* repeat masking. This is followed by [RepeatMasker](https://toolshed.g2.bx.psu.edu/repos/bgruening/repeat_masker/repeatmasker_wrapper/4.1.5+galaxy0), which screens the sequence against curated libraries to identify interspersed repeats and low-complexity DNA sequences.

The workflow produces several comprehensive outputs, including masked genomic sequences and repeat coordinates in BED format. Additionally, it generates a detailed repeat catalogue, execution logs, and summary statistics, providing a complete profile of the genome's repetitive landscape. This toolset is particularly useful for [Genome-annotation](https://training.galaxyproject.org/training-material/topics/genome-annotation/) pipelines following [GTN](https://training.galaxyproject.org/) best practices.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Raw genome sequence | data_input | The raw (not masked) genome sequence in fasta format |


Ensure your raw genome sequence is in FASTA format to maintain compatibility with both the Red and RepeatMasker tools. For processing multiple genomes simultaneously, organize your inputs into a dataset collection to streamline execution across the entire batch. Consult the `README.md` for comprehensive details on library selection and specific parameter configurations. You may also use `planemo workflow_job_init` to create a `job.yml` file for automated job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 1 | Red | toolshed.g2.bx.psu.edu/repos/iuc/red/red/2018.09.10+galaxy1 |  |
| 2 | RepeatMasker | toolshed.g2.bx.psu.edu/repos/bgruening/repeat_masker/repeatmasker_wrapper/4.1.5+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 1 | masked | masked |
| 1 | bed | bed |
| 2 | RepeatMasker repeat catalogue on input dataset(s) | output_repeat_catalog |
| 2 | RepeatMasker masked sequence on input dataset(s) | output_masked_genome |
| 2 | RepeatMasker output log on input dataset(s) | output_log |
| 2 | RepeatMasker repeat statistics on input dataset(s) | output_table |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run repeatmasker.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run repeatmasker.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run repeatmasker.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init repeatmasker.ga -o job.yml`
- Lint: `planemo workflow_lint repeatmasker.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `repeatmasker.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
