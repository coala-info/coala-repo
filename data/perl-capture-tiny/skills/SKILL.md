---
name: perl-capture-tiny
description: perl-capture-tiny intercepts and captures data sent to standard output and standard error streams. Use when user asks to capture output from external system calls, intercept stdout and stderr, or verify command-line interface output in testing suites.
homepage: https://github.com/dagolden/Capture-Tiny
metadata:
  docker_image: "quay.io/biocontainers/perl-capture-tiny:0.48--pl526_0"
---

# perl-capture-tiny

## Overview
`perl-capture-tiny` provides a robust, portable mechanism to intercept everything sent to standard output and standard error. While Perl's native redirection often fails to catch output from external system calls or C-based XS extensions, this tool ensures all streams are captured. It is particularly useful in bioinformatics pipelines and automated testing suites where verifying the exact output of a command-line interface is required.

## Installation
The package is widely available via Bioconda and CPAN.

- **Conda (Bioconda):**
  ```bash
  conda install bioconda::perl-capture-tiny
  ```
- **CPAN (cpanminus):**
  ```bash
  cpanm Capture::Tiny
  ```

## Development and Testing Workflow
When contributing to or testing modules that depend on `Capture::Tiny`, use the following patterns:

- **Dependency Management:** Use `cpanm --installdeps .` to satisfy requirements listed in `Makefile.PL` or `cpanfile`.
- **Testing:** Use the `prove` tool for standard Perl testing.
  - Run all tests: `prove -l`
  - Verbose testing for a specific file: `prove -lv t/target_test.t`
- **Authoring:** The distribution is managed with `Dist::Zilla`. To build from source:
  ```bash
  dzil build
  dzil test
  ```

## Expert Tips and Constraints

### 1. Threading Limitations
`Capture::Tiny` has known limitations when used with Perl threads. Avoid using capture blocks inside heavily threaded code, as it may lead to unpredictable behavior or deadlocks.

### 2. Unique File Naming
When capturing to specific files (rather than scalars), ensure that the file designated for `stdout` is different from the one designated for `stderr`. Using the same filename for both streams simultaneously will cause errors.

### 3. Privilege Escalation/De-escalation
If your script drops privileges (e.g., switching from root to a less-privileged user) during execution, `Capture::Tiny` may be unable to clean up its temporary files in `/tmp`. Ensure the environment allows the user to delete files created during the capture process.

### 4. External Program Execution
When capturing output from `exec` or `system` calls, `Capture::Tiny` is more reliable than standard shell redirection (`> /dev/null 2>&1`) because it handles the file descriptors at the process level, ensuring that even output from sub-processes is caught.

### 5. Version Comparisons
When writing conditional logic based on the Perl version (e.g., for compatibility checks), use numeric comparisons with `$]` rather than string comparisons to avoid logic errors in version parsing.

## Reference documentation
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-capture-tiny_overview.md)
- [GitHub Repository](./references/github_com_dagolden_Capture-Tiny.md)
- [Issue Tracker](./references/github_com_dagolden_Capture-Tiny_issues.md)