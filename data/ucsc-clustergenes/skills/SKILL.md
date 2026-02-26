---
name: ucsc-clustergenes
description: ucsc-clustergenes aggregates transcript-level annotations into gene-level clusters based on genomic overlaps. Use when user asks to 'cluster transcripts into genes', 'create non-redundant gene sets', 'cluster transcripts by CDS only', 'cluster transcripts ignoring strand', 'cluster all overlapping transcripts'.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-clustergenes

## Overview
The `clusterGenes` utility is a specialized tool from the UCSC Genome Browser "kent" source tree designed to aggregate transcript-level annotations into gene-level clusters. It analyzes genomic coordinates in `genePred` format and assigns transcripts to a common cluster ID if they share overlapping exons. This tool is essential for bioinformaticians needing to simplify complex transcriptomes into non-redundant gene sets or to analyze the genomic relationship between different gene prediction tracks.

## Usage Instructions

### Basic Command Structure
The tool typically requires an output filename and one or more input `genePred` files.
```bash
clusterGenes [options] <outputFile> <input.gp>
```

### Common CLI Patterns
- **Cluster by CDS only**: Use the `-cds` flag to ignore UTR overlaps and only cluster transcripts that share coding sequence overlaps.
- **Ignore Strand**: By default, the tool respects strand orientation. Use `-ignoreStrand` to cluster overlapping transcripts even if they are on opposite strands.
- **Track Name Inclusion**: If the input file includes a track name column (common in UCSC table dumps), use the `-trackNames` flag to ensure the tool parses the columns correctly.
- **Join All Overlaps**: Use `-allJoin` to ensure that any degree of overlap results in a cluster assignment, creating a more inclusive grouping.

### Expert Tips
- **Input Preparation**: Ensure your input is in valid `genePred` format. If you have GTF or GFF3 files, use `gtfToGenePred` or `gff3ToGenePred` first.
- **Output Parsing**: The output file is a simple tab-separated mapping of transcript IDs to cluster IDs. You can join this back to your original data using standard Unix tools like `join` or `awk`.
- **Chromosome Filtering**: For large datasets, process one chromosome at a time using the `-chrom=chrN` option to reduce memory overhead.
- **Database Connectivity**: While often used on flat files, the tool can connect to a UCSC MySQL instance if an `.hg.conf` file is present in your home directory.

## Reference documentation
- [ucsc-clustergenes Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-clustergenes_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)