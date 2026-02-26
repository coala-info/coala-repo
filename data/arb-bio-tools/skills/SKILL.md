---
name: arb-bio-tools
description: ARB is a software suite for managing large-scale sequence databases, performing phylogenetic analysis, and designing taxon-specific probes. Use when user asks to manage rRNA datasets, align sequences based on secondary structure, reconstruct phylogenetic trees, or design and verify molecular probes.
homepage: http://www.arb-home.de
---


# arb-bio-tools

## Overview
The ARB (Latin for "tree") software suite is a specialized environment for handling large-scale sequence databases with a focus on phylogeny-based data organization. It is primarily used by the microbial ecology community for maintaining manually curated rRNA datasets (like SILVA), performing sequence alignments, and reconstructing phylogenetic trees. This skill provides guidance on utilizing the ARB toolset for sequence database management, probe design, and phylogenetic analysis.

## Core Functionalities
- **Database Management**: Centralized storage of aligned sequences and associated metadata, structured according to phylogenetic relationships.
- **Sequence Editing & Alignment**: Integrated editors (e.g., ARB_EDIT4) for primary structure analysis, automated alignment, and secondary structure verification.
- **Phylogenetics**: Support for distance matrix, maximum parsimony, and maximum likelihood methods.
- **Probe/Primer Design**: Tools for evaluating sequence signatures and designing taxon-specific probes against comprehensive database backgrounds.
- **PT Server**: Positional Tree server for rapid searching of closest relatives and specific sequence signatures.

## Common CLI and Workflow Patterns

### Installation via Conda
The tools are available via the Bioconda channel.
```bash
conda install -c bioconda arb-bio-tools
```

### Database Operations
ARB uses a proprietary database format. While much of the interaction is graphical, the following concepts are essential for CLI-based preparation:
- **Importing Data**: Supports flat-file formats (GenBank, EMBL, FASTA).
- **PT Server Generation**: Before designing probes or searching for relatives, a PT (Positional Tree) server must be built for the specific database to enable rapid indexing.

### Probe Design Workflow
1. **Select Target Group**: Identify the cluster of sequences in the database for which a probe is needed.
2. **Run Probe Design**: Use the integrated tool to find potential signatures.
3. **Match against Database**: Use the PT Server to check the specificity of the candidate probe against all other entries in the database.

### Alignment Best Practices
- **Secondary Structure**: When aligning rRNA, use the integrated secondary structure check to ensure biological accuracy.
- **Filters**: Apply column filters (positional masks) to exclude highly variable or non-homologous regions before performing phylogenetic tree reconstructions.

## Expert Tips
- **Memory Management**: ARB is memory-intensive. For databases exceeding 20,000 entries, ensure the host system has sufficient RAM, as the entire database is typically loaded into memory for analysis.
- **SILVA Integration**: ARB is the native environment for the SILVA rRNA database. For best results in microbial identification, use the latest curated SILVA datasets provided in ARB format.
- **Linux Requirements**: The tool suite is optimized for Linux (libc 6 based). If running on macOS, use the Homebrew-maintained recipes. There is no native Windows version.

## Reference documentation
- [ARB Documentation Overview](./references/www_arb-home_de_documentation.html.md)
- [ARB Features and Capabilities](./references/www_arb-home_de_features.html.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_arb-bio-tools_overview.md)
- [ARB Download and Installation Guide](./references/www_arb-home_de_downloads.html.md)