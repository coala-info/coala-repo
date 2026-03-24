---
name: paired-end-variant-calling-in-haploid-system
description: "This workflow processes paired-end whole genome sequencing data from haploid organisms using fastp, BWA-MEM, and LoFreq to identify and annotate SNPs and small indels against a reference genome and GTF file. Use this skill when you need to characterize genetic variation and functional effects in haploid genomes such as those found in eukaryotic parasites, fungi, or bacteria."
homepage: https://workflowhub.eu/workflows/1190
---

# Paired end variant calling in haploid system

## Overview

This workflow is designed for variant analysis in haploid systems using whole genome sequencing (WGS) paired-end data. It identifies single nucleotide polymorphisms (SNPs) and small indels across multiple genomic sequences, such as contigs or chromosomes. The process requires three primary inputs: a paired-end FASTQ collection, a genome reference in FASTA format, and a corresponding GTF annotation file.

The pipeline begins with quality control and adapter trimming using [fastp](https://github.com/OpenGene/fastp), followed by read mapping with [BWA-MEM](https://github.com/lh3/bwa). To ensure high-quality calls, the workflow filters for properly aligned mate pairs, removes PCR duplicates via Picard, and performs local realignment using [LoFreq](https://csb5.github.io/lofreq/). Variants are then called and annotated using [SnpEff](https://pcingola.github.io/SnpEff/) and [SnpSift](https://pcingola.github.io/SnpEff/ss_introduction/), which integrate the provided GTF data to determine functional impacts.

Key outputs include a comprehensive tab-delimited summary of annotated variants and a [MultiQC](https://multiqc.info/) report aggregating preprocessing and mapping statistics. This generic toolset is released under the MIT license and is particularly useful for [VeuPath](https://veupathdb.org/veupathdb/app) organisms or other haploid research contexts requiring a robust, automated variant calling pipeline.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Paired Collection | data_collection_input | Illumina reads with fastqsanger encoding |
| 1 | Annotation GTF | data_input | GTF with gene annotation, will be used for annotating variants |
| 2 | Genome fasta | data_input | Fasta file to use as reference for variant calling |


Ensure your input reads are organized as a Paired Collection of FASTQ files, while the reference genome must be provided in FASTA format alongside a matching GTF annotation file. For optimal results, verify that the sequence identifiers in your FASTA file strictly match those used in the GTF and GenBank-sourced annotations. Detailed configuration steps and file specifications are available in the README.md. You can streamline the execution process by using `planemo workflow_job_init` to generate a `job.yml` template for your input parameters.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.23.2+galaxy0 |  |
| 4 | SnpEff build: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff_build_gb/4.3+T.galaxy6 |  |
| 5 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.2 |  |
| 6 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.13+galaxy1 | Retains alignments if read is paired and mapped in proper orientation |
| 7 | Samtools stats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_stats/samtools_stats/2.0.2+galaxy2 |  |
| 8 | MarkDuplicates | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MarkDuplicates/2.18.2.2 |  |
| 9 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.11+galaxy0 |  |
| 10 | Realign reads | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_viterbi/lofreq_viterbi/2.1.5+galaxy0 |  |
| 11 | Call variants | toolshed.g2.bx.psu.edu/repos/iuc/lofreq_call/lofreq_call/2.1.5+galaxy3 |  |
| 12 | Text reformatting | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_awk_tool/9.3+galaxy1 |  |
| 13 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy2 |  |
| 14 | SnpSift Extract Fields | toolshed.g2.bx.psu.edu/repos/iuc/snpsift/snpSift_extractFields/4.3+t.galaxy0 |  |
| 15 | Collapse Collection | toolshed.g2.bx.psu.edu/repos/nml/collapse_collections/collapse_dataset/5.1.0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | fastp html report | report_html |
| 4 | SnpEff4.3 database | snpeff_output |
| 9 | Preprocessing and mapping reports | html_report |
| 13 | SnpEff variants | snpeff_output |
| 13 | SnpEff eff reports | statsFile |
| 15 | Annotated Variants | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run WGS-PE-variant-calling-in-haploid-system.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run WGS-PE-variant-calling-in-haploid-system.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run WGS-PE-variant-calling-in-haploid-system.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init WGS-PE-variant-calling-in-haploid-system.ga -o job.yml`
- Lint: `planemo workflow_lint WGS-PE-variant-calling-in-haploid-system.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `WGS-PE-variant-calling-in-haploid-system.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
