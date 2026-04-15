---
name: ucsc-twobitmask
description: ucsc-twobitmask applies hard or soft masking to DNA sequences in .2bit files based on provided genomic coordinates. Use when user asks to apply hard or soft masking to DNA sequences, generate masked genome versions, hard mask specific regions, soft mask specific regions, or add new masked regions to an existing .2bit file.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-twobitmask:482--h0b57e2e_0"
---

# ucsc-twobitmask

## Overview

`ucsc-twobitmask` (invoked via the command `twoBitMask`) is a high-performance utility from the UCSC Genome Browser "kent" toolset designed to modify `.2bit` files. It applies masking to DNA sequences based on coordinates provided in an external file, typically in BED format. This allows researchers to generate masked versions of a genome—where specific regions are either converted to 'N' (hard masking) or lowercase (soft masking)—without the overhead of converting the compact binary format back to FASTA.

## Command Line Usage

The primary command for this tool is `twoBitMask`.

### Basic Syntax
```bash
twoBitMask input.2bit mask.bed output.2bit
```

### Common Patterns and Flags

*   **Preserving Existing Masking**: By default, the output file will only contain the masking defined in your `mask.bed` file. To keep the masking that already exists in the `input.2bit` file and add the new regions to it, use the `-add` flag.
    ```bash
    twoBitMask -add input.2bit new_repeats.bed output.2bit
    ```

*   **Specifying Input Types**: While BED is the default, you can specify other input formats for the masking data using the `-type` flag.
    ```bash
    twoBitMask -type=out input.2bit RepeatMasker.out output.2bit
    ```

## Expert Tips and Best Practices

*   **Coordinate Consistency**: Always ensure that the `mask.bed` file uses the exact same chromosome naming convention (e.g., "chr1" vs "1") and assembly version as the `input.2bit` file. Discrepancies will result in the masking being ignored for those records.
*   **Binary Permissions**: If installing manually from the UCSC directory rather than via Conda, remember to set execution permissions: `chmod +x twoBitMask`.
*   **Verification**: After masking, use `twoBitToFa` on a small region to verify that the masking (N's or lowercase) was applied correctly to the expected coordinates.
*   **Memory Efficiency**: `twoBitMask` is highly efficient because it operates on the binary format directly. It is significantly faster and uses less memory than converting a genome to FASTA, masking with a script, and converting back to 2bit.

## Reference documentation

- [ucsc-twobitmask overview](./references/anaconda_org_channels_bioconda_packages_ucsc-twobitmask_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)