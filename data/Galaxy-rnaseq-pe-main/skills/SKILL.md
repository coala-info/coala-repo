---
name: rna-seq-analysis-paired-end-read-processing-and-quantificati
description: "This workflow processes paired-end RNA-Seq FASTQ collections through quality filtering with fastp, STAR alignment, and gene quantification using featureCounts, StringTie, or Cufflinks. Use this skill when you need to transform raw transcriptomic sequencing data into normalized expression values, count tables, and genomic coverage tracks while accounting for library strandedness and adapter contamination."
homepage: https://workflowhub.eu/workflows/401
---

# RNA-Seq Analysis: Paired-End Read Processing and Quantification

## Overview

This workflow provides a comprehensive pipeline for processing paired-end RNA-Seq data, covering every stage from raw FASTQ quality control to gene-level quantification. It begins by utilizing [fastp](https://github.com/OpenGene/fastp) for adapter trimming and quality filtering, followed by read alignment using [STAR](https://github.com/alexdobin/STAR) configured with ENCODE parameters. The pipeline is highly flexible, supporting both stranded and unstranded libraries while generating multiple types of output, including mapped BAM files and normalized genomic coverage tracks in BigWig format.

Quantification is handled through several integrated methods to suit different downstream analysis needs. Users can generate gene count tables via STAR or [featureCounts](https://subread.sourceforge.net/featureCounts.html), and calculate normalized expression values (FPKM/TPM) using [StringTie](https://ccb.jhu.edu/software/stringtie/) and [Cufflinks](http://cole-trapnell-lab.github.io/cufflinks/). The workflow also includes an optional but extensive QC suite—incorporating FastQC, Picard, and Samtools—all summarized into a final [MultiQC](https://multiqc.info/) report for easy assessment of library quality and strandedness.

For detailed information on input requirements, parameter settings, and file preparation, please refer to the [README.md](README.md).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Collection paired FASTQ files | data_collection_input | Should be a list of paired-end RNA-seq fastqs |
| 1 | Forward adapter | parameter_input | This is optional. Fastp will use overlapping. If you want to specify, for Nextera use: CTGTCTCTTATACACATCTCCGAGCCCACGAGAC, for TruSeq: GATCGGAAGAGCACACGTCTGAACTCCAGTCAC or AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC |
| 2 | Reverse adapter | parameter_input | This is optional. Fastp will use overlapping. If you want to specify, for Nextera use: CTGTCTCTTATACACATCTGACGCTGCCGACGA, for TruSeq: GATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT or AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT |
| 3 | Generate additional QC reports | parameter_input | Whether to compute additional QC like fastQC, gene body coverage etc... |
| 4 | Reference genome | parameter_input | Select the reference genome |
| 5 | GTF file of annotation | data_input | GTF compatible with the reference genome. Mind the UCSC/Ensembl differences in chromosome naming. |
| 6 | Strandedness | parameter_input | For stranded RNA, reverse means that the read is complementary to the coding sequence, forward means that the read is in the same orientation as the coding sequence |
| 7 | Use featureCounts for generating count tables | parameter_input | Use featureCounts tool instead of RNA STAR? |
| 8 | Compute Cufflinks FPKM | parameter_input | Whether FPKM values should be computed with Cufflinks |
| 9 | GTF with regions to exclude from FPKM normalization with Cufflinks | data_input | It could be a GTF with for example one entry for the chrM forward and one entry for the chrM reverse |
| 10 | Compute StringTie FPKM | parameter_input | Whether FPKM values should be computed with StringTie |


Ensure your input data is organized as a paired-end collection of fastqsanger files to maintain sample relationships throughout the automated processing. You must provide a reference genome compatible with STAR and a GTF annotation file, while an optional mask GTF can be used to exclude regions like chrM from Cufflinks normalization. Verify your library's strandedness and adapter sequences (e.g., TruSeq or Nextera) beforehand, as these parameters significantly impact quantification accuracy and coverage orientation. Refer to the README.md for detailed guidance on masking formats and interpreting stranded coverage outputs. For automated execution, you can initialize your configuration using `planemo workflow_job_init` to generate a `job.yml` file.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 11 | Flatten collection | __FLATTEN__ |  |
| 12 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.1.0+galaxy0 |  |
| 13 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 14 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 15 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 16 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 17 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 18 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.11b+galaxy0 |  |
| 19 | Get Uniquely mapped unstranded coverage | (subworkflow) |  |
| 20 | Re-arrange Stranded RNA-seq coverage | (subworkflow) |  |
| 21 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/2.1.1+galaxy0 |  |
| 22 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.3+galaxy0 |  |
| 23 | Cufflinks | toolshed.g2.bx.psu.edu/repos/devteam/cufflinks/cufflinks/2.2.1.4 |  |
| 24 | Process Count files | (subworkflow) |  |
| 25 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0 |  |
| 26 | RNA-seq-Paired-QC | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 18 | Mapped Reads | mapped_reads |
| 22 | Gene Abundance Estimates from StringTie | gene_abundance_estimation |
| 23 | Genes Expression from Cufflinks | genes_expression |
| 23 | Transcripts Expression from Cufflinks | transcripts_expression |
| 25 | Small MultiQC HTML report | html_report |
| 25 | Small MultiQC stats | stats |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run rnaseq-pe.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run rnaseq-pe.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run rnaseq-pe.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init rnaseq-pe.ga -o job.yml`
- Lint: `planemo workflow_lint rnaseq-pe.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `rnaseq-pe.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)
