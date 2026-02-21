---
name: itsx
description: The `itsx` skill provides a specialized workflow for processing eukaryotic ribosomal sequences.
homepage: http://microbiology.se/software/itsx/
---

# itsx

## Overview
The `itsx` skill provides a specialized workflow for processing eukaryotic ribosomal sequences. It identifies and isolates the highly variable ITS1 and ITS2 subregions while trimming away the highly conserved SSU, 5S, and LSU rRNA genes. This tool is essential for researchers working with fungal metabarcoding or environmental DNA (eDNA) datasets where precise sequence extraction is required for accurate species identification and diversity analysis.

## Core Usage Patterns

### Basic Extraction
To extract ITS regions from a FASTA file using default settings (optimized for fungi):
```bash
ITSx -i input.fasta -o output_prefix
```

### Specifying Target Groups
While fungi are the default, `itsx` supports various eukaryotic groups. Use the `-t` flag to specify the organism type:
- **Common groups**: `f` (Fungi), `a` (Alveolata), `b` (Bryophyta), `c` (Chlorophyta), `m` (Metazoa), `p` (Phaeophyceae).
- **Example for Metazoa**:
```bash
ITSx -i sequences.fasta -o metazoa_its -t m
```

### Performance Optimization
For large datasets, utilize multicore support to significantly reduce processing time:
```bash
ITSx -i large_dataset.fasta -o results --cpu 8
```

### Handling Truncated Sequences
If working with sequences that might not contain the full ITS region (e.g., short reads), use the partial extraction flags:
- `--partial <number>`: Allows for the detection of partial ITS regions (0 = no partials, 1 = allow partials).
- `--preserve T`: Keeps the original sequence headers in the output.

## Expert Tips
- **Avoid Misleading Results**: Always use `itsx` before performing clustering or taxonomic assignment. Including conserved rRNA gene fragments in your sequences can artificially inflate similarity scores between distantly related species.
- **Output Files**: `itsx` generates several files. Focus on `.ITS1.fasta` and `.ITS2.fasta` for downstream analysis. The `.full_and_partial.fasta` file is useful if you need the entire ITS region (ITS1+5.8S+ITS2).
- **Detailed Logging**: Check the `.log` file if sequences are being filtered out; it provides details on why specific sequences failed to meet the extraction criteria (e.g., no HMMER matches).

## Reference documentation
- [ITSx - Microbiology.se](./references/microbiology_se_software_itsx.md)
- [ITSx Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_itsx_overview.md)