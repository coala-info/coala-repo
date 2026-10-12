# perl-devel-cover CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-devel-cover | PASS |  |
| perl-devel-cover_cpancover | Not completed | needs a directory of unpacked CPAN distributions and runs their test suites; too heavy for a minimal test |
| perl-devel-cover_gcov2perl | Not completed | no real gcov files available: the image has no gcc to build coverage data and the module ships none |

## perl-devel-cover

### Tool Description
A tool to generate code coverage reports for Perl using the Devel::Cover module.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0
- **Homepage**: http://www.pjcj.net/perl.html
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-devel-cover/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-devel-cover/overview
- **Total Downloads**: 5.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage:
     cover -test

     cover -report html_basic

Options:
    The following command line options are supported:

     -h -help              - show help
     -i -info              - show documentation
     -v -version           - show version

     -silent               - don't print informational messages (default off)
     -summary              - give summary report                (default on)
     -report report_format - report format                      (default html)
     -outputdir dir        - directory for output               (default given db)
     -launch               - launch report in viewer (if avail) (default off)

     -select filename      - only report on the file            (default all)
     -ignore filename      - don't report on the file           (default none)
     -select_re RE         - append to REs of files to select   (default none)
     -ignore_re RE         - append to REs of files to ignore   (default none)
     -write [db]           - write the merged database          (default off)
     -delete               - drop database(s)                   (default off)
     -dump_db              - dump database(s) (for debugging)   (default off)

     -coverage criterion   - report on criterion  (default all available)

     -test                 - drop database(s) and run make test (default off)
     -gcov                 - run gcov to cover XS code     (default on if using gcc)
     -make make_prog       - use the given 'make' program for 'make test'
     -prefer_lib           - prefer files in lib                (default off)

     -add_uncoverable_point    string
     -delete_uncoverable_point string
     -clean_uncoverable_points
     -uncoverable_file         file

     other options specific to the report format

     coverage_database [coverage_database ...]

    The "-report", "-select", "-ignore", "-select_re", "-ignore_re", and
    "-coverage" options may be specified multiple times.
```

## perl-devel-cover_gcov2perl

### Tool Description
Convert gcov files to Devel::Cover databases

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0
- **Homepage**: http://www.pjcj.net/perl.html
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-devel-cover/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
     gcov2perl -h -i -v -db database gcov_files
```


## perl-devel-cover_cpancover

### Tool Description
Report coverage statistics on CPAN modules

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0
- **Homepage**: http://www.pjcj.net/perl.html
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-devel-cover/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
     cpancover -help -info -version
               -collect -redo_cpancover_html -redo_html -force -dryrun
               -modules module_name
               -results_dir /path/to/dir
               -outputdir /path/to/dir
               -outputfile filename.html
               -report report_name
               -generate_html
               -compress_old_versions number_to_keep
               -local
```

