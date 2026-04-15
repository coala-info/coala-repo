---
name: covid-19-gatk4
description: This workflow downloads Illumina sequencing data and utilizes BWA-MEM, Picard, and GATK4 Mutect2 to perform high-sensitivity variant calling and SnpEff annotation for COVID-19 genomic analysis. Use this skill when you need to identify low-frequency mutations or characterize the genetic diversity of SARS-CoV-2 samples from public repositories or clinical datasets.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-gatk4

## Overview

This Galaxy workflow provides a comprehensive pipeline for identifying genomic variants in COVID-19 samples using the GATK4 framework. It begins by retrieving raw Illumina sequencing data via [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4) and performing essential quality control and preprocessing with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1) and [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7).

The core analysis involves mapping reads to a reference genome using [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1) and [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0). The resulting alignments are processed through a rigorous Picard suite pipeline, including [AddOrReplaceReadGroups](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_AddOrReplaceReadGroups/2.18.2.1), [SortSam](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_SortSam/2.18.2.1), and [MarkDuplicates](https://toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2) to ensure data integrity for variant calling.

Variant detection is performed using [GATK4 Mutect2](https://toolshed.g2.bx.psu.edu/repos/iuc/gatk4_mutect2/gatk4_mutect2/4.1.4.0+galaxy2), followed by allelic simplification with [VcfAllelicPrimitives](https://toolshed.g2.bx.psu.edu/repos/devteam/vcfallelicprimitives/vcfallelicprimitives/1.0.0_rc3+galaxy0). Finally, the workflow builds a custom genomic database to annotate variants using [SnpEff](https://toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1) and extracts specific data fields via [SnpSift](https://toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0) for downstream interpretation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | List of Illumina accessions | data_input |  |
| 1 | Refrence genome | data_input |  |
| 2 | Reference genome annotation | data_input | COVID-19.gff |


Ensure the reference genome is provided in FASTA format and the annotation file as a GFF3 or GTF to support SnpEff database building and variant effect prediction. The workflow processes a text file containing a list of Illumina accessions to automatically download and organize paired-end reads into a dataset collection for batch processing. Verify that the reference sequence identifiers match across all input files to prevent errors during the GATK4 Mutect2 and Picard processing stages. For comprehensive details on parameter configurations and specific reference requirements, refer to the README.md file. You may use `planemo workflow_job_init` to create a `job.yml` for streamlined input management and reproducible execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4 |  |
| 4 | SnpEff build: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff_build_gb/4.3+T.galaxy4 |  |
| 5 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 6 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 7 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 8 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 9 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 10 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 11 | AddOrReplaceReadGroups | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_AddOrReplaceReadGroups/2.18.2.1 |  |
| 12 | SortSam | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_SortSam/2.18.2.1 |  |
| 13 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2 |  |
| 14 | GATK4 Mutect2 | toolshed.g2.bx.psu.edu/repos/iuc/gatk4_mutect2/gatk4_mutect2/4.1.4.0+galaxy2 |  |
| 15 | VcfAllelicPrimitives: | toolshed.g2.bx.psu.edu/repos/devteam/vcfallelicprimitives/vcfallelicprimitives/1.0.0_rc3+galaxy0 |  |
| 16 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1 | Annotate variants. |
| 17 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 18 | Concatenate datasets | cat1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | list_paired | list_paired |
| 3 | log | log |
| 4 | snpeff_output | snpeff_output |
| 5 | output_paired_coll | output_paired_coll |
| 5 | report_html | report_html |
| 6 | bam_output | bam_output |
| 7 | stats | stats |
| 7 | html_report | html_report |
| 8 | output1 | output1 |
| 9 | forward | forward |
| 9 | reverse | reverse |
| 10 | output | output |
| 10 | mapping_stats | mapping_stats |
| 11 | outFile | outFile |
| 12 | outFile | outFile |
| 13 | outFile | outFile |
| 13 | metrics_file | metrics_file |
| 14 | VCF | output_vcf |
| 15 | out_file1 | out_file1 |
| 16 | snpeff_output | snpeff_output |
| 16 | statsFile | statsFile |
| 17 | output | output |
| 18 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run GATK4.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run GATK4.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run GATK4.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init GATK4.ga -o job.yml`
- Lint: `planemo workflow_lint GATK4.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `GATK4.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)