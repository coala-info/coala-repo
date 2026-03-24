---
name: vvv2_align_pe_bwamem2
description: "This viral genomics workflow processes paired-end sequencing reads through fastp, BWA-MEM2, VADR, and VarDict to perform alignment, annotation, and variant calling. Use this skill when you need to identify significant mutations in viral genomes, generate consensus sequences, and visualize the spatial relationship between variants, gene annotations, and coverage depth."
homepage: https://workflowhub.eu/workflows/1738
---

# vvv2_align_PE_bwamem2

## Overview

This Galaxy workflow performs comprehensive viral sequence analysis, focusing on paired-end read alignment, variant calling, and visualization. It begins by preprocessing raw reads with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0) and formatting the reference FASTA. The core alignment is handled by [BWA-MEM2](https://toolshed.g2.bx.psu.edu/repos/iuc/bwa_mem2/bwa_mem2/2.2.1+galaxy1), followed by duplicate removal and depth calculation using Samtools.

The pipeline integrates [VADR](https://toolshed.g2.bx.psu.edu/repos/ftouzain/vadr/vadr/0.2.0) for viral annotation and utilizes [VarDict](https://toolshed.g2.bx.psu.edu/repos/iuc/vardict_java/vardict_java/1.8.3+galaxy1) alongside BCFTools for robust variant calling. These steps allow for the generation of both IUPAC and Majority consensus sequences, ensuring a detailed representation of the viral population.

The final stage employs [vvv2_display](https://toolshed.g2.bx.psu.edu/repos/ftouzain/vvv2_display/vvv2_display/0.2.4.0) to produce high-quality summary outputs. These include a PNG image visualizing variant calling, gene/protein annotations, and coverage depths, as well as a TSV file containing detailed information on significant variants. This workflow is licensed under GPL-3.0-or-later and is tagged for virus research and variant calling.

## Inputs and data preparation

_None listed._


Ensure your input reference is in FASTA format and sequencing reads are provided as paired-end FASTQ files. Organizing your reads into a paired dataset collection is highly recommended to streamline processing through fastp and BWA-MEM2. Refer to the README.md for specific guidance on selecting the correct VADR model and adjusting VarDict thresholds for your viral samples. You may use `planemo workflow_job_init` to generate a `job.yml` template for configuring these parameters.

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
| 9 | image of all variants, genes, proteins and coverage depth | snp_img |
| 9 | tsv file of information for significant variants | snp_loc_summary |
| 10 | IUPAC_consensus | output_file |
| 11 | Majority_consensus | output_file |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run 20250619_Galaxy-Workflow-vvv2_align_PE_bwamem2.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run 20250619_Galaxy-Workflow-vvv2_align_PE_bwamem2.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run 20250619_Galaxy-Workflow-vvv2_align_PE_bwamem2.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init 20250619_Galaxy-Workflow-vvv2_align_PE_bwamem2.ga -o job.yml`
- Lint: `planemo workflow_lint 20250619_Galaxy-Workflow-vvv2_align_PE_bwamem2.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `20250619_Galaxy-Workflow-vvv2_align_PE_bwamem2.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
