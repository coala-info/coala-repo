---
name: pbstarphase
description: pbstarphase is a specialized diplotyper that uses PacBio HiFi data to resolve complex pharmacogenomic regions and call genotypes. Use when user asks to call PGx diplotypes, perform HLA typing, or analyze structural variants in the CYP2D6 locus.
homepage: https://github.com/PacificBiosciences/pb-StarPhase
---


# pbstarphase

## Overview
The `pbstarphase` tool is a specialized diplotyper that leverages the long-read advantages of PacBio HiFi data to resolve complex pharmacogenomic regions. Unlike traditional tools that may struggle with structural variants or highly homologous pseudogenes (like CYP2D7), this tool uses phase-aware algorithms to accurately call diplotypes. It is essential for researchers and clinicians looking to translate PacBio sequencing results into actionable PGx genotypes based on CPIC and IMGTHLA standards.

## Installation
The recommended method for installation is via Bioconda:
```bash
conda install bioconda::pbstarphase
```

## Common CLI Patterns

### Basic Diplotyping
To run the standard diplotyping workflow on a BAM file, use the `diplotype` command. You typically need a reference genome and the input BAM.
```bash
pbstarphase diplotype --reference ref.fa --input sample.bam --output-prefix sample_pgx
```

### Database Management
`pbstarphase` allows you to create or update the underlying allele database using the latest CPIC and IMGTHLA information.
```bash
pbstarphase create-db --cpic-dir ./cpic_data --imgthla-dir ./imgthla_data --output pgx_db.json
```

### Targeted vs. WGS
*   **Targeted Sequencing:** When working with targeted amplicons, ensure the BAM is properly aligned to the specific gene regions.
*   **WGS:** For whole-genome data, the tool efficiently parses the relevant PGx loci.

## Expert Tips and Best Practices
*   **CYP2D6 Analysis:** `pbstarphase` is specifically optimized for the CYP2D6 locus, which often involves structural variants (SVs) and gene conversions. Ensure you are using the latest version (v2.0.0+) for improved suballele expansion and SV support.
*   **HLA Typing:** The tool supports HLA-A and HLA-B. For the most accurate results, ensure your input data has sufficient coverage over the highly polymorphic MHC region.
*   **Input Quality:** While the tool is robust, high-quality HiFi reads (Q20+) provide the best phasing performance, especially for distinguishing between functional genes and pseudogenes.
*   **Resource Management:** For large WGS datasets, monitor memory usage during the diplotyping phase, as high-depth regions or complex SVs in CYP2D6 can increase computational requirements.

## Reference documentation
- [github_com_PacificBiosciences_pb-StarPhase.md](./references/github_com_PacificBiosciences_pb-StarPhase.md)
- [anaconda_org_channels_bioconda_packages_pbstarphase_overview.md](./references/anaconda_org_channels_bioconda_packages_pbstarphase_overview.md)