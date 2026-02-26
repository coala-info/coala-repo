---
name: ucsc-estorient
description: UCSC-estorient refines EST alignments by correcting the strand field in PSL records to reflect true biological orientation. Use when user asks to correct EST alignment orientation, update PSL strand fields, or determine the true biological orientation of ESTs.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-estorient

## Overview
The `ucsc-estorient` utility is a specialized tool for refining EST (Expressed Sequence Tag) alignments. Standard alignment tools often produce PSL files where the strand indicates the genomic match rather than the direction of transcription. This tool cross-references alignment IDs against a database to determine the true biological orientation. It updates the strand field in the PSL records accordingly, ensuring that downstream analysis correctly interprets the coding direction. By default, any alignments where the orientation cannot be definitively determined are filtered out of the resulting file.

## Usage and Best Practices

### Basic Command Pattern
The tool requires a target database name, an input PSL file, and a destination for the corrected PSL:

```bash
estOrient [options] <db> <in.psl> <out.psl>
```

### Database Connectivity
Because `ucsc-estorient` queries metadata tables (`estOrientInfo` or `gbCdnaInfo`), it requires access to a UCSC Genome Browser database.
*   **Public Server**: To connect to the UCSC public MySQL server, ensure you have an `.hg.conf` file in your home directory with the appropriate credentials (user: `genomep`, host: `genome-mysql.soe.ucsc.edu`).
*   **Local Database**: If using a local mirror, ensure the database name provided matches your local MySQL instance.

### Common Options
*   **-all**: Use this flag if you want to keep all PSLs in the output, even those where the orientation could not be determined. By default, these are dropped.
*   **-verbose=N**: Increase the logging level (e.g., `-verbose=2`) to debug why specific ESTs are being dropped or how they are being categorized.

### Expert Tips
*   **PSL Compatibility**: Ensure your input PSL is standard (10-column or 21-column format). The tool specifically modifies the `strand` column (column 9).
*   **Batch Processing**: When processing large datasets, it is more efficient to run `estOrient` on a single combined PSL file rather than many small ones to minimize database connection overhead.
*   **Permission Errors**: If running the binary directly after download, remember to set execution permissions: `chmod +x estOrient`.

## Reference documentation
- [ucsc-estorient Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-estorient_overview.md)
- [UCSC Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)