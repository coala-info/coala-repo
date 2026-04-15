---
name: find-transcripts-tsi
description: This workflow performs tissue-specific transcript discovery by aligning paired-end RNA-seq reads to a masked genome using HISAT2 and assembling the resulting alignments into a GTF file with StringTie. Use this skill when you need to characterize the unique transcriptomic landscape of individual tissues or identify novel isoforms within a specific biological sample.
homepage: https://www.biocommons.org.au/
metadata:
  docker_image: "N/A"
---

# find-transcripts-tsi

## Overview

This Galaxy workflow is designed to identify and assemble transcripts from RNA-seq data on a per-tissue basis. It requires three primary inputs: a masked genome in FASTA format and a pair of trimmed, merged R1 and R2 RNA-seq reads.

The pipeline begins by indexing the genome and aligning the reads using [HISAT2](https://toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.2.1+galaxy1). The alignment step is specifically configured to report alignments tailored for transcript assemblers (equivalent to the `-dta` flag), ensuring the output is optimized for downstream processing. Following alignment, the workflow uses `samtools sort` to organize the resulting BAM files by coordinate.

In the final stage, [StringTie](https://toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.1+galaxy1) processes the sorted alignments to generate a GTF file representing the assembled transcripts for the specific tissue. The workflow outputs include the final `transcripts.gtf` file, the HISAT2 alignment summary, and the mapped read files.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Trimmed, merged R1 files | data_input |  |
| 1 | Trimmed, merged R2 files | data_input |  |
| 2 | genome.fasta (use masked if available) | data_input |  |


Ensure your input files are in FASTA format for the masked genome and FASTQ format for the trimmed RNA-seq reads. Since this workflow is designed to be run per tissue, you can process multiple samples efficiently by organizing your paired-end reads into a dataset collection. Refer to the README.md file for comprehensive details on parameter settings and specific tool configurations. You can use planemo workflow_job_init to generate a job.yml file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.2.1+galaxy1 |  |
| 4 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.1+galaxy1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | hisat2_summary_file | summary_file |
| 3 | output_alignments | output_alignments |
| 4 | output_gtf | output_gtf |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-Find-transcripts-TSI.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-Find-transcripts-TSI.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-Find-transcripts-TSI.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-Find-transcripts-TSI.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-Find-transcripts-TSI.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-Find-transcripts-TSI.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)