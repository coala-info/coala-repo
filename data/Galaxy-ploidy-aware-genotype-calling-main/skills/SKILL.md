---
name: paired-end-variant-and-ploidy-aware-genotype-calling
description: This workflow processes paired-end Illumina reads through quality control, BWA-MEM mapping, and FreeBayes variant calling to generate annotated VCF and TSV files for organisms of any specified ploidy. Use this skill when you need to identify germline variants and functional effects in non-diploid or diploid genomes using a reference FASTA and GTF annotation.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# paired-end-variant-and-ploidy-aware-genotype-calling

## Overview

This Galaxy workflow provides an end-to-end pipeline for germline variant and genotype calling using paired-end Illumina sequencing data. It is designed to be ploidy-aware, allowing users to specify the organism's ploidy (e.g., diploid, polyploid) for accurate calling. The process begins with raw FASTQ reads, performing quality control and adapter trimming via [fastp](https://github.com/OpenGene/fastp), followed by read mapping to a reference genome using [BWA-MEM](https://github.com/lh3/bwa).

To ensure high-quality results, the workflow filters for properly paired reads with [Samtools](https://www.htslib.org/) and removes PCR duplicates using [Picard MarkDuplicates](https://broadinstitute.github.io/picard/). Comprehensive quality metrics from these steps are aggregated into a single [MultiQC](https://multiqc.info/) report. Variant calling is then executed by [FreeBayes](https://github.com/freebayes/freebayes), which utilizes a haplotype-based approach tailored to the user-defined ploidy level.

The final stage focuses on normalization and functional annotation. Raw variants are normalized and left-aligned with [bcftools](https://samtools.github.io/bcftools/), then annotated using [SnpEff](https://pcingola.github.io/SnpEff/) based on a custom database built on-the-fly from provided FASTA and GTF files. The workflow outputs include annotated VCF files, detailed HTML summary reports, and a merged TSV table containing extracted fields such as gene names, functional impacts, and amino acid changes.

This workflow is released under the [MIT](https://opensource.org/licenses/MIT) license and is tagged for use with **VeuPath**, **Diploid**, and **FreeBayes** applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Paired Collection | data_collection_input | Illumina reads with fastqsanger encoding |
| 1 | Reference Genome fasta | data_input | Reference FASTA file to use as reference for variant calling |
| 2 | Set Ploidy for FreeBayes Variant Calling | parameter_input | This step sets ploidy for FreeBayes Variant Caller |
| 3 | Annotation GTF | data_input | GTF with gene annotation, will be used for annotating variants |


Ensure your input reads are organized as a `list:paired` collection of fastqsanger or fastqsanger.gz files to enable batch processing. You must provide a reference genome in FASTA format and a matching GTF annotation file, which the workflow uses to build a custom SnpEff database on-the-fly. Remember to manually set the ploidy parameter to match your organism's biology before execution to ensure accurate FreeBayes genotype calling. For comprehensive details on file formatting and specific tool parameters, refer to the README.md. You can also use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 4 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.1.0+galaxy0 | Processing of FASTQ files |
| 5 | SnpEff build: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff_build_gb/5.2+galaxy1 | Build SnpEff database from the given reference fasta file |
| 6 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.19 | Mapping reads with reference sequence |
| 7 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.22+galaxy1 | Retains alignments if read is paired and mapped in proper orientation |
| 8 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.8 | Generates statistics of BAM file |
| 9 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/3.1.1.0 | Marks duplicates in the input BAM file |
| 10 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0 | Aggregation of results from mapping, and other preprocessing steps |
| 11 | FreeBayes | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/freebayes/1.3.10+galaxy1 | Variant detection |
| 12 | bcftools norm | toolshed.g2.bx.psu.edu/repos/iuc/bcftools_norm/bcftools_norm/1.22+galaxy0 | Processes output data from FreeBayes variant caller |
| 13 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/5.2+galaxy1 | Annotates detected variants |
| 14 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 | Extracts required fields from the VCF file |
| 15 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 | Collapse multiple datasets into a single dataset |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 4 | fastp HTML report | report_html |
| 10 | Preprocessing and mapping reports | html_report |
| 11 | output_vcf | output_vcf |
| 13 | SnpEff eff reports | statsFile |
| 13 | SnpEff variants | snpeff_output |
| 15 | Annotated Variants | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run genotype-variant-calling-wgs-pe.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run genotype-variant-calling-wgs-pe.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run genotype-variant-calling-wgs-pe.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init genotype-variant-calling-wgs-pe.ga -o job.yml`
- Lint: `planemo workflow_lint genotype-variant-calling-wgs-pe.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `genotype-variant-calling-wgs-pe.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)