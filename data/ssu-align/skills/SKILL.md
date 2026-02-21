---
name: ssu-align
description: The `ssu-align` package is a specialized toolset for structural alignment of SSU rRNA sequences.
homepage: http://eddylab.org/software/ssu-align/
---

# ssu-align

## Overview
The `ssu-align` package is a specialized toolset for structural alignment of SSU rRNA sequences. Unlike standard sequence-only aligners, it utilizes covariance models (CMs) that incorporate conserved secondary structure information to produce high-quality alignments. This skill provides the procedural knowledge to execute the core workflow: identifying the source domain of sequences, generating structural alignments, masking unreliable positions, and merging results for downstream phylogenetic analysis.

## Core Workflow and Commands

### 1. Sequence Identification and Initial Alignment
The first step is to parse a FASTA file to identify which sequences belong to which domain (Archaea, Bacteria, or Eukarya) and align them to the corresponding model.

```bash
ssu-align <input_fasta> <output_directory>
```
- **Tip**: This command automatically sorts sequences into subdirectories based on their best-scoring model.
- **Key Output**: Look for `.stk` (Stockholm format) files in the output directory.

### 2. Masking Alignments
To improve phylogenetic signal, use `ssu-mask` to remove columns in the alignment that are poorly conserved or have high gap frequencies.

```bash
ssu-mask <output_directory>
```
- **Default Behavior**: It uses pre-defined masks specific to the SSU rRNA models.
- **Customization**: Use `--thresh <f>` to specify a frequency threshold for masking columns.

### 3. Merging and Exporting
After masking, you often need to merge the alignments or convert them to a format suitable for tree-building software (like Phylip or FASTA).

```bash
ssu-merge --stk <output_directory>
```
- **ssu-merge**: Combines the individual domain alignments into a single file.
- **ssu-draw**: Use this to generate postscript visualizations of the secondary structure with alignment statistics mapped onto them.

## Expert Tips
- **Large Datasets**: `ssu-align` is designed for "millions of sequences." If running on a cluster, ensure you have sufficient disk space for the intermediate Stockholm files.
- **LSU rRNA**: While optimized for SSU, the tool can be used for Large Subunit (LSU) rRNA if you provide custom covariance models.
- **Infernal Version**: Note that `ssu-align` uses a version of Infernal similar to 1.0.2. While newer versions of Infernal (1.1+) exist, `ssu-align` commands remain consistent with the bundled version for stability in structural alignment.
- **Phylogeny**: Remember that `ssu-align` does not build trees; it prepares the alignment. You must export the masked alignment to a tool like RAxML or FastTree.

## Reference documentation
- [SSU-ALIGN Overview](./references/eddylab_org_software_ssu-align.md)
- [SSU-ALIGN README](./references/eddylab_org_software_ssu-align_README.md)
- [Release Notes](./references/eddylab_org_software_ssu-align_00RELEASE.md)