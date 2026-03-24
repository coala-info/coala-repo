---
name: vvv2_align_se_bwamem2
description: "This viral genomics workflow processes single-end sequencing reads using BWA-MEM2 for alignment, VADR for annotation, and VarDict for variant calling to generate consensus sequences and visual summaries of genomic features. Use this skill when you need to identify significant variants in viral samples, annotate protein-coding regions, and visualize the relationship between coverage depth and mutations across a viral genome."
homepage: https://workflowhub.eu/workflows/1739
---

# vvv2_align_SE_bwamem2

## Overview

The `vvv2_align_SE_bwamem2` workflow is designed for viral sequence analysis, specifically focusing on single-end (SE) read alignment, annotation, and variant calling. It begins by preprocessing raw reads with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0) for quality control and formatting the reference sequence. It integrates [VADR](https://toolshed.g2.bx.psu.edu/repos/ftouzain/vadr/vadr/0.2.0) (Viral Annotation DefineR) to provide precise protein and CDS annotations based on selected viral models.

Alignment is performed using [BWA-MEM2](https://toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1), followed by duplicate removal and coverage depth calculation via Samtools. The workflow identifies genomic variations using the [VarDict](https://toolshed.g2.bx.psu.edu/repos/iuc/vardict_java/vardict_java/1.8.3+galaxy1) variant caller and [bcftools](https://toolshed.g2.bx.psu.edu/repos/iuc/bcftools_call/bcftools_call/1.15.1+galaxy3). These steps culminate in the generation of both IUPAC and Majority consensus sequences.

The final output is summarized through [vvv2_display](https://toolshed.g2.bx.psu.edu/repos/ftouzain/vvv2_display/vvv2_display/0.2.4.0), which produces a TSV file of significant variants and a comprehensive PNG visualization. This image maps variant proportions, gene annotations, and coverage depths into a single view. This workflow is licensed under GPL-3.0-or-later and is optimized for viral research involving variant calling and display.

## Inputs and data preparation

_None listed._


Ensure your input sequencing reads are in FASTQ or FASTQ.GZ format and the reference genome is provided as a standard FASTA file. For efficient batch processing of multiple samples, organize your single-end reads into a Dataset Collection before launching the workflow. It is essential to select the correct VADR model corresponding to your target virus to ensure accurate annotation and variant visualization. Please refer to the README.md for comprehensive details on specific tool parameters and configuration requirements. You may use `planemo workflow_job_init` to streamline the creation of a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | FASTA Width | toolshed.g2.bx.psu.edu/repos/devteam/fasta_formatter/cshl_fasta_formatter/1.0.1+galaxy2 |  |
| 1 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0 |  |
| 2 | VADR - Viral Annotation DefineR | toolshed.g2.bx.psu.edu/repos/ftouzain/vadr/vadr/0.2.0 |  |
| 3 | BWA-MEM2 | toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1 |  |
| 4 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 5 | bcftools mpileup | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_mpileup/bcftools_mpileup/1.15.1+galaxy3 |  |
| 6 | VarDict | toolshed.g2.bx.psu.edu/repos/iuc/vardict_java/vardict_java/1.8.3+galaxy1 |  |
| 7 | Samtools depth | toolshed.g2.bx.psu.edu/repos/iuc/samtools_depth/samtools_depth/1.15.1+galaxy2 |  |
| 8 | bcftools call | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_call/bcftools_call/1.15.1+galaxy3 |  |
| 9 | vvv2_display: Display SNP proportions and CDS of an assembly in png image | toolshed.g2.bx.psu.edu/repos/ftouzain/vvv2_display/vvv2_display/0.2.4.0 | - png image of variants - tsv file of variants info |
| 10 | bcftools consensus | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_consensus/bcftools_consensus/1.15.1+galaxy3 |  |
| 11 | bcftools consensus | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_consensus/bcftools_consensus/1.15.1+galaxy3 | Gives consensus with major nucleotides only |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 9 | tsv file of information for significant variants | snp_loc_summary |
| 9 | image of all variants, genes, proteins and coverage depth | snp_img |
| 10 | IUPAC_consensus | output_file |
| 11 | Majority_consensus | output_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2.ga -o job.yml`
- Lint: `planemo workflow_lint 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
