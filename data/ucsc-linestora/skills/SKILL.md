---
name: ucsc-linestora
description: The `linesToRa` utility is a specialized tool within the UCSC Kent utilities suite designed to transform flat, pipe-delimited text into the stanza-based Resource Archive (.ra) format.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-linestora

## Overview
The `linesToRa` utility is a specialized tool within the UCSC Kent utilities suite designed to transform flat, pipe-delimited text into the stanza-based Resource Archive (.ra) format. This is a critical step for bioinformaticians building UCSC Track Hubs, as the browser requires `.ra` files (like `trackDb.ra`) to define track display settings, data types, and visibility. This skill provides the procedural knowledge to execute this conversion efficiently.

## Command Line Usage

The primary executable for this tool is `linesToRa`.

### Basic Syntax
```bash
linesToRa input.txt output.ra
```

### Input Requirements
- **Delimiter**: The tool expects fields to be separated by the pipe character (`|`).
- **Structure**: Each line in the input file represents one record (stanza) in the output file.
- **Field Mapping**: Typically, the first field in the pipe-separated line becomes the primary identifier for the stanza.

### Output Format (.ra)
The resulting file will be formatted into stanzas, where each field from the input line is placed on a new line within the record. For example:
- **Input**: `trackName|type|bigDataUrl`
- **Output**:
  ```ra
  track trackName
  type bigWig
  bigDataUrl http://example.com/data.bw
  ```

## Best Practices and Tips

### Permission Handling
If you have downloaded the binary directly from the UCSC server rather than installing via Conda, you must ensure the file is executable:
```bash
chmod +x ./linesToRa
./linesToRa input.txt output.ra
```

### Data Preparation
- **Clean Pipes**: Ensure that your data fields do not contain internal pipe characters, as `linesToRa` will interpret them as field boundaries.
- **Header Management**: If your source data has a header, you may need to strip it or ensure it follows the pipe-delimited format to avoid creating a malformed first stanza.
- **Batch Processing**: For large-scale hub generation, use `linesToRa` in combination with `awk` or `sed` to format your metadata into the required pipe-delimited intermediate state.

### Integration with Kent Utilities
`linesToRa` is often used in workflows alongside:
- `raToLines`: The inverse operation, converting `.ra` files back to pipe-delimited text.
- `hubCheck`: To validate the resulting `.ra` files within a track hub structure.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Bioconda ucsc-linestora Package](./references/anaconda_org_channels_bioconda_packages_ucsc-linestora_overview.md)