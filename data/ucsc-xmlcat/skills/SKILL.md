---
name: ucsc-xmlcat
description: ucsc-xmlcat merges multiple XML files into a single, valid XML document by nesting their content under a new root tag. Use when user asks to merge XML files, combine XML fragments, or integrate multiple XML documents into a single valid XML file.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-xmlcat:482--h0b57e2e_0"
---

# ucsc-xmlcat

## Overview

The `ucsc-xmlcat` utility is a specialized tool from the UCSC Genome Browser "Kent" suite used for XML data integration. Standard file concatenation (like using `cat`) often results in invalid XML because it creates multiple root elements or redundant headers. `ucsc-xmlcat` solves this by stripping the individual XML declarations and nesting the content of all input files inside a new, user-defined parent tag. This is particularly useful in bioinformatics pipelines where data is generated in chunks but needs to be processed as a single XML document.

## Usage Instructions

### Basic Command Syntax
The tool requires the name of the new root tag followed by the list of files to be merged.

```bash
ucsc-xmlcat <root-tag-name> <input1.xml> <input2.xml> ... > <output.xml>
```

### Common Patterns

**Merging a directory of XML fragments:**
If you have numerous XML files (e.g., results from a distributed compute job), you can merge them all into a single document named "results":
```bash
ucsc-xmlcat results *.xml > combined_results.xml
```

**Handling Permissions:**
If you have downloaded the binary directly from the UCSC server, ensure it has execution permissions:
```bash
chmod +x ucsc-xmlcat
./ucsc-xmlcat myRoot input.xml > output.xml
```

## Expert Tips and Best Practices

*   **Root Tag Naming**: The first argument becomes the literal name of the XML root element. Ensure this name follows XML naming conventions (no spaces, cannot start with a number).
*   **Input Validation**: While `ucsc-xmlcat` handles the wrapping, it generally assumes the input files are well-formed XML. If an input file has a broken tag, the resulting concatenated file will also be broken.
*   **Memory Efficiency**: As a C-based utility from the Kent suite, `ucsc-xmlcat` is highly efficient at streaming data, making it suitable for merging very large genomic XML datasets that might crash DOM-based parsers.
*   **Header Stripping**: The tool automatically handles the removal of individual `<?xml ... ?>` declarations from the input files so that only one declaration (or none, depending on the version) exists at the top of the output, preventing "extra content at the end of the document" errors.
*   **Stdout Redirection**: The tool outputs directly to the terminal (stdout). Always remember to redirect the output to a file using `>` to avoid flooding the console.

## Reference documentation
- [ucsc-xmlcat Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-xmlcat_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)