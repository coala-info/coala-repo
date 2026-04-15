---
name: 2-plant-virus-confirmation
description: This plant virology workflow processes paired-end FASTQ reads using Minimap2 for mapping, Shovill for de novo assembly, and NCBI BLAST+ for sequence identification. Use this skill when you need to validate a preliminary taxonomic classification of a plant virus by assembling mapped reads into contigs and identifying the closest genomic matches.
homepage: https://www.gembloux.ulg.ac.be/phytopathologie/
metadata:
  docker_image: "N/A"
---

# 2-plant-virus-confirmation

## Overview

This workflow is designed to confirm plant virus predictions initially made by taxonomic classifiers like Kraken. It validates the presence of viral sequences by mapping raw sequencing reads against a reference, assembling those reads into contigs, and performing a final sequence similarity search to identify the closest known viral relatives.

The process begins by merging and filtering reference sequences to create a clean target for alignment. Input paired-end reads (Data_R1 and Data_R2) are mapped using [minimap2](https://toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy2), followed by rigorous BAM filtering and quality assessment via Samtools. This ensures that only high-confidence mapped reads are carried forward for downstream analysis.

In the final stages, the filtered reads are converted back to FASTQ format and processed by [Shovill](https://toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy0) for de novo assembly. The resulting contigs are then analyzed using [NCBI BLAST+ blastn](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy0) to provide definitive taxonomic confirmation and identify specific viral strains.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 1 | Data_R1.fastq | data_input |  |
| 2 | Data_R2.fastq | data_input |  |


For this workflow, ensure your input sequencing data is in FASTQ format (R1 and R2) and your reference sequences are provided as a FASTA file. If processing multiple samples, organizing your reads into paired-end data collections will significantly streamline the mapping and assembly steps. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and testing. Refer to the `README.md` for comprehensive details on parameter tuning for Shovill and BLAST+ settings. Always verify that your reference FASTA contains unique sequence headers to avoid errors during the merging and filtering stage.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 | Merge several fasta in a multi-fasta file to be use as reference for mapping. WARNING: If two fasta with the same header are provided only one will be kept |
| 3 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy2 | Map the input reads against the chosen reference fasta file. Multiple mapping The correct placement of a read may be ambiguous, e.g. due to repeats. In this case, there may be multiple read alignments for the same read. One of these alignments is considered primary. All the other alignments have the secondary alignment flag set in the SAM records that represent them. All the SAM records have the same QNAME and the same values for 0x40 and 0x80 flags. Typically the alignment designated primary is the best alignment, but the decision may be arbitrary. |
| 4 | BAM filter | toolshed.g2.bx.psu.edu/repos/iuc/ngsutils_bam_filter/ngsutils_bam_filter/0.5.9 | Keep only mapped read to perform faster assembly later. |
| 5 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 | Obtain stats on the bam file |
| 6 | SamToFastq | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_SamToFastq/2.18.2.2 | Extract read from bam as fastq sequence. Remove secondary alignement reads (that are mapped several time) |
| 7 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy0 | Make contig out of candidate read. |
| 8 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy0 | Blast contig against precise database to find closest reference |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | reference_fasta | output |
| 3 | Read_mapping_alignement | alignment_output |
| 4 | mapped_read | outfile |
| 6 | Paired-end forward | fq1 |
| 6 | Paired-end reverse | fq2 |
| 7 | Contigs | contigs |
| 7 | Log file | shovill_std_log |
| 8 | blastn result | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-2__Plant_virus_confirmation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-2__Plant_virus_confirmation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-2__Plant_virus_confirmation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-2__Plant_virus_confirmation.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-2__Plant_virus_confirmation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-2__Plant_virus_confirmation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)