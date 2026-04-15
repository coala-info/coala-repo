---
name: perl-base
description: This tool formats and indents LaTeX source code using the latexindent.pl script to improve readability and structure. Use when user asks to format LaTeX files, indent code blocks, wrap text in documents, or apply consistent styling to .tex, .sty, or .cls files.
homepage: https://github.com/cmhughes/latexindent.pl
metadata:
  docker_image: "quay.io/biocontainers/perl-base:2.23--pl526_1"
---

# perl-base

## Overview

The `perl-base` skill provides a specialized workflow for using `latexindent.pl`, a powerful Perl-based formatter for LaTeX documents. This tool automates the process of adding consistent horizontal leading space to code blocks, environments, and commands. Beyond simple indentation, it handles complex tasks like text wrapping, one-sentence-per-line formatting, and regex-based substitutions. It is the standard tool for ensuring LaTeX source code remains readable and professionally formatted across large projects.

## Command Line Usage and Patterns

### Basic Formatting
To preview the formatted version of a LaTeX file in the terminal without modifying the source:
```bash
latexindent.pl myfile.tex
```

### Saving Changes
To save the formatted output to a new file (recommended for first-time use):
```bash
latexindent.pl myfile.tex -o myfile-formatted.tex
```

To overwrite the original file directly (use with caution):
```bash
latexindent.pl -w myfile.tex
```

### Common Flags
- `-s`: Silent mode; suppresses log output.
- `-w`: Overwrites the input file with the formatted version.
- `-o`: Specifies the output file path.
- `-v`: Displays the version information.

## Expert Tips and Best Practices

### Verification Workflow
Before applying changes to a critical document, follow this safety protocol:
1. **Output to a temporary file**: Use the `-o` switch to create a formatted copy.
2. **Visual Inspection**: Check the output file for any unexpected structural changes.
3. **Diff Analysis**: Use `latexdiff` to compare the original and the formatted version to ensure no content was accidentally removed or altered:
   ```bash
   latexdiff myfile.tex myfile-formatted.tex
   ```

### Version Control Integration
Always ensure your LaTeX files are tracked in a version control system (like Git) before running `latexindent.pl` with the `-w` (overwrite) flag. This allows you to revert changes if the formatting logic does not align with your specific style requirements.

### Handling Different File Types
While primarily used for `.tex` files, the tool is equally effective for:
- `.sty` (LaTeX Style files)
- `.cls` (LaTeX Class files)
- `.bib` (BibTeX files)

## Reference documentation
- [latexindent.pl Main Repository](./references/github_com_cmhughes_latexindent.pl.md)
- [Issues and Known Behaviors](./references/github_com_cmhughes_latexindent.pl_issues.md)