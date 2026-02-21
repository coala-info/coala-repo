---
name: arb-bio
description: ARB is a graphically-oriented software suite designed for the handling and analysis of large sequence databases, specifically optimized for ribosomal RNA (rRNA) data.
homepage: http://www.arb-home.de
---

# arb-bio

## Overview
ARB is a graphically-oriented software suite designed for the handling and analysis of large sequence databases, specifically optimized for ribosomal RNA (rRNA) data. It integrates tools for sequence alignment, phylogenetic tree construction, and probe design into a single environment linked to a central database. This skill covers the installation via Bioconda and the primary workflows supported by the suite, such as database navigation and the use of the PT (Positional Tree) server.

## Installation and Environment Setup
The most efficient way to deploy ARB on modern Linux or macOS systems is through the Bioconda channel.

- **Conda Installation**:
  ```bash
  conda install bioconda::arb-bio
  ```
- **System Requirements**:
  - **Memory**: ARB is memory-intensive. Ensure the system has sufficient RAM relative to the size of the database (e.g., SILVA or Greengenes).
  - **Platform**: Supported on `linux-64` and `macOS-64`.
  - **Dependencies**: Requires a functional X11 environment for the graphical interface. On Linux, verify `libc 6` compatibility using `ldd /bin/su`.

## Core Components and Workflows
ARB operates as a suite of cooperating tools rather than a single monolithic command.

- **Primary Editor (ARB_EDIT4)**: Used for manual and automated sequence alignment. It includes tools for string searching, local alignment optimization, and secondary structure visualization.
- **PT Server (Positional Tree)**: A critical background service that enables rapid searching for closest relatives and specific sequence signatures. It is the foundation for taxon-specific probe design.
- **Database Management**:
  - ARB uses a central database format where sequences are linked to phylogenetic trees and additional metadata.
  - **Importing Data**: Supports flat file formats from EMBL and GenBank.
  - **Exporting Data**: Can generate publication-ready trees and exported sequences in various formats.

## Best Practices
- **Database Integrity**: When downloading ARB databases on Windows to be used in Linux/Mac environments, only download `.gz` files to prevent file corruption.
- **Installation Script**: If not using Conda, always use the `arb_install.sh` script provided in the source tarball rather than manually uncompressing the `.tgz` file to ensure proper environment configuration.
- **Phylogenetic Methods**: Utilize the integrated distance matrix, maximum parsimony, and maximum likelihood tools. For very large datasets (>20,000 entries), use the specialized maximum parsimony approach for tree optimization.
- **Probe Design**: Use the "Probe Design" and "Probe Match" functions in conjunction with a running PT Server to evaluate oligonucleotide accessibility against the full database background.

## Reference documentation
- [ARB Overview and Bioconda Details](./references/anaconda_org_channels_bioconda_packages_arb-bio_overview.md)
- [ARB Documentation and Manuals](./references/www_arb-home_de_documentation.html.md)
- [ARB Features and Capabilities](./references/www_arb-home_de_features.html.md)
- [ARB Download and Installation Instructions](./references/www_arb-home_de_downloads.html.md)