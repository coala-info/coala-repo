---
name: ucsc-pslmap
description: The `ucsc-pslmap` utility is a specialized tool from the UCSC Genome Browser "kent" suite used to transitive-map alignments.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-pslmap

## Overview
The `ucsc-pslmap` utility is a specialized tool from the UCSC Genome Browser "kent" suite used to transitive-map alignments. It takes an initial set of alignments (Query vs. Target A) and a mapping alignment (Target A vs. Target B) to produce a new set of alignments (Query vs. Target B). This process is often referred to as "lifting" or "projecting" alignments across different genomic backgrounds.

## Command Line Usage

The basic syntax for `pslMap` requires an input PSL, a mapping file, and a destination for the output.

### Basic Mapping
To map alignments using a PSL file as the coordinate bridge:
```bash
pslMap input.psl mapping.psl output.psl
```

### Mapping with Chain Files
If your mapping file is in Chain format (common for cross-species lifts), use the `-chainMapFile` flag:
```bash
pslMap -chainMapFile input.psl mapping.chain output.psl
```

### Common Options
- `-mapPsl`: Use this if the mapping file is a PSL (default behavior, but can be explicit).
- `-swapMap`: Swaps the query and target sides of the mapping file before processing.
- `-mapQuery`: Map the query side of the input PSL instead of the target side.
- `-simplifyId`: Strip version numbers from sequence IDs (e.g., "NM_0001.1" becomes "NM_0001").

## Expert Tips and Best Practices

### Coordinate Consistency
The "Target" sequence names in your `input.psl` must exactly match the "Query" sequence names in your `mapping.psl` or `mapping.chain`. If they do not match, the tool will skip those records without generating an error, resulting in an empty or incomplete output file.

### Post-Mapping Cleanup
Mapping can often result in fragmented alignments, especially when projecting across distant species. Use `pslMapPostChain` to join these fragments into more coherent blocks:
```bash
pslMap input.psl mapping.psl stdout | pslMapPostChain stdin output.psl
```

### Validation
Always validate your PSL files using `pslCheck` before and after mapping to ensure that the block coordinates and sequence sizes remain consistent with the genomic headers.

### Binary Execution
If using the standalone binaries from the UCSC server, ensure the file has execution permissions:
```bash
chmod +x ./pslMap
./pslMap [options] in.psl map.psl out.psl
```

## Reference documentation
- [ucsc-pslmap overview](./references/anaconda_org_channels_bioconda_packages_ucsc-pslmap_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)