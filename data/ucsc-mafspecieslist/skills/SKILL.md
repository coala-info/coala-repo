---
name: ucsc-mafspecieslist
description: The `mafSpeciesList` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed to parse Multiple Alignment Format (MAF) files.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-mafspecieslist

## Overview
The `mafSpeciesList` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed to parse Multiple Alignment Format (MAF) files. Its primary function is to scan the alignment blocks and extract the unique species identifiers (the prefix before the first dot in the sequence name field). This is particularly useful when working with large-scale whole-genome alignments where you need to programmatically determine which organisms are represented without manually inspecting the file.

## Usage Instructions

### Basic Command
To list all species in a MAF file, provide the filename as the first argument:

```bash
mafSpeciesList input.maf
```

The tool will output a unique list of species names found in the file, one per line.

### Common Workflow Patterns

**1. Counting Species**
If you need to quickly verify the number of species in a large alignment:
```bash
mafSpeciesList input.maf | wc -l
```

**2. Validating Species Presence**
To check if a specific species (e.g., "hg38") is included in an alignment:
```bash
mafSpeciesList input.maf | grep -q "hg38" && echo "Species found"
```

**3. Processing Multiple Files**
To get a master list of species across a directory of MAF files:
```bash
mafSpeciesList *.maf | sort -u
```

### Expert Tips
*   **Naming Convention**: MAF files typically use the format `species.chromosome` or `species.scaffold`. `mafSpeciesList` specifically extracts the `species` portion.
*   **Performance**: For very large MAF files, the tool is significantly faster than using generic text processing tools like `awk` or `sed` because it is optimized for the MAF structure.
*   **Permissions**: If you downloaded the binary directly from the UCSC server instead of using Conda, ensure it is executable: `chmod +x mafSpeciesList`.
*   **Empty Output**: If the tool returns no output, verify that the MAF file is correctly formatted and that the sequence lines (starting with `s`) contain the standard `species.sequence` naming convention.

## Reference documentation
- [ucsc-mafspecieslist overview](./references/anaconda_org_channels_bioconda_packages_ucsc-mafspecieslist_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)