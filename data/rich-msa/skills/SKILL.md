---
name: rich-msa
description: rich-msa provides colorful, high-quality Multiple Sequence Alignment visualization directly in the terminal. Use when user asks to visualize sequence alignments, identify conserved regions, or render color-coded MSA data in the command line.
homepage: https://github.com/althonos/rich-msa
---


# rich-msa

## Overview

`rich-msa` is a specialized tool designed to bring high-quality, colorful Multiple Sequence Alignment (MSA) visualization to the terminal. By leveraging the `rich` library, it transforms raw alignment data into a readable, color-coded format that scales to the terminal's width. Use this skill when you need to verify alignment quality, identify conserved regions, or debug sequence data directly within a command-line environment.

## Installation

Ensure the tool and its primary dependency (Biopython) are installed:

```bash
pip install rich-msa biopython
# OR
conda install -c bioconda rich-msa
```

## Command-Line Usage

The most efficient way to use `rich-msa` is via its module interface.

### Basic Visualization
To view an aligned FASTA file (the default format):
```bash
python -m rich_msa -i sequences.fasta
```

### Specifying Alignment Formats
If your file is not in FASTA format, use the `-f` flag. `rich-msa` supports any format recognized by `Bio.AlignIO` (e.g., clustal, stockholm, phylip):
```bash
python -m rich_msa -i alignment.aln -f clustal
```

### Advanced CLI Options
*   **Custom Coloring**: You can pass a Gecos color file to customize residue highlighting:
    ```bash
    python -m rich_msa -i sequences.fasta --colors gecos_style.txt
    ```

## Python API Integration

For more control, such as embedding alignments within larger terminal dashboards or reports, use the Python API.

### Rendering with Biopython
```python
import Bio.AlignIO
from rich_msa import RichAlignment
from rich.console import Console

# Load the alignment
msa = Bio.AlignIO.read("alignment.fasta", "fasta")

# Create the renderable
viewer = RichAlignment(
    names=[record.id for record in msa],
    sequences=[str(record.seq) for record in msa]
)

# Print to terminal
console = Console()
console.print(viewer)
```

## Best Practices and Tips

*   **Terminal Width**: The output automatically scales to your terminal width. For very long alignments, ensure your terminal window is maximized or use a terminal multiplexer like `tmux` to manage large outputs.
*   **Panel Wrapping**: To add a title or border around your alignment, wrap the `RichAlignment` object in a `rich.panel.Panel`.
*   **Residue Styles**: The library allows for configuring the styles of individual letters in the alignment when used via the Python API, which is useful for highlighting specific motifs or mutations.
*   **Biopython Dependency**: Always ensure `biopython` is installed in the same environment as `rich-msa`, as the CLI relies on it for parsing alignment files.

## Reference documentation
- [rich-msa GitHub Repository](./references/github_com_althonos_rich-msa.md)
- [rich-msa Commit History](./references/github_com_althonos_rich-msa_commits_main.md)