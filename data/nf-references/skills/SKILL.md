---
name: references
description: This pipeline builds genomic reference indices and metadata from FASTA, GTF/GFF3, and VCF files using tools like Bowtie2, BWA-MEM2, STAR, and Salmon to generate alignment-ready assets. Use when automating the creation of standardized reference genomes for common organisms or preparing data for storage in AWS iGenomes.
homepage: https://github.com/nf-core/references
---

## Overview
nf-core/references is a bioinformatics pipeline designed to automate the creation of reference genomes and associated indices for various analysis use cases. It handles the generation of alignment indices, transcript sequences, and sequence dictionaries required by downstream tools, ensuring consistency across different genomic workflows.

The pipeline takes raw genomic sequences and annotations to produce a comprehensive set of assets. These results are typically used to populate reference repositories like AWS iGenomes or to provide a unified set of reference files for large-scale genomic studies across different organisms.

## Data preparation
The pipeline requires a samplesheet in CSV, TSV, or YAML format specified via the `--input` parameter. The samplesheet must contain metadata for each genome and paths to the source files.

**Required columns:**
- `genome`: A unique identifier for the genome (no spaces).
- `source`: The origin of the genome (e.g., Ensembl, NCBI).
- `species`: The species name (no spaces).

**Optional columns (depending on tools used):**
- `fasta`: Path to the FASTA file (required for most indices).
- `gtf` or `gff`: Annotation files required for transcript-aware indices like STAR or RSEM.
- `vcf`: Variant file for tabix indexing.

**Minimal CSV example:**
```csv
genome,source,species,fasta,gtf
GRCh38,Ensembl,homo_sapiens,s3://bucket/hg38.fa,s3://bucket/hg38.gtf
```

## How to run
Run the pipeline using the `nextflow run` command. You must provide the input samplesheet, an output directory, and specify the tools you wish to use for index generation.

```bash
nextflow run nf-core/references \
    -profile docker \
    --input samplesheet.csv \
    --outdir ./results \
    --tools star,bowtie2,samtools \
    -r 1.0.0
```

Key parameters include:
- `-profile`: Choose a configuration profile (e.g., `docker`, `singularity`, `conda`).
- `--tools`: A comma-separated list of tools to build references for (e.g., `bowtie2`, `bwamem2`, `star`, `salmon`, `rsem`).
- `-resume`: Use this to restart a pipeline from the last cached step if it was interrupted.

## Outputs
Results are saved in the directory specified by `--outdir`. The structure typically includes subdirectories named after the tools used to generate the indices.

- `star/`: STAR index files.
- `bowtie2/`: Bowtie2 index files.
- `samtools/`: Fasta index (`.fai`) and size files.
- `gatk4/`: Sequence dictionaries and interval lists.
- `multiqc/`: A summary report of the pipeline run.

For a complete list of generated files and tool-specific outputs, refer to the [official output documentation](https://nf-co.re/references/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/retreat-brainstrorming.md`](references/docs/retreat-brainstrorming.md)
- [`references/docs/usage.md`](references/docs/usage.md)
