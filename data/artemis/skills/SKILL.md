---
name: artemis
description: Artemis is a suite of tools for the visualization, annotation, and comparison of genomic data and sequencing reads. Use when user asks to visualize genomic features, compare DNA sequences, view BAM or CRAM alignment files, or generate circular and linear DNA maps.
homepage: http://sanger-pathogens.github.io/Artemis/
---


# artemis

## Overview
Artemis is a specialized suite of Java-based tools designed for the visualization and annotation of genomic data. This skill enables the efficient use of the four primary components: Artemis (genome browser), ACT (comparison tool), BamView (NGS data viewer), and DNAPlotter (image generation). It is particularly useful for researchers needing to integrate high-throughput sequencing data with reference annotations or to perform comparative genomics.

## Installation and Environment
The recommended method for installing the Artemis suite is via Bioconda, which manages Java dependencies automatically.

```bash
# Install via Bioconda
conda config --add channels bioconda
conda config --add channels conda-forge
conda install artemis
```

### Memory Management
Java tools often require manual memory allocation for large datasets. Use the `ARTEMIS_JVM_FLAGS` environment variable to prevent "Out of Memory" errors:
- **Standard allocation**: `-mx2g -ms100m` (2GB max)
- **High-memory allocation**: `-mx4g` (4GB max)

## Tool-Specific CLI Patterns

### Artemis (Genome Browser)
Used for viewing sequence features and six-frame translations.
- **Launch empty**: `art`
- **Open specific file**: `art <sequence_file.embl|genbank|fasta>`
- **Help**: `art -help`

### ACT (Artemis Comparison Tool)
Used for displaying pairwise comparisons between two or more DNA sequences.
- **Launch with files**: `act <sequence1.embl> <comparison_file.crunch> <sequence2.embl>`
- **Comparison generation**: Comparison files can be generated via BLASTN, TBLASTX, or Mummer.

### BamView (NGS Viewer)
Visualizes read-alignment data (BAM/CRAM) in the context of a reference.
- **Basic usage**: `bamview -a <file.bam>`
- **With reference**: `bamview -a <file.cram> -r <reference.fasta>`
- **Remote files**: Supports `http://` and `ftp://` paths for the `-a` argument.
- **Requirement**: Alignment files must be sorted and indexed (`samtools sort` and `samtools index`).

### DNAPlotter (Map Generation)
Generates circular or linear DNA maps for publication.
- **Launch with template**: `dnaplotter -t <template_file.xml>`
- **Supported formats**: Reads EMBL, GenBank, and GFF3.

## Expert Tips
- **CRAM References**: BamView attempts to download missing CRAM references from EBI. Control this using `REF_PATH` and `REF_CACHE` environment variables (similar to samtools).
- **File Extensions**: Ensure BAM/CRAM indices follow the naming convention: `<filename>.bam.bai` or `<filename>.cram.crai`.
- **Mac Security**: If running the `.app` versions on macOS, you may need to allow the application in "Security & Privacy" settings due to the "unidentified developer" flag.
- **Chado Integration**: For database connectivity, use the specific Chado-enabled launch scripts or DMG versions if working with relational genomic databases.

## Reference documentation
- [Artemis Overview](./references/sanger-pathogens_github_io_Artemis_Artemis.md)
- [ACT Manual](./references/sanger-pathogens_github_io_Artemis_ACT.md)
- [BamView Documentation](./references/sanger-pathogens_github_io_Artemis_BamView.md)
- [DNAPlotter Guide](./references/sanger-pathogens_github_io_Artemis_DNAPlotter.md)