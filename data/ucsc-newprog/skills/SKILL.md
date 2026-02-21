---
name: ucsc-newprog
description: The `ucsc-newprog` utility is a developer productivity tool from the UCSC Genome Browser "kent" source suite.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-newprog

## Overview
The `ucsc-newprog` utility is a developer productivity tool from the UCSC Genome Browser "kent" source suite. It automates the creation of a C source file skeleton, pre-populated with standard headers, command-line argument parsing logic, and a basic usage function. This ensures that new utilities follow the consistent coding patterns used throughout the UCSC Genome Browser codebase, facilitating easier integration and maintenance.

## Usage Patterns

### Generating a New C Skeleton
To create a new program skeleton, run the command followed by the desired program name and a brief description.

```bash
newProg <programName> <"Description of what the program does">
```

This will generate a file named `programName.c` in your current directory.

### Standard Boilerplate Features
The generated skeleton includes:
- **Standard Includes**: Links to `common.h`, `options.h`, and other essential kent library headers.
- **Option Handling**: A pre-configured `options` table and `optionHash` for parsing command-line flags.
- **Usage Function**: A `usage()` function that displays the description provided during generation.
- **Main Entry Point**: A `main()` function that handles initial option parsing and calls a processing function (usually named after the program).

### Best Practices
- **Naming**: Use camelCase for the program name (e.g., `bedFilterOverlap`) to match the UCSC convention.
- **Descriptions**: Provide a clear, concise description in quotes; this becomes the primary documentation shown to users when they run your tool without arguments.
- **Environment**: Ensure you have the kent source library headers in your include path to compile the resulting `.c` file.
- **Permissions**: If you have just downloaded the binary, ensure it is executable:
  ```bash
  chmod +x newProg
  ```

### Related Tools
- **newPythonProg**: If you prefer developing in Python while maintaining the UCSC tool style, use `newPythonProg` to generate a Python script skeleton with standard argument parsing.

## Reference documentation
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [ucsc-newprog - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-newprog_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)