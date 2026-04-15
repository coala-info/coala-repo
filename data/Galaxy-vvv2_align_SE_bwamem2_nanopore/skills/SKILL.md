---
name: vvv2_align_se_bwamem2_nanopore
description: This viral genomics workflow processes Nanopore single-end reads using BWA-MEM2 for alignment, VADR for annotation, and VarDict for variant calling to generate consensus sequences and visual summaries. Use this skill when you need to characterize viral genetic diversity, identify significant mutations in Nanopore sequencing data, and produce annotated visualizations of variant proportions alongside genomic features.
homepage: https://www.anses.fr
metadata:
  docker_image: "N/A"
---

# vvv2_align_se_bwamem2_nanopore

## Overview

This Galaxy workflow is designed for viral variant calling and annotation using Nanopore single-end sequencing data. It begins with sequence preprocessing and quality control using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0), followed by viral structural annotation through [VADR](https://toolshed.g2.bx.psu.edu/repos/ftouzain/vadr/vadr/0.2.0) to define coding sequences and features.

The core analysis involves aligning reads to a reference genome using [BWA-MEM2](https://toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1). After removing duplicates and calculating coverage with [Samtools](https://toolshed.g2.bx.psu.edu/repos/iuc/samtools_depth/samtools_depth/1.15.1+galaxy2), the workflow identifies genetic variations using the [VarDict](https://toolshed.g2.bx.psu.edu/repos/iuc/vardict_java/vardict_java/1.8.3+galaxy1) variant caller and [bcftools](https://toolshed.g2.bx.psu.edu/repos/iuc/bcftools_call/bcftools_call/1.15.1+galaxy3).

The final stage focuses on visualization and consensus generation. The [vvv2_display](https://toolshed.g2.bx.psu.edu/repos/ftouzain/vvv2_display/vvv2_display/0.2.4.0) tool produces a PNG image that maps SNP proportions against gene annotations and coverage depths. Primary outputs include a TSV file of significant variants and two consensus sequences (IUPAC and Majority) generated via [bcftools consensus](https://toolshed.g2.bx.psu.edu/repos/iuc/bcftools_consensus/bcftools_consensus/1.15.1+galaxy3).

## Inputs and data preparation

_None listed._


To prepare your data for this Nanopore-focused workflow, ensure your primary inputs are in fastq.gz format for sequencing reads and FASTA format for the viral reference genome. Using a dataset collection for multiple Nanopore runs is highly recommended to streamline the BWA-MEM2 alignment and subsequent VarDict variant calling steps. Always consult the README.md for specific VADR model selection criteria and parameter tuning for the vvv2_display tool. For automated testing or command-line execution, you can initialize a job template using `planemo workflow_job_init`. Refer to the accompanying documentation for detailed guidance on interpreting the final PNG visualization and significant variant TSV.

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
planemo run 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2_nanopore.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2_nanopore.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2_nanopore.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2_nanopore.ga -o job.yml`
- Lint: `planemo workflow_lint 20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2_nanopore.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `20250619_Galaxy-Workflow-vvv2_align_SE_bwamem2_nanopore.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)