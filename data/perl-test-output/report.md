# perl-test-output CWL Generation Report

## perl-test-output

### Tool Description
The provided text does not contain help documentation. It consists of container runtime logs indicating that the executable 'perl-test-output' was not found in the system PATH.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-test-output:1.031--pl526_0
- **Homepage**: https://github.com/briandfoy/test-output
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-test-output/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-test-output/overview
- **Total Downloads**: 19.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/briandfoy/test-output
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 19:23:25  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "perl-test-output": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## perl-test-output_prove

### Tool Description
Run tests through a TAP harness

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-test-output:1.031--pl526_0
- **Homepage**: https://github.com/briandfoy/test-output
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-test-output/overview
- **Validation**: PASS
### Original Help Text
```text
Usage:
     prove [options] [files or directories]

Options:
    Boolean options:

     -v,  --verbose         Print all test lines.
     -l,  --lib             Add 'lib' to the path for your tests (-Ilib).
     -b,  --blib            Add 'blib/lib' and 'blib/arch' to the path for
                            your tests
     -s,  --shuffle         Run the tests in random order.
     -c,  --color           Colored test output (default).
          --nocolor         Do not color test output.
          --count           Show the X/Y test count when not verbose
                            (default)
          --nocount         Disable the X/Y test count.
     -D   --dry             Dry run. Show test that would have run.
     -f,  --failures        Show failed tests.
     -o,  --comments        Show comments.
          --ignore-exit     Ignore exit status from test scripts.
     -m,  --merge           Merge test scripts' STDERR with their STDOUT.
     -r,  --recurse         Recursively descend into directories.
          --reverse         Run the tests in reverse order.
     -q,  --quiet           Suppress some test output while running tests.
     -Q,  --QUIET           Only print summary results.
     -p,  --parse           Show full list of TAP parse errors, if any.
          --directives      Only show results with TODO or SKIP directives.
          --timer           Print elapsed time after each test.
          --trap            Trap Ctrl-C and print summary on interrupt.
          --normalize       Normalize TAP output in verbose output
     -T                     Enable tainting checks.
     -t                     Enable tainting warnings.
     -W                     Enable fatal warnings.
     -w                     Enable warnings.
     -h,  --help            Display this help
     -?,                    Display this help
     -V,  --version         Display the version
     -H,  --man             Longer manpage for prove
          --norc            Don't process default .proverc

    Options that take arguments:

     -I                     Library paths to include.
     -P                     Load plugin (searches App::Prove::Plugin::*.)
     -M                     Load a module.
     -e,  --exec            Interpreter to run the tests ('' for compiled
                            tests.)
          --ext             Set the extension for tests (default '.t')
          --harness         Define test harness to use.  See TAP::Harness.
          --formatter       Result formatter to use. See FORMATTERS.
          --source          Load and/or configure a SourceHandler. See
                            SOURCE HANDLERS.
     -a,  --archive out.tgz Store the resulting TAP in an archive file.
     -j,  --jobs N          Run N test jobs in parallel (try 9.)
          --state=opts      Control prove's persistent state.
          --rc=rcfile       Process options from rcfile
          --rules           Rules for parallel vs sequential processing.
```

## perl-test-output_cpanm

### Tool Description
Get, unpack, build and install modules from CPAN

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-test-output:1.031--pl526_0
- **Homepage**: https://github.com/briandfoy/test-output
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-test-output/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: cpanm [options] Module [...]

Options:
  -v,--verbose              Turns on chatty output
  -q,--quiet                Turns off the most output
  --interactive             Turns on interactive configure (required for Task:: modules)
  -f,--force                force install
  -n,--notest               Do not run unit tests
  --test-only               Run tests only, do not install
  -S,--sudo                 sudo to run install commands
  --installdeps             Only install dependencies
  --showdeps                Only display direct dependencies
  --reinstall               Reinstall the distribution even if you already have the latest version installed
  --mirror                  Specify the base URL for the mirror (e.g. http://cpan.cpantesters.org/)
  --mirror-only             Use the mirror's index file instead of the CPAN Meta DB
  -M,--from                 Use only this mirror base URL and its index file
  --prompt                  Prompt when configure/build/test fails
  -l,--local-lib            Specify the install base to install modules
  -L,--local-lib-contained  Specify the install base to install all non-core modules
  --self-contained          Install all non-core modules, even if they're already installed.
  --auto-cleanup            Number of days that cpanm's work directories expire in. Defaults to 7

Commands:
  --self-upgrade            upgrades itself
  --info                    Displays distribution info on CPAN
  --look                    Opens the distribution with your SHELL
  -U,--uninstall            Uninstalls the modules (EXPERIMENTAL)
  -V,--version              Displays software version

Examples:

  cpanm Test::More                                          # install Test::More
  cpanm MIYAGAWA/Plack-0.99_05.tar.gz                       # full distribution path
  cpanm http://example.org/LDS/CGI.pm-3.20.tar.gz           # install from URL
  cpanm ~/dists/MyCompany-Enterprise-1.00.tar.gz            # install from a local file
  cpanm --interactive Task::Kensho                          # Configure interactively
  cpanm .                                                   # install from local directory
  cpanm --installdeps .                                     # install all the deps for the current directory
  cpanm -L extlib Plack                                     # install Plack and all non-core deps into extlib
  cpanm --mirror http://cpan.cpantesters.org/ DBI           # use the fast-syncing mirror
  cpanm -M https://cpan.metacpan.org App::perlbrew          # use only this secure mirror and its index

You can also specify the default options in PERL_CPANM_OPT environment variable in the shell rc:

  export PERL_CPANM_OPT="--prompt --reinstall -l ~/perl --mirror http://cpan.cpantesters.org"

Type `man cpanm` or `perldoc cpanm` for the more detailed explanation of the options.
```

