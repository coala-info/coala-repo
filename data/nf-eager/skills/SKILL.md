---
name: eager
description: This pipeline processes raw FASTQ or preprocessed BAM data against a reference genome to perform adapter removal, mapping with specialized aligners like CircularMapper, and ancient DNA damage assessment. Use when analyzing genomic NGS data from ancient samples—including human, microbial, or environmental sources—that require specific quality control for C-to-T damage patterns, library complexity, and authentication.
homepage: https://github.com/nf-core/eager
---

# eager

## Overview
nf-core/eager is a scalable and reproducible bioinformatics pipeline designed for the analysis of genomic NGS sequencing data, with a specific focus on ancient DNA (aDNA). It addresses the unique challenges of palaeogenomic data, such as highly degraded DNA fragments, characteristic biochemical damage patterns, and potential modern contamination.

The pipeline accepts raw sequencing reads or existing alignments and produces a comprehensive suite of results including mapped BAM files, damage profiles, and genotyping calls. Users receive a centralized MultiQC report that aggregates statistics from general NGS quality control and aDNA-specific metrics to evaluate sample authenticity and library quality.

## Data preparation
The pipeline accepts input via direct paths to sequencing files or a structured TSV samplesheet for complex experimental designs involving multiple lanes or libraries.

*   **Sequencing Data**: Supports FASTQ (compressed or uncompressed) and BAM formats. For paired-end FASTQ data, use the `{1,2}` globbing pattern.
*   **Reference Genome**: A FASTA file is required via `--fasta`. If the reference is larger than 3.5GB, the `--large_ref` parameter should be used to generate `.csi` indices.
*   **Samplesheet (TSV)**: Recommended for merging multiple sequencing runs or specifying metadata like UDG treatment per library.
*   **Metadata Constraints**: Users must specify the UDG treatment type (`--udg_type 'none'`, `'half'`, or `'full'`) and whether libraries are single-stranded (`--single_stranded`) if using the direct path input method.

Example of a minimal run with direct paths:
```bash
--input 'data/sample1_R{1,2}.fastq.gz' --fasta 'refs/genome.fasta'
```

## How to run
The pipeline requires Nextflow (versions between 20.07.1 and 22.10.6 for the 2.* series). It is highly recommended to use a container engine like Docker or Singularity for reproducibility.

```bash
# Run the test profile to verify installation
nextflow run nf-core/eager -profile test,docker

# Run a custom analysis
nextflow run nf-core/eager \
    -r 2.5.0 \
    -profile docker \
    --input '/path/to/data/*.fastq.gz' \
    --fasta '/path/to/ref.fasta' \
    --mapper 'bwaaln' \
    --outdir './results' \
    -resume
```

Key parameters include:
*   `-profile`: Choose between `docker`, `singularity`, `conda`, or institutional profiles.
*   `--mapper`: Select the alignment tool (`bwaaln`, `bwamem`, `circularmapper`, or `bowtie2`).
*   `--udg_type`: Define the Uracil-DNA glycosylase treatment (default: `none`).
*   `-resume`: Restart a pipeline from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir` (default is `./results`).

*   **MultiQC Report**: Found at `results/MultiQC/multiqc_report.html`, this is the primary file for assessing run success and data quality.
*   **Mapped Reads**: Located in the mapping and deduplication folders as BAM files.
*   **Damage Analysis**: DamageProfiler or mapDamage2 results providing C-to-T transition frequencies.
*   **Genotypes**: VCF, EIGENSTRAT, or consensus FASTA files depending on the genotyping modules activated (e.g., GATK, pileupCaller).
*   **Metagenomics**: Taxonomic binning results from MALT or Kraken2 if screening is enabled.

For detailed descriptions of every output file, refer to the official documentation at `https://nf-co.re/eager/output`.

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/images/README.md`](references/docs/images/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)