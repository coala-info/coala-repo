---
name: trinity-ng
description: "This transcriptomics workflow processes paired-end RNA-seq read collections and sample metadata to perform de novo transcriptome assembly, functional annotation, and differential expression analysis using Trinity, Trimmomatic, and TransDecoder. Use this skill when you need to reconstruct a transcriptome for a non-model organism lacking a reference genome and identify significantly regulated genes or expression clusters across multiple biological conditions."
homepage: https://workflowhub.eu/workflows/1716
---

# trinity NG

## Overview

This workflow provides a comprehensive pipeline for *de novo* transcriptome assembly and differential expression analysis using the [Trinity](https://github.com/trinityrnaseq/trinityrnaseq/wiki) suite. Starting from paired-end sequence reads and a sample description file, the process begins with quality control via [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) and [MultiQC](https://multiqc.info/), followed by adapter trimming and read cleaning using [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic).

The core of the workflow utilizes [Trinity](https://toolshed.g2.bx.psu.edu/repos/iuc/trinity) to assemble transcripts from the processed reads. Following assembly, the pipeline estimates transcript abundance and generates expression matrices. It includes rigorous quality assessments, such as computing Ex90N50 statistics and performing RNA-seq sample quality checks to ensure the reliability of the assembled contigs and quantification data.

Downstream analysis involves functional annotation and coding region prediction using [TransDecoder](https://github.com/TransDecoder/TransDecoder/wiki) and [Trinotate](https://trinotate.github.io/). The workflow concludes with a robust differential expression (DE) analysis, which extracts and clusters DE transcripts, performs GOseq enrichment, and generates visualization reports. This end-to-end solution is designed for [Transcriptomics](https://training.galaxyproject.org/training-material/topics/transcriptomics/) and was refined during the Roscoff hackathon.

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Collection of R1 reads | data_collection_input |  |
| 1 | Collection of R2 reads | data_collection_input |  |
| 3 | Samples description | data_input | The list of samples and replicates. Can be created with the 'Describe samples and replicates' tool |


Ensure your input fastq files are organized into two separate paired-end collections (R1 and R2) and that your samples description file is a correctly formatted tabular file matching your collection identifiers. Using collections instead of individual datasets is essential for the Trinity downstream tools to correctly map samples to conditions. For automated execution, you can initialize your parameters using `planemo workflow_job_init` to generate a `job.yml` template. Refer to the README.md for specific details on the required tabular columns and metadata configuration. Always verify that your read headers are compatible with Trinity’s naming requirements to avoid assembly errors.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 2 | Describe samples | toolshed.g2.bx.psu.edu/repos/iuc/describe_samples/describe_samples/2.8.4 |  |
| 4 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.69 |  |
| 5 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.69 |  |
| 6 | Trimmomatic | toolshed.g2.bx.psu.edu/repos/pjbriggs/trimmomatic/trimmomatic/0.32.3 |  |
| 7 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.2.0 |  |
| 8 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.69 |  |
| 9 | FastQC | toolshed.g2.bx.psu.edu/repos/devteam/fastqc/fastqc/0.69 |  |
| 10 | Trinity | toolshed.g2.bx.psu.edu/repos/iuc/trinity/trinity/2.8.4 |  |
| 11 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.2.0 |  |
| 12 | Align reads and estimate abundance | toolshed.g2.bx.psu.edu/repos/iuc/trinity_align_and_estimate_abundance/trinity_align_and_estimate_abundance/2.8.4 |  |
| 13 | Build expression matrix | toolshed.g2.bx.psu.edu/repos/iuc/trinity_abundance_estimates_to_matrix/trinity_abundance_estimates_to_matrix/2.8.4 |  |
| 14 | RNASeq samples quality check | toolshed.g2.bx.psu.edu/repos/iuc/trinity_samples_qccheck/trinity_samples_qccheck/2.8.4 |  |
| 15 | Filter low expression transcripts | toolshed.g2.bx.psu.edu/repos/iuc/trinity_filter_low_expr_transcripts/trinity_filter_low_expr_transcripts/2.8.4 |  |
| 16 | Compute contig Ex90N50 statistic and Ex90 transcript count | toolshed.g2.bx.psu.edu/repos/iuc/trinity_contig_exn50_statistic/trinity_contig_exn50_statistic/2.8.4 |  |
| 17 | Align reads and estimate abundance | toolshed.g2.bx.psu.edu/repos/iuc/trinity_align_and_estimate_abundance/trinity_align_and_estimate_abundance/2.8.4 |  |
| 18 | TransDecoder | toolshed.g2.bx.psu.edu/repos/iuc/transdecoder/transdecoder/3.0.1 |  |
| 19 | Build expression matrix | toolshed.g2.bx.psu.edu/repos/iuc/trinity_abundance_estimates_to_matrix/trinity_abundance_estimates_to_matrix/2.8.4 |  |
| 20 | Trinotate | toolshed.g2.bx.psu.edu/repos/iuc/trinotate/trinotate/3.1.1 |  |
| 21 | Differential expression analysis | toolshed.g2.bx.psu.edu/repos/iuc/trinity_run_de_analysis/trinity_run_de_analysis/2.8.4 |  |
| 22 | Extract and cluster differentially expressed transcripts | toolshed.g2.bx.psu.edu/repos/iuc/trinity_analyze_diff_expr/trinity_analyze_diff_expr/2.8.4 |  |
| 23 | Partition genes into expression clusters | toolshed.g2.bx.psu.edu/repos/iuc/trinity_define_clusters_by_cutting_tree/trinity_define_clusters_by_cutting_tree/2.8.4 |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 7 | html_report | html_report |
| 10 | assembled_transcripts | assembled_transcripts |
| 13 | trans_counts | trans_counts |
| 13 | TPM_no_norm | TPM_no_norm |
| 14 | reports | reports |
| 18 | transdecoder_pep | transdecoder_pep |
| 21 | count_matrices | count_matrices |
| 21 | DE_results | DE_results |
| 21 | PDF_results | PDF_results |
| 22 | GOseq_enrichment | GOseq_enrichment |
| 22 | extracted_DE_genes | extracted_DE_genes |
| 22 | summary_files | summary_files |
| 22 | rdata | rdata |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run main-workflow.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run main-workflow.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run main-workflow.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init main-workflow.ga -o job.yml`
- Lint: `planemo workflow_lint main-workflow.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `main-workflow.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
