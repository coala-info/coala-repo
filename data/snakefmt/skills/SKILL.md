---
name: snakefmt
description: "snakefmt is an opinionated code formatter that automatically styles Snakemake files according to a deterministic standard. Use when user asks to format Snakemake files, check for style compliance, or preview formatting changes with a diff."
homepage: https://github.com/snakemake/snakefmt
---


# snakefmt

## Overview
snakefmt is an opinionated code formatter for Snakemake, heavily inspired by the Python formatter "Black". It provides a deterministic way to style Snakemake files, ensuring that workflows look the same regardless of who wrote them. It treats Snakemake keywords (like `rule`, `checkpoint`, or `subworkflow`) as top-level blocks, enforcing specific spacing and indentation, while internally utilizing Black to format Python code within `run` blocks or parameter assignments.

## Usage Patterns

### Basic Formatting
Format a specific file or an entire directory in-place:
```bash
# Format a single file
snakefmt Snakefile

# Format all .smk files in a directory recursively
snakefmt workflows/
```

### Safe Execution and Review
Since snakefmt modifies files in-place by default, use these flags to preview changes or verify compliance without altering the source:
```bash
# Check if files need formatting (returns exit code 1 if changes are needed)
snakefmt --check Snakefile

# View a diff of the proposed changes
snakefmt --diff Snakefile

# View a compact diff (only changed lines with context)
snakefmt --compact-diff Snakefile
```

### Piping and Standard Input
To format code and output the result to the terminal (stdout) instead of a file:
```bash
snakefmt - < Snakefile
```

## Configuration and Best Practices

### Line Length
The default line length is 88 characters (matching Black). Adjust this for wider monitors or specific project requirements:
```bash
snakefmt --line-length 100 Snakefile
```

### Project Configuration
Instead of passing CLI arguments every time, use a `pyproject.toml` file in the project root. snakefmt automatically reads settings from the `[tool.snakefmt]` section and passes `[tool.black]` settings to the internal Black formatter.

**Key Configuration Options:**
- `line_length`: Integer for maximum line width.
- `include`: Regex for files to include (default: `(\.smk$|^Snakefile)`).
- `exclude`: Regex for files/directories to ignore (e.g., `.git`, `.snakemake`).

### Expert Tips
- **Version Control**: Always ensure files are committed to Git before running snakefmt, as it modifies files in-place.
- **Keyword Spacing**: snakefmt enforces two newlines between Snakemake keywords (like rules) to treat them similarly to Python classes.
- **Trailing Commas**: The tool automatically adds trailing commas to multi-line lists in `input`, `output`, and `params` blocks, which helps reduce diff noise in version control.
- **Python Integration**: If you have `.py` files in your Snakemake project, you can include them in the snakefmt config to format them using the same tool, effectively wrapping Black.

## Reference documentation
- [snakefmt Main Documentation](./references/github_com_snakemake_snakefmt.md)
- [snakefmt Installation and Overview](./references/anaconda_org_channels_bioconda_packages_snakefmt_overview.md)