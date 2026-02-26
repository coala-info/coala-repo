---
name: mice
description: mice identifies synteny blocks across multiple genomes by compacting discrete genomic elements into stable markers. Use when user asks to identify synteny blocks, analyze structural variations, or compress pangenome paths into conserved markers.
homepage: https://github.com/gi-bielefeld/mice
---


# mice

## Overview
`mice` (Markers Inferred by Compacting Elements) is a specialized tool for pangenomics that identifies synteny blocks across multiple genomes. It treats genomes as sequences of discrete elements—such as unitigs from a compacted de Bruijn graph, k-mers, or genes—and identifies conserved orderings of these elements. This process effectively "compresses" complex pangenome paths into a set of stable markers, facilitating structural variation analysis and comparative visualization.

## Installation
The tool is available via Bioconda or can be built from source using Rust's package manager:
```bash
# Via Conda/Mamba
mamba install -c bioconda mice

# Via Cargo
cargo install --path .
```

## Core CLI Usage
The primary input is a GFF file where each feature contains an `ID` attribute representing a unique genomic element.

### Basic Execution
```bash
mice input.gff
```

### Common Options
- `-o, --out-dir <DIR>`: Specify the output directory (default is `mice_output`).
- `-r, --remove-dup <X>`: Filters out elements that appear more than `X` times in any single genome. Setting this to `0` (default) disables the filter. Use this to handle repetitive regions that might obscure synteny.
- `-m, --min-size <bp>`: Drops unmerged elements shorter than the specified base pair length after the initial compression phase. This is useful for removing noise from very short fragments.
- `-s, --no-group-by`: By default, `mice` groups paths by genome. Use this flag to treat every individual path as a separate entity.

## Output Files
After execution, the output directory will contain:
- `output.gff`: The final synteny block annotations.
- `paths.txt`: The input genomes rewritten as sequences of the newly identified synteny blocks.
- `partitions.txt`: A mapping file detailing which original elements are contained within each synteny block.

## Expert Tips
- **Pangenome Graph Preparation**: If starting from a GFA file, ensure it is converted to the expected GFF format. The tool expects the `ID` attribute to be a 1-based index specifying the element used in the path.
- **Handling Repetitive Elements**: In complex pangenomes, high-frequency elements (like common k-mers or transposons) can prevent the formation of long synteny blocks. Use the `-r` parameter to prune these elements and produce more contiguous blocks.
- **Quorum and Merging**: Recent updates have introduced parameters like `--quorum` and `--merge-with-dup` to provide finer control over how elements are aggregated into blocks across different genomes.

## Reference documentation
- [mice - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mice_overview.md)
- [GitHub - gi-bielefeld/mice](./references/github_com_gi-bielefeld_mice.md)
- [Commits · gi-bielefeld/mice](./references/github_com_gi-bielefeld_mice_commits_main.md)