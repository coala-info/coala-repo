---
name: stacks-rad-seq-reference-guided-workflow
description: This workflow processes demultiplexed RAD-seq fastq reads by mapping them to a reference genome using BWA-MEM2 and Samtools before performing variant calling and population genetic analysis with Stacks2 gstacks and populations. Use this skill when you need to identify SNPs, call haplotypes, and calculate population-level summary statistics for organisms with an available reference genome to investigate genetic diversity or population structure.
homepage: https://usegalaxy.org.au/
metadata:
  docker_image: "N/A"
---

# stacks-rad-seq-reference-guided-workflow

## Overview

This workflow implements a reference-guided approach for processing RAD-seq data using the [Stacks](http://catchenlab.life.illinois.edu/stacks/) software suite. It is designed to take demultiplexed FASTQ reads, a reference genome, and a population map to perform variant calling and population genetic analysis. The pipeline integrates quality control checkpoints to ensure the reliability of alignments before proceeding to downstream analysis.

The process begins by mapping reads to the reference genome using [BWA-MEM2](https://github.com/bwa-mem2/bwa-mem2). Initial mapping quality is assessed via [Samtools stats](http://www.htslib.org/doc/samtools-stats.html) and [MultiQC](https://multiqc.info/). Alignments are then filtered using [Samtools view](http://www.htslib.org/doc/samtools-view.html) to remove unmapped reads, non-primary alignments, and PCR duplicates, followed by a second round of quality assessment to verify the filtered dataset.

In the final stages, the workflow utilizes the Stacks modules `gstacks` and `populations`. `gstacks` assembles loci and identifies SNPs across the population based on the provided alignments. Subsequently, the `populations` module calculates population-level summary statistics and exports results in various formats, including VCF, FASTA, and STRUCTURE. These outputs provide comprehensive insights into genetic diversity, haplotypes, and F-statistics.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Reference genome | data_input |  |
| 1 | Input dataset collection | data_collection_input |  |
| 2 | Population map | data_input |  |


Ensure your input reads are demultiplexed FASTQ files organized into a dataset collection, alongside a reference genome in FASTA format and a tab-separated population map. Before running, verify that your population map exactly matches the sample names within your collection to avoid errors during the gstacks step. Use the Samtools stats and MultiQC outputs to monitor mapping rates and soft-clipping, as low-quality alignments may require adjusting BWA-MEM2 settings or removing specific samples from the population map. For comprehensive details on file formatting and parameter tuning, refer to the README.md. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy0 |  |
| 4 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.3 |  |
| 5 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.13+galaxy2 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy0 |  |
| 7 | Stacks2: gstacks | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_gstacks/stacks2_gstacks/2.55+galaxy2 |  |
| 8 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.3 |  |
| 9 | Stacks2: populations | toolshed.g2.bx.psu.edu/repos/iuc/stacks2_populations/stacks2_populations/2.55+galaxy2 |  |
| 10 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | BWA-MEM2 on input dataset(s) (mapped reads in BAM format) | bam_output |
| 4 | Samtools stats on input dataset(s) | output |
| 5 | Samtools view on input dataset(s): filtered alignments | outputsam |
| 6 | MultiQC on input dataset(s): Webpage | html_report |
| 6 | MultiQC on input dataset(s): Stats | stats |
| 7 | Stacks2: gstacks  on input dataset(s) Assembled contigs and variant sites | gstacks_out |
| 7 | Stacks2: gstacks on input dataset(s) log file | output_log |
| 8 | output | output |
| 9 | out_phistats_sum | out_phistats_sum |
| 9 | out_vcf_haplotypes_snps | out_vcf_haplotypes_snps |
| 9 | out_fasta_strict | out_fasta_strict |
| 9 | out_vcf_haplotypes_haps | out_vcf_haplotypes_haps |
| 9 | Stacks2: populations  on input dataset(s) Summary of Population-level summary statistics | out_sumstats_sum |
| 9 | out_phistats | out_phistats |
| 9 | Stacks2: populations  on input dataset(s) Raw Genotypes/Haplotypes | out_haplotypes |
| 9 | Stacks2: populations on input dataset(s) log file | output_log |
| 9 | Stacks2: populations  on input dataset(s) Population-level haplotype summary statistics | out_hapstats |
| 9 | Stacks2: populations  on input dataset(s) Populations log distributions | out_populations_log_distribs |
| 9 | out_fststats_sum | out_fststats_sum |
| 9 | Stacks2: populations  on input dataset(s) Population-level summary statistics | out_sumstats |
| 9 | out_structure | out_structure |
| 10 | stats | stats |
| 10 | html_report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Stacks_RAD-seq_reference-guided_workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Stacks_RAD-seq_reference-guided_workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Stacks_RAD-seq_reference-guided_workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Stacks_RAD-seq_reference-guided_workflow.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Stacks_RAD-seq_reference-guided_workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Stacks_RAD-seq_reference-guided_workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)