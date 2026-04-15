---
name: partial-de-novo-workflow-c-s-g-pops-only
description: This RAD-seq workflow processes ustacks outputs and a population map using the Stacks2 toolset, including cstacks, sstacks, tsv2bam, gstacks, and populations. Use this skill when you need to build a locus catalog, call variants, and calculate population genetic statistics for species lacking a reference genome.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# partial-de-novo-workflow-c-s-g-pops-only

## Overview

This workflow is designed for RAD-seq data analysis on the [Galaxy](https://usegalaxy.org.au/) platform, specifically focusing on the middle and late stages of the [Stacks](http://catchenlab.life.illinois.edu/stacks/) pipeline. It serves as a partial de novo assembly path, picking up after the initial `ustacks` step. For users needing the preliminary processing, the `ustacks` workflow is available on [WorkflowHub](https://workflowhub.eu/workflows/349).

The process integrates several core Stacks2 tools to move from individual sample loci to population-level insights. It begins by using `cstacks` to create a catalog of loci and `sstacks` to match individual samples against that catalog. Subsequently, the workflow utilizes `tsv2bam` and `gstacks` to assemble contigs and identify variant sites across the entire dataset.

The final stage employs the `populations` tool to calculate comprehensive genetic statistics. Key outputs include population-level summary statistics (such as Fst and Phi), Structure files, and variant calls in VCF and FASTA formats. For detailed information on input preparation and specific file requirements, please refer to the [README.md](README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Ustacks inputs | data_collection_input |  |
| 1 | Population map | data_input |  |


Ensure your ustacks inputs are provided as a paired dataset collection of .tags.tsv, .snps.tsv, and .alleles.tsv files, while the population map must be a two-column tab-separated file (tabular) matching your sample identifiers. For efficient execution, verify that the collection metadata is correctly set so that cstacks can properly aggregate the loci into a catalog. Refer to the README.md for comprehensive details on file formatting and prerequisite steps. You can use `planemo workflow_job_init` to generate a `job.yml` for automated testing and parameter configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Stacks2: cstacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_cstacks/stacks2_cstacks/2.55+galaxy2 |  |
| 3 | Stacks2: sstacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_sstacks/stacks2_sstacks/2.55+galaxy2 |  |
| 4 | Stacks2: tsv2bam | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_tsv2bam/stacks2_tsv2bam/2.55+galaxy2 |  |
| 5 | Stacks2: gstacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_gstacks/stacks2_gstacks/2.55+galaxy2 |  |
| 6 | Stacks2: populations | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_populations/stacks2_populations/2.55+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Stacks2: cstacks  on input dataset(s) Catalog of loci | catalog |
| 2 | Stacks2: cstacks on input dataset(s) log file | output_log |
| 3 | Stacks2: sstacks on input dataset(s) log file | output_log |
| 3 | Stacks2: sstacks  on input dataset(s) Matches to the catalog | matches |
| 4 | Stacks2: tsv2bam on input dataset(s) log file | output_log |
| 4 | Stacks2: tsv2bam  on input dataset(s) Matches to the catalog (bam) | bams |
| 5 | Stacks2: gstacks  on input dataset(s) Assembled contigs and variant sites | gstacks_out |
| 5 | Stacks2: gstacks on input dataset(s) log file | output_log |
| 6 | out_fststats_sum | out_fststats_sum |
| 6 | Stacks2: populations  on input dataset(s) Populations log distributions | out_populations_log_distribs |
| 6 | out_phistats_sum | out_phistats_sum |
| 6 | out_structure | out_structure |
| 6 | Stacks2: populations  on input dataset(s) Population-level summary statistics | out_sumstats |
| 6 | Stacks2: populations on input dataset(s) log file | output_log |
| 6 | Stacks2: populations  on input dataset(s) Raw Genotypes/Haplotypes | out_haplotypes |
| 6 | Stacks2: populations  on input dataset(s) Summary of Population-level summary statistics | out_sumstats_sum |
| 6 | out_phistats | out_phistats |
| 6 | out_fasta_strict | out_fasta_strict |
| 6 | Stacks2: populations  on input dataset(s) Population-level haplotype summary statistics | out_hapstats |
| 6 | out_vcf_haplotypes_snps | out_vcf_haplotypes_snps |
| 6 | out_vcf_haplotypes_haps | out_vcf_haplotypes_haps |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Partial_de_novo_workflow_c-s-g-pops_only.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Partial_de_novo_workflow_c-s-g-pops_only.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Partial_de_novo_workflow_c-s-g-pops_only.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Partial_de_novo_workflow_c-s-g-pops_only.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Partial_de_novo_workflow_c-s-g-pops_only.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Partial_de_novo_workflow_c-s-g-pops_only.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)