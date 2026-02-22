# perl-capture-tiny CWL Generation Report

## perl-capture-tiny

### Tool Description
The provided text does not contain help information for perl-capture-tiny; it is an error log indicating the executable was not found.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-capture-tiny:0.48--pl526_0
- **Homepage**: https://github.com/dagolden/Capture-Tiny
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-capture-tiny/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-capture-tiny/overview
- **Total Downloads**: 288.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dagolden/Capture-Tiny
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 08:33:39  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "perl-capture-tiny": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## perl-capture-tiny_prove

### Tool Description
Run tests through a TAP harness.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-capture-tiny:0.48--pl526_0
- **Homepage**: https://github.com/dagolden/Capture-Tiny
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-capture-tiny/overview
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

