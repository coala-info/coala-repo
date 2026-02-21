---
name: kissplice
description: KisSplice is a specialized tool designed for "assembly-first" transcriptomics.
homepage: http://kissplice.prabi.fr
---

# kissplice

## Overview
KisSplice is a specialized tool designed for "assembly-first" transcriptomics. Unlike global assemblers that attempt to reconstruct full-length transcripts, KisSplice performs local assembly to specifically isolate variable regions (bubbles in the De Bruijn graph). This makes it highly effective for discovering novel splicing events and polymorphisms in non-model organisms or complex datasets where a reference genome may be incomplete or unavailable.

## Core Workflows

### 1. Basic Local Assembly
To run a basic analysis on one or more FASTQ files:
```bash
kissplice -r read1.fa -r read2.fa -k 41 -c 2 -t 8
```
- `-r`: Input reads (can be specified multiple times).
- `-k`: K-mer size (default is 41; larger k-mers increase specificity but decrease sensitivity).
- `-c`: Minimum contribution of a junction (filters out low-frequency noise).
- `-t`: Number of threads.

### 2. Multi-Condition Quantification
When comparing different biological conditions, provide all reads to KisSplice to ensure a common set of variants is quantified across all samples:
```bash
kissplice -r cond1_R1.fq -r cond1_R2.fq -r cond2_R1.fq -r cond2_R2.fq --counts 2
```
The `--counts` option (default 2) ensures that the abundance of each variant is reported for each input file, which is essential for downstream differential analysis.

### 3. Downstream Integration
The output of KisSplice (typically a FASTA file of "type 1" to "type 4" bubbles) should be processed based on your available resources:
- **With a Reference Genome**: Use `KisSplice2RefGenome` to map the discovered variants back to the genome and `kissDE` for differential expression/splicing analysis.
- **Without a Reference Genome**: Use `KisSplice2RefTranscriptome` to associate bubbles with a de novo assembly or known transcripts.

## Best Practices
- **Memory Management**: Expect to use approximately 5GB of RAM per 100M reads. For very large datasets (e.g., >1G reads), ensure the environment has sufficient memory for the graph construction phase.
- **K-mer Selection**: While `k=41` is standard for Illumina reads (100bp+), consider smaller k-mers for shorter reads or lower coverage areas, though this may increase the number of branching k-mers and computational complexity.
- **Strandedness**: If using stranded RNA-seq data, ensure you use the latest version (2.6.0+) which utilizes strand information during the `kissreads` quantification step to improve accuracy.
- **Graph Construction**: Recent versions include `bcalm`, which significantly speeds up the construction of the De Bruijn graph and reduces the disk footprint.

## Reference documentation
- [KisSplice Home and Documentation](./references/kissplice_prabi_fr_index.md)
- [Bioconda KisSplice Package Overview](./references/anaconda_org_channels_bioconda_packages_kissplice_overview.md)