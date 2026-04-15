---
name: stacks-rad-seq-de-novo-workflow
description: This workflow processes demultiplexed RAD-seq fastq reads and a population map using the Stacks2 toolset to perform de novo locus assembly, catalog construction, and variant calling. Use this skill when studying the population genetics, phylogeography, or genetic diversity of organisms without a reference genome to generate SNP data and population-level summary statistics.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# stacks-rad-seq-de-novo-workflow

## Overview

This workflow performs *de novo* genetic analysis of RAD-seq data using the [Stacks](http://catchenlab.life.illinois.edu/stacks/) software suite. It is specifically designed for organisms without a reference genome, requiring only a collection of demultiplexed fastq reads and a population map as initial inputs.

The pipeline begins by assembling reads into hypothetical alleles with `ustacks`, followed by the creation of a consensus loci catalog via `cstacks`. Individual samples are then matched against this catalog using `sstacks`, and the resulting data is processed through `tsv2bam` to align reads to each locus in BAM format for downstream variant calling.

In the final stages, `gstacks` identifies SNPs and assembles contigs, while the `populations` tool calculates population-level summary statistics. The workflow produces a comprehensive set of outputs, including VCF files for SNPs and haplotypes, locus consensus sequences in FASTA format, and various population genetic metrics (e.g., FST and PhiST).

For detailed instructions on input preparation and a full description of the intermediate files, please refer to the [README.md](#) in the Files section and the official [Stacks manual](https://catchenlab.life.illinois.edu/stacks/manual/#ufiles).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Input dataset collection | data_collection_input |  |
| 1 | Population map | data_input |  |


Ensure your demultiplexed reads are in FASTQ format and organized into a dataset collection, while the population map must be a two-column tabular file. Using a collection is essential for this workflow to allow Stacks to process multiple samples simultaneously and maintain sample-to-locus relationships across the pipeline. For comprehensive details on file formatting and specific preparation steps, refer to the README.md. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Stacks2: ustacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_ustacks/stacks2_ustacks/2.55+galaxy3 |  |
| 3 | Stacks2: cstacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_cstacks/stacks2_cstacks/2.55+galaxy2 |  |
| 4 | Stacks2: sstacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_sstacks/stacks2_sstacks/2.55+galaxy2 |  |
| 5 | Stacks2: tsv2bam | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_tsv2bam/stacks2_tsv2bam/2.55+galaxy2 |  |
| 6 | Stacks2: gstacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_gstacks/stacks2_gstacks/2.55+galaxy2 |  |
| 7 | Stacks2: populations | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_populations/stacks2_populations/2.55+galaxy2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | tabs | tabs |
| 2 | output_log | output_log |
| 3 | Stacks2: cstacks on input dataset(s) log file | output_log |
| 3 | Stacks2: cstacks  on input dataset(s) Catalog of loci | catalog |
| 4 | Stacks2: sstacks  on input dataset(s) Matches to the catalog | matches |
| 4 | Stacks2: sstacks on input dataset(s) log file | output_log |
| 5 | Stacks2: tsv2bam  on input dataset(s) Matches to the catalog (bam) | bams |
| 5 | Stacks2: tsv2bam on input dataset(s) log file | output_log |
| 6 | Stacks2: gstacks  on input dataset(s) Assembled contigs and variant sites | gstacks_out |
| 6 | Stacks2: gstacks on input dataset(s) log file | output_log |
| 7 | out_phistats_sum | out_phistats_sum |
| 7 | out_structure | out_structure |
| 7 | Stacks2: populations  on input dataset(s) Population-level summary statistics | out_sumstats |
| 7 | Stacks2: populations on input dataset(s) log file | output_log |
| 7 | Stacks2: populations  on input dataset(s) Raw Genotypes/Haplotypes | out_haplotypes |
| 7 | Stacks2: populations  on input dataset(s) Summary of Population-level summary statistics | out_sumstats_sum |
| 7 | out_phistats | out_phistats |
| 7 | out_fststats_sum | out_fststats_sum |
| 7 | out_fasta_strict | out_fasta_strict |
| 7 | Stacks2: populations  on input dataset(s) Population-level haplotype summary statistics | out_hapstats |
| 7 | Stacks2: populations  on input dataset(s) Populations log distributions | out_populations_log_distribs |
| 7 | out_vcf_haplotypes_snps | out_vcf_haplotypes_snps |
| 7 | out_vcf_haplotypes_haps | out_vcf_haplotypes_haps |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Stacks_RAD-seq_de_novo_workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Stacks_RAD-seq_de_novo_workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Stacks_RAD-seq_de_novo_workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Stacks_RAD-seq_de_novo_workflow.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Stacks_RAD-seq_de_novo_workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Stacks_RAD-seq_de_novo_workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)