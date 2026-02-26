---
name: perl-cpan-meta
description: This tool reads, writes, and validates metadata files for Perl distributions according to the CPAN Meta Spec. Use when user asks to validate META.json or META.yml files, extract distribution versioning, or list package dependencies.
homepage: https://github.com/dagolden/cpan-meta
---


# perl-cpan-meta

## Overview
The `perl-cpan-meta` skill provides the capability to interact with CPAN distribution metadata. It centers on the `CPAN::Meta` library, which is the standard implementation for reading, writing, and validating the metadata files that describe Perl distributions. This is essential for ensuring that a Perl package correctly communicates its dependencies, versioning, and license information to the wider Perl ecosystem and installers like `cpanm`.

## Usage and Best Practices

### Installation
In a Bioconda or Conda environment, ensure the package is available:
```bash
conda install bioconda::perl-cpan-meta
```

### Metadata Validation
The most common use for this tool is validating that a `META.json` or `META.yml` file conforms to the CPAN Meta Spec. You can perform a quick validation check using a Perl one-liner:

```bash
# Validate a META.json file
perl -MCPAN::Meta -e 'CPAN::Meta->load_file("META.json")'
```
If the file is invalid, the command will die with a descriptive error message.

### Data Extraction
You can programmatically extract specific fields from the metadata without manually parsing the files, which avoids errors related to spec versions.

```bash
# Extract the distribution version
perl -MCPAN::Meta -e 'print CPAN::Meta->load_file("META.json")->version'

# List runtime dependencies
perl -MCPAN::Meta -e '$m = CPAN::Meta->load_file("META.json"); print join("\n", keys %{$m->effective_prereqs->requirements_for("runtime", "requires")->as_string_hash})'
```

### Development Workflow Integration
*   **Testing**: When developing a Perl module, use `prove` to run tests that may rely on metadata being correctly parsed.
    ```bash
    prove -l
    ```
*   **Authoring**: While `perl-cpan-meta` handles the reading and validation, it is often used in conjunction with `Dist::Zilla` for automated metadata generation.
    ```bash
    # Check author dependencies required for metadata management
    dzil authordeps | cpanm
    ```

### Expert Tips
*   **Spec Versioning**: `CPAN::Meta` automatically handles different versions of the metadata spec (e.g., 1.4 vs 2). Always use `load_file` rather than manual JSON/YAML parsing to ensure the library's normalization logic is applied.
*   **Strictness**: By default, `load_file` is strict. If you need to read a potentially malformed file for recovery purposes, you may need to wrap the call in an `eval` block or use specialized parsing scripts.
*   **Dependency Resolution**: Use the `effective_prereqs` method to get a merged view of requirements across different phases (configure, build, runtime, test).

## Reference documentation
- [Specifications for CPAN distribution META files](./references/github_com_Perl-Toolchain-Gang_CPAN-Meta.md)
- [perl-cpan-meta Overview](./references/anaconda_org_channels_bioconda_packages_perl-cpan-meta_overview.md)