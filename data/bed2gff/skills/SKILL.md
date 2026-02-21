---
name: bed2gff
description: `bed2gff` is a high-speed, Rust-based utility designed to translate BED files into GFF3 format.
homepage: https://github.com/alejandrogzi/bed2gff
---

# bed2gff

## Overview

`bed2gff` is a high-speed, Rust-based utility designed to translate BED files into GFF3 format. While many tools focus on GTF, `bed2gff` specifically targets the GFF3 layout, preserving reading frames and adjusting indexing counts for features like CDS, start/stop codons, and UTRs. It leverages parallel processing to handle large-scale genomic data (such as GENCODE sets) in seconds.

## CLI Usage and Patterns

### Standard Conversion (Gene-Transcript Mapping)
The most common use case involves a BED file and an "isoforms" file that maps transcript IDs to gene IDs.

```bash
bed2gff --bed input.bed --isoforms mapping.txt --output annotation.gff3
```

**The Isoforms File Format:**
A simple tab-delimited file without a header:
```text
ENSG00000198888    ENST00000361390
ENSG00000198763    ENST00000361453
```

### Simple Conversion (No Gene Mapping)
If you do not have a mapping file or only need a direct conversion of the BED features, use the `--no-gene` flag. In this mode, the `-i` argument is not required.

```bash
bed2gff -b input.bed -o output.gff3 --no-gene
```

### Performance Optimization
`bed2gff` defaults to using the maximum available CPU threads. For shared computing environments, manually restrict thread usage:

```bash
bed2gff -b input.bed -i mapping.txt -o output.gff3 --threads 4
```

### Handling Compressed Data
The tool can produce Gzip-compressed GFF3 output directly, which is recommended for large-scale annotations to save disk space.

```bash
bed2gff -b input.bed -i mapping.txt -o output.gff3.gz --gz
```

## Expert Tips and Best Practices

*   **Input Requirements**: Ensure your BED file contains 12 fields (BED12) if you intend to reconstruct full gene models including exons and CDS. If the BED line has fewer than 12 fields, the tool may fail to parse it into a full `BedRecord`.
*   **Transcript Consistency**: Every transcript name in the 4th column of your BED file must have a corresponding entry in the isoforms mapping file. Missing entries will cause errors during the gene-mapping phase.
*   **Coordinate Systems**: Remember that BED is 0-indexed, half-open, while GFF3 is 1-indexed, fully closed. `bed2gff` handles this coordinate shift automatically.
*   **Feature Reconstruction**: The tool evaluates exon positions to derive CDS, UTR, and codon features. If your BED file lacks thickStart/thickEnd information (columns 7 and 8), the resulting GFF3 may lack CDS features.
*   **BioMart Integration**: You can easily generate the required isoforms mapping file using Ensembl BioMart by exporting "Gene stable ID" and "Transcript stable ID" as a TSV.

## Reference documentation
- [bed2gff Overview](./references/anaconda_org_channels_bioconda_packages_bed2gff_overview.md)
- [bed2gff GitHub Repository](./references/github_com_alejandrogzi_bed2gff.md)