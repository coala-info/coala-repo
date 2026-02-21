---
name: strainseeker
description: StrainSeeker is a specialized command-line program designed to process raw sequencing reads and map them to a hierarchical database of bacterial strains.
homepage: http://bioinfo.ut.ee/strainseeker
---

# strainseeker

## Overview
StrainSeeker is a specialized command-line program designed to process raw sequencing reads and map them to a hierarchical database of bacterial strains. Unlike general metagenomic classifiers, it excels at high-resolution identification down to the strain level and can identify "novel" strains by placing them within the context of a guide tree. It is particularly effective for large datasets where speed and taxonomic precision are required.

## Core Usage Patterns

### Basic Identification
To identify strains from a set of sequencing reads (FASTQ format), the standard execution follows this pattern:
```bash
strainseeker.pl -i <input_reads.fastq> -d <database_directory> -o <output_prefix>
```

### Key Parameters and Best Practices
- **Input Handling**: While primarily designed for raw reads, ensure your input files are in FASTQ format. For paired-end data, it is often best to provide both files or a merged file depending on the specific version requirements.
- **Database Customization**: One of the tool's primary strengths is the ability to use custom databases. You can build a database using your own strains of interest to increase the relevance of the search.
- **Interpreting "Novel" Strains**: If the tool identifies a "novel" strain, it means the reads match a node in the guide tree that does not have a specific leaf-node (strain) match in the database. This indicates a relative of the strains present in your reference set.

### Performance Optimization
- **Large Datasets**: StrainSeeker is optimized for speed. When handling very large datasets, ensure the database is stored on a fast disk (SSD) to minimize I/O bottlenecks during the k-mer lookup process.
- **Memory Management**: Ensure your environment has sufficient RAM to load the k-mer index of your chosen database.

## Expert Tips
- **Guide Trees**: The accuracy of the identification is heavily dependent on the quality of the guide tree used during database construction. Use well-curated phylogenetic trees for the best results.
- **Taxon Visualization**: For complex samples, consider using the web-based visualization tools or converting the output to a format compatible with Krona or other taxonomic pie-chart viewers to better understand the community composition.

## Reference documentation
- [StrainSeeker Home and Manual](./references/bioinfo_ut_ee_strainseeker.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_strainseeker_overview.md)