---
name: saffrontree
description: SaffronTree is a specialized bioinformatics tool for constructing pseudo-phylogenomic trees directly from raw sequencing data or assembled sequences.
homepage: https://github.com/sanger-pathogens/saffrontree
---

# saffrontree

# SaffronTree

## Overview
SaffronTree is a specialized bioinformatics tool for constructing pseudo-phylogenomic trees directly from raw sequencing data or assembled sequences. By bypassing the need for a reference genome or de novo assembly, it utilizes k-mer analysis and neighbor-joining algorithms to produce a Newick format tree. This approach is significantly faster than traditional pipelines, making it highly effective for initial data insights and outbreak tracking, particularly for datasets with fewer than 50 samples.

## Usage Patterns

### Basic Command
The standard execution requires an output directory followed by the input files (FASTQ or FASTA, gzipped or raw):
```bash
saffrontree output_directory sample1.fastq.gz sample2.fastq.gz sample3.fastq.gz
```

### Optimizing K-mer Size
The k-mer size (`-k`) significantly impacts results. It must be an odd number.
- **Default (31)**: Generally suitable for standard Illumina reads.
- **Range (25-61)**: Use smaller k-mers for lower quality data to increase sensitivity, or larger k-mers to increase specificity if the data is high quality and has sufficient depth.
- **Tip**: Ensure the k-mer size fits within the high-quality portion of your reads.

### Handling Coverage Depth
Adjust the k-mer frequency thresholds to filter out sequencing noise or repetitive regions:
- **Minimum Threshold (`-m`)**: Default is 5. For raw reads, set this to approximately half the estimated depth of coverage to filter out sequencing errors.
- **Maximum Threshold (`-x`)**: Default is 255. Lower this value if you suspect highly repetitive sequences are skewing the distance calculations.

### Performance and Scaling
- **Threads**: Use `--threads` or `-t` to speed up the k-mer counting phase.
- **Sample Limits**: SaffronTree has a complexity of $O(N^2)$. It performs best with sets of < 50 samples. Beyond this, execution time increases significantly.
- **Intermediate Files**: By default, SaffronTree cleans up temporary files. Use `--keep_files` or `-f` if you need to inspect the k-mer counts or intermediate data for debugging.

## Expert Tips
- **Quality Control**: While SaffronTree is reference-free, quality trimming your FASTQ files before processing can drastically reduce false-positive k-mers caused by sequencing errors at the ends of reads.
- **Mixed Inputs**: You can mix FASTQ and FASTA files in the same command. SaffronTree automatically treats FASTA inputs with a minimum k-mer threshold of 1.
- **Tree Visualization**: The output `kmer_tree.newick` can be viewed in standard phylogenetic tree viewers like FigTree, ITOL, or Microreact.
- **Outbreak Rule-out**: Use this tool as a "first-pass" filter. If samples do not cluster together in SaffronTree, they are unlikely to be part of the same transmission chain, allowing you to rule them out without performing a full assembly-based analysis.

## Reference documentation
- [SaffronTree README](./references/github_com_sanger-pathogens_saffrontree.md)