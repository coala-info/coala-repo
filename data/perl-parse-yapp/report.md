# perl-parse-yapp CWL Generation Report

## perl-parse-yapp

### Tool Description
The tool 'perl-parse-yapp' was not found or could not be executed in the provided environment. No help text was available to parse arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-parse-yapp:1.21--pl526_0
- **Homepage**: http://metacpan.org/pod/Parse::Yapp
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-parse-yapp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-parse-yapp/overview
- **Total Downloads**: 34.9K
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
2026/02/14 16:20:41  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "perl-parse-yapp": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## perl-parse-yapp_yapp

### Tool Description
A perl-based compiler for Parse::Yapp grammar files, used to generate parser modules.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-parse-yapp:1.21--pl526_0
- **Homepage**: http://metacpan.org/pod/Parse::Yapp
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-parse-yapp/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
/usr/local/bin/yapp version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.26.2.

Usage: yapp [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -b -m -t -o
	Boolean (without arguments): -V -h -v -s -n

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.

For more details run
	perldoc -F /usr/local/bin/yapp
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]

Usage:	yapp [options] grammar[.yp]
  or	yapp -V
  or	yapp -h

    -m module   Give your parser module the name <module>
                default is <grammar>
    -v          Create a file <grammar>.output describing your parser
    -s          Create a standalone module in which the driver is included
    -n          Disable source file line numbering embedded in your parser
    -o outfile  Create the file <outfile> for your parser module
                Default is <grammar>.pm or, if -m A::Module::Name is
                specified, Name.pm
    -t filename Uses the file <filename> as a template for creating the parser
                module file.  Default is to use internal template defined
                in Parse::Yapp::Output
    -b shebang  Adds '#!<shebang>' as the very first line of the output file

    grammar     The grammar file. If no suffix is given, and the file
                does not exists, .yp is added

    -V          Display current version of Parse::Yapp and gracefully exits
    -h          Display this help screen
```

