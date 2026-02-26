---
name: showali
description: showali is a terminal-based viewer for the rapid inspection and visualization of aligned biological sequences. Use when user asks to visualize multiple sequence alignments in the command line, inspect alignment files like FASTA or PHYLIP, or sanity-check alignment outputs.
homepage: https://github.com/kirilenkobm/showali
---


# showali

## Overview
showali is a lightweight, terminal-based viewer designed for the rapid inspection of aligned biological sequences. It provides a "glance-and-go" workflow for bioinformaticians, allowing for the visualization of alignments directly within a terminal session. It prioritizes speed and simplicity over complex editing features, making it an ideal tool for sanity-checking alignment outputs or exploring sequence relationships in a command-line environment.

## Installation
The tool is available via Bioconda:
```bash
conda install -c bioconda showali
```

## Usage and CLI Patterns
The basic syntax is straightforward:
```bash
showali <alignment_file>
```

### Supported Formats
showali automatically detects the following formats:
- **FASTA**: Standard aligned fasta files.
- **MAF**: Multiple Alignment Format.
- **PHYLIP**: Interleaved or sequential (.phy).
- **CLUSTAL/ALN**: Standard Clustal alignment files (.aln).

### Navigation and Controls
Once the TUI is open, use the following controls for navigation:
- **WASD Keys**: Use W (up), A (left), S (down), and D (right) for rapid directional navigation through the alignment.
- **Search**: Access the built-in search function to locate specific motifs or sequence IDs.
- **Selection**: Supports rectangular selection for highlighting specific blocks of the alignment.
- **Ruler**: A ruler is displayed at the top of the interface to help track genomic or protein coordinates.

### Display Options
- **Coloring**: The tool includes automatic protein sequence coloring by default.
- **No Color Mode**: If working in a terminal with limited color support or if a plain text view is preferred, use the `--no-color` flag:
  ```bash
  showali --no-color my_alignment.fasta
  ```

## Expert Tips
- **Quick Inspection**: Use showali as a final step in a pipeline to verify that an alignment tool (like ClustalW or MAFFT) produced a reasonable result before proceeding to downstream analysis.
- **Format Flexibility**: Since showali auto-detects formats, you can use it as a universal viewer for various alignment outputs without needing to specify the input type.
- **Minimalist Workflow**: It is designed to do one thing well: viewing. For heavy editing or complex MSA manipulation, consider piping data to other tools, but use showali for the immediate visual feedback loop.

## Reference documentation
- [showali - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_showali_overview.md)
- [GitHub - kirilenkobm/showali: TUI sequences viewer](./references/github_com_kirilenkobm_showali.md)
- [Commits · kirilenkobm/showali · GitHub](./references/github_com_kirilenkobm_showali_commits_master.md)