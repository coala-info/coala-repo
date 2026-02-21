---
name: gemoma
description: GeMoMa (Gene Model Mapper) is a specialized tool for transferring gene annotations between species.
homepage: http://www.jstacs.de/index.php/GeMoMa
---

# gemoma

## Overview
GeMoMa (Gene Model Mapper) is a specialized tool for transferring gene annotations between species. Unlike ab initio predictors, it leverages evolutionary conservation of amino acid sequences and intron positions. This skill provides the necessary command-line patterns to run the integrated GeMoMa pipeline, incorporate RNA-seq data, and combine results from multiple reference organisms.

## Core Workflow: The GeMoMa Pipeline
The most efficient way to use GeMoMa is through the `GeMoMaPipeline` module, which automates RNA-seq evidence extraction, homology searching (via tblastn or mmseqs), and annotation filtering.

### Basic Execution
To run a standard homology-based prediction:
```bash
java -jar GeMoMa-1.9.jar CLI GeMoMaPipeline \
  threads=8 \
  outdir=./output_dir \
  t=target_genome.fasta \
  s=own \
  i=RefID \
  a=reference_annotation.gff \
  g=reference_genome.fasta \
  GeMoMa.Score=ReAlign \
  AnnotationFinalizer.r=NO \
  o=true
```

### Key Parameters
- `t`: The target genome (FASTA) you want to annotate.
- `s=own`: Indicates you are providing your own reference files (use `s=pre-extracted` if using previously processed CDS parts).
- `i`, `a`, `g`: ID, Annotation (GFF/GTF), and Genome (FASTA) for the reference species.
- `GeMoMa.Score=ReAlign`: Recommended when using mmseqs to ensure score accuracy.
- `o=true`: Produces individual prediction files per reference, making it easier to re-run the filtering step (GAF).

## Incorporating RNA-seq Evidence
GeMoMa can significantly improve splice site prediction using mapped RNA-seq data (BAM/SAM).

### Using Mapped Reads
Add the following flags to the pipeline command:
```bash
r=MAPPED \
ERE.m=mapped_reads.bam \
ERE.s=FR_FIRST_STRAND \
DenoiseIntrons.me=0.01
```
- `ERE.s`: Set the strandedness (e.g., `FR_FIRST_STRAND` for Illumina TruSeq).
- `DenoiseIntrons.me`: Minimum expression threshold to filter out noise/low-confidence introns.

## Multi-Reference Annotation
To use multiple reference organisms, repeat the reference parameters or run them separately and combine with the GeMoMa Annotation Filter (GAF).

### Combining Results
If you have multiple GFFs from different references, use GAF to produce a consensus:
```bash
java -jar GeMoMa-1.9.jar CLI GAF \
  g=target_genome.fasta \
  e=prediction_1.gff \
  e=prediction_2.gff \
  outdir=combined_output
```

## Expert Tips & Troubleshooting
- **ID Matching**: Ensure contig/chromosome names in your GFF and FASTA files match exactly.
- **Stop Codons**: If the `Extractor` module fails to return CDS parts, check if your reference GFF includes the stop codon in the CDS coordinates; GeMoMa expects them.
- **Prediction Density**: If you get too few predictions, try decreasing the contig threshold (`ct`) and increasing the number of predictions (`p`).
- **Memory/Performance**: While the pipeline is multi-threaded, it runs on a single machine. For very large genomes, ensure sufficient heap space for the JVM (`-Xmx`).

## Reference documentation
- [GeMoMa-Docs](./references/www_jstacs_de_index.php_GeMoMa-Docs.md)
- [GeMoMa Overview](./references/www_jstacs_de_index.php_GeMoMa.md)