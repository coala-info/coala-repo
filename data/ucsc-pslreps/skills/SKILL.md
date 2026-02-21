---
name: ucsc-pslreps
description: The `ucsc-pslreps` skill provides guidance on using the `pslReps` utility, a core component of the UCSC Genome Browser "Kent" toolset.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-pslreps

## Overview

The `ucsc-pslreps` skill provides guidance on using the `pslReps` utility, a core component of the UCSC Genome Browser "Kent" toolset. This tool is designed to take a set of local alignments (PSL format) and determine the best alignment for each query sequence across the target genome. By applying various scoring and coverage thresholds, it helps researchers distinguish between unique genomic hits and repetitive elements, effectively reducing alignment noise and identifying the most biologically relevant sequences.

## Usage Patterns and Best Practices

### Basic Command Structure
The tool requires an input PSL file and produces two output files: the filtered alignments and a report on the repeats.

```bash
pslReps input.psl output.psl output.psr
```
*   `input.psl`: The raw alignment file (should be sorted by query).
*   `output.psl`: The "best" alignments selected by the tool.
*   `output.psr`: The "pslReps" report file containing repeat analysis.

### Common Filtering Options
To improve the quality of the output, use the following flags to set specific thresholds:

*   **-minCover=0.N**: Sets the minimum coverage required to keep an alignment. For example, `-minCover=0.9` requires 90% of the query to be aligned.
*   **-minAli=N**: Sets the minimum alignment size in bases (default is usually 15-20).
*   **-nearTop=0.0N**: Keeps hits that are within a certain fraction of the best score. This is useful if you want to see nearly-identical paralogs rather than just one "best" hit.
*   **-singleHit**: Only outputs the single best hit for each query, regardless of how close other hits are.

### Handling Repetitive Sequences
If your goal is to analyze or mask repeats:
*   The `.psr` output file is the primary resource for identifying which queries hit multiple locations.
*   Use the `-minId=N` flag to set a minimum percentage identity (e.g., `-minId=95`) to ensure you are only analyzing high-quality repeat families.

### Expert Tips
*   **Sorting Requirement**: `pslReps` expects the input PSL to be sorted by query name. If your file is not sorted, use `pslSort` before running `pslReps`.
*   **Memory Management**: For extremely large genomes or alignment sets, ensure you are using the 64-bit version of the tool (found in the `linux.x86_64` directory of the UCSC repository) to avoid memory overflow errors.
*   **Interpreting PSR Files**: The PSR output columns include the query name, the number of times it repeats, and the total coverage. High repeat counts in this file often indicate transposable elements or common structural variations.

## Reference documentation
- [ucsc-pslreps Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-pslreps_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)