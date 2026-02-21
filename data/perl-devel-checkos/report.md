# perl-devel-checkos CWL Generation Report

## perl-devel-checkos

### Tool Description
A tool (likely based on the Perl module Devel::CheckOS) to check the current operating system against a list of platforms.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-devel-checkos:1.81--pl526_0
- **Homepage**: http://metacpan.org/pod/Devel::CheckOS
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-devel-checkos/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-devel-checkos/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 10:00:41  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "perl-devel-checkos": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## perl-devel-checkos_perl

### Tool Description
The Perl 5 language interpreter

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-devel-checkos:1.81--pl526_0
- **Homepage**: http://metacpan.org/pod/Devel::CheckOS
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-devel-checkos/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/perl [switches] [--] [programfile] [arguments]
  -0[octal]         specify record separator (\0, if no argument)
  -a                autosplit mode with -n or -p (splits $_ into @F)
  -C[number/list]   enables the listed Unicode features
  -c                check syntax only (runs BEGIN and CHECK blocks)
  -d[:debugger]     run program under debugger
  -D[number/list]   set debugging flags (argument is a bit mask or alphabets)
  -e program        one line of program (several -e's allowed, omit programfile)
  -E program        like -e, but enables all optional features
  -f                don't do $sitelib/sitecustomize.pl at startup
  -F/pattern/       split() pattern for -a switch (//'s are optional)
  -i[extension]     edit <> files in place (makes backup if extension supplied)
  -Idirectory       specify @INC/#include directory (several -I's allowed)
  -l[octal]         enable line ending processing, specifies line terminator
  -[mM][-]module    execute "use/no module..." before executing program
  -n                assume "while (<>) { ... }" loop around program
  -p                assume loop like -n but print line also, like sed
  -s                enable rudimentary parsing for switches after programfile
  -S                look for programfile using PATH environment variable
  -t                enable tainting warnings
  -T                enable tainting checks
  -u                dump core after parsing program
  -U                allow unsafe operations
  -v                print version, patchlevel and license
  -V[:variable]     print configuration summary (or a single Config.pm variable)
  -w                enable many useful warnings
  -W                enable all warnings
  -x[directory]     ignore text before #!perl line (optionally cd to directory)
  -X                disable all warnings
  
Run 'perldoc perl' for more help with Perl.
```

