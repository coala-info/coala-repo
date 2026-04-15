---
name: perl-archive-tar
description: This tool provides a Perl-based interface for creating, extracting, and manipulating TAR archives with fine-grained control over file metadata and contents. Use when user asks to create or extract archives, search for patterns within compressed files, compare archives to directories, or perform in-memory modifications like renaming and filtering files.
homepage: https://metacpan.org/pod/Archive::Tar
metadata:
  docker_image: "quay.io/biocontainers/perl-archive-tar:3.04--pl5321hdfd78af_0"
---

# perl-archive-tar

## Overview
The `perl-archive-tar` package provides a robust Perl-centric approach to managing TAR files. Unlike standard system `tar`, this tool allows for fine-grained manipulation of archive contents, including in-memory editing of file metadata (chmod/chown) and content replacement without full extraction. It is the preferred tool when working within Perl-heavy pipelines or when cross-platform consistency for archive handling is required in Bioconda environments.

## Core CLI Utilities
The package typically installs several command-line wrappers for the `Archive::Tar` module:

### ptar
The primary CLI interface for creating and extracting archives.
- **Create an archive**: `ptar -c -f archive.tar file1 file2 dir/`
- **Extract an archive**: `ptar -x -f archive.tar`
- **List contents**: `ptar -t -f archive.tar`
- **Compressed archives**: Use `-z` for gzip compression (e.g., `ptar -czf archive.tar.gz files/`).

### ptargrep
A powerful utility to search for patterns within the contents of a TAR archive without manual extraction.
- **Usage**: `ptargrep "pattern" archive.tar.gz`

### ptardiff
Used to compare the contents of an extracted directory against a TAR archive.
- **Usage**: `ptardiff archive.tar directory/`

## Expert Perl One-Liner Patterns
For tasks that exceed standard CLI flags, use Perl one-liners to leverage the `Archive::Tar` API directly:

### In-Memory Content Modification
Replace content of a specific file inside an archive without extracting the whole package:
```bash
perl -MArchive::Tar -e '$t = Archive::Tar->new("data.tar"); $t->replace_content("config.txt", "new_content"); $t->write("data_updated.tar")'
```

### Filtering Extraction by Property
Extract only files that meet specific criteria (e.g., files larger than 1MB):
```bash
perl -MArchive::Tar -e '$t = Archive::Tar->new("data.tar"); @files = grep { $_->size > 1024*1024 } $t->get_files; $t->extract(@files)'
```

### Batch Renaming Inside Archive
Rename files within the archive before writing it back to disk:
```bash
perl -MArchive::Tar -e '$t = Archive::Tar->new("old.tar"); for ($t->list_files) { $new = $_; $new =~ s/old_prefix/new_prefix/; $t->rename($_, $new) }; $t->write("new.tar")'
```

## Best Practices
- **Memory Management**: `Archive::Tar` loads the entire archive into memory by default. For extremely large archives (multi-gigabyte), ensure the environment has sufficient RAM or use the `read` method with the `extract` option to process files sequentially.
- **Compression Detection**: While `ptar` uses flags, the Perl API `Archive::Tar->new()` can often auto-detect compression if the `IO::Zlib` or `Compress::Zlib` modules are present.
- **Permissions**: Use `$tar->chmod($file, $mode)` and `$tar->chown($file, $user)` to normalize archive permissions when preparing software releases or Bioconda packages to ensure they are portable across different user environments.

## Reference documentation
- [Archive::Tar - module for manipulations of tar archives](./references/metacpan_org_pod_Archive__Tar.md)
- [Archive::Tar::File - a subclass for in-memory extracted file](./references/metacpan_org_pod_Archive__Tar__File.md)
- [perl-archive-tar - bioconda overview](./references/anaconda_org_channels_bioconda_packages_perl-archive-tar_overview.md)