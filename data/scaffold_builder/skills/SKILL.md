---
name: scaffold_builder
description: Scaffold_builder aligns de novo assembled contigs against a reference genome to determine their relative order and orientation for a more contiguous assembly. Use when user asks to scaffold contigs, order and orient assembly fragments against a reference, or bridge gaps in a de novo assembly.
homepage: http://edwards.sdsu.edu/scaffold_builder
---


# scaffold_builder

## Overview
The `scaffold_builder` tool is a Python-based utility designed to bridge the gap between de novo assembly and reference-guided mapping. It takes a set of de novo assembled contigs (in FASTA format) and aligns them against a reference genome to determine their relative order and orientation. By identifying overlaps and gaps, it generates a more contiguous scaffolded assembly, making it an essential step in finishing microbial or small eukaryotic genomes.

## Usage Patterns

### Basic Scaffolding
The primary workflow involves providing a query file (your contigs) and a reference file.
```bash
python scaffold_builder.py -q contigs.fasta -r reference.fasta -p output_prefix
```

### Key Parameters and Tuning
- `-q <file>`: Query sequences (de novo contigs) in FASTA format.
- `-r <file>`: Reference genome sequence in FASTA format.
- `-p <string>`: Prefix for all output files.
- `-o <int>`: Minimum overlap length required to merge contigs (default is often 20bp, but increase this for higher confidence).
- `-i <float>`: Minimum identity threshold (e.g., 0.9 for 90%) for alignments to be considered valid.

### Expert Tips
- **Contig Pre-processing**: Ensure your input contigs have been filtered for length. Very short contigs (<200bp) often align non-specifically and can create false joins.
- **Reference Selection**: The quality of the scaffolding is highly dependent on the evolutionary distance of the reference. If using a distant relative, lower the identity threshold (`-i`), but be prepared for more misassemblies.
- **Output Inspection**: Always check the `.log` and `.agp` files generated. The AGP file describes the layout of the scaffolds and indicates where gaps (Ns) were inserted.
- **Handling Circularity**: If working with circular bacterial chromosomes, `scaffold_builder` can help identify if the ends of your assembly overlap, suggesting a complete circularization.

## Reference documentation
- [scaffold_builder Overview](./references/anaconda_org_channels_bioconda_packages_scaffold_builder_overview.md)