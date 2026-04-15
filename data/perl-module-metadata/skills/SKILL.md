---
name: perl-module-metadata
description: This tool performs static analysis of Perl files to extract package declarations, version numbers, and documentation structure. Use when user asks to extract module versions, list packages within a file, find a module's path by name, or generate CPAN provides metadata.
homepage: https://github.com/Perl-Toolchain-Gang/Module-Metadata
metadata:
  docker_image: "quay.io/biocontainers/perl-module-metadata:1.000038--pl5321hdfd78af_0"
---

# perl-module-metadata

## Overview
The `perl-module-metadata` skill (based on the `Module::Metadata` Perl library) allows for the programmatic inspection of Perl files. It performs mostly static analysis to find package declarations and POD headings. For version extraction, it safely evaluates `$VERSION` assignments using the same logic as the standard CPAN toolchain. This tool is essential for developers and sysadmins who need to index Perl distributions, verify installed module versions, or extract documentation structure without the overhead or security risks of running the entire module.

## Installation
The package is available via Bioconda for environment-managed Perl setups:
```bash
conda install bioconda::perl-module-metadata
```

## Common CLI Patterns
Since `Module::Metadata` is primarily a library, it is most effectively used from the command line via Perl one-liners to inspect files quickly.

### Extracting Module Version
To get the version of a specific `.pm` file:
```bash
perl -MModule::Metadata -e 'print Module::Metadata->new_from_file("Path/To/Module.pm")->version'
```

### Listing Packages in a File
A single `.pm` file can contain multiple package declarations. To list them all:
```bash
perl -MModule::Metadata -e 'print join("\n", Module::Metadata->new_from_file("Module.pm")->packages_inside)'
```

### Finding a Module's Path by Name
Locate where a module is stored in your `@INC` path:
```bash
perl -MModule::Metadata -e 'print Module::Metadata->find_module_by_name("Target::Module")'
```

### Generating CPAN "provides" Metadata
To generate a metadata structure for all modules in a directory (useful for creating `META.json` or `META.yml` files):
```bash
perl -MModule::Metadata -MData::Dumper -e 'print Dumper(Module::Metadata->provides(dir => "lib", version => 2))'
```

## Expert Tips and Best Practices
- **POD Collection**: By default, POD data is not collected to save memory. If you need to extract documentation content, you must explicitly enable it:
  `Module::Metadata->new_from_file($file, collect_pod => 1)`
- **Encoding**: If working with modern Perl modules containing UTF-8 characters in POD, use the `decode_pod => 1` argument to ensure the output respects the `=encoding` declaration.
- **Safety**: `Module::Metadata` is safer than `require` or `use` because it does not execute the module's body code; it only `eval`s the specific line containing the `$VERSION` assignment.
- **BOM Handling**: The tool automatically handles Byte Order Marks (UTF-8, UTF-16BE/LE) at the start of files, making it robust for cross-platform Perl source files.
- **Private Packages**: When using the `provides()` method, the tool automatically filters out "private" packages (those with a leading underscore in the name) and the `main` or `DB` packages, adhering to CPAN indexing standards.

## Reference documentation
- [Module::Metadata Overview](./references/anaconda_org_channels_bioconda_packages_perl-module-metadata_overview.md)
- [Module::Metadata GitHub Documentation](./references/github_com_Perl-Toolchain-Gang_Module-Metadata.md)