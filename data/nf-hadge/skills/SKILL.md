---
name: hadge
description: This pipeline performs single-cell multiplexing deconvolution by combining hashing-based methods like HTODemux and GMM-Demux with genotype-based tools such as Vireo and Demuxlet. Use when analyzing multiplexed single-cell datasets where both cell surface protein hashing and genetic variation are available to identify donor origins and recover discarded cells through donor matching.
homepage: https://github.com/nf-core/hadge
---

## Overview
nf-core/hadge (hashing deconvolution combined with genotype information) is designed for demultiplexing single-cell data where multiple donors are pooled in a single experiment. It integrates 11 different computational methods to assign cells to their original donors using both cell-surface protein tags (hashing) and natural genetic variation (genotypes).

The pipeline produces a unified assignment report by joining results from multiple tools and includes a "rescue" mode to recover previously discarded cells through donor matching. It outputs standardized data structures like AnnData and MuData objects, facilitating immediate downstream analysis of the demultiplexed results.

## Data preparation
Users must provide a CSV samplesheet containing paths to RNA and HTO count matrices, alignment files, and reference genotypes. RNA and HTO matrices should be in 10x Genomics format and compressed as `.tar.gz`.

Required samplesheet columns:
- `sample`: Unique identifier for the multiplexed experiment.
- `rna_matrix`: Path to the RNA count matrix (`.tar.gz`).
- `hto_matrix`: Path to the hashing count matrix (`.tar.gz`).
- `bam`: Path to the alignment file (`.bam`).
- `vcf`: Path to the donor genotype or common SNP file (`.vcf`).
- `n_samples`: Integer representing the number of multiplexed donors.
- `barcodes`: Path to the TSV file containing target cell barcodes.

Example `samplesheet.csv`:
```csv
sample,rna_matrix,hto_matrix,bam,vcf,n_samples,barcodes
id1,rna.tar.gz,hto.tar.gz,chr21.bam,donor_genotype_chr21.vcf,2,barcodes.tsv
```

## How to run
The pipeline supports four primary modes: `genetic`, `hashing`, `rescue` (default), and `donor_match`. You can specify which algorithms to execute using the `--hash_tools` and `--genetic_tools` parameters.

```bash
nextflow run nf-core/hadge \
   -r [version] \
   -profile <docker/singularity/conda> \
   --input samplesheet.csv \
   --outdir ./results \
   --mode rescue \
   --hash_tools htodemux,hasheddrops,multiseq \
   --genetic_tools demuxlet,vireo \
   --fasta genome.fasta
```

Key parameters:
- `--mode`: Select analysis strategy (`genetic`, `hashing`, `rescue`, `donor_match`).
- `--hash_tools`: Comma-separated list of tools (e.g., `htodemux`, `multiseq`, `bff`, `demuxem`, `gmm-demux`, `hasheddrops`, `hashsolo`).
- `--genetic_tools`: Comma-separated list of tools (e.g., `vireo`, `demuxlet`, `freemuxlet`, `souporcell`, `cellsnp`).
- `--fasta`: Path to the reference genome FASTA file (mandatory if `--genome` is not used).
- `-resume`: Use this Nextflow flag to restart a pipeline from the last successful step.

## Outputs
Results are saved to the directory specified by the `--outdir` parameter. The primary deliverables include:
- `MultiQC/`: Integrated quality control reports summarizing the demultiplexing performance.
- `AnnData/` and `MuData/`: Processed objects (`.h5ad`, `.mu`) containing the final demultiplexing assignments and metadata.
- Joined results and donor matching summaries that combine assignments from all selected tools.

For more details about the output files and reports, please refer to the official [output documentation](https://nf-co.re/hadge/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)
