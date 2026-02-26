---
name: perl-par-packer
description: The perl-par-packer tool bundles Perl scripts and their dependencies into single, portable executables or self-contained scripts. Use when user asks to create stand-alone binaries, package Perl applications with dependencies, or distribute scripts to systems without required modules.
homepage: https://github.com/rschupp/PAR-Packer
---


# perl-par-packer

## Overview
The `perl-par-packer` skill provides the procedural knowledge required to use the `pp` (Perl Packer) utility. This tool bundles a Perl script along with its dependencies (including core and site modules) into a single, portable file. This allows for "PerlApp-like" functionality, enabling developers to distribute software to target machines that may only have a basic Perl interpreter or no Perl installation at all.

## Core CLI Patterns

### Creating Stand-alone Executables
The most common use case is creating a binary that runs without requiring a local Perl installation.
```bash
pp -o output_name.exe source.pl
```

### Creating Portable Perl Scripts
If the target machine has a Perl interpreter but lacks required modules, you can create a self-contained Perl script.
1. Generate a PAR archive:
   ```bash
   pp -p -B source.pl -o source.par
   ```
2. Convert the archive to a self-contained script:
   ```bash
   par.pl -B -Opacked.pl source.par
   ```

### Managing Dependencies and Assets
- **Include extra files**: Use `-a` or `--addfile` to bundle non-module assets (config files, images).
  ```bash
  pp -o app.exe -a "config.yaml;config.yaml" script.pl
  ```
- **Include shared libraries**: Use `-l` to bundle `.dll` or `.so` files.
  ```bash
  pp -o app.exe -l libcrypto.so script.pl
  ```
- **Filter modules**: Use `--modfilter` to exclude specific modules or apply regex-based filtering to reduce package size.

## Expert Tips and Best Practices

### Windows-Specific Considerations
- **Compiler Requirements**: A C compiler is required for installation. Strawberry Perl users have MinGW by default. ActiveState users should install MinGW via `ppm install MinGW`.
- **Shared Libraries**: If your Perl was built with a shared library, the stand-alone executable may still require `perl5x.dll` or `libperl.so` in the path.
- **UTF-8 Arguments**: Recent versions have fixed issues where packaged scripts lost the ability to parse UTF-8 command-line arguments. Ensure you are using a version >= 1.061 for robust UTF-8 support.

### Troubleshooting and Optimization
- **Temporary Directory**: PAR extracts files to a temporary directory (often controlled by the `PAR_TMPDIR` environment variable). If you encounter "unsafe private subdirectory" errors, ensure the temp location is writable and secure.
- **Clean Execution**: Use the `--clean` flag if you want the temporary files to be removed immediately after the execution of the packaged script.
  ```bash
  pp --clean -o app.exe script.pl
  ```
- **Module Discovery**: If `pp` fails to find a dependency, use the `-M` flag to force-include a module that is loaded dynamically (e.g., via `eval "require $module"`).
  ```bash
  pp -M DBI::mysql -o app.exe script.pl
  ```

## Reference documentation
- [PAR-Packer README](./references/github_com_rschupp_PAR-Packer.md)
- [PAR-Packer Commits (Troubleshooting & UTF-8)](./references/github_com_rschupp_PAR-Packer_commits_master.md)