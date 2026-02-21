---
name: ucsc-pslrecalcmatch
description: The `pslRecalcMatch` utility is a specialized tool from the UCSC Kent toolkit used to refresh the scoring columns of a PSL file.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-pslrecalcmatch

## Overview
The `pslRecalcMatch` utility is a specialized tool from the UCSC Kent toolkit used to refresh the scoring columns of a PSL file. It works by comparing the alignment coordinates defined in the PSL against the actual target and query sequences. This process ensures that the `match`, `misMatch`, `repMatch`, and `nCount` columns accurately reflect the base-level identity of the alignment. This is a critical step in bioinformatics pipelines before filtering alignments by identity or score, especially after merging PSL files or using alignment tools that produce "fake" or placeholder scores.

## Command Line Usage

### Basic Syntax
The tool requires the input PSL, the sequence files for both target and query, and a destination for the updated PSL.

```bash
pslRecalcMatch in.psl target.seq query.seq out.psl
```

### Sequence File Formats
The `target.seq` and `query.seq` arguments can be in several formats. For efficiency, especially with large genomes, specific formats are preferred:
*   **.2bit**: Highly recommended for speed and random access.
*   **.fa / .fasta**: Standard text format (slower for large files).
*   **.nib**: Older UCSC format (one file per chromosome).

### Common Patterns and Options
*   **Updating Scores for BLAT results**: If you have a PSL from a BLAT search where the sequences have changed or the scoring needs verification:
    ```bash
    pslRecalcMatch search.psl hg38.2bit query.fa updated_search.psl
    ```
*   **Generating PSLX Output**: Use the `-outPslx` flag if you need the output to include the sequence strings (PSLX format), which is useful for visual inspection of mismatches.
    ```bash
    pslRecalcMatch -outPslx in.psl target.2bit query.2bit out.pslx
    ```

## Expert Tips and Best Practices
*   **Sequence ID Consistency**: Ensure that the sequence names in the `tName` and `qName` columns of your PSL file exactly match the headers/IDs in your `.2bit` or `.fa` files. If they do not match, the tool will fail to find the sequences and cannot recalculate the matches.
*   **Performance with 2bit**: Always convert your genome FASTA to `.2bit` using `faToTwoBit` before running `pslRecalcMatch`. This prevents the tool from loading the entire genome into memory and allows it to jump directly to the coordinates specified in the PSL.
*   **Permission Handling**: If running the binary directly from a download, ensure it is executable:
    ```bash
    chmod +x pslRecalcMatch
    ```
*   **Validation**: After recalculating, it is good practice to run `pslCheck` on the output file to ensure the internal consistency of the new scores and coordinates.
*   **Handling Repeat Masking**: If your sequences contain lowercase masked repeats, `pslRecalcMatch` will correctly populate the `repMatch` column based on matches involving these lowercase bases.

## Reference documentation
*   [ucsc-pslrecalcmatch overview](./references/anaconda_org_channels_bioconda_packages_ucsc-pslrecalcmatch_overview.md)
*   [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
*   [Linux x86_64 v369 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)