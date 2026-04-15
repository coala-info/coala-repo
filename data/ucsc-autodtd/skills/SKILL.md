---
name: ucsc-autodtd
description: ucsc-autodtd reverse-engineers a Document Type Definition (DTD) from a sample XML file. Use when user asks to generate a DTD from an XML file, create an XML schema, or infer a DTD from an XML document.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-autodtd:482--h0b57e2e_0"
---

# ucsc-autodtd

## Overview
The `autoDtd` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed to reverse-engineer a DTD from a sample XML file. It analyzes the structure, hierarchy, and attributes of a provided XML document to produce a schema that can be used for validation or as a template for further XML development. This is particularly useful in bioinformatics workflows where data is often exchanged in XML format without an accompanying formal schema.

## Usage Instructions

### Basic Command
To generate a DTD from an XML file, use the following syntax:
```bash
autoDtd input.xml output.dtd
```

### Installation and Setup
The tool is available via Bioconda or as a standalone binary from the UCSC Genome Browser server.
1. **Bioconda**: `conda install bioconda::ucsc-autodtd`
2. **Direct Download**: If downloading the binary directly from the UCSC server, ensure you have execution permissions:
   ```bash
   chmod +x autoDtd
   ./autoDtd input.xml output.dtd
   ```

### Expert Tips and Best Practices
* **Representative Samples**: Since `autoDtd` infers the schema based on the provided file, ensure your input XML is a "rich" example that contains all possible optional elements and attributes. If the sample is too simple, the resulting DTD may be too restrictive.
* **Help Statement**: Like most UCSC "kent" utilities, running the command with no arguments will display the built-in usage statement and version information.
* **Integration with autoXml**: `autoDtd` is often used in conjunction with `autoXml`, which can generate C code and parsers based on the inferred DTD, facilitating the creation of custom XML-processing applications.
* **Platform Compatibility**: Ensure you are using the binary specific to your architecture (e.g., `linux.x86_64`, `macOSX.arm64`, or `linux.aarch64`).

## Reference documentation
- [ucsc-autodtd Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-autodtd_overview.md)
- [UCSC Admin Executables Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary Listing](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)