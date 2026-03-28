---
name: comparative-annotation-toolkit
description: The Comparative Annotation Toolkit produces high-quality gene annotations across multiple genomes using a reference annotation and a whole-genome alignment. Use when user asks to project annotations from a reference genome to target genomes, perform comparative gene prediction with Augustus, or generate a UCSC Assembly Hub for comparative genomics.
homepage: https://github.com/ComparativeGenomicsToolkit/Comparative-Annotation-Toolkit
---


# comparative-annotation-toolkit

## Overview

The Comparative Annotation Toolkit (CAT) is a specialized workflow engine designed for large-scale comparative genomics. It takes a multiple genome alignment (HAL format) and an existing annotation (GFF3) on a reference genome to produce consistent, high-quality annotations for all other genomes in the alignment. CAT is unique in its ability to combine "transMap" (projection via alignment) with ab initio gene prediction (Augustus) and RNA-seq evidence to resolve orthology and improve annotation accuracy in divergent regions.

## Core CLI Usage

CAT is executed as a `luigi` task. The primary module is `cat.RunCat`.

### Basic Command Structure

```bash
luigi --module cat RunCat \
    --hal=/path/to/alignment.hal \
    --ref-genome=ReferenceName \
    --target-genomes='("Target1", "Target2")' \
    --out-dir=./output \
    --work-dir=./temp \
    --local-scheduler
```

### Common Parameters

- `--hal`: Path to the HAL alignment file containing all genomes.
- `--ref-genome`: The name of the genome in the HAL file that has the source annotations.
- `--target-genomes`: A Python-style tuple string listing the genomes to be annotated.
- `--annotation-gff3`: Path to the source GFF3 file on the reference genome.
- `--augustus`: Enables the standard Augustus species-specific gene prediction.
- `--augustus-cgp`: Enables Augustus Comparative Gene Prediction (CGP) for simultaneous prediction across all genomes.
- `--augustus-pb`: Enables Augustus Protein-Coding (PB) mode using RNA-seq/protein hints.
- `--assembly-hub`: Automatically generates a UCSC Assembly Hub for visualizing results.
- `--workers`: Number of parallel luigi workers (tasks) to run.

## Expert Tips and Best Practices

### Environment and Dependencies
CAT has a complex dependency tree including the Kent toolset, HAL tools, and Augustus. 
- **Path Management**: Ensure `hal2fasta`, `halLiftover`, `wigToBigWig`, and `augustus` are in your `$PATH`.
- **Docker/Singularity**: Due to the heavy dependency load, running CAT via the official Docker image (`quay.io/ucsc_cgl/cat`) is highly recommended for stability.

### Resource Management
- **Work Directory**: CAT generates many intermediate files. Ensure `--work-dir` is on a filesystem with high IOPS and significant free space.
- **Toil Integration**: For large-scale runs (e.g., 50+ genomes), CAT can use the Toil engine to distribute jobs across a cluster. This requires configuring a `toil` leader node.

### Input Validation
- **GFF3 Format**: CAT is strict about GFF3 formatting. Ensure your reference GFF3 is validated (e.g., using `gff3ToGenePred`) before starting the pipeline.
- **HAL Names**: The names provided in `--ref-genome` and `--target-genomes` must exactly match the sequence names inside the HAL alignment. Use `halStats --tree <file.hal>` to verify names.

### Troubleshooting
- **Luigi Scheduler**: If running on a single machine, always include `--local-scheduler`. If the pipeline crashes, you can resume by pointing to the same `--work-dir`; CAT will skip successfully completed tasks.
- **Logging**: Use `--log-level DEBUG` to diagnose failures in specific sub-tools like `transMap` or `Augustus`.



## Subcommands

| Command | Description |
|---------|-------------|
| faToTwoBit | Convert DNA from fasta to 2bit format |
| gff3ToGenePred | convert a GFF3 file to a genePred file |
| pslMap | map PSLs alignments to new targets using alignments of the old target to the new target. Given inPsl and mapPsl, where the target of inPsl is the query of mapPsl, create a new PSL with the query of inPsl aligned to all the targets of mapPsl. If inPsl is a protein to nucleotide alignment and mapPsl is a nucleotide to nucleotide alignment, the resulting alignment is nucleotide to nucleotide alignment of a hypothetical mRNA that would code for the protein. This is useful as it gives base alignments of spliced codons. A chain file may be used instead mapPsl. |

## Reference documentation
- [Comparative-Annotation-Toolkit README](./references/github_com_ComparativeGenomicsToolkit_Comparative-Annotation-Toolkit_blob_master_README.md)
- [CAT Complete Dockerfile (Dependency List)](./references/github_com_ComparativeGenomicsToolkit_Comparative-Annotation-Toolkit_blob_master_Dockerfile.complete.md)
- [Travis CI Test Patterns](./references/github_com_ComparativeGenomicsToolkit_Comparative-Annotation-Toolkit_blob_master_.travis.yml.md)