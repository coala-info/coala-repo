---
name: ucsc-localtime
description: `ucsc-localtime` is a specialized utility from the UCSC Genome Browser "kent" tool suite.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-localtime

## Overview

`ucsc-localtime` is a specialized utility from the UCSC Genome Browser "kent" tool suite. It provides a simple command-line interface to translate Unix epoch integers—the number of seconds elapsed since January 1, 1970—into formatted, human-readable date and time strings. While general-purpose tools like `date` exist, this utility is often bundled within bioinformatics environments (like Bioconda) to provide a consistent, lightweight method for timestamp conversion within genomic data pipelines and UCSC database workflows.

## Usage Instructions

### Basic Conversion
To convert a single Unix timestamp to a local time string, pass the integer as the sole argument:

```bash
localtime 1719693445
```

### Batch Processing
In bioinformatics workflows, timestamps are often stored in columns within TSV or CSV files. You can use `xargs` to process these values from a file or stream:

```bash
# Convert a list of timestamps from a file
cat timestamps.txt | xargs -I {} localtime {}

# Extract a timestamp from a specific column (e.g., column 3) and convert
cut -f3 data.tsv | xargs -I {} localtime {}
```

### Related Utilities
The UCSC kent suite typically includes two related time utilities that follow the same syntax:
- **`gmtime`**: Converts the timestamp to Greenwich Mean Time (UTC) instead of the system's local time.
- **`mktime`**: The inverse operation; converts a date string back into a Unix timestamp.

## Expert Tips

- **Permission Errors**: If you have downloaded the binary directly from the UCSC server rather than installing via Conda, you must grant execution permissions before use: `chmod +x localtime`.
- **Timezone Sensitivity**: Note that `localtime` relies on the `TZ` environment variable or the system's `/etc/localtime`. If you are processing data for a different region, set the `TZ` variable temporarily:
  ```bash
  TZ=America/New_York localtime 1719693445
  ```
- **Pipeline Integration**: Because the tool outputs a simple string, it is highly effective when used in `sed` or `awk` scripts to replace raw integers with readable dates in-place during report generation.

## Reference documentation
- [ucsc-localtime Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-localtime_overview.md)
- [UCSC Linux x86_64 Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)