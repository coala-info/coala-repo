---
name: ptgaul
description: ptGAUL is a bioinformatics pipeline for the rapid assembly of chloroplast genomes using long-read data and a reference-guided approach. Use when user asks to assemble plastid genomes, perform post-assembly path extraction, or implement polishing workflows for high-quality plastome sequences.
homepage: https://github.com/Bean061/ptgaul
---


# ptgaul

## Overview

ptGAUL (Plastid Genome Assembly Using Long-read data) is a specialized bioinformatics pipeline for the rapid assembly of chloroplast genomes. It utilizes a reference-guided approach combined with long-read data to bridge structural gaps and resolve large repeat regions. Use this skill to automate the assembly process, perform post-assembly path extraction, and implement polishing workflows for high-quality plastome sequences.

## Installation and Environment

Install ptgaul via Bioconda to ensure all dependencies are met:

```bash
conda install -c bioconda ptgaul
```

## Core Usage Patterns

### Basic Assembly
The pipeline requires two mandatory inputs: a reference genome from a closely related species and the raw long-read data.

```bash
ptGAUL.sh -r reference.fasta -l long_reads.fastq.gz
```

### Optimized Assembly
For standard production runs, specify threads, expected genome size, and a dedicated output directory.

```bash
ptGAUL.sh -r reference.fasta -l long_reads.fastq -t 8 -g 160000 -o ./assembly_results
```

### Parameter Tuning
- **Filtering (-f)**: By default, reads shorter than 3000 bp are filtered. Decrease this value if working with shorter long-read libraries or low-input samples.
- **Coverage (-c)**: The default target coverage is 50x. Adjust based on the depth of your input data to improve assembly consistency.

## Manual Path Extraction

If the automated assembly does not produce a standard circular plastome (e.g., edge numbers in the GFA are not 1 or 3), manually run the path combination script after inspecting the graph in Bandage.

```bash
combine_gfa.py -e ./output/edges.fa -d ./output/sorted_depth -o ./final_output/
```

## Polishing Workflows

### Long-read Polishing (Racon)
To improve the initial assembly using the original long reads:

1. Map reads: `minimap2 -x ava-ont -t 8 assembly.fasta reads.fastq > map.paf`
2. Polish: `racon -t 8 reads.fastq map.paf assembly.fasta > polished_assembly.fasta`

### Short-read Polishing (FMLRC)
Hybrid polishing with Illumina data is highly recommended for correcting long-read indels. This requires a pre-built BWT index of the short reads.

1. Build BWT: `gunzip -c r1.fq.gz r2.fq.gz | awk 'NR % 4 == 2' | sort | tr NT TN | ropebwt2 -LR | tr NT TN | msbwt convert ./msbwt_dir`
2. Correct: `fmlrc -p 8 ./msbwt_dir/comp_msbwt.npy assembly.fasta corrected_cp.fasta`

## Expert Tips

- **Reference Selection**: Use a reference from the same genus or family. The pipeline is robust enough to handle references that are not perfectly identical but share conserved synteny.
- **Memory Management**: A typical assembly requires approximately 16GB of RAM for datasets under 10Gbp.
- **Graph Inspection**: Always visualize the `final.gfa` file in Bandage. A successful plastome assembly typically shows a characteristic "dumbbell" or circular structure with two paths representing the different orientations of the Small Single Copy (SSC) region.

## Reference documentation

- [ptgaul Overview](./references/anaconda_org_channels_bioconda_packages_ptgaul_overview.md)
- [ptgaul GitHub Repository](./references/github_com_Bean061_ptgaul.md)