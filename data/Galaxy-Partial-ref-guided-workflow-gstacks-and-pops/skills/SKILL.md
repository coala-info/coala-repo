---
name: partial-ref-guided-workflow-gstacks-and-pops
description: "This RAD-seq workflow processes BAM files and a population map using the Stacks2 gstacks and populations tools to perform reference-guided variant calling and population genetic analysis. Use this skill when you need to calculate population-level summary statistics, identify variant sites, and export genotype data for evolutionary or conservation genetics studies using a reference-guided approach."
homepage: https://workflowhub.eu/workflows/352
---

# Partial ref-guided workflow - gstacks and pops

## Overview

This Galaxy workflow is designed for the analysis of RAD-seq data using the [Stacks](http://catchenlab.life.illinois.edu/stacks/) software suite. It represents the latter portion of a reference-guided pipeline, specifically focusing on genotype calling and population genetics statistics. The workflow processes aligned sequence data to identify SNPs and haplotypes across different populations.

The pipeline requires two primary inputs: a collection of BAM files containing aligned reads and a population map to define group assignments. It utilizes [gstacks](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks2_gstacks/stacks2_gstacks/2.55+galaxy2) to assemble contigs and call variant sites from the BAM files, followed by the [populations](https://toolshed.g2.bx.psu.edu/repos/iuc/stacks2_populations/stacks2_populations/2.55+galaxy2) tool to calculate population-level summary statistics.

Key outputs include assembled contigs, VCF files for both SNPs and haplotypes, and various statistical summaries such as Fst and Phi statistics. The workflow also generates formatted files for downstream analysis, including Structure and FASTA formats. This workflow is part of a larger suite available on [Galaxy Australia](https://usegalaxy.org.au/) and is documented as part of a broader reference-guided strategy on [WorkflowHub](https://workflowhub.eu/workflows/347).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Bam files | data_collection_input |  |
| 1 | Population map | data_input |  |


Ensure your input BAM files are organized into a paired-end or list collection to match the workflow's requirement for grouped sequence data. The population map must be a two-column tab-separated (TSV) file mapping each individual sample name to its respective population identifier. For automated testing or command-line execution, you can initialize a job template using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on preparing these files and specific formatting requirements. Ensure all BAM files are indexed and that sample names in the population map exactly match the filenames in your collection.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Stacks2: gstacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_gstacks/stacks2_gstacks/2.55+galaxy2 |  |
| 3 | Stacks2: populations | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_populations/stacks2_populations/2.55+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | Stacks2: gstacks  on input dataset(s) Assembled contigs and variant sites | gstacks_out |
| 2 | Stacks2: gstacks on input dataset(s) log file | output_log |
| 3 | out_vcf_haplotypes_haps | out_vcf_haplotypes_haps |
| 3 | Stacks2: populations  on input dataset(s) Summary of Population-level summary statistics | out_sumstats_sum |
| 3 | out_phistats_sum | out_phistats_sum |
| 3 | out_vcf_haplotypes_snps | out_vcf_haplotypes_snps |
| 3 | Stacks2: populations on input dataset(s) log file | output_log |
| 3 | Stacks2: populations  on input dataset(s) Population-level haplotype summary statistics | out_hapstats |
| 3 | Stacks2: populations  on input dataset(s) Populations log distributions | out_populations_log_distribs |
| 3 | out_fststats_sum | out_fststats_sum |
| 3 | Stacks2: populations  on input dataset(s) Population-level summary statistics | out_sumstats |
| 3 | out_structure | out_structure |
| 3 | out_phistats | out_phistats |
| 3 | Stacks2: populations  on input dataset(s) Raw Genotypes/Haplotypes | out_haplotypes |
| 3 | out_fasta_strict | out_fasta_strict |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Partial_ref-guided_workflow_gstacks_and_pops.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Partial_ref-guided_workflow_gstacks_and_pops.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Partial_ref-guided_workflow_gstacks_and_pops.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Partial_ref-guided_workflow_gstacks_and_pops.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Partial_ref-guided_workflow_gstacks_and_pops.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Partial_ref-guided_workflow_gstacks_and_pops.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
