---
name: perl-local-lib
description: The `perl-local-lib` tool allows for the creation and management of a private Perl module repository, typically located in a user's home directory (e.g., `~/perl5`).
homepage: http://metacpan.org/pod/local::lib
---

# perl-local-lib

## Overview
The `perl-local-lib` tool allows for the creation and management of a private Perl module repository, typically located in a user's home directory (e.g., `~/perl5`). It automates the configuration of environment variables like `PERL5LIB`, `PATH`, and `CPAN` configuration, enabling a "bootstrap" environment where modules can be installed and loaded without interfering with the system Perl installation. This is particularly useful for developers working on shared systems or managing multiple projects with conflicting dependency requirements.

## Core Usage and Best Practices

### Bootstrapping a Local Environment
To initialize a local library directory and configure the current shell session, use the following command pattern. This is the most common entry point for using the tool.

```bash
perl -Mlocal::lib
```

To apply these changes to your environment permanently, append the command to your shell configuration file (e.g., `~/.bashrc` or `~/.zshrc`):

```bash
echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >> ~/.bashrc
```

### Installing Modules to a Specific Directory
If you need to maintain separate environments for different projects, you can specify a target directory during the bootstrap process:

```bash
perl -Mlocal::lib=~/my-project-lib
```

Once the environment is set, standard CPAN clients will respect the local path:

```bash
cpan App::cpanminus
cpanm Module::Name
```

### Environment Variable Management
The tool manages several key variables. If you need to inspect what `local::lib` is doing to your environment, run it without `eval`:

- `PERL5LIB`: Prepends the local library paths so Perl finds your local modules first.
- `PATH`: Prepends the local `bin` directory so locally installed scripts are executable.
- `PERL_MM_OPT`: Sets `INSTALL_BASE` for `ExtUtils::MakeMaker`.
- `PERL_MB_OPT`: Sets flags for `Module::Build`.

### Win32 and PowerShell Considerations
On Windows systems using PowerShell, the syntax for exporting environment variables differs. Use the following command to generate the correct setup script:

```powershell
perl -Mlocal::lib | Out-String | Invoke-Expression
```

### Expert Tips
- **Clean Slate**: If you encounter path conflicts, you can use the `--self-contained` flag (if supported by your version) or manually unset `PERL5LIB` before running the `eval` command to ensure a predictable environment.
- **Multiple Libs**: You can stack multiple local libraries by calling `local::lib` multiple times with different paths; however, the last one called will generally take precedence in the `PATH`.
- **Non-Interactive Scripts**: When writing shell scripts that depend on a local library, always include the `eval "$(perl -Mlocal::lib)"` line at the start of the script to ensure the environment is correctly inherited.

## Reference documentation
- [local::lib - create and use a local lib/ for perl modules with PERL5LIB](./references/metacpan_org_pod_local__lib.md)
- [perl-local-lib - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-local-lib_overview.md)