---
name: ucsc-fafilter
description: This tool filters FASTA files by extracting or excluding sequence records based on user-defined criteria. Use when user asks to filter sequences by length, filter sequences by name pattern, exclude sequences by name, or filter sequences by N-content.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-fafilter:482--h0b57e2e_0"
---

# ucsc-fafilter

## Overview
The `faFilter` utility is a high-performance tool from the UCSC Genome Browser "kent" source suite designed for the rapid processing of FASTA files. It allows for the extraction or exclusion of sequence records based on user-defined constraints. This is particularly useful in bioinformatics pipelines for cleaning assembly data, filtering out small scaffolds, or selecting specific sequences for downstream analysis without the overhead of complex scripting.

## Usage Patterns

### Basic Syntax
```bash
faFilter [options] input.fa output.fa
```

### Common Filtering Tasks

**Filter by Sequence Length**
To keep only sequences that meet a minimum length requirement (e.g., 1000bp):
```bash
faFilter -minSize=1000 input.fa output.fa
```

**Filter by Name Pattern**
To extract sequences whose names contain a specific substring:
```bash
faFilter -name="chr*" input.fa output.fa
```

**Exclude Specific Sequences**
To remove sequences matching a specific name:
```bash
faFilter -notName="chrM" input.fa output.fa
```

**Filter by N-Content**
To remove sequences that contain too many "N" (unknown) bases:
```bash
faFilter -maxN=10 input.fa output.fa
```

### Expert Tips
- **No Arguments for Help**: Running `faFilter` with no arguments will display the full list of available options and version information.
- **Wildcards**: The `-name` and `-notName` flags support basic wildcard patterns (e.g., `*` for any character string).
- **Pipeline Integration**: `faFilter` is often used immediately after sequence assembly or before alignment to reduce the search space by removing low-quality or irrelevant sequences.
- **Permissions**: If using a direct binary download from UCSC, ensure the file is executable using `chmod +x faFilter`.

## Reference documentation
- [UCSC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-fafilter_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binaries List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)