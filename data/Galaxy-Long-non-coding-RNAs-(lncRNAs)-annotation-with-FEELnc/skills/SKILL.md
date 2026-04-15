---
name: long-non-coding-rnas-lncrnas-annotation-with-feelnc
description: This workflow performs long non-coding RNA annotation by processing RNA-seq BAM files, genome annotations, and assembly sequences using StringTie for transcript assembly and FEELnc for lncRNA identification. Use this skill when you need to identify novel lncRNAs from transcriptomic data and classify them based on their genomic environment relative to protein-coding genes.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# long-non-coding-rnas-lncrnas-annotation-with-feelnc

## Overview

This Galaxy workflow provides a standardized pipeline for the identification and annotation of long non-coding RNAs (lncRNAs) from transcriptomic data. Based on the [Galaxy Training Network](https://training.galaxyproject.org/) (GTN) methodology, it utilizes the [FEELnc](https://github.com/bioinfo-pf-curie/feelnc) toolset to accurately distinguish between coding and non-coding transcripts using a reference genome and RNA-Seq data.

The process begins by assembling transcripts from mapped RNA-Seq reads using [StringTie](https://ccb.jhu.edu/software/stringtie/). These assemblies are then processed through FEELnc, which filters transcripts by size and biotype, evaluates their coding potential, and classifies identified lncRNAs based on their genomic location relative to neighboring protein-coding genes.

The workflow produces several key outputs, including categorized datasets for mRNAs and lncRNAs, a detailed classifier report, and a final merged annotation file. This toolset is tagged for **Genome-annotation** and is distributed under the **GPL-3.0-or-later** license.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | mapped_RNASeq.bam | data_input | RNASeq data mapped on the genome |
| 1 | genome_annotation.gff3 | data_input | Original structural annotation |
| 2 | genome_assembly.fasta | data_input | Genome sequence |


Ensure your input files are correctly formatted as BAM for mapped reads, GFF3 for genome annotations, and FASTA for the reference assembly to ensure compatibility with FEELnc. While individual datasets are sufficient for single-sample analysis, organizing multiple RNA-Seq BAM files into a dataset collection will significantly streamline the initial StringTie assembly step. Refer to the README.md for comprehensive details on specific parameter settings and necessary data preprocessing steps. You can quickly generate a template for these inputs using `planemo workflow_job_init` to create a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/1.3.6 |  |
| 4 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.3+galaxy0 |  |
| 5 | FEELnc | toolshed.g2.bx.psu.edu/repos/iuc/feelnc/feelnc/0.2 |  |
| 6 | Concatenate datasets | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_cat/0.1.1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 5 | mRNAs | candidate_mRNA |
| 5 | lncRNAs | candidate_lncRNA |
| 5 | Classifier output | classifier |
| 6 | final_annotation | out_file1 |


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