---
name: core-genome-multilocus-sequence-typing-cgmlst-of-bacterial-g
description: "This workflow performs core genome multilocus sequence typing on bacterial genome contigs by applying curated reference schemes through CoreProfiler and ToolDistillator. Use this skill when you need to characterize bacterial strains, identify allelic profiles, or perform high-resolution genotyping for epidemiological surveillance and comparative genomics."
homepage: https://workflowhub.eu/workflows/2055
---

# core genome Multilocus Sequence Typing (cgMLST) of bacterial genome

## Overview

This workflow performs core genome multilocus sequence typing (cgMLST) on assembled bacterial genome contigs to characterize strains using curated reference schemes. It is designed to identify allele profiles by comparing input sequences against established databases such as pubMLST, BIGSdb, Enterobase, or cgMLST.org.

The process begins with [CoreProfiler](https://toolshed.g2.bx.psu.edu/repos/iuc/coreprofiler_allele_calling/coreprofiler_allele_calling/2.0.0+galaxy2), which performs allele calling to generate a tabular profile for each locus and identifies any newly detected or temporary alleles. Following the analysis, [ToolDistillator](https://toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.5+galaxy1) extracts and aggregates these results into a structured JSON format for downstream interpretation.

The workflow requires two primary inputs: bacterial genome contigs in FASTA format and a reference allele scheme. Key outputs include a comprehensive allele calling report, a FASTA file of novel alleles, and summarized JSON data containing the distilled cgMLST results. Detailed instructions on file preparation and input specifications can be found in the [README.md](./README.md) in the Files section.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Bacterial genome contigs | data_input | The input for this workflow is a single FASTA file containing contigs of one bacterial genome. |
| 1 | Reference Allele Scheme | parameter_input | Reference Allele Scheme (from pubMLST,  BIGSdb, Enterobase, or cgMLST.org) that will be used by CoreProfiler to compare the contigs to and identify corresponding alleles. |


Ensure your bacterial genome contigs are provided in FASTA format and that you have identified the correct curated reference scheme for your specific organism. While the workflow processes a single genome, utilizing dataset collections allows for the parallel analysis of multiple bacterial strains. For comprehensive details on scheme selection and parameter settings, please consult the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined job configuration.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | CoreProfiler allele_calling | toolshed.g2.bx.psu.edu/repos/iuc/coreprofiler_allele_calling/coreprofiler_allele_calling/2.0.0+galaxy2 | Identifies alleles in contigs by comparing them to a reference allele scheme by detecting both exact matches to known alleles and potential novel alleles using a two-step BLAST-based approach. |
| 3 | ToolDistillator | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator/tooldistillator/1.0.5+galaxy1 | Extracts results from tool outputs and creates a JSON file for each tool |
| 4 | ToolDistillator Summarize | toolshed.g2.bx.psu.edu/repos/iuc/tooldistillator_summarize/tooldistillator_summarize/1.0.5+galaxy1 | Summarizes several ToolDistillator JSON files into a unique JSON file |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | CoreProfiler allele calling report | output_file |
| 2 | Newly detected alleles by CoreProfiler | outfa |
| 2 | Information about temporary alleles found by CoreProfiler | profiles_w_tmp_alleles |
| 3 | Extracted cgMLST results by ToolDistillator | output_json |
| 4 | Summarized cgMLST ToolDistillator results | summary_json |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run cgmlst_bacterial_genome.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run cgmlst_bacterial_genome.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run cgmlst_bacterial_genome.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init cgmlst_bacterial_genome.ga -o job.yml`
- Lint: `planemo workflow_lint cgmlst_bacterial_genome.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `cgmlst_bacterial_genome.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
