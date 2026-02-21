name: alen
description: Simple terminal sequence alignment viewer for DNA or protein FASTA files. Use when you need a quick, interactive view of alignments in the shell to check consensus, translate DNA, or search for motifs without leaving the command line.

# alen

`alen` is a lightweight, terminal-based viewer for biological sequence alignments. It is designed for rapid inspection rather than heavy editing.

## Basic Usage

View an alignment file:
```bash
alen path/to/alignment.fasta
```

`alen` supports compressed files automatically:
```bash
alen alignment.fasta.gz
alen alignment.fasta.zst
```

## Interactive Controls

Once the viewer is open, use the following keys to navigate and analyze the alignment:

### Navigation
- **Arrow Keys**: Move 1 column or row.
- **Shift + Arrow Keys**: Move 10 columns or rows.
- **Ctrl + Arrow Keys**: Jump to the first or last column/row.
- **Ctrl-j**: Jump to a specific column number.

### Analysis & View Toggles
- **c**: Toggle consensus sequence comparison (highlights differences).
- **t**: Toggle DNA to protein translation (only for DNA alignments).
- **f**: Rotate the reading frame (when translation is active).
- **r**: Force a screen re-render.

### Search & Organization
- **Ctrl-f**: Find. Searches headers and sequences using regex (case-insensitive).
- **Ctrl-s**: Select and move rows to reorder the alignment view.

### Exit
- **Esc / q / Ctrl-C**: Quit the viewer.

## Expert Tips & Constraints

- **Memory Limit**: `alen` loads the entire alignment into memory. Avoid using it for multi-gigabyte files; it is best suited for gene-scale or moderately sized genomic alignments.
- **Auto-detection**: The tool automatically detects whether the input is nucleotide or amino acid data.
- **FASTA Only**: Ensure input files are in FASTA format.
- **Terminal Environment**: If the display appears corrupted after resizing the terminal, press `r` to re-render the interface.
- **Non-Destructive**: `alen` is a viewer, not an editor. It will not modify your original FASTA files.