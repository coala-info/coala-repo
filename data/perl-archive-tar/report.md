# perl-archive-tar CWL Generation Report

## perl-archive-tar

### Tool Description
FAIL to generate CWL: perl-archive-tar not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-archive-tar:3.04--pl5321hdfd78af_0
- **Homepage**: https://metacpan.org/pod/Archive::Tar
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-archive-tar/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-archive-tar/overview
- **Total Downloads**: 1.4M
- **Last updated**: 2025-06-12
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: perl-archive-tar not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: perl-archive-tar not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## perl-archive-tar_ptar

### Tool Description
ptar is a small, tar look-alike program that uses the perl module Archive::Tar to extract, create and list tar archives.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-archive-tar:3.04--pl5321hdfd78af_0
- **Homepage**: https://metacpan.org/pod/Archive::Tar
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-archive-tar/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/ptar version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.32.1.

Usage: ptar [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -f -T
	Boolean (without arguments): -D -d -c -v -z -t -h -x -I -C

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.

For more details run
	perldoc -F /usr/local/bin/ptar
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
You need exactly one of 'x', 't' or 'c' options: 
NAME

ptar - a tar-like program written in perl

DESCRIPTION

ptar is a small, tar look-alike program that uses the perl module
Archive::Tar to extract, create and list tar archives.

SYNOPSIS

    ptar -c [-v] [-z] [-C] [-f ARCHIVE_FILE | -] FILE FILE ...
    ptar -c [-v] [-z] [-C] [-T index | -] [-f ARCHIVE_FILE | -]
    ptar -x [-v] [-z] [-f ARCHIVE_FILE | -]
    ptar -t [-z] [-f ARCHIVE_FILE | -]
    ptar -h

OPTIONS

    c   Create ARCHIVE_FILE or STDOUT (-) from FILE
    x   Extract from ARCHIVE_FILE or STDIN (-)
    t   List the contents of ARCHIVE_FILE or STDIN (-)
    f   Name of the ARCHIVE_FILE to use. Default is './default.tar'
    z   Read/Write zlib compressed ARCHIVE_FILE (not always available)
    v   Print filenames as they are added or extracted from ARCHIVE_FILE
    h   Prints this help message
    C   CPAN mode - drop 022 from permissions
    T   get names to create from file

SEE ALSO

L<tar(1)>, L<Archive::Tar>.
```

## perl-archive-tar_ptargrep

### Tool Description
Apply pattern matching to the contents of files in a tar archive

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-archive-tar:3.04--pl5321hdfd78af_0
- **Homepage**: https://metacpan.org/pod/Archive::Tar
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-archive-tar/overview
- **Validation**: PASS
### Original Help Text
```text
NAME
    ptargrep - Apply pattern matching to the contents of files in a tar
    archive

SYNOPSIS
      ptargrep [options] <pattern> <tar file> ...

      Options:

       --basename|-b     ignore directory paths from archive
       --ignore-case|-i  do case-insensitive pattern matching
       --list-only|-l    list matching filenames rather than extracting matches
       --verbose|-v      write debugging message to STDERR
       --help|-?         detailed help message

DESCRIPTION
    This utility allows you to apply pattern matching to the contents of
    files contained in a tar archive. You might use this to identify all
    files in an archive which contain lines matching the specified pattern
    and either print out the pathnames or extract the files.

    The pattern will be used as a Perl regular expression (as opposed to a
    simple grep regex).

    Multiple tar archive filenames can be specified - they will each be
    processed in turn.

OPTIONS
    --basename (alias -b)
        When matching files are extracted, ignore the directory path from
        the archive and write to the current directory using the basename of
        the file from the archive. Beware: if two matching files in the
        archive have the same basename, the second file extracted will
        overwrite the first.

    --ignore-case (alias -i)
        Make pattern matching case-insensitive.

    --list-only (alias -l)
        Print the pathname of each matching file from the archive to STDOUT.
        Without this option, the default behaviour is to extract each
        matching file.

    --verbose (alias -v)
        Log debugging info to STDERR.

    --help (alias -?)
        Display this documentation.

COPYRIGHT
    Copyright 2010 Grant McLean <grantm@cpan.org>

    This program is free software; you can redistribute it and/or modify it
    under the same terms as Perl itself.
```

## perl-archive-tar_ptardiff

### Tool Description
ptardiff is a small program that diffs an extracted archive against an unextracted one, using the perl module Archive::Tar. It lets you view changes made to an archive's contents by comparing files in the archive with files in the current working directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-archive-tar:3.04--pl5321hdfd78af_0
- **Homepage**: https://metacpan.org/pod/Archive::Tar
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-archive-tar/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image


Usage:  ptardiff ARCHIVE_FILE
        ptardiff -h

    ptardiff is a small program that diffs an extracted archive
    against an unextracted one, using the perl module Archive::Tar.

    This effectively lets you view changes made to an archives contents.

    Provide the progam with an ARCHIVE_FILE and it will look up all
    the files with in the archive, scan the current working directory
    for a file with the name and diff it against the contents of the
    archive.


Options:
    h   Prints this help message


Sample Usage:

    $ tar -xzf Acme-Buffy-1.3.tar.gz
    $ vi Acme-Buffy-1.3/README

    [...]

    $ ptardiff Acme-Buffy-1.3.tar.gz > README.patch


See Also:
    tar(1)
    ptar
    Archive::Tar
```

