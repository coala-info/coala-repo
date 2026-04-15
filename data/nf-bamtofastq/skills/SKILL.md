---
name: bamtofastq
description: This pipeline converts mapped or unmapped BAM and CRAM files into compressed FASTQ format using a samplesheet that specifies input paths, file types, and optional indices. Use when you need to revert alignment files to raw sequencing reads for re-analysis or when migrating data between pipelines that require FASTQ inputs.
homepage: https://github.com/nf-core/bamtofastq
---

# bamtofastq

## Overview
nf-core/bamtofastq is a bioinformatics pipeline designed to transform sequence alignment files (BAM or CRAM) back into raw sequencing data (FASTQ). It handles both single-end and paired-end data by automatically detecting the library type and ensuring read pairs are correctly collated before extraction.

The pipeline produces standardized `fq.gz` files along with detailed statistics and quality control metrics. These outputs serve as the starting point for new alignment workflows or data archival processes, providing a consistent way to recover original reads from processed files.

## Data preparation
The pipeline requires a CSV samplesheet specified with the `--input` parameter. This file must contain a header and define the sample identity and file locations.

Required columns:
- `sample_id`: Unique identifier for the sample (no spaces).
- `mapped`: Path to the input `.bam` or `.cram` file.
- `file_type`: The format of the input file, either `bam` or `cram`.

Optional columns:
- `index`: Path to the index file (`.bai` or `.crai`).

Example `samplesheet.csv`:
```csv
sample_id,mapped,index,file_type
sample1,data/test1.bam,data/test1.bam.bai,bam
sample2,data/test2.cram,data/test2.cram.crai,cram
```

If processing CRAM files or extracting specific regions, you must provide a reference genome using `--fasta` and `--fasta_fai`, or by specifying an iGenomes ID with `--genome`.

## How to run
Run the pipeline by providing the samplesheet and an output directory. It is recommended to use a container profile (e.g., `docker` or `singularity`) for reproducibility.

```bash
nextflow run nf-core/bamtofastq \
   -profile <docker/singularity/conda> \
   --input samplesheet.csv \
   --outdir ./results
```

To extract reads from a specific chromosome or region, use the `--chr` parameter:
```bash
nextflow run nf-core/bamtofastq -profile docker --input samplesheet.csv --outdir ./results --chr "chr22"
```

Useful flags:
- `-resume`: Restart a pipeline from the last cached step.
- `--no_stats`: Skip all quality control and statistics computation (FastQC, Samtools stats).
- `--no_read_QC`: Skip QC only on the final extracted FASTQ reads.
- `--samtools_collate_fast`: Enable fast mode for samtools collate during extraction.

## Outputs
All results are saved in the directory specified by `--outdir`.

- `fastq/`: Contains the converted `.fq.gz` files. For paired-end data, these are typically split into `_1.fq.gz` and `_2.fq.gz`.
- `multiqc/`: Contains the `multiqc_report.html` which summarizes statistics and QC from all samples. This is the primary file to review after a run.
- `fastqc/`: Quality control reports for both the input BAM/CRAM files and the resulting FASTQ files.
- `samtools/`: Statistics including `flagstat`, `idxstats`, and general `stats` for the input files.

For more details about the output files and reports, refer to the [official output documentation](https://nf-co.re/bamtofastq/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)