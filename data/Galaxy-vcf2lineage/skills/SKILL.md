---
name: vcf2lineage
description: "This Galaxy workflow transforms variant calls and a reference genome into consensus sequences and lineage assignments using SnpSift, bcftools, and Pangolin. Use this skill when you need to identify specific viral lineages and generate multi-sample consensus FASTA files from genomic variant data."
homepage: https://workflowhub.eu/workflows/1391
---

# vcf2lineage

## Overview

This Galaxy workflow automates the process of generating consensus sequences and assigning lineages from variant call data. It is designed for [variant-analysis](https://training.galaxyproject.org/training-material/topics/variant-analysis/) and workflow automation, taking a collection of VCF files, a reference genome, and a minimum allele frequency (min-AF) parameter as primary inputs.

The pipeline begins by filtering the input variant calls using [SnpSift Filter](https://pcingola.github.io/SnpEff/ss_filter/) to ensure only high-confidence variants meeting the min-AF threshold are retained. These filtered variants are then integrated with the reference genome via [bcftools consensus](https://samtools.github.io/bcftools/bcftools.html#consensus) to produce individual consensus sequences for each sample in the collection.

To streamline downstream analysis, the workflow collapses the individual sequences into a single multi-sample FASTA file. This merged dataset is then processed by [Pangolin](https://github.com/cov-lineages/pangolin) to perform lineage classification. The final outputs include the filtered consensus variants, the individual and multisample consensus FASTA files, and the comprehensive Pangolin lineage report.

This tool is released under the MIT license and follows [GTN](https://training.galaxyproject.org/) best practices for Galaxy-based genomic surveillance.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Variant calls | data_collection_input |  |
| 1 | min-AF for consensus variant | parameter_input |  |
| 2 | Reference genome | data_input |  |


Ensure your variant calls are uploaded as a VCF collection and the reference genome is provided in FASTA format to maintain compatibility with the bcftools and Pangolin steps. Utilizing a data collection for variant calls is necessary for the workflow to correctly batch process samples before collapsing them into a multisample FASTA. Please refer to the `README.md` for exhaustive details on input requirements and parameter tuning. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated job submission.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 4 | SnpSift Filter | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_filter/4.3+t.galaxy1 |  |
| 5 | bcftools consensus | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_consensus/bcftools_consensus/1.10 |  |
| 6 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/4.2 |  |
| 7 | Pangolin | toolshed.g2.bx.psu.edu/repos/iuc/pangolin/pangolin/2.3.8 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | consensus_variants | output |
| 5 | consensus | output_file |
| 6 | multisample_consensus_fasta | output |
| 7 | pangolin_results | output1 |


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
