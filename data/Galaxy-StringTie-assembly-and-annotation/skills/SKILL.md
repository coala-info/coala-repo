---
name: covid-19-stringtie-assembly-and-annotation
description: This workflow performs transcript assembly and functional annotation for SARS-CoV-2 using Illumina sequencing accessions and reference data through tools including StringTie, HISAT2, and TransDecoder. Use this skill when you need to characterize the viral transcriptome, identify novel isoforms, or predict protein-coding regions and gene clusters from COVID-19 genomic data.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-stringtie-assembly-and-annotation

## Overview

This Galaxy workflow provides a comprehensive pipeline for the assembly and functional annotation of SARS-CoV-2 transcriptomes from Illumina sequencing data. It begins by retrieving raw reads via [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4) and performing essential preprocessing, including adapter trimming and quality filtering with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1). Quality metrics are aggregated using [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7) to ensure data viability.

The core analysis involves mapping processed reads to a reference genome using [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1) and [HISAT2](https://toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.1.0+galaxy5). Following alignment, [StringTie](https://toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.1.1) is used to assemble transcripts and estimate abundance, while a merging step consolidates multiple assemblies into a single, non-redundant set of gene structures.

The final stage focuses on structural and functional annotation of the assembled sequences. The workflow utilizes [TransDecoder](https://toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/3.0.1) and [Glimmer3](https://toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_knowlegde-based/0.2) to identify candidate coding regions and open reading frames. These predictions are further characterized through [NCBI BLAST+](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3) searches against UniProt and SARS-CoV-2 protein databases, alongside [Antismash](https://toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/4.1) for identifying specialized genomic clusters.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | List of Illumina accessions | data_input |  |
| 1 | Reference genome | data_input |  |
| 2 | Reference genome annotation | data_input |  |
| 4 | SARS-CoV-2 proteins | data_input |  |


Ensure your input list of Illumina accessions is formatted as a text collection to facilitate automated downloading via SRA tools. The reference genome and its corresponding annotation should be provided in FASTA and GTF/GFF3 formats, respectively, to ensure compatibility with HISAT2 and StringTie. For large-scale processing, organize your raw sequence data into paired-end collections to streamline the fastp and mapping stages. Refer to the README.md for comprehensive details on parameter tuning and data preparation. You can use `planemo workflow_job_init` to generate a `job.yml` file for managing these inputs efficiently.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | UniProt | toolshed.g2.bx.psu.edu/repos/galaxyp/uniprotxml_downloader/uniprotxml_downloader/2.1.0 |  |
| 5 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4 |  |
| 6 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 7 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 8 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 9 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 10 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 11 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 12 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 13 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.1.0+galaxy5 |  |
| 14 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.1.1 |  |
| 15 | StringTie merge | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie_merge/2.1.1 |  |
| 16 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.2 |  |
| 17 | Glimmer ICM builder | toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_build-icm/0.2 |  |
| 18 | Antismash | toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/4.1 |  |
| 19 | TransDecoder | toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/3.0.1 |  |
| 20 | Glimmer3 | toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_knowlegde-based/0.2 |  |
| 21 | jackhmmer | toolshed.g2.bx.psu.edu/repos/iuc/hmmer3/hmmer_jackhmmer/0.1.0 |  |
| 22 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 23 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |
| 24 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |
| 25 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | fasta | proteome |
| 5 | list_paired | list_paired |
| 5 | log | log |
| 6 | outfile | outfile |
| 7 | outfile | outfile |
| 8 | output_paired_coll | output_paired_coll |
| 8 | report_html | report_html |
| 9 | stats | stats |
| 9 | html_report | html_report |
| 10 | bam_output | bam_output |
| 11 | output1 | output1 |
| 12 | forward | forward |
| 12 | reverse | reverse |
| 13 | output_alignments | output_alignments |
| 14 | output_gtf | output_gtf |
| 14 | transcript_counts | transcript_counts |
| 14 | gene_counts | gene_counts |
| 14 | coverage | coverage |
| 15 | out_gtf | out_gtf |
| 16 | output_exons | output_exons |
| 17 | outfile | outfile |
| 18 | genbank | genbank |
| 18 | embl | embl |
| 18 | html | html |
| 18 | genecluster_tabular | genecluster_tabular |
| 18 | archive | archive |
| 19 | transdecoder_pep | transdecoder_pep |
| 19 | transdecoder_bed | transdecoder_bed |
| 19 | transdecoder_cds | transdecoder_cds |
| 19 | transdecoder_gff3 | transdecoder_gff3 |
| 20 | report_output | report_output |
| 20 | genes_output | genes_output |
| 20 | detailed_output | detailed_output |
| 21 | output | output |
| 21 | tblout | tblout |
| 21 | domtblout | domtblout |
| 22 | outfile | outfile |
| 23 | output1 | output1 |
| 24 | output1 | output1 |
| 25 | output1 | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run StringTie_assembly_and_annotation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run StringTie_assembly_and_annotation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run StringTie_assembly_and_annotation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init StringTie_assembly_and_annotation.ga -o job.yml`
- Lint: `planemo workflow_lint StringTie_assembly_and_annotation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `StringTie_assembly_and_annotation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)