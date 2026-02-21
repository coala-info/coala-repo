---
name: ucsc-autoxml
description: The `ucsc-autoxml` tool (often invoked as `autoXml`) is a specialized code generator from the UCSC Kent utility suite.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-autoxml

## Overview
The `ucsc-autoxml` tool (often invoked as `autoXml`) is a specialized code generator from the UCSC Kent utility suite. It automates the creation of C header files (containing data structures) and C source files (containing the parser logic) based on a simplified Document Type Definition (DTD) input. This ensures that the C code remains synchronized with the XML schema, reducing manual boilerplate and parsing errors.

## Usage Patterns and Best Practices

### Basic Command Structure
The tool is typically executed by providing a specification file and the desired output filenames for the C code and headers.
```bash
autoXml spec.dtd output.c output.h
```

### Workflow Integration
1.  **Define the Specification**: Create a `.dtd` or `.x` file that describes the hierarchy and attributes of your XML data.
2.  **Generate Code**: Run `autoXml` to produce the `.c` and `.h` files.
3.  **Compile**: Include the generated header in your project and compile the generated C file alongside your application code.
4.  **Link with Kent Library**: Ensure your project links against the `jkweb` (Kent) library, as the generated parser relies on its internal utility functions for memory management and string handling.

### Expert Tips
*   **Binary Name**: While the package is named `ucsc-autoxml`, the binary in the UCSC execution directory is often named `autoXml`.
*   **Permissions**: If you download the binary directly from the UCSC servers, remember to set execution permissions: `chmod +x autoXml`.
*   **Schema Evolution**: When the XML format changes, update the DTD spec first and re-run the tool. Do not manually edit the generated `.c` or `.h` files, as they will be overwritten during the next generation cycle.
*   **Dependency Management**: The generated code is highly dependent on the UCSC "Kent" library environment. It is best used within projects already utilizing the Kent source tree infrastructure.

## Reference documentation
- [UCSC Genome Browser Binaries Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-autoxml Package Summary](./references/anaconda_org_channels_bioconda_packages_ucsc-autoxml_overview.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)