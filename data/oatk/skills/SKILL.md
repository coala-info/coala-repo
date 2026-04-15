---
name: oatk
description: oatk is a specialized toolkit designed to reconstruct and annotate plant organelle genomes from high-fidelity sequencing reads or assembly graphs. Use when user asks to assemble mitochondrial or plastid genomes, extract organelle sequences from GFA files, or resolve circular genome structures using HMM profiles.
homepage: https://github.com/c-zhou/oatk
metadata:
  docker_image: "quay.io/biocontainers/oatk:1.0--h577a1d6_1"
---

# oatk

## Overview
oatk (Organelle Assembly ToolKit) is a specialized suite designed to reconstruct complex plant organelle genomes. It streamlines the process of assembling high-fidelity (HiFi) reads into subgraphs, annotating them using HMM profiles, and resolving the final circular or linear structure of the genome. The toolkit is essential when you need to separate organelle sequences from nuclear contamination or when working with assembly graphs from other tools like MBG or Hifiasm to extract specific organelle contigs.

## Core CLI Usage

### The Standard Wrapper
The most efficient way to run the full pipeline (assembly, annotation, and pathfinding) is using the `oatk` wrapper.

```bash
oatk -k 1001 -c 30 -t 8 \
  -m mito_database.fam \
  -p pltd_database.fam \
  -o output_prefix \
  input_reads.hifi.fa.gz
```

### Key Parameters and Tuning
- **`-c` (Coverage Threshold)**: This is the most critical parameter for successful assembly. Set this to **5-10 times the nuclear genome coverage**. This helps the assembler ignore nuclear reads and NUMTs (Nuclear Mitochondrial DNA) while focusing on the high-copy organelle reads.
- **`-k` (Syncmer Size)**: Default is 1001. Adjusting this can help resolve repeats, though the default is optimized for HiFi data.
- **`-m` and `-p`**: Provide the path to the HMM profile databases (from OatkDB) for mitochondria and plastids respectively.

## Working with External Assembly Graphs
If you have already assembled your data using another tool (e.g., MBG, Spades, Hifiasm), you can use `oatk` to extract the organelle genomes from the existing GFA file.

```bash
oatk -G input_graph.gfa \
  -m mito_database.fam \
  -p pltd_database.fam \
  -o output_prefix \
  --kmer-c-tag FC:f --edge-c-tag ec:i
```

**Expert Tip**: When using external GFAs, you must specify the correct coverage tags. For MBG, use `--kmer-c-tag FC:f` and `--edge-c-tag ec:i`. Without these, `oatk` may fail to resolve the genome structure correctly.

## Auxiliary Tools

### Sequence Rotation
Organelle genomes are often circular. Use `rotate` to set a specific starting position (e.g., a specific gene or the start of the Large Single Copy region).
```bash
rotate -p <position> input.fasta > rotated.fasta
```

### Extracting Paths to FASTA
If you have identified a specific path in a GFA file, use `path_to_fasta` to generate the sequence.
```bash
path_to_fasta -g assembly.gfa -p "path_string" > sequence.fasta
```

## Best Practices
1. **Database Selection**: For land plants, always start with the `embryophyta` database from OatkDB unless a more specific lower-rank taxonomy database is available.
2. **Dependency Check**: Ensure `nhmmscan` (from the HMMER suite) is in your PATH or provide the path explicitly using `--nhmmscan`.
3. **Input Formats**: The tool accepts FASTA/FASTQ, plain or gzipped. You can provide multiple input files in a single command.
4. **Output Interpretation**:
   - `.utg.final.gfa`: The complete assembly graph.
   - `.mito.ctg.fasta` / `.pltd.ctg.fasta`: The final resolved organelle contigs.
   - `.bed` files: Gene annotations for the resulting sequences.

## Reference documentation
- [Oatk GitHub Repository](./references/github_com_c-zhou_oatk.md)
- [Oatk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_oatk_overview.md)