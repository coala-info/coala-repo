---
name: genomeassembler
description: This pipeline performs de novo genome assembly, polishing, and scaffolding using ONT or PacBio HiFi long reads and optional short reads, delivering assembled contigs and comprehensive QC reports from tools like BUSCO and QUAST. Use when generating high-quality genome assemblies from long-read data, though it does not currently support phasing of polyploid genomes or HiC scaffolding.
homepage: https://github.com/nf-core/genomeassembler
---

## Overview
nf-core/genomeassembler addresses the challenge of generating high-quality de novo genome assemblies from long-read sequencing data. It streamlines the process of selecting assemblers, applying polishing algorithms to correct errors, and using scaffolding tools to increase assembly continuity.

Users provide raw ONT or PacBio HiFi reads, and the pipeline generates polished genomic sequences in FASTA format. The output includes detailed quality control reports that help researchers assess the integrity and completeness of the resulting assembly.

## Data preparation
The pipeline requires a CSV samplesheet specified with the `--input` parameter. Each row represents one genome to be assembled.

*   `sample`: Unique name for the sample (required).
*   `ontreads`: Path to ONT reads (fastq.gz).
*   `hifireads`: Path to HiFi reads (fastq.gz).
*   `ref_fasta`: Reference genome FASTA for scaffolding or QC.
*   `ref_gff`: Reference annotations for liftover.
*   `shortread_F` / `shortread_R`: Forward and reverse short-reads for polishing or QC.
*   `paired`: Boolean indicating if short-reads are paired.

Columns can be omitted if they contain no data, but `shortread_R` must be present if `shortread_F` is provided, even if it is empty.

Example `samplesheet.csv`:
```csv
sample,ontreads,hifireads,ref_fasta,ref_gff,shortread_F,shortread_R,paired
sampleName,ontreads.fa.gz,hifireads.fa.gz,assembly.fasta.gz,reference.fasta,reference.gff,short_F1.fastq,short_F2.fastq,true
```

## How to run
Run the pipeline using the `nextflow run` command. Specify a profile (e.g., `docker`, `singularity`) and the output directory.

```bash
nextflow run nf-core/genomeassembler \
   -profile docker \
   --input samplesheet.csv \
   --outdir ./results \
   -resume
```

Key parameters include:
*   `--assembler`: Choose between `flye`, `hifiasm`, `flye_on_hifiasm`, or `hifiasm_on_hifiasm`.
*   `--ont` / `--hifi`: Specify which long-read types are available.
*   `--polish_medaka` / `--polish_pilon`: Enable polishing (Pilon requires short reads).
*   `--scaffold_ragtag`: Enable scaffolding (requires a reference).

## Outputs
Results are saved in the directory specified by `--outdir`.

*   Assembled and polished contigs or scaffolds in FASTA format.
*   Quality control reports from BUSCO, QUAST, and Merqury.
*   Annotation liftover results if a reference was provided.

For a detailed description of all output files and how to interpret them, refer to the [official output documentation](https://nf-co.re/genomeassembler/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
