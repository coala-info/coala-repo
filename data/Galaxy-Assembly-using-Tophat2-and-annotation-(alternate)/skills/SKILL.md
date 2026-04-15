---
name: covid-19-assembly-using-tophat2-and-annotation-alternate
description: This viral genomics workflow performs transcript assembly and functional annotation from Illumina reads using TopHat2, Cufflinks, TransDecoder, and BLAST+ against a SARS-CoV-2 reference. Use this skill when you need to characterize the transcriptomic landscape of COVID-19 samples and identify protein-coding regions or secondary metabolite clusters within the viral genome.
homepage: https://github.com/galaxyproject/SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# covid-19-assembly-using-tophat2-and-annotation-alternate

## Overview

This workflow provides an end-to-end pipeline for the assembly and functional annotation of SARS-CoV-2 genomes using Illumina sequencing data. It begins by retrieving raw reads from the SRA via [fasterq-dump](https://toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4) and performing essential quality control and preprocessing using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1) and [MultiQC](https://toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7).

The core assembly process utilizes [TopHat2](https://toolshed.g2.bx.psu.edu/repos/devteam/tophat2/tophat2/2.1.1) for splice-aware alignment against a reference genome. Following alignment, the workflow employs the Cufflinks suite—including [Cufflinks](https://toolshed.g2.bx.psu.edu/repos/devteam/cufflinks/cufflinks/2.2.1.2) and [Cuffmerge](https://toolshed.g2.bx.psu.edu/repos/devteam/cuffmerge/cuffmerge/2.2.1.1)—to reconstruct transcripts and merge them into a unified set of assembled isoforms.

For downstream annotation, the pipeline integrates several specialized tools to identify coding sequences and functional features. [TransDecoder](https://toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/3.0.1) identifies candidate coding regions, while [Glimmer3](https://toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_knowlegde-based/0.2) provides knowledge-based gene predictions. These predictions are further characterized through [NCBI BLAST+](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3) searches against UniProt databases and [antiSMASH](https://toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/4.1) for identifying gene clusters and secondary metabolites.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | List of Illumina accessions | data_input |  |
| 1 | Reference genome. | data_input |  |
| 2 | Reference annotation | data_input |  |
| 4 | SARS-CoV-2 proteins | data_input |  |


To ensure successful execution, provide the Illumina accessions as a list or collection to facilitate automated retrieval via fasterq-dump, while the reference genome and proteins should be in FASTA format and the annotation in GFF3 or GTF. Using a dataset collection for the accessions allows the workflow to scale efficiently across multiple samples during the TopHat2 alignment and Cufflinks assembly stages. For automated job configuration and parameter mapping, you can use `planemo workflow_job_init` to generate a template `job.yml` file. Detailed specifications regarding specific tool versions and parameter settings are available in the accompanying README.md. Always verify that your reference files are properly indexed or formatted as required by the NCBI BLAST+ and Glimmer steps.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 3 | UniProt | toolshed.g2.bx.psu.edu/repos/galaxyp/uniprotxml_downloader/uniprotxml_downloader/2.1.0 |  |
| 5 | Faster Download and Extract Reads in FASTQ | toolshed.g2.bx.psu.edu/repos/iuc/sra_tools/fasterq_dump/2.10.4 |  |
| 6 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 7 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 8 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.19.5+galaxy1 |  |
| 9 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.7 |  |
| 10 | TopHat | toolshed.g2.bx.psu.edu/repos/devteam/tophat2/tophat2/2.1.1 |  |
| 11 | Cufflinks | toolshed.g2.bx.psu.edu/repos/devteam/cufflinks/cufflinks/2.2.1.2 |  |
| 12 | Cuffmerge | toolshed.g2.bx.psu.edu/repos/devteam/cuffmerge/cuffmerge/2.2.1.1 |  |
| 13 | gffread | toolshed.g2.bx.psu.edu/repos/devteam/gffread/gffread/2.2.1.2 |  |
| 14 | TransDecoder | toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/3.0.1 |  |
| 15 | Antismash | toolshed.g2.bx.psu.edu/repos/bgruening/antismash/antismash/4.1 |  |
| 16 | Glimmer ICM builder | toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_build-icm/0.2 |  |
| 17 | jackhmmer | toolshed.g2.bx.psu.edu/repos/iuc/hmmer3/hmmer_jackhmmer/0.1.0 |  |
| 18 | NCBI BLAST+ makeblastdb | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_makeblastdb/0.3.3 |  |
| 19 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |
| 20 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |
| 21 | Glimmer3 | toolshed.g2.bx.psu.edu/repos/bgruening/glimmer3/glimmer_knowlegde-based/0.2 |  |
| 22 | NCBI BLAST+ blastp | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastp_wrapper/0.3.3 |  |


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
| 9 | stats | stats |
| 9 | html_report | html_report |
| 10 | deletions | deletions |
| 10 | align_summary | align_summary |
| 10 | insertions | insertions |
| 10 | accepted_hits | accepted_hits |
| 10 | junctions | junctions |
| 11 | skipped | skipped |
| 11 | transcripts_expression | transcripts_expression |
| 11 | assembled_isoforms | assembled_isoforms |
| 11 | genes_expression | genes_expression |
| 11 | total_map_mass | total_map_mass |
| 12 | merged_transcripts | merged_transcripts |
| 13 | fasta | output_exons |
| 14 | transdecoder_pep | transdecoder_pep |
| 14 | transdecoder_bed | transdecoder_bed |
| 14 | transdecoder_cds | transdecoder_cds |
| 14 | transdecoder_gff3 | transdecoder_gff3 |
| 15 | genbank | genbank |
| 15 | html | html |
| 15 | embl | embl |
| 15 | archive | archive |
| 15 | genecluster_tabular | genecluster_tabular |
| 16 | outfile | outfile |
| 17 | output | output |
| 17 | tblout | tblout |
| 17 | domtblout | domtblout |
| 18 | outfile | outfile |
| 19 | output1 | output1 |
| 20 | output1 | output1 |
| 21 | genes_output | genes_output |
| 21 | report_output | report_output |
| 21 | detailed_output | detailed_output |
| 22 | output1 | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Tophat2_and_annotation_(alternate).ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Tophat2_and_annotation_(alternate).ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Tophat2_and_annotation_(alternate).ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Tophat2_and_annotation_(alternate).ga -o job.yml`
- Lint: `planemo workflow_lint Tophat2_and_annotation_(alternate).ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Tophat2_and_annotation_(alternate).ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)