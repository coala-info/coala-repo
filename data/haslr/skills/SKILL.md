---
name: haslr
description: HASLR (Hybrid Assembly of Long Reads) is a specialized tool designed for the fast assembly of genomic data by combining the structural information of long reads with the high base-pair accuracy of short reads.
homepage: https://github.com/vpc-ccg/haslr
---

# haslr

## Overview

HASLR (Hybrid Assembly of Long Reads) is a specialized tool designed for the fast assembly of genomic data by combining the structural information of long reads with the high base-pair accuracy of short reads. It functions by assembling short reads into contigs, aligning them to long reads to create a backbone graph, and then generating a consensus sequence. This approach allows for human-scale genome assembly in a fraction of the time required by traditional long-read-only assemblers.

## Command Line Usage

The primary interface is the Python wrapper `haslr.py`.

### Required Arguments

- `-o, --out`: Output directory.
- `-g, --genome`: Estimated genome size (e.g., `4.6m` for E. coli, `3g` for Human).
- `-l, --long`: Path to the long read file (FASTA/FASTQ).
- `-x, --type`: Type of long reads; must be either `pacbio` or `nanopore`.
- `-s, --short`: One or more short read files (FASTA/FASTQ).

### Common CLI Patterns

**Basic Hybrid Assembly**
```bash
haslr.py -t 16 -o output_dir -g 4.6m -l long_reads.fastq.gz -x nanopore -s short_R1.fastq.gz short_R2.fastq.gz
```

**Assembly with Pre-corrected Long Reads**
If using corrected long reads or PacBio CCS (HiFi) data, you can set the long read coverage to 0 to ensure all reads are utilized:
```bash
haslr.py -t 32 -o output_dir -g 3g -l ccs_reads.fastq -x pacbio --cov-lr 0 -s illumina_reads.fastq
```

**Tuning Assembly Sensitivity**
Adjust the k-mer size for the internal Minia assembly or the minimum alignment similarity:
```bash
haslr.py -o output_dir -g 100m -l reads.fq -x pacbio -s short.fq --minia-kmer 51 --aln-sim 0.90
```

## Best Practices and Expert Tips

- **Genome Size Estimation**: Accuracy in the `-g` parameter is important for the tool to calculate the required coverage depths correctly. Use suffixes `k`, `m`, or `g`.
- **Thread Allocation**: HASLR scales well with threads. For large genomes (e.g., Human), use at least 32-64 threads to achieve the advertised sub-10-hour performance.
- **Iterative Parameter Testing**: If you run HASLR multiple times with different parameters but the same output directory (`-o`), it will reuse existing intermediate files (like short-read contigs) to save time.
- **Output Identification**: The final assembled sequences are always located in the subdirectory named after the parameters used (e.g., `asm_contigs_k49.../`) in a file named `asm.final.fa`.
- **Graph Visualization**: The backbone graph is produced in GFA format (e.g., `backbone.06.smallbubble.gfa`). Use tools like **Bandage** to visualize the assembly graph and assess connectivity.
- **Memory Management**: HASLR is designed for single-node use. If memory is an issue, consider reducing the number of threads or checking the k-mer abundance setting (`--minia-solid`).

## Reference documentation

- [HASLR GitHub Repository](./references/github_com_vpc-ccg_haslr.md)
- [Bioconda HASLR Overview](./references/anaconda_org_channels_bioconda_packages_haslr_overview.md)