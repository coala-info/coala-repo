---
name: ucsc-qatoqac
description: The ucsc-qatoqac tool compresses uncompressed quality score files (.qa) into a binary compressed format (.qac). Use when user asks to compress quality score files, or convert .qa files to .qac format.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-qatoqac

## Overview
The `qaToQac` utility is a specialized tool within the UCSC Genome Browser "Kent" suite. It facilitates the compression of uncompressed quality score files (`.qa`) into a binary compressed format (`.qac`). This transformation is critical for reducing the storage footprint of large-scale genomic datasets while maintaining the integrity of the quality information required for sequence analysis and visualization.

## Command Line Usage

### Basic Conversion
To compress an uncompressed quality file:
```bash
qaToQac input.qa output.qac
```

### Reverse Conversion
To decompress a `.qac` file back to its original text format, use the companion utility:
```bash
qacToQa input.qac output.qa
```

### Viewing Usage and Version
If the binary is in your path, run it without arguments to see the internal help documentation:
```bash
qaToQac
```

## Best Practices and Expert Tips

### File Permissions
If you have downloaded the binary directly from the UCSC servers rather than installing via Conda, you must ensure the file is executable:
```bash
chmod +x ./qaToQac
./qaToQac input.qa output.qac
```

### Input Format Requirements
The input `.qa` file should be in the standard UCSC uncompressed quality format, which typically consists of integer quality scores. Ensure your file does not contain headers or metadata that the tool does not recognize, as this can lead to conversion errors.

### Downstream Integration
Compressed `.qac` files are often required by other UCSC utilities. For example, if you are performing coordinate lifting on quality scores, you will likely need the `.qac` format for tools like `qacAgpLift`.

### Database Connectivity
While `qaToQac` is a standalone file processor, other tools in this suite may require a `.hg.conf` file in your home directory to connect to the UCSC public MySQL server. If you encounter connection errors with related tools, verify your database configuration.

## Reference documentation
- [ucsc-qatoqac - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-qatoqac_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Index of /admin/exe/linux.x86_64.v369](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.v369.md)