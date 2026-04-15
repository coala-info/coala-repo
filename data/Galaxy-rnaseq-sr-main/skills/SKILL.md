---
name: rna-seq-analysis-single-end-read-processing-and-quantificati
description: This workflow processes single-end FASTQ collections through quality control with fastp, alignment via STAR, and multi-method quantification using featureCounts, StringTie, and Cufflinks. Use this skill when you need to determine gene expression levels, normalized FPKM/TPM values, and genomic coverage tracks from transcriptomic data while accounting for specific library strandedness and annotation requirements.
homepage: https://iwc.galaxyproject.org/
metadata:
  docker_image: "N/A"
---

# rna-seq-analysis-single-end-read-processing-and-quantificati

## Overview

This Galaxy workflow provides a comprehensive pipeline for processing single-end RNA-Seq data, covering every stage from raw FASTQ quality control to gene expression quantification. It begins by utilizing [fastp](https://github.com/OpenGene/fastp) for adapter trimming and quality filtering, followed by read alignment using [STAR](https://github.com/alexdobin/STAR) configured with ENCODE parameters. The workflow is highly flexible, supporting both stranded and unstranded libraries and allowing users to toggle specific quantification methods based on their research needs.

For expression analysis, the pipeline offers multiple quantification paths. It can generate gene count tables via STAR or [featureCounts](https://subread.sourceforge.net/), and calculate normalized expression values (FPKM/TPM) using [Cufflinks](http://cole-trapnell-lab.github.io/cufflinks/) and [StringTie](https://ccb.jhu.edu/software/stringtie/). Additionally, the workflow processes alignments to produce normalized genomic coverage tracks in BigWig format, filtered for uniquely mapped reads to ensure high-quality visualization in genome browsers.

The workflow concludes with an integrated quality assessment, generating a [MultiQC](https://multiqc.info/) report that aggregates statistics from the various processing steps. Users can also enable an extended QC suite that includes Picard metrics and gene body coverage analysis. Detailed information regarding input requirements, parameter settings, and library strandedness can be found in the [README.md](README.md).

## Inputs and data preparation

| Step | Label | Type | Notes |
| --- | --- | --- | --- |
| 0 | Collection of FASTQ files | data_collection_input | Should be a list of single-read RNA-seq fastqs |
| 1 | Forward adapter | parameter_input | This is optional. If not provided, fastp will try to guess the sequence. If you want to specify, for Nextera use: CTGTCTCTTATACACATCTCCGAGCCCACGAGAC, for TruSeq: GATCGGAAGAGCACACGTCTGAACTCCAGTCAC or AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC |
| 2 | Generate additional QC reports | parameter_input | Whether to compute additional QC like fastQC, gene body coverage etc... |
| 3 | Reference genome | parameter_input | Select the reference genome |
| 4 | GTF file of annotation | data_input | GTF compatible with the reference genome. Mind the UCSC/Ensembl differences in chromosome naming. |
| 5 | Strandedness | parameter_input | For stranded RNA, reverse means that the read is complementary to the coding sequence, forward means that the read is in the same orientation as the coding sequence |
| 6 | Use featureCounts for generating count tables | parameter_input | Use featureCounts tool instead of RNA STAR? |
| 7 | Compute Cufflinks FPKM | parameter_input | Whether FPKM values should be computed with Cufflinks |
| 8 | GTF with regions to exclude from FPKM normalization with Cufflinks | data_input | It could be a GTF with for example one entry for the chrM forward and one entry for the chrM reverse |
| 9 | Compute StringTie FPKM | parameter_input | Whether FPKM values should be computed with StringTie |


Ensure your input FASTQ files are organized into a dataset collection and formatted as fastqsanger to ensure compatibility with the fastp and STAR steps. You must provide a GTF annotation file, and optionally a masking GTF for Cufflinks normalization, while selecting the appropriate reference genome and strandedness (forward, reverse, or unstranded) to match your library preparation. For optimal results, verify adapter sequences via FastQC before entry or allow fastp to auto-detect them. Consult the README.md for detailed guidance on stranded coverage outputs and specific parameter configurations. You can use `planemo workflow_job_init` to generate a `job.yml` for automated execution.

## Steps (tools)

| Step | Name | Tool ID | Notes |
| --- | --- | --- | --- |
| 10 | fastp | toolshed.g2.bx.psu.edu/repos/iuc/fastp/fastp/1.1.0+galaxy0 |  |
| 11 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 12 | Compose text parameter value | toolshed.g2.bx.psu.edu/repos/iuc/compose_text_param/compose_text_param/0.1.1 |  |
| 13 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 14 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 15 | Map parameter value | toolshed.g2.bx.psu.edu/repos/iuc/map_param_value/map_param_value/0.2.0 |  |
| 16 | RNA STAR | toolshed.g2.bx.psu.edu/repos/iuc/rgrnastar/rna_star/2.7.11b+galaxy0 |  |
| 17 | Get Uniquely mapped unstranded coverage | (subworkflow) |  |
| 18 | Re-arrange Stranded RNA-seq coverage | (subworkflow) |  |
| 19 | featureCounts | toolshed.g2.bx.psu.edu/repos/iuc/featurecounts/featurecounts/2.1.1+galaxy0 |  |
| 20 | StringTie | toolshed.g2.bx.psu.edu/repos/iuc/stringtie/stringtie/2.2.3+galaxy0 |  |
| 21 | Cufflinks | toolshed.g2.bx.psu.edu/repos/devteam/cufflinks/cufflinks/2.2.1.4 |  |
| 22 | Process Count files | (subworkflow) |  |
| 23 | MultiQC | toolshed.g2.bx.psu.edu/repos/iuc/multiqc/multiqc/1.33+galaxy0 |  |
| 24 | RNA-seq-QC | (subworkflow) |  |


## Workflow outputs (marked in Galaxy)

| Step | Label | Output name |
| --- | --- | --- |
| 16 | Mapped Reads | mapped_reads |
| 20 | Gene Abundance Estimates from StringTie | gene_abundance_estimation |
| 21 | Transcripts Expression from Cufflinks | transcripts_expression |
| 21 | Genes Expression from Cufflinks | genes_expression |
| 23 | Small MultiQC stats | stats |
| 23 | Small MultiQC HTML report | html_report |


## How to run (Planemo)

### Local Galaxy (default engine)

```bash
planemo run rnaseq-sr.ga job.yml --download_outputs --output_directory . --output_json output.json
```

Optional: `--galaxy_root /path/to/galaxy` speeds up spinning up a local Galaxy.

### Docker Galaxy

Append e.g. `--engine docker_galaxy --ignore_dependency_problems` (requires Docker).

### External Galaxy (usegalaxy.org / EU / …)

```bash
planemo run rnaseq-sr.ga job.yml --engine external_galaxy --galaxy_url SERVER_URL --galaxy_user_key YOUR_API_KEY
```

Create a reusable profile: `planemo profile_create myprofile --galaxy_url ... --galaxy_user_key ... --engine external_galaxy` then `planemo run rnaseq-sr.ga job.yml --profile myprofile`.

### Job file

- Generate a template: `planemo workflow_job_init rnaseq-sr.ga -o job.yml`
- Lint: `planemo workflow_lint rnaseq-sr.ga`

See **[Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)** in the Planemo documentation.

## Invocation outputs

After a successful run with `--download_outputs`, files appear under your chosen `--output_directory`. `--output_json` records CWL-style metadata for outputs (paths, checksums).

On an external Galaxy, use `planemo invocation_download INVOCATION_ID --profile ...` to fetch outputs, or track progress with `planemo workflow_track INVOCATION_ID`.

Workflow steps marked as **workflow outputs** in the editor are listed under **Workflow outputs**; exact filenames depend on tools and Galaxy configuration.

## Files

- `rnaseq-sr.ga` — Galaxy workflow export (JSON)
- `job.yml` — inputs/parameters for `planemo run` (create with `planemo workflow_job_init`)
- `README.md` — project reference (inputs, data, preparation)
- [Planemo: Running Galaxy workflows](https://planemo.readthedocs.io/en/master/running.html)