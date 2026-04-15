---
name: plass
description: PLASS is a specialized tool that assembles protein sequences directly from metagenomic sequencing reads or performs protein-guided nucleotide assembly. Use when user asks to assemble protein sequences from DNA reads, perform protein-guided nucleotide assembly, or recover protein sequences from low-coverage environmental samples.
homepage: https://github.com/soedinglab/plass
metadata:
  docker_image: "quay.io/biocontainers/plass:5.cf8933--hd6d6fdc_3"
---

# plass

## Overview

PLASS (Protein-Level ASSembler) and PenguiN (Protein-guided Nucleotide assembler) are specialized tools designed to extract maximum biological information from complex environmental sequencing datasets. Unlike traditional assemblers that work strictly at the DNA level, PLASS assembles sequences in protein space, which allows for much higher sensitivity and recovery of protein sequences from low-coverage or highly diverse samples. PenguiN extends this logic by using translated protein information to guide the assembly of nucleotide contigs, making it an industry-leading choice for strain-resolved assembly of viral genomes and 16S rRNA genes.

## Assembly Workflows

### Protein Assembly (PLASS)
Use the `assemble` command to convert nucleotide reads directly into assembled protein sequences.

```bash
# Paired-end reads
plass assemble reads_1.fastq.gz reads_2.fastq.gz assembly.fas tmp

# Single-end reads
plass assemble reads.fastq.gz assembly.fas tmp

# Using stdin
cat reads.fastq.gz | plass assemble stdin assembly.fas tmp
```

### Nucleotide Assembly (PenguiN)
Use `guided_nuclassemble` for high-fidelity nucleotide contigs guided by protein information.

```bash
penguin guided_nuclassemble reads_1.fastq.gz reads_2.fastq.gz assembly.fas tmp
```

## Key Parameters and Optimization

| Parameter | Description | Default/Tip |
|-----------|-------------|-------------|
| `--min-seq-id` | Adjusts the overlap sequence identity threshold | Lower for higher sensitivity |
| `--min-length` | Minimum codon length for ORF prediction | Default: 40 |
| `-e` | E-value threshold for overlaps | Controls statistical significance |
| `--num-iterations` | Number of assembly iterations | More iterations can improve contiguity |
| `--filter-proteins` | Switches the neural network protein filter off/on | Keep on to reduce noise |

## Expert Tips

- **Performance**: Always use the AVX2-compiled binary if your CPU supports it, as the assembly process is computationally intensive.
- **Temporary Storage**: The `tmp` directory can grow significantly. Ensure it is located on a high-speed SSD with sufficient space to prevent I/O bottlenecks.
- **Memory Management**: For extremely large metagenomes, monitor RAM usage closely; the protein-level overlap graph can be memory-intensive.
- **Input Formats**: Both tools natively support gzipped FASTQ and FASTA files.



## Subcommands

| Command | Description |
|---------|-------------|
| penguin | protein-guided nucleotide assembler. Assemble nucleotide sequences by iterative greedy overlap assembly using protein and nucleotide information. |
| plass assemble | Protein-level assembly of metagenomic samples |

## Reference documentation
- [PLASS and PenguiN README](./references/github_com_soedinglab_plass_blob_master_README.md)
- [PLASS Main Repository](./references/github_com_soedinglab_plass.md)