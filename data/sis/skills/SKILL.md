---
name: sis
description: The `sis` (Scaffold Independent of Synteny) tool is a specialized utility for the final stages of small genome assembly.
homepage: http://marte.ic.unicamp.br:8747/
---

# sis

## Overview
The `sis` (Scaffold Independent of Synteny) tool is a specialized utility for the final stages of small genome assembly. It leverages the MUMmer alignment suite to map de novo assembled contigs onto a related reference genome. This process allows for the identification of contig order and orientation, effectively turning fragmented assemblies into structured scaffolds. It is particularly useful for bacterial, viral, or organelle genomes where a high-quality reference of a related strain is available.

## Usage Guidelines

### Basic Workflow
To use `sis`, you typically need two primary inputs: your assembled contigs (query) and a reference genome (target).

```bash
sis -r reference.fasta -q contigs.fasta -o output_directory
```

### Key Parameters and Best Practices
- **Reference Selection**: Choose the most closely related finished genome available. The quality of the scaffolding is directly dependent on the synteny between your contigs and the reference.
- **MUMmer Integration**: Ensure MUMmer is installed and in your system PATH, as `sis` calls `nucmer` and `show-coords` internally.
- **Output Analysis**:
    - Examine the generated `.agp` or scaffold files to verify the placement of contigs.
    - Check for "unplaced" contigs which may represent novel insertions or highly divergent regions not present in the reference.

### Expert Tips
- **Contig Pre-processing**: Filter out very short contigs (e.g., <200bp) before running `sis` to reduce noise and potential misplacements caused by repetitive elements.
- **Circular Genomes**: For circular genomes (like many bacteria), be aware that `sis` might struggle with contigs spanning the origin of replication if the reference is linearized at a different point.
- **Validation**: Always validate the resulting scaffolds by mapping raw reads back to the new scaffolded sequence to check for consistent coverage across the newly formed gaps.

## Reference documentation
- [sis Overview](./references/anaconda_org_channels_bioconda_packages_sis_overview.md)