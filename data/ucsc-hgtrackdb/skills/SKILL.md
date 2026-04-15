---
name: ucsc-hgtrackdb
description: The ucsc-hgtrackdb tool synchronizes text-based track configurations from `trackDb.ra` files with the UCSC Genome Browser's underlying database. Use when user asks to set up a local browser mirror, add or update data tracks in a local database, validate track configurations, or debug track hierarchy and inheritance.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-hgtrackdb:482--h0b57e2e_0"
---

# ucsc-hgtrackdb

## Overview
The `ucsc-hgtrackdb` tool is a specialized utility within the UCSC Kent toolset designed to synchronize text-based track configurations with the Genome Browser's underlying database. It parses `trackDb.ra` files—which use a stanza-based format to define track attributes—and populates the `trackDb` table for a given assembly (e.g., hg38, mm10). Use this skill when setting up a local browser mirror, adding new data tracks to a local database, or debugging track hierarchy and inheritance issues.

## Command Line Usage

### Basic Syntax
The standard invocation requires the target database name, the table name (usually `trackDb`), and the root directory containing the `.ra` files:
```bash
hgTrackDb [options] <database> <table_name> <directory>
```

### Common CLI Patterns
*   **Standard Update**: To update the hg38 track database from the current directory:
    `hgTrackDb hg38 trackDb .`
*   **Strict Validation**: Use the `-strict` flag to ensure all referenced files exist and stanzas are correctly formatted. This is highly recommended before pushing changes to a production mirror.
    `hgTrackDb -strict hg38 trackDb .`
*   **Custom Table Names**: If testing a new configuration without overwriting the live tracks, specify a different table name:
    `hgTrackDb hg38 trackDb_test .`

## Expert Tips and Best Practices

### Database Connectivity
*   **The .hg.conf Requirement**: This tool requires a `.hg.conf` file in your home directory to connect to the MySQL server. Ensure this file has `600` permissions and contains the correct `db.host`, `db.user`, and `db.password` entries.
*   **Permission Errors**: If you encounter "permission denied" when running the binary, ensure the execution bit is set: `chmod +x ./hgTrackDb`.

### Configuration Management
*   **Hierarchical Organization**: Use `include` statements within your `trackDb.ra` files to keep configurations modular. `hgTrackDb` will recursively process these includes starting from the root directory.
*   **Inheritance Debugging**: Tracks often inherit settings from "supertracks" or "composite tracks." If a track is not appearing as expected, check the `parent` and `subTrack` settings in the `.ra` files.
*   **Release Tags**: Use the `release` tag (e.g., `release alpha,beta`) to control which tracks are loaded into specific browser environments.

### Performance and Maintenance
*   **Table Cleanup**: `hgTrackDb` typically replaces the contents of the target table. If you are managing a large number of tracks, ensure your MySQL `max_allowed_packet` setting is high enough to handle large inserts.
*   **Binary Compatibility**: Always use the version of `hgTrackDb` that matches your OS architecture (e.g., `linux.x86_64` or `macOSX.arm64`). You can check your system type with `uname -a`.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hgtrackdb Package Summary](./references/anaconda_org_channels_bioconda_packages_ucsc-hgtrackdb_overview.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)