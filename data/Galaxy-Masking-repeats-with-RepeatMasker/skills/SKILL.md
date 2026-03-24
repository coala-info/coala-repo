---
name: repeatmasker
description: "This genome annotation workflow processes raw genome sequences to identify and mask repetitive elements using the Red and RepeatMasker tools. Use this skill when you need to identify transposable elements and low-complexity regions to prepare a draft assembly for downstream gene prediction or comparative genomics."
homepage: https://workflowhub.eu/workflows/753
---

# RepeatMasker

## Overview

This workflow is designed for genome annotation, specifically focusing on identifying and masking repetitive elements within a raw genome sequence. It provides a streamlined approach to handle the complexity of repetitive DNA, which is a crucial step in preparing genomic data for gene prediction and comparative genomics.

The pipeline utilizes two primary tools to ensure comprehensive coverage. First, [Red](https://toolshed.g2.bx.psu.edu/repos/iuc/red/red/2018.09.10+galaxy1) (REpeat Detector) performs de novo repeat discovery and masking using an automated, high-performance algorithm. This is followed by [RepeatMasker](https://toolshed.g2.bx.psu.edu/repos/bgruening/repeat_masker/repeatmasker_wrapper/4.1.5+galaxy0), which screens the sequence against known repeat libraries to classify and mask interspersed repeats and low-complexity DNA sequences.

The workflow generates several key outputs, including masked genomic sequences, BED files of detected repeats, and a detailed repeat catalogue. Users also receive statistical summaries and processing logs to evaluate the distribution and types of repeats found within the assembly. This tool is licensed under [GPL-3.0-or-later](https://spdx.org/licenses/GPL-3.0-or-later.html) and is categorized under genome-annotation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Raw genome sequence | data_input | The raw (not masked) genome sequence in fasta format |


Ensure your raw genome sequence is provided in FASTA format to ensure compatibility with both Red and RepeatMasker. If you are masking multiple assemblies or large genomic batches, organizing your files into a dataset collection will significantly simplify the workflow execution. Refer to the `README.md` for comprehensive details on selecting the appropriate species-specific repeat libraries and sensitivity parameters. You can also use `planemo workflow_job_init` to quickly generate a `job.yml` for defining these input parameters.

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
planemo run Masking repeats with RepeatMasker.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Masking repeats with RepeatMasker.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Masking repeats with RepeatMasker.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Masking repeats with RepeatMasker.ga -o job.yml`
- Lint: `planemo workflow_lint Masking repeats with RepeatMasker.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Masking repeats with RepeatMasker.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
