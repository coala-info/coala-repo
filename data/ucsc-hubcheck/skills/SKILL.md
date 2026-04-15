---
name: ucsc-hubcheck
description: ucsc-hubcheck validates the format and accessibility of files within a UCSC Track Data Hub. Use when user asks to 'validate a Track Data Hub', 'check Track Data Hub format', 'verify Track Data Hub file accessibility', or 'identify broken links or syntax errors'.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-hubcheck:482--h0b57e2e_0"
---

# ucsc-hubcheck

## Overview
The `hubCheck` utility is a diagnostic tool used to ensure that a Track Data Hub is correctly formatted and that all referenced data files (BigWig, BigBed, VCF, etc.) are accessible. It performs a recursive crawl of the hub structure—starting from the `hub.txt` file through the `genomes.txt` and individual `trackDb.txt` files—to identify broken links, syntax errors in stanzas, or missing required settings.

## Usage Patterns

### Basic Validation
To check a local or remote hub, provide the path or URL to the `hub.txt` file.
```bash
hubCheck http://your-server.edu/hubs/myHub/hub.txt
```

### Common CLI Options
While running the binary without arguments displays the full help, these are the most frequent flags:
- `-udcDir=/path/to/dir`: Specify a custom directory for the UCSC Data Cache. This is useful for managing temporary files during large crawls.
- `-verbose=2`: Increase the logging level to see exactly which files are being checked.
- `-noCheckFiles`: Validate the syntax of the `.txt` files only, without attempting to download or verify the existence of the large data files (BigWig/BigBed).

### Troubleshooting Permissions
If you have downloaded the binary directly from the UCSC server and encounter a "permission denied" error, you must set the executable bit:
```bash
chmod +x hubCheck
./hubCheck [URL]
```

## Expert Tips
- **Public Hub Validation**: Use `hubPublicCheck` (a related utility often bundled with `hubCheck`) if you are specifically testing a hub intended for the UCSC Public Hub list, as it may have stricter requirements for metadata.
- **Remote vs. Local**: Always test with the remote URL if the hub is intended for public use. `hubCheck` will verify that your web server supports byte-range requests, which are required for the Genome Browser to function.
- **Database Connections**: Some advanced hub configurations might require a `.hg.conf` file in your home directory if they attempt to connect to UCSC's public MySQL server for metadata.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hubcheck Package](./references/anaconda_org_channels_bioconda_packages_ucsc-hubcheck_overview.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)