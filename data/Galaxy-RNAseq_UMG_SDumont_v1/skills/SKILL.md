---
name: rnaseq_umg_sdumont_v1
description: "This RNA-seq workflow processes wild-type and knockout Fastq files using Bowtie2 for alignment, htseq-count for gene quantification, and DESeq2 for differential expression analysis against a GTF reference. Use this skill when you need to identify significant changes in gene expression levels between experimental conditions and generate normalized count plots or statistical summaries."
homepage: https://workflowhub.eu/workflows/412
---

# RNAseq_UMG_SDumont_v1

## Overview

This workflow performs a standard differential gene expression analysis comparing Wild Type (WT) and Knockout (KO) samples. It begins by taking Fastq data collections and aligning the reads to a reference genome using [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0).

Following alignment, the workflow utilizes [htseq-count](https://toolshed.g2.bx.psu.edu/repos/lparsons/htseq_count/htseq_count/0.9.1) to quantify transcript abundance based on a user-provided GTF annotation file. This step generates the raw count tables necessary for downstream statistical comparisons between the two experimental conditions.

The core differential expression analysis is conducted via [DESeq2](https://toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.6), which produces comprehensive outputs including normalized counts, transformation logs (vst and rlog), and diagnostic plots. The final stages of the pipeline include filtering and sorting steps to refine the results and highlight significant gene expression changes.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | WT Fastq Files | data_collection_input |  |
| 1 | KO Fastq Files | data_collection_input |  |
| 2 | GTF File | data_input |  |


Ensure your raw sequencing reads are organized into two distinct list collections for the WT and KO groups, typically using fastqsanger or fastqsanger.gz file formats. The reference annotation must be supplied as a valid GTF file that aligns with the genome build used during the Bowtie2 mapping stages. For comprehensive details on experimental design and metadata formatting, refer to the README.md file. You may also use `planemo workflow_job_init` to create a `job.yml` for streamlined input management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 4 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 5 | htseq-count | toolshed.g2.bx.psu.edu/repos/lparsons/htseq_count/htseq_count/0.9.1 |  |
| 6 | htseq-count | toolshed.g2.bx.psu.edu/repos/lparsons/htseq_count/htseq_count/0.9.1 |  |
| 7 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.6 |  |
| 8 | Filter | Filter1 |  |
| 9 | Filter | Filter1 |  |
| 10 | Sort | sort1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | output | output |
| 4 | output | output |
| 5 | othercounts | othercounts |
| 5 | counts | counts |
| 6 | counts | counts |
| 6 | othercounts | othercounts |
| 7 | vst_out | vst_out |
| 7 | rlog_out | rlog_out |
| 7 | deseq_out | deseq_out |
| 7 | plots | plots |
| 7 | counts_out | counts_out |
| 8 | out_file1 | out_file1 |
| 9 | out_file1 | out_file1 |
| 10 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-RNAseq_UMG_SDumont_v1.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-RNAseq_UMG_SDumont_v1.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-RNAseq_UMG_SDumont_v1.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-RNAseq_UMG_SDumont_v1.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-RNAseq_UMG_SDumont_v1.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-RNAseq_UMG_SDumont_v1.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
