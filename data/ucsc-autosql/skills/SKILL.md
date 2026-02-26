---
name: ucsc-autosql
description: The ucsc-autosql tool generates SQL and C code from an AutoSql definition file. Use when user asks to generate SQL for a database table, create C code for data structures, define a database schema, or synchronize database schemas with application code.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-autosql

## Overview

The `ucsc-autosql` tool (commonly invoked as `autoSql`) is a core utility from the UCSC Genome Browser "kent" source tree. It solves the problem of maintaining synchronization between a database schema and the application code that interacts with it. By defining a data object once in a specialized AutoSql (`.as`) file, the tool generates the SQL necessary to create the database table and the C code (headers and source) required to parse, load, and store that data. This is the standard workflow for creating new track types or data structures within the UCSC ecosystem.

## Common CLI Patterns

The basic syntax for `autoSql` is straightforward:

```bash
autoSql <input.as> <outputPrefix>
```

### Example Workflow
If you have a schema file named `myTrack.as`, run:
```bash
autoSql myTrack.as myTrack
```

This command generates three files:
1.  **myTrack.sql**: The CREATE TABLE statement for MySQL/MariaDB.
2.  **myTrack.h**: C header file containing the structure definition and function prototypes.
3.  **myTrack.c**: C source file containing functions to load the data from a database or file into the C structures.

## AutoSql (.as) File Structure

To use the tool effectively, the input `.as` file must follow a specific format:

```text
table <tableName>
"Short description of the table"
    (
    <type> <fieldName>;  "Description of the field"
    ...
    )
```

### Supported Data Types
*   **int/uint**: Signed and unsigned integers.
*   **float/double**: Floating point numbers.
*   **string/lstring**: Standard strings and long strings (mapped to VARCHAR or BLOB).
*   **char[N]**: Fixed-length character arrays.
*   **set/enum**: Mapped to SQL SET and ENUM types.

## Expert Tips and Best Practices

*   **Consistency is Key**: Always regenerate your C and SQL files immediately after modifying the `.as` file to prevent memory corruption or SQL errors caused by mismatched schemas.
*   **Documentation**: The comments provided in the `.as` file (the strings in quotes) are automatically propagated into the generated C headers and SQL comments. Use descriptive text to make the generated code self-documenting.
*   **Integration with Kent Library**: The generated C code is designed to work seamlessly with the `jkweb` (Kent) library. Ensure your include paths are set up to find `common.h` and other core UCSC headers.
*   **Binary Availability**: If the tool is not in your path, it is typically found in the UCSC binary distribution directories (e.g., `~/bin/x86_64/autoSql`).
*   **Permissions**: When downloading the binary directly from the UCSC servers, remember to set executable permissions: `chmod +x autoSql`.

## Reference documentation

- [ucsc-autosql Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-autosql_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)