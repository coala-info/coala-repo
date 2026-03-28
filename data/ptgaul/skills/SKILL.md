---
name: ptgaul
description: ptgaul is a bioinformatics pipeline that reconstructs complete chloroplast genomes using long-read sequencing data and a reference-based baiting approach. Use when user asks to assemble plastid genomes, reconstruct chloroplast sequences from Nanopore or PacBio reads, or resolve assembly graphs for circular organelle genomes.
homepage: https://github.com/Bean061/ptgaul
---


# ptgaul

## Overview

ptgaul (PlasTid Genome Assembly Using Long reads) is a specialized bioinformatics pipeline designed to reconstruct complete chloroplast genomes. It leverages the length of Nanopore or PacBio reads to bridge repetitive regions that often cause short-read assemblers to produce fragmented results. The tool works by using a reference genome from a closely related species to "bait" and filter relevant long reads from a raw dataset, followed by assembly and path resolution.

## Installation and Environment

The tool is best managed via a Conda environment to handle its dependencies (minimap2, flye, seqkit, etc.).

```bash
conda create --name chloroplast python=3.7
source activate chloroplast
conda install -c bioconda ptgaul
```

## Core CLI Usage

The primary entry point is the `ptGAUL.sh` script. It requires a reference fasta and a long-read data file.

### Basic Command
```bash
ptGAUL.sh -r reference_species.fasta -l raw_long_reads.fastq
```

### Advanced Configuration
Use additional flags to optimize for specific datasets or hardware:
- `-t`: Number of threads (default: 1).
- `-g`: Expected plastome size in bp (default: 160000).
- `-c`: Target coverage for assembly (default: 50).
- `-f`: Minimum read length filter (default: 3000).
- `-o`: Output directory.

**Example:**
```bash
ptGAUL.sh -r ./refs/Beta.fasta -l ./data/reads.fq.gz -t 16 -f 5000 -o ./assembly_results/
```

## Manual Path Resolution

If the automated assembly does not produce a single circular contig (indicated by edge numbers not equaling 1 or 3), you may need to manually resolve the assembly graph using the provided Python utility.

1. Visualize the `assembly_graph.gfa` in **Bandage**.
2. If the graph structure is confirmed, run the combination script:
```bash
combine_gfa.py -e ./output/edges.fa -d ./output/sorted_depth -o ./final_output/
```

## Expert Polishing Workflows

While ptgaul produces a consensus, polishing is highly recommended to improve base-call accuracy, especially for Nanopore data.

### Short-Read Polishing (Recommended)
Using Illumina reads with FMLRC provides the highest accuracy. This requires a pre-built MSBWT index of your short reads.

1. **Build Index:**
```bash
gunzip -c r1.fq.gz r2.fq.gz | awk 'NR % 4 == 2' | sort | tr NT TN | ropebwt2 -LR | tr NT TN | msbwt convert ./msbwt_index
```

2. **Correct Assembly:**
```bash
fmlrc -p 8 ./msbwt_index/comp_msbwt.npy ptgaul_assembly.fasta corrected_cp.fasta
```

### Long-Read Polishing
If short reads are unavailable, use Racon with the original long reads:
```bash
minimap2 -x ava-ont -t 8 ptgaul_assembly.fasta long_reads.fastq > map.paf
racon -t 8 long_reads.fastq map.paf ptgaul_assembly.fasta > polished_assembly.fasta
```

## Troubleshooting Tips

- **Reference Selection**: The reference genome does not need to be an exact match; a species from the same genus or family is usually sufficient for the filtering step.
- **Memory Requirements**: For a standard 10Gbp dataset, 16GB of RAM is typically sufficient.
- **Read Filtering**: If the assembly is fragmented, try increasing the `-f` (filter) threshold to 5000 or higher to force the assembler to use only the longest, most informative reads.



## Subcommands

| Command | Description |
|---------|-------------|
| awk | Pattern scanning and processing language |
| combine_gfa.py | This script is used to merge the edges from assembly graph. |
| gunzip | Decompress FILEs (or stdin) |
| minimap2 | A versatile pairwise aligner for genomic and transcribed nucleotide sequences |
| ptGAUL.sh | this pipeline is used for plastome assembly using long read data. |
| sort | Sort lines of text |
| tr | Translate, squeeze, or delete characters from stdin, writing to stdout |

## Reference documentation
- [ptGAUL GitHub README](./references/github_com_Bean061_ptgaul_blob_main_README.md)
- [ptGAUL Shell Script Reference](./references/github_com_Bean061_ptgaul_blob_main_ptGAUL.sh.md)
- [GFA Combination Utility](./references/github_com_Bean061_ptgaul_blob_main_combine_gfa.py.md)