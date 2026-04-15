---
name: vvv2_align_se
description: This workflow processes single-end viral sequencing data and a ploidy file to perform reference-based alignment, variant calling, and genome annotation using tools like BWA-MEM, bcftools, VarDict, and VADR. Use this skill when you need to generate consensus sequences, identify haploid mutations, and visualize SNP distributions for viral pathogens.
homepage: https://www.anses.fr
metadata:
  docker_image: "N/A"
---

# vvv2_align_se

## Overview

This Galaxy workflow is designed for the high-throughput analysis of single-end viral sequencing data. It performs comprehensive processing including quality control with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0), reference mapping via [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.12.1), and variant calling using [VarDict](https://toolshed.g2.bx.psu.edu/repos/iuc/vardict_java/vardict_java/1.8.3+galaxy1) and [bcftools](https://toolshed.g2.bx.psu.edu/repos/iuc/bcftools_call/bcftools_call/1.4.0). The pipeline generates consensus sequences, coverage depth reports, and detailed mutation explanations.

A critical requirement for this workflow is the manual import of a **Ploidy file** (typically "Y" for haploid) from the "Données partagées" (Shared Data) section into your active history. This file must be provided to the `bcftools call` step to ensure correct haploid variant calling. Additionally, users must select the most appropriate [VADR](https://toolshed.g2.bx.psu.edu/repos/ftouzain/vadr/vadr/0.1.1) model parameters to ensure accurate viral annotation and feature identification.

The workflow provides several visualization and summary outputs, including SNP proportion displays and CDS assembly images via [vvv2_display](https://toolshed.g2.bx.psu.edu/repos/ftouzain/vvv2_display/vvv2_display/0.1.10). Final outputs include passed/failed annotations, variant call files (VCF), and converted consensus sequences in FASTA format, making it a robust tool for viral surveillance and genomic characterization.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 2 | Ploidy file (Y for happloid) | data_input |  |


Ensure your input history contains single-end FASTQ files and the mandatory haploid ploidy file, which must be imported from "Shared Data" to enable correct consensus calling. When configuring the workflow, select the VADR model most appropriate for your specific viral target to ensure accurate annotation. You can manage large batches of samples efficiently by using dataset collections for the sequencing data. For automated execution and parameter mapping, consider using `planemo workflow_job_init` to generate a `job.yml` file. Refer to the `README.md` for comprehensive details on tool parameters and specific file requirements.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | FASTA Width | toolshed.g2.bx.psu.edu/repos/devteam/fasta_formatter/cshl_fasta_formatter/1.0.1 |  |
| 1 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0 |  |
| 3 | VADR - Viral Annotation DefineR | toolshed.g2.bx.psu.edu/repos/ftouzain/vadr/vadr/0.1.1 |  |
| 4 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.12.1 |  |
| 5 | bcftools mpileup | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_mpileup/bcftools_mpileup/1.4.0.0 |  |
| 6 | VarDict | toolshed.g2.bx.psu.edu/repos/iuc/vardict_java/vardict_java/1.8.3+galaxy1 |  |
| 7 | bcftools call | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_call/bcftools_call/1.4.0 |  |
| 8 | vvv2_display: Display SNP proportions and CDS of an assembly in png image | toolshed.g2.bx.psu.edu/repos/ftouzain/vvv2_display/vvv2_display/0.1.10 |  |
| 9 | vcfutils_vcf2fq: convert vcf file to fastq file | toolshed.g2.bx.psu.edu/repos/ftouzain/vcfutils_vcf2fq/vcfutils_vcf2fq/1.16 |  |
| 10 | seqtk_seq | toolshed.g2.bx.psu.edu/repos/iuc/seqtk/seqtk_seq/1.3.3 | fastq2fasta conversion |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | output | output |
| 3 | seqstat | seqstat |
| 3 | pass_annotation | pass_annotation |
| 3 | fail_annotation | fail_annotation |
| 6 | passed_variants | passed_variants |
| 6 | all_variants | all_variants |
| 8 | snp_img | snp_img |
| 8 | snp_loc_summary | snp_loc_summary |
| 9 | fastq_f | fastq_f |
| 10 | default | default |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 20231016_Galaxy-Workflow-VVV2_align_SE.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 20231016_Galaxy-Workflow-VVV2_align_SE.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 20231016_Galaxy-Workflow-VVV2_align_SE.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 20231016_Galaxy-Workflow-VVV2_align_SE.ga -o job.yml`
- Lint: `planemo workflow_lint 20231016_Galaxy-Workflow-VVV2_align_SE.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `20231016_Galaxy-Workflow-VVV2_align_SE.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)