---
name: salmon
description: Salmon quantifies transcript expression from RNA-seq data using fast quasi-mapping or alignment-based modes. Use when user asks to index a reference transcriptome, quantify gene expression levels, or generate TPM and read counts for differential expression analysis.
homepage: https://github.com/COMBINE-lab/salmon
metadata:
  docker_image: "quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5"
---

# salmon

## Overview

Salmon is a high-performance tool designed for the fast and accurate quantification of transcript expression from RNA-seq data. It utilizes quasi-mapping and selective alignment to bypass traditional, slower alignment steps while maintaining high accuracy. This skill should be used to generate command-line instructions for indexing reference transcriptomes and quantifying expression levels (TPM and read counts) for downstream differential expression analysis.

## Core Workflows

### 1. Indexing the Transcriptome
Before quantification, you must build an index. For the highest accuracy, it is recommended to use a "decoy-aware" index which includes the whole genome to prevent reads from genomic contaminants being misassigned to transcripts.

**Basic Indexing:**
```bash
salmon index -t transcripts.fa.gz -i transcripts_index
```

**Decoy-Aware Indexing (Recommended):**
1. Concatenate transcriptome and genome: `cat transcripts.fa genome.fa > gentrome.fa`
2. Create a `decoys.txt` file containing the names of the genome sequences.
3. Run indexing:
```bash
salmon index -t gentrome.fa -d decoys.txt -i transcripts_index
```

### 2. Quantification (Quasi-mapping Mode)
This is the standard mode for processing raw FASTQ files.

```bash
salmon quant -i transcripts_index -l A \
             -1 sample_R1.fastq.gz -2 sample_R2.fastq.gz \
             -p 8 --validateMappings --gcBias -o quants/sample_quant
```

### 3. Quantification (Alignment-based Mode)
Use this if you have already aligned reads to the transcriptome using another aligner (e.g., STAR) and have a BAM file.

```bash
salmon quant -t transcripts.fa -l A -a alignments.bam -o quants/sample_quant
```

## Key Parameters and Best Practices

- **Library Type (`-l`)**: Use `-l A` to let Salmon automatically detect the library type (strandedness and orientation).
- **Mapping Validation (`--validateMappings`)**: Always enable this in quasi-mapping mode to improve the sensitivity and specificity of mappings.
- **Bias Correction**: 
    - Use `--seqBias` to correct for sequence-specific biases.
    - Use `--gcBias` to correct for fragment-level GC content bias.
- **Duplicate Transcripts**: Salmon collapses exact sequence duplicates by default. Check `duplicate_clusters.tsv` in the index directory for details. Use `--keepDuplicates` during indexing if you need to retain them.
- **Output**: The primary output is `quant.sf`, a TSV file containing:
    - `Name`: Transcript ID
    - `Length`: Template length
    - `EffectiveLength`: Computed effective length accounting for biases
    - `TPM`: Transcripts Per Million
    - `NumReads`: Estimated number of reads

## Expert Tips

- **Memory Management**: If running out of memory during GC bias correction, use `--reduceGCMemory`.
- **Speed vs. Accuracy**: The `--biasSpeedSamp` option (default 5) can be increased to speed up GC bias modeling at a slight cost to fidelity.
- **Single-Cell**: For 10x Genomics or similar data, use the `salmon alevin` command.
- **Merging Results**: Use `salmon quantmerge` to combine multiple `quant.sf` files into a single expression matrix.



## Subcommands

| Command | Description |
|---------|-------------|
| alevin | salmon-based processing of single-cell RNA-seq data. |
| salmon quant | Quantifies expression using raw reads or already-aligned reads (in BAM/SAM format). |
| salmon_index | Creates a salmon index. |
| salmon_quantmerge | Merge multiple quantification results into a single file. |
| salmon_swim | A tool for single-cell RNA-seq analysis. |

## Reference documentation

- [Salmon Overview](./references/combine-lab_github_io_salmon.md)
- [About Salmon](./references/combine-lab_github_io_salmon_about.md)
- [Getting Started with Salmon](./references/combine-lab_github_io_salmon_getting_started.md)
- [Salmon FAQ](./references/combine-lab_github_io_salmon_faq.md)
- [Salmon GitHub Repository](./references/github_com_COMBINE-lab_salmon.md)