---
name: de-novo
description: "This workflow performs de novo assembly of Illumina amplicon pool sequencing data using PEAR for merging, MEGAHIT for assembly, and CAP3 for contig refinement. Use this skill when you need to reconstruct consensus sequences from pooled amplicons without a reference genome to identify genetic variants or characterize unknown sequences."
homepage: https://workflowhub.eu/workflows/2038
---

# De novo

## Overview

This workflow is designed for the *de novo* assembly and analysis of amplicon pool sequencing data, specifically for cases where a reference sequence is unavailable. It processes paired-end Illumina FASTQ files, utilizing user-defined parameters for size filtering and primer sequences to ensure high-quality input for the assembly process.

The pipeline begins with quality control using [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1), followed by read merging with [Pear](https://toolshed.g2.bx.psu.edu/repos/iuc/pear/iuc_pear/0.9.6.4) and adapter/primer trimming via [Cutadapt](https://toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.1+galaxy0). Initial assembly is performed by [MEGAHIT](https://toolshed.g2.bx.psu.edu/repos/iuc/megahit/megahit/1.2.9+galaxy2), with subsequent contig refinement and joining handled by [CAP3](https://toolshed.g2.bx.psu.edu/repos/artbio/cap3/cap3/2.0.0) to generate robust consensus sequences.

Downstream analysis includes sequence identification through [NCBI BLAST+](https://toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.16.0+galaxy0) and validation by mapping reads back to the assembly using [Bowtie2](https://toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0). The workflow produces comprehensive outputs, including consensus contigs, [SeqKit](https://toolshed.g2.bx.psu.edu/repos/iuc/seqkit_stats/seqkit_stats/2.10.1+galaxy0) statistics, and interactive visualizations via [JBrowse2](https://toolshed.g2.bx.psu.edu/repos/fubar/jbrowse2/jbrowse2/3.6.5+galaxy0).

This tool is released under the MIT license and is tagged for `de_novo`, `pool_amplicon`, and `illumina` sequencing applications.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | FASTQ - Forward | data_input | Enter the bank containing the forward reads. |
| 1 | FASTQ - Reverse | data_input | Enter the bank containing the reverse reads. |
| 2 | Filter FASTQ - Minimum size | parameter_input | Minimum reads filtering size.  Leave 0 if no filtering. |
| 3 | Filter FASTQ - Maximum size | parameter_input | Maximum reads filtering size.  Leave 0 if no filtering. |
| 4 | Is your primer used more than once? | parameter_input |  |
| 5 | Forward primer | parameter_input | Enter your forward primer in capital letters. |
| 6 | Reverse primer | parameter_input | Enter your reverse primer in capital letters. |


This workflow requires paired-end Illumina reads in FASTQ format as the primary data inputs, alongside specific primer sequences and size filtering parameters. While inputs are defined as individual datasets, you can use dataset collections to manage multiple amplicon pools efficiently within your Galaxy history. Please refer to the `README.md` for comprehensive details on parameter configuration and expected primer formats. You can use `planemo workflow_job_init` to generate a `job.yml` file for automated execution and structured parameter management.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 7 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.5+galaxy2 |  |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 9 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 10 | Pear | toolshed.g2.bx.psu.edu/repos/iuc/pear/iuc_pear/0.9.6.4 |  |
| 11 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.5+galaxy2 |  |
| 12 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.5+galaxy2 |  |
| 13 | Create text file | toolshed.g2.bx.psu.edu/repos/bgruening/text_processing/tp_text_file_with_recurring_lines/9.5+galaxy2 |  |
| 14 | Filter FASTQ | toolshed.g2.bx.psu.edu/repos/devteam/fastq_filter/fastq_filter/1.1.5+galaxy2 |  |
| 15 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 16 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 17 | Regex Find And Replace | toolshed.g2.bx.psu.edu/repos/galaxyp/regex_find_replace/regex1/1.0.3 |  |
| 18 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.74+galaxy1 |  |
| 19 | MEGAHIT | toolshed.g2.bx.psu.edu/repos/iuc/megahit/megahit/1.2.9+galaxy2 |  |
| 20 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.1+galaxy0 |  |
| 21 | FASTQ to FASTA | toolshed.g2.bx.psu.edu/repos/devteam/fastq_to_fasta/cshl_fastq_to_fasta/1.0.2+galaxy2 |  |
| 22 | Chop.seqs | toolshed.g2.bx.psu.edu/repos/iuc/mothur_chop_seqs/mothur_chop_seqs/1.39.5.0 |  |
| 23 | cap3 | toolshed.g2.bx.psu.edu/repos/artbio/cap3/cap3/2.0.0 |  |
| 24 | FASTA Width | toolshed.g2.bx.psu.edu/repos/devteam/fasta_formatter/cshl_fasta_formatter/1.0.1+galaxy2 |  |
| 25 | Select first | Show beginning1 |  |
| 26 | Select first | Show beginning1 |  |
| 27 | Select last | Show tail1 |  |
| 28 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.16.0+galaxy0 |  |
| 29 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 30 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 31 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 32 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.21+galaxy0 |  |
| 33 | NCBI BLAST+ blastn | toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.16.0+galaxy0 |  |
| 34 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 35 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.21+galaxy0 |  |
| 36 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 37 | Concatenate datasets | cat1 |  |
| 38 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.21+galaxy0 |  |
| 39 | cap3 | toolshed.g2.bx.psu.edu/repos/artbio/cap3/cap3/2.0.0 |  |
| 40 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 41 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.1+galaxy0 |  |
| 42 | Samtools fastx | toolshed.g2.bx.psu.edu/repos/iuc/samtools_fastx/samtools_fastx/1.21+galaxy0 |  |
| 43 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 44 | SeqKit statistics | toolshed.g2.bx.psu.edu/repos/iuc/seqkit_stats/seqkit_stats/2.10.1+galaxy0 |  |
| 45 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 46 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 47 | Select last | Show tail1 |  |
| 48 | Concatenate datasets | cat1 |  |
| 49 | JBrowse2 | toolshed.g2.bx.psu.edu/repos/fubar/jbrowse2/jbrowse2/3.6.5+galaxy0 |  |
| 50 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.21+galaxy0 |  |
| 51 | Cut | Cut1 |  |
| 52 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 53 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.7 |  |
| 54 | Samtools depth | toolshed.g2.bx.psu.edu/repos/iuc/samtools_depth/samtools_depth/1.21+galaxy0 |  |
| 55 | cap3 | toolshed.g2.bx.psu.edu/repos/artbio/cap3/cap3/2.0.0 |  |
| 56 | Add line to file | toolshed.g2.bx.psu.edu/repos/bgruening/add_line_to_file/add_line_to_file/0.1.0 |  |
| 57 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.9+galaxy0 |  |
| 58 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 59 | Select first | Show beginning1 |  |
| 60 | Paste | Paste1 |  |
| 61 | Cutadapt | toolshed.g2.bx.psu.edu/repos/lparsons/cutadapt/cutadapt/5.1+galaxy0 |  |
| 62 | Cut | Cut1 |  |
| 63 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 64 | Paste | Paste1 |  |
| 65 | Bowtie2 | toolshed.g2.bx.psu.edu/repos/devteam/bowtie2/bowtie2/2.5.4+galaxy0 |  |
| 66 | SeqKit statistics | toolshed.g2.bx.psu.edu/repos/iuc/seqkit_stats/seqkit_stats/2.10.1+galaxy0 |  |
| 67 | table rename column | toolshed.g2.bx.psu.edu/repos/recetox/table_pandas_rename_column/table_pandas_rename_column/2.2.3+galaxy0 |  |
| 68 | JBrowse2 | toolshed.g2.bx.psu.edu/repos/fubar/jbrowse2/jbrowse2/3.6.5+galaxy0 |  |
| 69 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 70 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 71 | Paste | Paste1 |  |
| 72 | Samtools view | toolshed.g2.bx.psu.edu/repos/iuc/samtools_view/samtools_view/1.21+galaxy0 |  |
| 73 | Select last | Show tail1 |  |
| 74 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 75 | Samtools depth | toolshed.g2.bx.psu.edu/repos/iuc/samtools_depth/samtools_depth/1.21+galaxy0 |  |
| 76 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 77 | Samtools idxstats | toolshed.g2.bx.psu.edu/repos/devteam/samtools_idxstats/samtools_idxstats/2.0.7 |  |
| 78 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 79 | Cut | Cut1 |  |
| 80 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 81 | Datamash | toolshed.g2.bx.psu.edu/repos/iuc/datamash_ops/datamash_ops/1.9+galaxy0 |  |
| 82 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 83 | Add line to file | toolshed.g2.bx.psu.edu/repos/bgruening/add_line_to_file/add_line_to_file/0.1.0 |  |
| 84 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 85 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 86 | Paste | Paste1 |  |
| 87 | Select first | Show beginning1 |  |
| 88 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 89 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 90 | Cut | Cut1 |  |
| 91 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 92 | Paste | Paste1 |  |
| 93 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 94 | table rename column | toolshed.g2.bx.psu.edu/repos/recetox/table_pandas_rename_column/table_pandas_rename_column/2.2.3+galaxy0 |  |
| 95 | Pick parameter value | toolshed.g2.bx.psu.edu/repos/iuc/pick_value/pick_value/0.2.0 |  |
| 96 | Paste | Paste1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 8 | forward_qc | html_file |
| 9 | reverse_qc | html_file |
| 18 | paired_qc | html_file |
| 26 | contig1 | out_file1 |
| 27 | contig2 | out_file1 |
| 28 | blastn1 | output1 |
| 33 | blastn2 | output1 |
| 41 | consensus_contig1 | out1 |
| 49 | browser1 | output |
| 61 | consensus_contig2 | out1 |
| 68 | browser2 | output |
| 71 | metadata1 | out_file1 |
| 96 | metadata2 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run Galaxy-Workflow-De_novo.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run Galaxy-Workflow-De_novo.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run Galaxy-Workflow-De_novo.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init Galaxy-Workflow-De_novo.ga -o job.yml`
- Lint: `planemo workflow_lint Galaxy-Workflow-De_novo.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `Galaxy-Workflow-De_novo.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
