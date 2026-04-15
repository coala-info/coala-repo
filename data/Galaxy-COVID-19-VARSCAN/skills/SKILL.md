---
name: covid-19-varscan
description: This Galaxy workflow automates the identification and annotation of SARS-CoV-2 genomic variants from Illumina sequencing accessions using BWA-MEM, VarScan, and SnpEff. Use this skill when you need to detect low-frequency mutations and assess the functional impact of variants within viral populations to support COVID-19 epidemiological surveillance.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-varscan

## Overview

This Galaxy workflow is designed for the identification and functional annotation of genomic variants in SARS-CoV-2 samples using Illumina sequencing data. It automates the process of retrieving raw reads from the Sequence Read Archive (SRA) via [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4), followed by rigorous quality control and adapter trimming using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1) and [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7).

Processed reads are aligned to a reference genome using [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1) and [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0). The workflow then employs [Samtools](https://toolshed.g2.bx.psu.edu/repos/devteam/samtools_sort/samtools_sort/2.0.3) to filter, sort, and generate mpileup files, which provide the necessary depth and base-call information for variant detection.

Variant calling is executed through [VarScan mpileup](https://toolshed.g2.bx.psu.edu/repos/iuc/varscan_mpileup/varscan_mpileup/2.4.3.1), targeting single nucleotide polymorphisms (SNPs) and indels. The resulting VCF files are refined with [VcfAllelicPrimitives](https://toolshed.g2.bx.psu.edu/repos/devteam/vcfallelicprimitives/vcfallelicprimitives/1.0.0_rc3+galaxy0) and annotated for biological impact using [SnpEff](https://toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1). Finally, [SnpSift](https://toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0) extracts key data fields into a consolidated format for final analysis.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | List of Illumina accessions | data_input |  |
| 1 | Reference genome | data_input |  |
| 2 | Reference genome annotation | data_input | COVID-19 |


Ensure the reference genome is provided in FASTA format and the annotation file is in a compatible format like GenBank for the SnpEff build step. The workflow is designed to handle a list of Illumina accessions as a text file, which it then uses to fetch and organize data into paired-end collections for downstream processing. For comprehensive details on parameter configurations and specific data requirements, please refer to the README.md. You can also use `planemo workflow_job_init` to create a `job.yml` file for streamlining the input mapping process.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4 |  |
| 4 | SnpEff build: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff_build_gb/4.3+T.galaxy4 |  |
| 5 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 6 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 7 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 8 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 9 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 10 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.3.4.3+galaxy0 |  |
| 11 | Samtools sort | toolshed.g2.bx.psu.edu/repos/devteam/samtools_sort/samtools_sort/2.0.3 |  |
| 12 | samtools mpileup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_mpileup/samtools_mpileup/2.1.4 |  |
| 13 | VarScan mpileup | toolshed.g2.bx.psu.edu/repos/iuc/varscan_mpileup/varscan_mpileup/2.4.3.1 |  |
| 14 | VarScan mpileup | toolshed.g2.bx.psu.edu/repos/iuc/varscan_mpileup/varscan_mpileup/2.4.3.1 |  |
| 15 | VcfAllelicPrimitives: | toolshed.g2.bx.psu.edu/repos/devteam/vcfallelicprimitives/vcfallelicprimitives/1.0.0_rc3+galaxy0 |  |
| 16 | VcfAllelicPrimitives: | toolshed.g2.bx.psu.edu/repos/devteam/vcfallelicprimitives/vcfallelicprimitives/1.0.0_rc3+galaxy0 |  |
| 17 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1 |  |
| 18 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1 |  |
| 19 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 20 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 21 | Concatenate datasets | cat1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | list_paired | list_paired |
| 3 | log | log |
| 4 | snpeff_output | snpeff_output |
| 5 | output_paired_coll | output_paired_coll |
| 5 | report_html | report_html |
| 6 | stats | stats |
| 6 | html_report | html_report |
| 7 | bam_output | bam_output |
| 8 | output1 | output1 |
| 9 | forward | forward |
| 9 | reverse | reverse |
| 10 | output | output |
| 10 | mapping_stats | mapping_stats |
| 11 | output1 | output1 |
| 12 | output_file_pu | output_file_pu |
| 13 | output | output |
| 14 | output | output |
| 15 | out_file1 | out_file1 |
| 16 | out_file1 | out_file1 |
| 17 | snpeff_output | snpeff_output |
| 17 | statsFile | statsFile |
| 18 | snpeff_output | snpeff_output |
| 18 | statsFile | statsFile |
| 19 | output | output |
| 20 | output | output |
| 21 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run VARSCAN.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run VARSCAN.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run VARSCAN.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init VARSCAN.ga -o job.yml`
- Lint: `planemo workflow_lint VARSCAN.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `VARSCAN.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)