---
name: de-novo-transcriptome-reconstruction-with-rna-seq
description: "This transcriptomics workflow performs de novo transcriptome reconstruction and differential expression analysis using paired-end RNA-Seq reads and a reference GTF with tools including HISAT2, StringTie, and DESeq2. Use this skill when you need to discover novel transcripts and quantify differential gene expression across multiple biological replicates in organisms with incomplete or evolving genome annotations."
homepage: https://workflowhub.eu/workflows/1685
---

# De novo transcriptome reconstruction with RNA-Seq

## Overview

This Galaxy workflow provides a comprehensive pipeline for *de novo* transcriptome reconstruction and differential gene expression analysis using RNA-Seq data. It is designed to process paired-end reads from multiple biological replicates (e.g., G1E and Megakaryocyte cells) to identify transcript structures and quantify expression levels without relying solely on existing gene annotations.

The process begins with rigorous quality control and preprocessing. Raw reads are analyzed using [FastQC](https://toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1) and cleaned with [Trimmomatic](https://toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0) to remove adapters and low-quality bases. The processed reads are then aligned to a reference genome using [HISAT2](https://toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.1.0+galaxy5). Following alignment, [StringTie](https://toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/1.3.6) assembles transcripts for each sample, which are subsequently merged into a unified transcriptome.

The final stages of the workflow focus on evaluation and quantification. [GffCompare](https://toolshed.g2.bx.psu.edu/repos/iuc/gffcompare/gffcompare/0.11.2) compares the assembled transcripts against a reference GTF to identify novel isoforms or genes. Expression levels are quantified via [featureCounts](https://toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/1.6.4+galaxy1), and differential expression analysis is performed using [DESeq2](https://toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.6). The workflow also generates genomic coverage visualizations (BigWig files) using [bamCoverage](https://toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.0.0.0) for downstream inspection in genome browsers.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | G1E_rep1_forward_read | data_input |  |
| 1 | G1E_rep1_reverse_read | data_input |  |
| 2 | G1E_rep2_forward_read | data_input |  |
| 3 | G1E_rep2_reverse_read | data_input |  |
| 4 | Megakaryocyte_rep1_forward_read | data_input |  |
| 5 | Megakaryocyte_rep1_reverse_read | data_input |  |
| 6 | Megakaryocyte_rep2_forward_read | data_input |  |
| 7 | Megakaryocyte_rep2_reverse_read | data_input |  |
| 8 | RefSeq_reference_GTF | data_input |  |


To prepare for this workflow, ensure your RNA-Seq forward and reverse reads are in fastqsanger format and your reference annotation is in GTF format. While the workflow accepts individual datasets for each replicate, organizing paired-end reads into data collections can streamline processing and improve history management. Verify that all input metadata, such as strand specificity, is correctly assigned before execution to ensure accurate transcript assembly with StringTie. For comprehensive guidance on parameter settings and data preparation, refer to the README.md file. You can also use `planemo workflow_job_init` to generate a `job.yml` file for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 9 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 10 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 11 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 12 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 13 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 14 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 15 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 16 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 17 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 18 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 19 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 20 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.38.0 |  |
| 21 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.1.0+galaxy5 |  |
| 22 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 23 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 24 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.1.0+galaxy5 |  |
| 25 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 26 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 27 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.1.0+galaxy5 |  |
| 28 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 29 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 30 | HISAT2 | toolshed.g2.bx.psu.edu/repos/iuc/hisat2/hisat2/2.1.0+galaxy5 |  |
| 31 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 32 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.72+galaxy1 |  |
| 33 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/1.3.6 |  |
| 34 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.0.0.0 |  |
| 35 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.0.0.0 |  |
| 36 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/1.3.6 |  |
| 37 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.0.0.0 |  |
| 38 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.0.0.0 |  |
| 39 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/1.3.6 |  |
| 40 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.0.0.0 |  |
| 41 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.0.0.0 |  |
| 42 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/1.3.6 |  |
| 43 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.0.0.0 |  |
| 44 | bamCoverage | toolshed.g2.bx.psu.edu/repos/bgruening/deeptools_bam_coverage/deeptools_bam_coverage/3.3.0.0.0 |  |
| 45 | StringTie merge | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie_merge/1.3.6 |  |
| 46 | GffCompare | toolshed.g2.bx.psu.edu/repos/iuc/gffcompare/gffcompare/0.11.2 |  |
| 47 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/1.6.4+galaxy1 |  |
| 48 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/1.6.4+galaxy1 |  |
| 49 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/1.6.4+galaxy1 |  |
| 50 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/1.6.4+galaxy1 |  |
| 51 | DESeq2 | toolshed.g2.bx.psu.edu/repos/iuc/deseq2/deseq2/2.11.40.6 |  |
| 52 | Filter | Filter1 |  |
| 53 | Filter | Filter1 |  |
| 54 | Filter | Filter1 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 21 | output_alignments | output_alignments |
| 22 | html_file | html_file |
| 22 | text_file | text_file |
| 23 | html_file | html_file |
| 23 | text_file | text_file |
| 24 | output_alignments | output_alignments |
| 25 | html_file | html_file |
| 25 | text_file | text_file |
| 26 | html_file | html_file |
| 26 | text_file | text_file |
| 27 | output_alignments | output_alignments |
| 28 | html_file | html_file |
| 28 | text_file | text_file |
| 29 | html_file | html_file |
| 29 | text_file | text_file |
| 30 | output_alignments | output_alignments |
| 31 | html_file | html_file |
| 31 | text_file | text_file |
| 32 | html_file | html_file |
| 32 | text_file | text_file |
| 33 | output_gtf | output_gtf |
| 34 | outFileName | outFileName |
| 35 | outFileName | outFileName |
| 36 | output_gtf | output_gtf |
| 37 | outFileName | outFileName |
| 38 | outFileName | outFileName |
| 39 | output_gtf | output_gtf |
| 40 | outFileName | outFileName |
| 41 | outFileName | outFileName |
| 42 | output_gtf | output_gtf |
| 43 | outFileName | outFileName |
| 45 | out_gtf | out_gtf |
| 47 | output_summary | output_summary |
| 48 | output_summary | output_summary |
| 49 | output_summary | output_summary |
| 50 | output_summary | output_summary |
| 51 | plots | plots |
| 51 | deseq_out | deseq_out |
| 52 | out_file1 | out_file1 |
| 53 | out_file1 | out_file1 |
| 54 | out_file1 | out_file1 |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run transcriptomics-denovo-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run transcriptomics-denovo-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run transcriptomics-denovo-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init transcriptomics-denovo-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint transcriptomics-denovo-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `transcriptomics-denovo-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
