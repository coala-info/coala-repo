---
name: ont-tutorial-nanopolish-variants
description: "This Nanopore sequencing workflow processes FASTA reads, FAST5 signal data, and a draft assembly using minimap2 and Nanopolish to identify genomic variants. Use this skill when you need to polish a draft genome assembly or call high-confidence variants by leveraging the raw signal information from Oxford Nanopore reads."
homepage: https://workflowhub.eu/workflows/50
---

# ONT --Tutorial-Nanopolish-variants

## Overview

This workflow is designed to identify variants and polish genomic assemblies using Oxford Nanopore Technologies (ONT) data. By leveraging the raw signal information from FAST5 files, the pipeline improves the consensus accuracy of a draft assembly beyond what is possible with basecalled reads alone.

The process begins by using [minimap2](https://github.com/lh3/minimap2) to align the basecalled sequences (`reads.fasta`) to a provided `draft.fa` reference. This alignment step provides the necessary positional context for the signal-level analysis, mapping the sequences to their corresponding locations on the draft genome.

In the final stage, the [nanopolish variants](https://nanopolish.readthedocs.io/en/latest/quickstart_call_variants.html) tool integrates the alignment data with the raw signal data stored in the `fast5_files.tar.gz` archive. By analyzing the original ion current signals, the workflow calls high-confidence SNPs and small indels to refine the draft sequence and correct systematic base-calling errors.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | reads.fasta | data_input |  |
| 1 | fast5_files.tar.gz | data_input |  |
| 2 | draft.fa | data_input |  |


Ensure your raw signal data is provided as a compressed .tar.gz archive of FAST5 files to be used alongside the basecalled reads.fasta and the draft.fa assembly. While individual datasets are used for this workflow, maintaining the integrity of the FAST5 archive is critical for Nanopolish to successfully index and link signal data to your sequences. Refer to the README.md for comprehensive details on file preparation and specific tool parameters. You may also use planemo workflow_job_init to create a job.yml file for streamlined execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.12 |  |
| 4 | Nanopolish variants | toolshed.g2.bx.psu.edu/repos/bgruening/nanopolish_variants/nanopolish_variants/0.1.0 |  |


## Workflow outputs (marked in Galaxy)

_No explicit workflow outputs in this export; add outputs in the Galaxy editor or inspect tool steps._

## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-ONT_--Tutorial-Nanopolish-variants.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-ONT_--Tutorial-Nanopolish-variants.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-ONT_--Tutorial-Nanopolish-variants.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-ONT_--Tutorial-Nanopolish-variants.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-ONT_--Tutorial-Nanopolish-variants.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-ONT_--Tutorial-Nanopolish-variants.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
