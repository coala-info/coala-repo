---
name: ucsc-mafspeciessubset
description: This tool filters Multiple Alignment Format (MAF) files to extract sequences for a specific subset of species. Use when user asks to subset a MAF file by species, isolate specific organisms from a multi-species alignment, or prune alignment blocks to include only sequences of interest.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-mafspeciessubset

## Overview
The `ucsc-mafspeciessubset` tool is a specialized utility from the UCSC Genome Browser "kent" suite designed to filter Multiple Alignment Format (MAF) files. It allows researchers to isolate specific species from a multi-species alignment, effectively "pruning" the alignment blocks to contain only the sequences of interest. This is essential for reducing file size, focusing on specific evolutionary clades, or preparing data for tools that only support a limited number of species.

## Usage Patterns

### Basic Filtering
The primary usage requires an input MAF file, a comma-separated list of species names (as they appear in the MAF headers), and an output filename.

```bash
mafSpeciesSubset input.maf species1,species2,species3 output.maf
```

### Common Workflow: Identifying Species First
Before subsetting, it is often necessary to verify the exact species identifiers used in the source file. Use the companion tool `mafSpeciesList` (often bundled in the same environment) to list all species present.

```bash
# 1. List species to get exact names
mafSpeciesList input.maf stdout

# 2. Subset based on the identified names
mafSpeciesSubset input.maf human,chimp,gorilla primate_subset.maf
```

## Expert Tips and Best Practices

### Handling Empty Blocks
When you subset a MAF, some alignment blocks might end up with only one species (or zero) if the other species in that block were filtered out. 
- By default, `mafSpeciesSubset` removes blocks that contain fewer than two species after subsetting, as a single-sequence "alignment" is generally not useful.
- If your downstream tool requires the preservation of the reference sequence even if no other species align in that region, check for the `-keepEmpty` flag (availability may vary by version).

### Species Naming Conventions
UCSC MAF files typically use the "db.chrom" or "organism" naming convention (e.g., `hg38`, `panTro6`). Ensure the species list provided to the tool matches the prefix before the first dot in the MAF sequence lines.

### Performance with Large Files
MAF files can be massive (gigabytes to terabytes). 
- **Piping**: If the tool version supports it, use `stdin` or `stdout` to avoid intermediate disk I/O.
- **Memory**: The tool generally processes MAF files block-by-block, making it memory-efficient even for very large files.

### Post-Processing
After subsetting, it is often useful to run `mafFilter` to remove blocks that are now too short or have too many gaps due to the removal of the other species.

## Reference documentation
- [ucsc-mafspeciessubset - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-mafspeciessubset_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Genome Browser source (kent)](./references/github_com_ucscGenomeBrowser_kent.md)