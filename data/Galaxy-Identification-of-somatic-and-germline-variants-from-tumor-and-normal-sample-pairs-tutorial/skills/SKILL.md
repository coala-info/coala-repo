---
name: identification-of-somatic-and-germline-variants-from-tumor-a
description: This cancer genomics workflow processes paired tumor and normal FASTQ samples using BWA-MEM for alignment, VarScan for somatic variant calling, and GEMINI for functional annotation against clinical databases. Use this skill when you need to distinguish between inherited germline mutations and acquired somatic variants in cancer research to identify potential therapeutic targets or driver mutations.
homepage: https://training.galaxyproject.org
metadata:
  docker_image: "N/A"
---

# identification-of-somatic-and-germline-variants-from-tumor-a

## Overview

This workflow provides a comprehensive pipeline for identifying and distinguishing between somatic and germline variants using paired tumor and normal samples. It processes paired-end FASTQ sequencing data against a reference genome, incorporating clinical and biological metadata from sources such as dbSNP, CIVic, and UniProt Cancer Genes to facilitate prioritized variant discovery.

The initial stages focus on data quality and alignment. Raw reads undergo quality control via [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and [MultiQC](https://multiqc.info/), followed by adapter trimming with [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic). Reads are then mapped using [BWA-MEM](http://bio-bwa.sourceforge.net/), with subsequent processing steps including duplicate removal, coordinate realignment, and MD tag calculation to ensure high-quality alignments for variant calling.

Variant detection is performed using [VarScan somatic](http://varscan.sourceforge.net/), which is specifically designed to compare tumor and normal BAM files to identify somatic mutations, germline variants, and areas of loss of heterozygosity (LOH). These variants are functionally annotated with [SnpEff](https://pcingola.github.io/SnpEff/) to predict their biological impact on protein-coding sequences.

In the final phase, the annotated variants are loaded into a [GEMINI](https://gemini.readthedocs.io/en/latest/) database for sophisticated genomic exploration. The workflow annotates the data with known hotspots and clinical databases before performing targeted queries. The process culminates in a consolidated gene report that joins variant calls with gene summaries and cancer-specific metadata for downstream clinical interpretation.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | SLGFSK-N_231335_r1_chr5_12_17.fastq | data_input |  |
| 1 | SLGFSK-N_231335_r2_chr5_12_17.fastq | data_input |  |
| 2 | SLGFSK-T_231336_r1_chr5_12_17.fastq | data_input |  |
| 3 | SLGFSK-T_231336_r2_chr5_12_17.fastq | data_input |  |
| 4 | hg19.chr5_12_17.fa | data_input |  |
| 5 | hotspots.bed | data_input |  |
| 6 | cgi_variant_positions.bed | data_input |  |
| 7 | 01-Feb-2019-CIVic.bed | data_input |  |
| 8 | dbsnp.b147.chr5_12_17.vcf.gz | data_input |  |
| 9 | Uniprot_Cancer_Genes.13Feb2019.txt | data_input |  |
| 10 | cgi_genes.txt | data_input |  |
| 11 | 01-Feb-2019-GeneSummaries.tsv | data_input |  |


To prepare for this somatic and germline variant analysis, ensure your paired-end tumor and normal sequencing data are in FASTQ format, while reference genomes and annotation files should be provided as FASTA, BED, VCF, and TSV/TXT files. Organizing your raw reads into paired-end dataset collections can significantly streamline the initial mapping and filtering steps across multiple samples. For automated environment setup and job configuration, you can use `planemo workflow_job_init` to generate a `job.yml` file. Detailed instructions on specific parameter settings and data organization are available in the README.md. Always verify that your BED and VCF files use the same chromosome naming convention as your reference FASTA to avoid tool errors during variant calling and annotation.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 12 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 13 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 14 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.36.5 |  |
| 15 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 16 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 17 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.36.5 |  |
| 18 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 19 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 20 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 21 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.8+galaxy0 |  |
| 22 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 23 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 24 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 25 | Filter | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.4.1 |  |
| 26 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.8+galaxy0 |  |
| 27 | Filter | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.4.1 |  |
| 28 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 29 | RmDup | toolshed.g2.bx.psu.edu/repos/devteam/samtools_rmdup/samtools_rmdup/2.0.1 |  |
| 30 | BamLeftAlign | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/bamleftalign/1.3.1 |  |
| 31 | BamLeftAlign | toolshed.g2.bx.psu.edu/repos/devteam/freebayes/bamleftalign/1.3.1 |  |
| 32 | CalMD | toolshed.g2.bx.psu.edu/repos/devteam/samtools_calmd/samtools_calmd/2.0.2 |  |
| 33 | CalMD | toolshed.g2.bx.psu.edu/repos/devteam/samtools_calmd/samtools_calmd/2.0.2 |  |
| 34 | Filter | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.4.1 |  |
| 35 | Filter | toolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/2.4.1 |  |
| 36 | VarScan somatic | toolshed.g2.bx.psu.edu/repos/iuc/varscan_somatic/varscan_somatic/2.4.3.6 |  |
| 37 | SnpEff eff: | toolshed.g2.bx.psu.edu/repos/iuc/snpeff/snpEff/4.3+T.galaxy1 |  |
| 38 | GEMINI load | toolshed.g2.bx.psu.edu/repos/iuc/gemini_load/gemini_load/0.20.1+galaxy2 |  |
| 39 | GEMINI annotate | toolshed.g2.bx.psu.edu/repos/iuc/gemini_annotate/gemini_annotate/0.20.1+galaxy2 |  |
| 40 | GEMINI annotate | toolshed.g2.bx.psu.edu/repos/iuc/gemini_annotate/gemini_annotate/0.20.1+galaxy2 |  |
| 41 | GEMINI annotate | toolshed.g2.bx.psu.edu/repos/iuc/gemini_annotate/gemini_annotate/0.20.1+galaxy2 |  |
| 42 | GEMINI annotate | toolshed.g2.bx.psu.edu/repos/iuc/gemini_annotate/gemini_annotate/0.20.1+galaxy2 |  |
| 43 | GEMINI annotate | toolshed.g2.bx.psu.edu/repos/iuc/gemini_annotate/gemini_annotate/0.20.1+galaxy2 |  |
| 44 | GEMINI query | toolshed.g2.bx.psu.edu/repos/iuc/gemini_query/gemini_query/0.20.1+galaxy1 |  |
| 45 | GEMINI query | toolshed.g2.bx.psu.edu/repos/iuc/gemini_query/gemini_query/0.20.1+galaxy1 |  |
| 46 | GEMINI query | toolshed.g2.bx.psu.edu/repos/iuc/gemini_query/gemini_query/0.20.1+galaxy1 |  |
| 47 | GEMINI query | toolshed.g2.bx.psu.edu/repos/iuc/gemini_query/gemini_query/0.20.1+galaxy1 |  |
| 48 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.1 |  |
| 49 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.1 |  |
| 50 | Join | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_easyjoin_tool/1.1.1 |  |
| 51 | Column arrange | toolshed.g2.bx.psu.edu/repos/bgruening/column_arrange_by_header/bg_column_arrange_by_header/0.2 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 51 | gene_report_output | output |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run somatic-variants-tutorial-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run somatic-variants-tutorial-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run somatic-variants-tutorial-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init somatic-variants-tutorial-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint somatic-variants-tutorial-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `somatic-variants-tutorial-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)