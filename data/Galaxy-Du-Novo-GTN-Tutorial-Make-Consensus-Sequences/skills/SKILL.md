---
name: du-novo-gtn-tutorial-make-consensus-sequences
description: "This workflow processes raw forward and reverse duplex sequencing reads using the Du Novo suite and Sequence Content Trimmer to generate high-accuracy duplex consensus sequences. Use this skill when you need to eliminate PCR and sequencing errors to identify extremely low-frequency genetic variants or ultra-rare mutations in complex samples."
homepage: https://workflowhub.eu/workflows/1664
---

# Du Novo GTN Tutorial - Make Consensus Sequences

## Overview

This workflow is designed to process raw duplex sequencing data to generate high-accuracy duplex consensus sequences. Based on the [Galaxy Training Network (GTN)](https://training.galaxyproject.org/) tutorial for variant analysis, it provides a robust pipeline for identifying true biological mutations by filtering out sequencing and PCR errors.

The process begins by organizing paired-end raw reads into families based on their unique molecular identifiers (UMIs) using the [Du Novo](https://toolshed.g2.bx.psu.edu/repos/nick/dunovo/make_families/2.15) suite. The workflow performs barcode error correction and aligns these families to identify consistent bases across read groups. This consensus-building step is critical for duplex sequencing, as it compares both strands of the original DNA molecule to ensure maximum data integrity.

In the final stages, the workflow generates the duplex consensus reads and utilizes the [Sequence Content Trimmer](https://toolshed.g2.bx.psu.edu/repos/nick/sequence_content_trimmer/sequence_content_trimmer/0.1) to clean and refine the sequences. The resulting outputs are high-fidelity reads ready for downstream variant calling and genomic analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SRR1799908_forward | data_input |  |
| 1 | SRR1799908_reverse | data_input |  |


Ensure your input files are in FASTQ format, representing the raw forward and reverse duplex sequencing reads required for family making. While the workflow accepts individual datasets, organizing your reads into a paired collection can streamline the processing of multiple samples simultaneously. Refer to the `README.md` for specific parameter configurations and comprehensive data preparation instructions. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Du Novo: Make families | toolshed.g2.bx.psu.edu/repos/nick/dunovo/make_families/2.15 |  |
| 3 | Du Novo: Correct barcodes | toolshed.g2.bx.psu.edu/repos/nick/dunovo/correct_barcodes/2.15 |  |
| 4 | Du Novo: Align families | toolshed.g2.bx.psu.edu/repos/nick/dunovo/align_families/2.15 |  |
| 5 | Du Novo: Make consensus reads | toolshed.g2.bx.psu.edu/repos/nick/dunovo/dunovo/2.15 |  |
| 6 | Sequence Content Trimmer | toolshed.g2.bx.psu.edu/repos/nick/sequence_content_trimmer/sequence_content_trimmer/0.1 |  |
| 7 | Sequence Content Trimmer | toolshed.g2.bx.psu.edu/repos/nick/sequence_content_trimmer/sequence_content_trimmer/0.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 6 | output2 | output2 |
| 6 | output1 | output1 |
| 7 | output2 | output2 |
| 7 | output1 | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run dunovo.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run dunovo.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run dunovo.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init dunovo.ga -o job.yml`
- Lint: `planemo workflow_lint dunovo.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `dunovo.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
