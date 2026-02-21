---
name: frag_gene_scan_rs
description: FragGeneScanRs is a high-performance Rust implementation of the FragGeneScan model.
homepage: https://github.com/unipept/FragGeneScanRs
---

# frag_gene_scan_rs

## Overview
FragGeneScanRs is a high-performance Rust implementation of the FragGeneScan model. It is designed to identify coding regions in DNA sequences that may contain sequencing errors or are fragmented, which is common in metagenomic datasets. It provides significant speed improvements over the original C-based tool while maintaining compatibility with its training models.

## Core Workflows

### Basic Gene Prediction
By default, the tool reads from standard input and writes predicted protein sequences (amino acids) to standard output.

```bash
# Predict proteins from Illumina reads with ~0.5% error rate
FragGeneScanRs -t illumina_5 < input.fna > output.faa
```

### Comprehensive Output Generation
To generate multiple output formats (metadata, nucleotides, and amino acids) simultaneously, use the `-o` prefix option.

```bash
# Generates output.out, output.ffn, and output.faa
FragGeneScanRs -s input.fna -o output -w 0 -t illumina_10 -p 4
```

### Specific Output Formats
You can direct specific data types to individual files or stdout using dedicated flags. These take precedence over the `-o` option.

- `-m`: Metadata (start, end, strand, frame, score)
- `-n`: Nucleotide sequences of predicted genes
- `-a`: Amino acid sequences of predicted genes
- `-g`: GFF format output

```bash
# Output GFF to a file and proteins to stdout
FragGeneScanRs -t complete -g predictions.gff < input.fna > proteins.faa
```

## Parameter Reference

### Training Models (`-t`)
Select the model that best matches your data source and expected error rate:
- `complete`: For finished genomes or error-free short reads.
- `illumina_5` / `illumina_10`: Illumina reads (0.5% or 1% error).
- `454_5` / `454_10` / `454_30`: 454 pyrosequencing (0.5%, 1%, or 3% error).
- `sanger_5` / `sanger_10`: Sanger reads (0.5% or 1% error).

### Sequence Type (`-w`)
- `-w 0`: For short sequence reads (default).
- `-w 1`: For complete genomic sequences.

## Expert Tips

- **Performance Boost**: Use the `-u` flag to enable unordered output. This reduces memory overhead and increases speed during multithreaded execution, though the output order will not match the input FASTA order.
- **Thread Scaling**: Use `-p <threads>` to utilize multiple CPU cores. FragGeneScanRs scales efficiently with thread count.
- **Training Directory**: If the tool cannot find the training files, explicitly point to them using `-r /path/to/train/`.
- **Piping**: Since the tool supports stdin/stdout, it is ideal for bioinformatics pipelines (e.g., piping directly from a quality control tool or into a functional annotation tool).

## Reference documentation
- [FragGeneScanRs GitHub Repository](./references/github_com_unipept_FragGeneScanRs.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_frag_gene_scan_rs_overview.md)