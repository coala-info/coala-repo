---
name: ucsc-hgloadoutjoined
description: This tool transforms RepeatMasker output into a format suitable for genomic database queries and loads it into a UCSC database. Use when user asks to 'load RepeatMasker output into a UCSC database' or 'populate a database with repeat data'.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-hgloadoutjoined:482--h0b57e2e_0"
---

# ucsc-hgloadoutjoined

## Overview
The `hgLoadOutJoined` utility is part of the UCSC Kent toolkit, designed to transform RepeatMasker output into a format suitable for genomic database queries. You should use this tool when you need to populate a local or public UCSC database with repeat data, particularly when dealing with the newer RepeatMasker output formats that superseded the older versions. It automates the parsing of the `.out` file and the insertion of records into the specified MySQL table.

## Database Configuration
Before running the tool, you must ensure your environment is configured to connect to a MySQL server.
- **Configuration File**: Create a file named `.hg.conf` in your home directory.
- **Permissions**: Set the file permissions to `600` to protect your database credentials.
- **Content**: The file should contain the host, user, and password for the database:
  ```
  db.host=localhost
  db.user=your_username
  db.password=your_password
  ```
- **Public Access**: If connecting to the UCSC public MySQL server, use `genome-mysql.soe.ucsc.edu` with the user `genomep`.

## Common CLI Patterns

### Basic Usage
The standard command structure requires the target database name, the table name to be created/updated, and the path to the RepeatMasker output file.
```bash
hgLoadOutJoined [database] [table] [input.out]
```

### Loading into a Specific Assembly
If you are working with a specific genome assembly (e.g., hg38), the database name usually matches the assembly ID:
```bash
hgLoadOutJoined hg38 rmskJoined RepeatMasker_output.out
```

## Expert Tips and Best Practices
- **Binary Permissions**: If you encounter a "permission denied" error after downloading the tool from the UCSC server, apply executable permissions: `chmod +x hgLoadOutJoined`.
- **Schema Validation**: This tool expects the "new style" (2014) RepeatMasker format. If you have legacy data, you may need to use the older `hgLoadOut` utility instead.
- **Table Overwriting**: By default, these utilities often drop existing tables before loading. Always back up your database if you are appending data to an existing track.
- **Architecture Matching**: Ensure you are using the binary that matches your system architecture (e.g., `linux.x86_64` or `macOSX.arm64`). You can check your machine type using `uname -a`.
- **Help Menu**: Run the command without any arguments to see the most up-to-date list of optional flags, such as those for specifying custom temporary directories or socket locations.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_ucsc-hgloadoutjoined_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)