---
name: panoct
description: PanOCT clusters orthologous genes across multiple bacterial genomes by combining BLAST sequence similarity with conserved gene neighborhood information. Use when user asks to identify orthologs, perform pan-genome clustering, or distinguish between orthologs and paralogs using synteny data.
homepage: https://panoct.sourceforge.io/
---


# panoct

## Overview
PanOCT (Pan-genome Ortholog Clustering Tool) is a specialized Perl-based utility for bacterial genomics. Unlike standard graph-based clustering methods that rely solely on BLAST scores, PanOCT incorporates conserved gene neighborhood (CGN) data. This makes it particularly effective for distinguishing between true orthologs and recent paralogs in highly similar strains where sequence identity alone might be ambiguous.

## CLI Usage and Best Practices

### Core Workflow
PanOCT typically requires three main inputs:
1.  **BLAST Results**: All-vs-all BLASTP results (usually in `-m 8` or `-outfmt 6` tabular format).
2.  **Attribute Files**: Files containing gene coordinates and functional annotations for each genome.
3.  **Configuration/Input List**: A file mapping genome IDs to their respective attribute files.

### Common Command Pattern
```bash
panoct.pl -gh <blast_file> -p <attribute_dir> -f <input_list> [options]
```

### Expert Tips for Success
-   **Synteny Weighting**: The strength of PanOCT lies in its use of micro-synteny. Ensure your attribute files are correctly formatted with contiguous gene coordinates, as the tool uses the physical distance and order of genes to calculate clustering scores.
-   **E-value Thresholds**: While PanOCT filters based on homology, it is often better to provide a pre-filtered BLAST file with a strict E-value (e.g., 1e-5 or 1e-10) to reduce computational overhead.
-   **Handling Draft Genomes**: When working with draft assemblies (contigs/scaffolds), be aware that synteny breaks at contig boundaries. PanOCT handles this, but clusters near edges may have lower synteny scores.
-   **Output Interpretation**: The primary output is a cluster file where each row represents an orthologous group. Use the "match type" column to identify if a cluster was joined primarily by homology or supported by strong synteny.

### Installation via Bioconda
The most reliable way to manage PanOCT's Perl dependencies is through Conda:
```bash
conda install -c bioconda panoct
```

## Reference documentation
- [PanOCT Overview on Bioconda](./references/anaconda_org_channels_bioconda_packages_panoct_overview.md)
- [PanOCT Project Documentation and Wiki](./references/sourceforge_net_projects_panoct.md)