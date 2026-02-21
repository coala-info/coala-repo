---
name: ucsc-htmlcheck
description: The `htmlCheck` utility is a command-line tool from the UCSC Genome Browser "kent" source tree.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-htmlcheck

## Overview
The `htmlCheck` utility is a command-line tool from the UCSC Genome Browser "kent" source tree. It performs automated reading and verification of HTML files to ensure they are well-formed and free of common errors. Use this skill when you need to audit local HTML files for broken internal/external links, unclosed tags, or general compliance before deployment.

## Command Line Usage

The basic syntax for the tool is:
```bash
htmlCheck <action> <url/file>
```

### Primary Actions
*   **check**: The most common use case. It parses the HTML and checks for basic tag consistency and internal link validity.
*   **test**: Performs a more rigorous check, often used to verify that external links are reachable.

### Common Patterns

**1. Validating a local file**
To check a local HTML file for structural errors:
```bash
htmlCheck check index.html
```

**2. Checking a remote URL**
To verify a live page or a staged data track description:
```bash
htmlCheck check http://your-server.edu/tracks/myTrack.html
```

**3. Recursive link testing**
If you need to ensure all links within a page are functional:
```bash
htmlCheck test http://your-server.edu/docs/
```

## Expert Tips and Best Practices

*   **Permission Setup**: If you have downloaded the binary directly from the UCSC server, ensure it has execution permissions: `chmod +x htmlCheck`.
*   **Genome Browser Integration**: When creating "Track Description" pages for the UCSC Genome Browser, use `htmlCheck` to ensure that the HTML doesn't contain stray tags that could break the browser's page layout.
*   **Silent Success**: The tool is designed for CLI pipelines; if no errors are found, it typically produces minimal output. You can check the exit code (`echo $?`) to verify success in automated scripts.
*   **Tag Consistency**: Unlike modern browsers that "fix" broken HTML on the fly, `htmlCheck` is strict. It is excellent for catching missing `</th>` or `</td>` tags in large data tables which are common in bioinformatics.

## Reference documentation
- [UCSC Genome Browser Binaries Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-htmlcheck Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-htmlcheck_overview.md)
- [Linux x86_64 Binary Directory](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)