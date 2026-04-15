---
name: ucsc-maforder
description: `mafOrder` rearranges the order of sequences within alignment blocks of a MAF file according to a specified list. Use when user asks to reorder sequences in MAF blocks, arrange species in a consistent order across MAF files, or place a reference genome first in MAF blocks.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-maforder:482--h0b57e2e_0"
---

# ucsc-maforder

# ucsc-maforder

## Overview
The `mafOrder` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed to manipulate the internal structure of MAF files. In a MAF file, each alignment block contains multiple lines representing different species or genomic sequences. `mafOrder` allows you to programmatically rearrange these lines based on a provided list, ensuring that every block in the output file follows the same sequence hierarchy. This is essential for maintaining consistency across large-scale genomic alignments.

## Usage Patterns

### Basic Command Syntax
The tool requires an input MAF file, a text file defining the desired order, and a destination for the output.

```bash
mafOrder input.maf species_order.txt output.maf
```

### Creating the Order File
The `species_order.txt` file should be a simple text file with one species or sequence identifier per line, in the exact order you want them to appear in the MAF blocks.

**Example `species_order.txt`:**
```text
hg38
panTro6
mm10
canFam3
```

## Expert Tips and Best Practices

### 1. Exact Header Matching
The identifiers in your order list must match the "src" field in the MAF file exactly (e.g., `hg38.chr1`). If the MAF uses `database.chromosome` naming conventions, ensure your order list reflects that specific format.

### 2. Handling Missing Species
If a species listed in your order file is missing from a specific alignment block in the input MAF, `mafOrder` will typically skip that species for that block but maintain the relative order of the species that are present. It does not "pad" blocks with empty sequences.

### 3. Reference-First Ordering
Many conservation scoring tools (like `phyloP` or `phastCons`) and visualization utilities expect the reference genome to be the first entry in every MAF block. Use `mafOrder` to move your primary assembly to the top if the original alignment was generated with a different sequence as the pivot.

### 4. Permission and Environment
If you are using the binary directly from the UCSC repository:
- Ensure the binary has execution permissions: `chmod +x mafOrder`
- If running on a headless Linux server, ensure you have the standard C libraries installed, as these are dynamically linked binaries.

### 5. Validation
After reordering, you can verify the change using `head` to check the first few blocks:
```bash
head -n 20 output.maf
```

## Reference documentation
- [UCSC Kent Utility Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-maforder Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-maforder_overview.md)