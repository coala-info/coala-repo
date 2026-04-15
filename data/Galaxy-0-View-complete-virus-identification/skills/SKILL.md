---
name: 0-view-complete-virus-identification
description: This workflow performs comprehensive viral identification from sequencing reads using fastp for preprocessing, Kraken2 and Krona for taxonomic classification, and Shovill for assembly followed by BLAST and HMMER validation. Use this skill when you need to detect, assemble, and characterize known or novel viruses within complex metagenomic samples or clinical isolates.
homepage: https://www.gembloux.ulg.ac.be/phytopathologie/
metadata:
  docker_image: "N/A"
---

# 0-view-complete-virus-identification

## Overview

This Galaxy workflow provides a comprehensive pipeline for virus identification and exploration from raw sequencing data. It begins with rigorous preprocessing using [fastp](https://toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.20.1+galaxy0) for quality control and [FLASH](https://toolshed.g2.bx.psu.edu/repos/iuc/flash/flash/1.2.11.4) for merging paired-end reads. These cleaned reads are then processed through [Kraken2](https://toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy0) to perform taxonomic classification, which is visualized using [Krona pie charts](https://toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0).

To further characterize the viral content, the workflow employs [Shovill](https://toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy0) for de novo assembly of reads into contigs. These contigs and filtered sequences undergo extensive sequence homology searches using [NCBI BLAST+ blastn](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy0), [tblastx](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_tblastx_wrapper/2.10.1+galaxy0), and protein domain identification via [hmmscan](https://toolshed.g2.bx.psu.edu/repos/iuc/hmmer_hmmscan/hmmer_hmmscan/3.3+galaxy1).

The pipeline also includes mapping steps using [minimap2](https://toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy2) and [BAM filtering](https://toolshed.g2.bx.psu.edu/repos/iuc/ngsutils_bam_filter/ngsutils_bam_filter/0.5.9) to refine the alignment of reads against reference sequences. By combining taxonomic binning, assembly, and multi-layered sequence alignment, the workflow ensures a high-confidence view of the viral community within a sample.

## Inputs and data preparation

_None listed._


To ensure optimal performance, provide high-quality sequencing data in fastq or fastqsanger format, ideally organized as paired-end collections to streamline processing through fastp and Shovill. You should verify that your reference databases for Kraken2, BLAST, and HMMER are correctly indexed and accessible within your Galaxy environment before execution. For automated execution and parameter reproducibility, consider using `planemo workflow_job_init` to generate a `job.yml` file. Detailed configuration settings for each tool step and specific database requirements are documented in the accompanying README.md. Always check that your input read headers are compatible with FLASH and minimap2 to avoid mapping errors.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 0 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/0.20.1+galaxy0 |  |
| 1 | FLASH | toolshed.g2.bx.psu.edu/repos/iuc/flash/flash/1.2.11.4 |  |
| 2 | Kraken2 | toolshed.g2.bx.psu.edu/repos/iuc/kraken2/kraken2/2.1.1+galaxy0 |  |
| 3 | FASTA Merge Files and Filter Unique Sequences | toolshed.g2.bx.psu.edu/repos/galaxyp/fasta_merge_files_and_filter_unique_sequences/fasta_merge_files_and_filter_unique_sequences/1.2.0 |  |
| 4 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy2 |  |
| 5 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy0 |  |
| 6 | NCBI BLAST+ tblastx | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_tblastx_wrapper/2.10.1+galaxy0 |  |
| 7 | hmmscan | toolshed.g2.bx.psu.edu/repos/iuc/hmmer_hmmscan/hmmer_hmmscan/3.3+galaxy1 |  |
| 8 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy0 |  |
| 9 | Convert Kraken | toolshed.g2.bx.psu.edu/repos/devteam/kraken2tax/Kraken2Tax/1.2 |  |
| 10 | Map with minimap2 | toolshed.g2.bx.psu.edu/repos/iuc/minimap2/minimap2/2.17+galaxy2 |  |
| 11 | Krona pie chart | toolshed.g2.bx.psu.edu/repos/crs4/taxonomy_krona_chart/taxonomy_krona_chart/2.7.1+galaxy0 |  |
| 12 | BAM filter | toolshed.g2.bx.psu.edu/repos/iuc/ngsutils_bam_filter/ngsutils_bam_filter/0.5.9 |  |
| 13 | BAM filter | toolshed.g2.bx.psu.edu/repos/iuc/ngsutils_bam_filter/ngsutils_bam_filter/0.5.9 |  |
| 14 | SamToFastq | toolshed.g2.bx.psu.edu/repos/devteam/picard/picard_SamToFastq/2.18.2.2 |  |
| 15 | Shovill | toolshed.g2.bx.psu.edu/repos/iuc/shovill/shovill/1.1.0+galaxy0 |  |
| 16 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.10.1+galaxy0 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 0 | fastp on input dataset(s): Read 1 output | out1 |
| 0 | out2 | out2 |
| 0 | fastp on input dataset(s): HTML report | report_html |
| 1 | FLASH on input dataset(s): Raw Log | log |
| 1 | FLASH on input dataset(s): Merged reads | merged_paired_reads |
| 2 | Kraken2 on input dataset(s): Classification | output |
| 3 | Merged and Filtered FASTA from input dataset(s) | output |
| 4 | Map with minimap2 on input dataset(s) (mapped reads in BAM format) | alignment_output |
| 5 | output1 | output1 |
| 6 | output1 | output1 |
| 7 | HMMSCAN on input dataset(s): per-sequence/per-domain hits from HMM matches | pfamtblout |
| 7 | HMMSCAN on input dataset(s): per-domain hits from HMM matches | domtblout |
| 7 | HMMSCAN on input dataset(s): per-sequence hits from HMM matches | tblout |
| 7 | HMMSCAN on input dataset(s) | output |
| 8 | Shovill on input dataset(s) Log file | shovill_std_log |
| 8 | Shovill on input dataset(s): Contigs | contigs |
| 9 | out_file | out_file |
| 10 | Map with minimap2 on input dataset(s) (mapped reads in BAM format) | alignment_output |
| 11 | Krona pie chart on input dataset(s): HTML | output |
| 12 | outfile | outfile |
| 13 | outfile | outfile |
| 14 | Paired-end forward strand from SamToFastq on input dataset(s) | fq1 |
| 14 | Paired-end reverse strand from SamToFastq on input dataset(s) | fq2 |
| 15 | Shovill on input dataset(s) Log file | shovill_std_log |
| 15 | Shovill on input dataset(s): Contigs | contigs |
| 16 | output1 | output1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-0__View_complete_virus_identification.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-0__View_complete_virus_identification.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-0__View_complete_virus_identification.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-0__View_complete_virus_identification.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-0__View_complete_virus_identification.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-0__View_complete_virus_identification.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)