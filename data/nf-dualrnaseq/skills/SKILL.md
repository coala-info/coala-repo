---
name: dualrnaseq
description: This pipeline processes Dual RNA-seq data from FASTQ inputs by merging host and pathogen genome annotations to quantify gene expression using STAR, HTSeq, or Salmon. Use when analyzing simultaneous transcriptomes from host-pathogen interactions where both organisms have available reference genomes and GFF annotations.
homepage: https://github.com/nf-core/dualrnaseq
---

# dualrnaseq

## Overview
nf-core/dualrnaseq is a bioinformatics pipeline designed for the simultaneous analysis of host and pathogen transcriptomes. It solves the biological problem of interrogating host-pathogen interactions by processing RNA-seq data that contains transcripts from two different organisms in a single sample.

The pipeline handles the complexity of dual-species mapping by merging genome annotations and providing multiple quantification routes, including alignment-based methods with STAR and HTSeq or selective alignment with Salmon. It produces separate expression matrices and quality control reports for both the host (e.g., Human or Mouse) and the pathogen (e.g., *Salmonella* or *E. coli*).

## Data preparation
Input sequencing files should be in FASTQ or FASTQ.GZ format. Files must be named descriptively without spaces or special characters, using underscores to separate experimental conditions and appending replicate numbers at the end.

### Reference Files
The pipeline requires reference genomes and annotations for both species:
*   **Host:** FASTA (`--fasta_host`) and GFF3 (`--gff_host_genome`).
*   **Pathogen:** FASTA (`--fasta_pathogen`) and GFF3 (`--gff_pathogen`).
*   **Optional:** A host tRNA GFF (`--gff_host_tRNA`) can be provided to improve host transcriptome construction.

### Input Glob Pattern
The `--input` parameter requires a quoted glob pattern. For paired-end data, use the `{1,2}` notation.
```bash
--input 'path/to/data/sample_*_{1,2}.fastq.gz'
```

## How to run
The pipeline is executed using `nextflow run`. You must specify a profile (e.g., `docker`, `singularity`) and provide the required reference paths.

### Basic execution
```bash
nextflow run nf-core/dualrnaseq \
    -r 1.0.0 \
    -profile docker \
    --input 'data/*_{1,2}.fastq.gz' \
    --fasta_host host.fasta \
    --fasta_pathogen pathogen.fasta \
    --gff_host_genome host.gff \
    --gff_pathogen pathogen.gff \
    --outdir ./results
```

### Common Options
*   **Single-end data:** Add `--single_end` and adjust the `--input` pattern.
*   **Trimming:** Enable trimming with `--run_cutadapt` or `--run_bbduk`.
*   **Quantification:** Choose a mode such as `--run_salmon_selective_alignment`, `--run_star`, or `--run_htseq_uniquely_mapped`.
*   **Resume:** Use `-resume` to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir` (default is `./results`).

*   **MultiQC:** The `multiqc/multiqc_report.html` file provides a comprehensive summary of quality control metrics.
*   **Quantification:** Separate results tables for the host and pathogen are generated, containing gene or transcript counts.
*   **Mapping Statistics:** If `--mapping_statistics` is enabled, the pipeline produces scatterplots comparing replicates and RNA-class distribution plots.
*   **Salmon Results:** If using Salmon, `quant.sf` files and equivalence class data (if `--dumpEq` is set) are available in the output subdirectories.

For detailed information on result interpretation, refer to the official `docs/output.md` file in the pipeline repository.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/parameters.md`](references/docs/parameters.md)
- [`references/docs/usage.md`](references/docs/usage.md)