---
name: ucsc-featurebits
description: The `ucsc-featurebits` tool analyzes genomic overlaps and calculates the total non-overlapping bases covered by genomic features. Use when user asks to calculate coverage of genomic features, report feature density, perform set operations (intersection, union, subtraction) on genomic features, find overlaps, or calculate enrichment.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-featurebits:482--h0b57e2e_0"
---

# ucsc-featurebits

## Overview
The `featureBits` utility is a high-performance tool from the UCSC Genome Browser "kent" suite designed to analyze genomic overlaps using bitmap projections. It is primarily used to calculate the total number of non-overlapping bases covered by one or more sets of genomic coordinates. It is the standard tool for reporting the "density" of features across a genome and for performing set operations (intersection, union, subtraction) to see how different annotations relate to one another spatially.

## Common CLI Patterns

### Basic Coverage Calculation
To find out how many bases are covered by a single track or BED file:
```bash
featureBits hg38 trackName
```
*Note: When running against the UCSC database, it requires an `.hg.conf` file for MySQL connectivity.*

### Overlap Between Two Tracks
To find the intersection (bases covered by both) of two tracks:
```bash
featureBits hg38 track1 track2
```

### Working with Local BED Files
You can use local files instead of database tables by specifying the path. This is common in custom pipelines:
```bash
featureBits hg38 file1.bed file2.bed
```

### Common Flags and Options
- `-countGaps`: Include gaps (N's) in the total genome size calculation.
- `-dots`: Output a dot every 1,000,000 bases to monitor progress on large datasets.
- `-bin`: Use the bin column for faster database queries (standard for UCSC tables).
- `-noGap`: Exclude gap regions from the calculation (useful for calculating coverage of "mappable" genome).
- `-enrichment`: Calculate the enrichment of the first track within the second.

## Expert Tips
- **Output Interpretation**: The tool typically outputs the number of bases covered, the total size of the genome/region, and the percentage.
- **Order Matters**: When using multiple arguments, `featureBits` often treats the first argument as the primary reference.
- **Database Access**: If you are querying UCSC's public database, ensure your environment is configured to allow connections to `genome-mysql.soe.ucsc.edu`.
- **Permissions**: If you have just downloaded the binary from the UCSC repository, remember to set execution permissions: `chmod +x featureBits`.

## Reference documentation
- [ucsc-featurebits Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-featurebits_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)