---
name: augustus
description: Augustus is a eukaryotic gene prediction tool that identifies genomic features using a Generalized Hidden Markov Model. Use when user asks to predict genes in a DNA sequence, incorporate extrinsic evidence for annotation, or identify alternative splicing isoforms.
homepage: http://bioinf.uni-greifswald.de/augustus/
metadata:
  docker_image: "quay.io/biocontainers/augustus:3.5.0--pl5321h9716f88_9"
---

# augustus

## Overview
Augustus is a eukaryotic gene prediction tool that utilizes a Generalized Hidden Markov Model (GHMM) to identify genomic features. It can function as a standalone "ab initio" predictor based solely on DNA sequence or as a "hint-based" predictor that integrates external biological data. Use this skill to navigate species-specific parameter selection, configure transcript output levels, and integrate extrinsic evidence for improved annotation sensitivity and specificity.

## Installation
The most efficient way to install Augustus is via Bioconda:
```bash
conda install -c bioconda augustus
```

## Common CLI Patterns

### Basic Ab Initio Prediction
To run a standard prediction on a genomic FASTA file, you must specify a pre-trained species.
```bash
augustus --species=human genome.fa
```

### Controlling Strand Prediction
By default, Augustus predicts genes on both strands. You can restrict this behavior:
```bash
# Predict on forward strand only
augustus --species=fly genome.fa --strand=forward

# Predict on reverse strand only
augustus --species=fly genome.fa --strand=backward
```

### Predicting Alternative Splicing
Augustus can report multiple transcripts per gene. Use the following flags to control the density of alternative isoforms:
```bash
# Report few alternative transcripts
augustus --species=human genome.fa --alternatives-from-sampling=true --minexonintronprob=0.2

# Report many alternative transcripts (expert mode)
augustus --species=human genome.fa --alternatives-from-sampling=true --sample=100 --keep_viterbi=true
```

### Incorporating Extrinsic Evidence (Hints)
To improve accuracy using RNA-Seq or EST data, provide a GFF file containing "hints."
```bash
augustus --species=human genome.fa --hintsfile=hints.gff --extrinsicCfgFile=extrinsic.cfg
```
*Note: The `extrinsic.cfg` file determines the "bonus" or "malus" (weight) given to specific types of evidence (e.g., intron hints, exonpart hints).*

### UTR Prediction
Augustus can predict 5' and 3' Untranslated Regions, but this feature must be supported by the species-specific training set.
```bash
augustus --species=human genome.fa --UTR=on
```

## Expert Tips and Best Practices

1.  **Species Selection**: If your specific organism is not in the trained list, use the most closely related species. For example, the `human` model is generally effective for most mammals, and `arabidopsis` is a standard starting point for many dicot plants.
2.  **Output Redirection**: Augustus outputs results to `stdout` in GFF format. Always redirect to a file for downstream analysis:
    ```bash
    augustus --species=human genome.fa > output.gff
    ```
3.  **Large Genomes**: For whole-genome annotations, it is often more efficient to split the genome into individual chromosomes or scaffolds and run Augustus in parallel across multiple CPU cores.
4.  **Complete Genes Only**: If you require only full-length gene models (start to stop codon), use:
    ```bash
    augustus --species=human genome.fa --genemodel=complete
    ```
5.  **Displaying Results**: The GFF output can be loaded directly into genome browsers like IGV or JBrowse, or converted to GTF for use with tools like GffRead.

## Reference documentation
- [Augustus Overview](./references/bioinf_uni-greifswald_de_augustus.md)
- [Augustus Accuracy Statistics](./references/bioinf_uni-greifswald_de_augustus_accuracy.md)
- [Augustus Datasets and Training Sets](./references/bioinf_uni-greifswald_de_augustus_datasets.md)
- [Augustus Web Submission Parameters](./references/bioinf_uni-greifswald_de_augustus_submission.php.md)