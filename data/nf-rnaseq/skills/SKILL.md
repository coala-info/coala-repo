---
name: rnaseq
description: nf-core/rnaseq performs quality control, trimming, and (pseudo-)alignment of RNA sequencing data using a samplesheet of FASTQ or BAM files alongside a reference genome and GTF/GFF annotation. It generates gene and transcript expression matrices, normalized coverage tracks, and comprehensive QC reports through multiple quantification routes including STAR, Salmon, and RSEM. Use when analyzing transcriptomic data from organisms with available reference assemblies to obtain quantification and quality metrics. This pipeline does not perform statistical differential expression testing but provides the necessary matrices for downstream analysis.
homepage: https://github.com/nf-core/rnaseq
---

## Overview
The nf-core/rnaseq pipeline provides an end-to-end solution for processing raw RNA-seq data into quantified expression levels. It addresses the complexity of read cleaning, alignment to a reference genome, and transcript-level quantification while providing extensive quality metrics to ensure data integrity.

Users provide raw sequencing reads or pre-aligned BAM files, which the pipeline transforms into gene-level count matrices and genomic coverage files. These outputs serve as the foundation for downstream biological interpretation, such as differential gene expression or functional enrichment analysis.

## Data preparation
A CSV samplesheet is required to define input data. The file must include headers and columns for `sample`, `fastq_1`, and `strandedness`. Technical replicates with the same sample ID are merged automatically.

**Example samplesheet.csv**:
```csv
sample,fastq_1,fastq_2,strandedness
CONTROL_REP1,AEG588A1_R1.fastq.gz,AEG588A1_R2.fastq.gz,auto
CONTROL_REP2,AEG588A2_R1.fastq.gz,AEG588A2_R2.fastq.gz,auto
```

**Constraints and References**:
- **Strandedness**: Must be `forward`, `reverse`, `unstranded`, or `auto` (inferred via Salmon).
- **Reference Files**: Requires `--fasta` (genome) and either `--gtf` or `--gff` (annotation).
- **Indices**: If pre-built indices (e.g., `--star_index`, `--salmon_index`) are not provided, the pipeline will generate them.
- **Prokaryotes**: Use `-profile prokaryotic` to handle CDS-based annotations and use splice-unaware alignment.

## How to run
Run the pipeline using the `nextflow run` command. It is recommended to pin a specific version using `-r`.

```bash
nextflow run nf-core/rnaseq \
    -r 3.14.0 \
    -profile <docker/singularity/institute> \
    --input samplesheet.csv \
    --outdir ./results \
    --fasta genome.fasta \
    --gtf genes.gtf
```

**Common Parameters**:
- `--aligner`: Choose between `star_salmon` (default), `star_rsem`, `hisat2`, or `bowtie2_salmon`.
- `--pseudo_aligner`: Optionally run `salmon` or `kallisto` in addition to the main aligner.
- `--remove_ribo_rna`: Enable rRNA removal using SortMeRNA or Bowtie2.
- `-resume`: Restart a run from the last successful step.

## Outputs
Results are saved to the directory specified by `--outdir`. 

- **MultiQC Report**: Found in `multiqc/multiqc_report.html`, this is the primary file to inspect for a summary of all QC metrics.
- **Quantification**: Gene and transcript-level count matrices are located in tool-specific folders (e.g., `star_salmon/` or `rsem/`).
- **Alignments**: BAM files and indices are provided in the alignment subdirectories.
- **Visualization**: BigWig coverage tracks are generated for genome browser visualization.

For a detailed description of all output files, refer to the [official output documentation](https://nf-co.re/rnaseq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/dev/metro_map.md`](references/docs/dev/metro_map.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
- [`references/docs/usage/differential_expression_analysis/de_rstudio.md`](references/docs/usage/differential_expression_analysis/de_rstudio.md)
- [`references/docs/usage/differential_expression_analysis/interpretation.md`](references/docs/usage/differential_expression_analysis/interpretation.md)
- [`references/docs/usage/differential_expression_analysis/introduction.md`](references/docs/usage/differential_expression_analysis/introduction.md)
- [`references/docs/usage/differential_expression_analysis/rnaseq.md`](references/docs/usage/differential_expression_analysis/rnaseq.md)
- [`references/docs/usage/differential_expression_analysis/theory.md`](references/docs/usage/differential_expression_analysis/theory.md)
