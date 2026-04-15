---
name: covid-19-assembly-using-tophat2-and-annotation
description: This workflow performs transcriptomic assembly and functional annotation of COVID-19 samples using Illumina accessions, reference genomes, and protein databases via TopHat2, Cufflinks, and TransDecoder. Use this skill when you need to reconstruct viral transcripts from raw sequencing reads, quantify gene expression, and identify protein-coding regions or secondary metabolite clusters in SARS-CoV-2 datasets.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-assembly-using-tophat2-and-annotation

## Overview

This Galaxy workflow provides a comprehensive pipeline for the assembly and functional annotation of SARS-CoV-2 genomic data. It begins by retrieving raw sequencing data from NCBI using [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4) and performing essential quality control and preprocessing with [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1) and [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7). Initial read mapping is performed via [BWA-MEM](https://toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1) to filter and organize the data for assembly.

The core of the analysis utilizes the Tuxedo suite for transcript reconstruction and quantification. Reads are aligned using [TopHat2](https://toolshed.g2.bx.psu.edu/repos/devteam/tophat2/tophat2/2.1.1), followed by transcript assembly with [Cufflinks](https://toolshed.g2.bx.psu.edu/repos/devteam/cufflinks/cufflinks/2.2.1.2). The workflow then merges these assemblies and calculates differential expression and isoform abundance using [Cuffmerge](https://toolshed.g2.bx.psu.edu/repos/devteam/cuffmerge/cuffmerge/2.2.1.1) and [Cuffdiff](https://toolshed.g2.bx.psu.edu/repos/devteam/cuffdiff/cuffdiff/2.2.1.5).

For downstream annotation, the pipeline identifies coding regions and gene structures using [TransDecoder](https://toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/3.0.1) and [Glimmer3](https://toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_knowlegde-based/0.2). These predicted sequences are characterized through [NCBI BLAST+](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3) and [jackhmmer](https://toolshed.g2.bx.psu.edu/repos/iuc/hmmer3/hmmer_jackhmmer/0.1.0) searches against protein databases. Finally, [AntiSMASH](https://toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/4.1) is employed to identify potential secondary metabolite biosynthesis gene clusters.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | List of Illumina accessions | data_input |  |
| 1 | Reference genome. | data_input |  |
| 2 | Reference annotation | data_input |  |
| 4 | SARS-CoV-2 proteins | data_input |  |


Ensure the reference genome and protein sequences are in FASTA format, while the reference annotation should be provided as a GTF or GFF3 file. The workflow is designed to process a list of Illumina accessions, which are converted into a paired-end dataset collection for efficient batch analysis through tools like fastp and TopHat2. For comprehensive details on parameter configurations and specific data source requirements, please refer to the accompanying README.md. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | UniProt | toolshed.g2.bx.psu.edu/repos/galaxyp/uniprotxml_downloader/uniprotxml_downloader/2.1.0 |  |
| 5 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4 |  |
| 6 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 7 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 8 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 9 | Map with BWA-MEM | toolshed.g2.bx.psu.edu/repos/devteam/bwa/bwa_mem/0.7.17.1 |  |
| 10 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 11 | Filter SAM or BAM, output SAM or BAM | toolshed.g2.bx.psu.edu/repos/devteam/samtool_filter2/samtool_filter2/1.8+galaxy1 |  |
| 12 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.9+galaxy1 |  |
| 13 | TopHat | toolshed.g2.bx.psu.edu/repos/devteam/tophat2/tophat2/2.1.1 |  |
| 14 | Cufflinks | toolshed.g2.bx.psu.edu/repos/devteam/cufflinks/cufflinks/2.2.1.2 |  |
| 15 | Cuffmerge | toolshed.g2.bx.psu.edu/repos/devteam/cuffmerge/cuffmerge/2.2.1.1 |  |
| 16 | Cuffquant | toolshed.g2.bx.psu.edu/repos/devteam/cuffquant/cuffquant/2.2.1.1 |  |
| 17 | Cuffdiff | toolshed.g2.bx.psu.edu/repos/devteam/cuffdiff/cuffdiff/2.2.1.5 |  |
| 18 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.2 |  |
| 19 | TransDecoder | toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/3.0.1 |  |
| 20 | Antismash | toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/4.1 |  |
| 21 | Glimmer ICM builder | toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_build-icm/0.2 |  |
| 22 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 23 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |
| 24 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |
| 25 | jackhmmer | toolshed.g2.bx.psu.edu/repos/iuc/hmmer3/hmmer_jackhmmer/0.1.0 |  |
| 26 | Glimmer3 | toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_knowlegde-based/0.2 |  |
| 27 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 3 | proteome | proteome |
| 5 | list_paired | list_paired |
| 5 | log | log |
| 6 | outfile | outfile |
| 7 | outfile | outfile |
| 8 | output_paired_coll | output_paired_coll |
| 8 | report_html | report_html |
| 9 | bam_output | bam_output |
| 10 | stats | stats |
| 10 | html_report | html_report |
| 11 | output1 | output1 |
| 12 | fastq | forward |
| 12 | fast | reverse |
| 13 | deletions | deletions |
| 13 | align_summary | align_summary |
| 13 | insertions | insertions |
| 13 | accepted_hits | accepted_hits |
| 13 | junctions | junctions |
| 14 | skipped | skipped |
| 14 | genes_expression | genes_expression |
| 14 | transcripts_expression | transcripts_expression |
| 14 | assembled_isoforms | assembled_isoforms |
| 14 | total_map_mass | total_map_mass |
| 15 | merged_transcripts | merged_transcripts |
| 16 | out_file | out_file |
| 17 | cds_exp_fpkm_tracking | cds_exp_fpkm_tracking |
| 17 | tss_groups_exp | tss_groups_exp |
| 17 | genes_fpkm_tracking | genes_fpkm_tracking |
| 17 | isoforms_exp | isoforms_exp |
| 17 | cds_diff | cds_diff |
| 17 | tss_groups_fpkm_tracking | tss_groups_fpkm_tracking |
| 17 | promoters_diff | promoters_diff |
| 17 | isoforms_fpkm_tracking | isoforms_fpkm_tracking |
| 17 | splicing_diff | splicing_diff |
| 17 | cds_fpkm_tracking | cds_fpkm_tracking |
| 17 | genes_exp | genes_exp |
| 18 | fasta | output_exons |
| 19 | transdecoder_pep | transdecoder_pep |
| 19 | transdecoder_bed | transdecoder_bed |
| 19 | transdecoder_cds | transdecoder_cds |
| 19 | transdecoder_gff3 | transdecoder_gff3 |
| 20 | html | html |
| 20 | genbank | genbank |
| 20 | embl | embl |
| 20 | archive | archive |
| 20 | genecluster_tabular | genecluster_tabular |
| 21 | outfile | outfile |
| 22 | outfile | outfile |
| 23 | output1 | output1 |
| 24 | output1 | output1 |
| 25 | output | output |
| 25 | tblout | tblout |
| 25 | domtblout | domtblout |
| 26 | genes_output | genes_output |
| 26 | report_output | report_output |
| 26 | detailed_output | detailed_output |
| 27 | output1 | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Tophat2_and_annotation.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Tophat2_and_annotation.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Tophat2_and_annotation.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Tophat2_and_annotation.ga -o job.yml`
- Lint: `planemo workflow_lint Tophat2_and_annotation.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Tophat2_and_annotation.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)