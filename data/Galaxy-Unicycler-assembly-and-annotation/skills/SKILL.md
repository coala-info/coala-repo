---
name: covid-19-unicycler-assembly-and-annotation
description: This workflow performs de novo assembly and functional annotation of SARS-CoV-2 genomes from Illumina sequencing accessions using Unicycler, Glimmer3, and BLAST+. Use this skill when you need to reconstruct complete viral genomes from raw reads and identify protein-coding sequences or secondary metabolite clusters to characterize novel COVID-19 variants.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-unicycler-assembly-and-annotation

## Overview

This Galaxy workflow provides a comprehensive pipeline for the de novo assembly and functional annotation of SARS-CoV-2 genomes from Illumina sequencing data. It begins by retrieving raw reads from the SRA using [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4) and performing quality control and adapter trimming with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1). To ensure high-quality input for the assembly, reads are mapped to a reference using [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1) and filtered to isolate relevant viral sequences.

The core assembly is performed by [Unicycler](https://toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.8.0), which generates a de novo consensus sequence and an assembly graph. Following assembly, the workflow executes an extensive annotation suite. It utilizes [Glimmer3](https://toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_knowlegde-based/0.2) for gene prediction and [TransDecoder](https://toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/3.0.1) to identify candidate coding regions.

Functional characterization is achieved through multiple alignment and search strategies. The pipeline integrates [NCBI BLAST+](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3) to compare predicted proteins against SARS-CoV-2 and UniProt databases, while [antiSMASH](https://toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/4.1) is used to identify secondary metabolite gene clusters. The final outputs include the assembled genome, annotated GenBank/EMBL files, and detailed protein homology reports.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | List of Illumina accessions | data_input |  |
| 1 | SARS-CoV-2 proteins | data_input |  |


Provide a text file containing Illumina SRA accessions and a FASTA file of reference SARS-CoV-2 proteins to initiate the assembly and annotation process. Ensure the accession list is formatted correctly to allow the SRA tools to generate paired-end collections for downstream processing in fastp and Unicycler. Consult the README.md for specific parameter configurations and detailed data preparation requirements. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and reproducible input mapping.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | UniProt | toolshed.g2.bx.psu.edu/repos/galaxyp/uniprotxml_downloader/uniprotxml_downloader/2.1.0 |  |
| 3 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4 |  |
| 4 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 5 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 6 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 7 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 8 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 9 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 10 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 11 | MergeSamFiles | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_MergeSamFiles/2.18.2.1 |  |
| 12 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 13 | Create assemblies with Unicycler | toolshed.g2.bx.psu.edu/repos/iuc/unicycler/unicycler/0.4.8.0 |  |
| 14 | Glimmer ICM builder | toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_build-icm/0.2 |  |
| 15 | Antismash | toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/4.1 |  |
| 16 | TransDecoder | toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/3.0.1 |  |
| 17 | Glimmer3 | toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_knowlegde-based/0.2 |  |
| 18 | jackhmmer | toolshed.g2.bx.psu.edu/repos/iuc/hmmer3/hmmer_jackhmmer/0.1.0 |  |
| 19 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 20 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |
| 21 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |
| 22 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 2 | proteome | proteome |
| 3 | list_paired | list_paired |
| 3 | log | log |
| 4 | outfile | outfile |
| 5 | outfile | outfile |
| 6 | output_paired_coll | output_paired_coll |
| 6 | report_html | report_html |
| 7 | bam_output | bam_output |
| 8 | stats | stats |
| 8 | html_report | html_report |
| 9 | output1 | output1 |
| 10 | fastq | forward |
| 10 | fast | reverse |
| 11 | outFile | outFile |
| 12 | forward | forward |
| 12 | reverse | reverse |
| 13 | assembly | assembly |
| 13 | assembly_graph | assembly_graph |
| 14 | outfile | outfile |
| 15 | genbank | genbank |
| 15 | html | html |
| 15 | embl | embl |
| 15 | archive | archive |
| 15 | genecluster_tabular | genecluster_tabular |
| 16 | transdecoder_pep | transdecoder_pep |
| 16 | transdecoder_bed | transdecoder_bed |
| 16 | transdecoder_cds | transdecoder_cds |
| 16 | transdecoder_gff3 | transdecoder_gff3 |
| 17 | genes_output | genes_output |
| 18 | output | output |
| 18 | tblout | tblout |
| 18 | domtblout | domtblout |
| 19 | outfile | outfile |
| 20 | output1 | output1 |
| 21 | output1 | output1 |
| 22 | output1 | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Unicycler_assembly_and_annotation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Unicycler_assembly_and_annotation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Unicycler_assembly_and_annotation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Unicycler_assembly_and_annotation.ga -o job.yml`
- Lint: `planemo workflow_lint Unicycler_assembly_and_annotation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Unicycler_assembly_and_annotation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)