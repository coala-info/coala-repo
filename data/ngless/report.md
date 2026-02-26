# ngless CWL Generation Report

## ngless

### Tool Description
ngless implement the NGLess language

### Metadata
- **Docker Image**: quay.io/biocontainers/ngless:1.5.0--h9ee0642_0
- **Homepage**: http://ngless.embl.de
- **Package**: https://anaconda.org/channels/bioconda/packages/ngless/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngless/overview
- **Total Downloads**: 109.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: ngless-wrapped [-V|--version] [--version-short] [--version-debug] 
                      [--date-short] 
                      (((-e|--script ARG) | INPUT) [--debug ARG] 
                        [-n|--validate-only] [-p|--print-last] 
                        [-j|--jobs|--threads ARG] 
                        [--strict-threads | --no-strict-threads] 
                        [--create-report | --no-create-report] 
                        [-o|--html-report-directory ARG] 
                        [-t|--temporary-directory ARG] 
                        [--keep-temporary-files | --no-keep-temporary-files] 
                        [--config-file ARG] [--no-header] [--subsample] 
                        [--experimental-features] [--export-json ARG] 
                        [--export-cwl ARG] [--check-deprecation] 
                        [--search-dir ARG | --search-path ARG] 
                        [--index-path ARG] [ARGV] |
                        --download-file --download-url ARG --local-file ARG | 
                        --download-demo DEMO-NAME | --install-reference-data
                        REF |
                        --print-path EXEC | --check-install [-v|--verbose]) 
                      [-v|--verbosity ARG] [-q|--quiet] [--color ARG] 
                      [--trace | --no-trace]
  ngless implement the NGLess language

Available options:
  -V,--version             print version and exit
  --version-short          print just version string (useful for scripting)
  --version-debug          print detailed version information
  --date-short             print just release date string (useful for scripting)
  -h,--help                Show this help text
  -e,--script ARG          inline script to execute
  INPUT                    Filename of script to interpret
  -n,--validate-only       Only validate input, do not run script
  -p,--print-last          print value of last line in script
  -j,--jobs,--threads ARG  Nr of threads to use
  --strict-threads         strictly respect the --threads option (by default,
                           NGLess will, occasionally, use more threads than
                           specified)
  --no-strict-threads      opposite of --strict-threads
  --create-report          create the report directory
  --no-create-report       opposite of --create-report
  -o,--html-report-directory ARG
                           name of output directory
  -t,--temporary-directory ARG
                           Directory where to store temporary files
  --keep-temporary-files   Whether to keep temporary files (default is delete
                           them)
  --no-keep-temporary-files
                           opposite of --keep-temporary-files
  --config-file ARG        Configuration files to parse
  --no-header              Do not print copyright information
  --subsample              Subsample mode: quickly test a pipeline by discarding
                           99% of the input
  --experimental-features  Whether to allow the use of experimental features
  --export-json ARG        File to write JSON representation of script to
  --export-cwl ARG         File to write CWL wrapper of given script
  --check-deprecation      Check if ngless version or any used modules have been
                           deprecated
  --search-dir ARG         Deprecated. Use --search-path instead
  --search-path ARG        Reference search directories (replace <references> in
                           script)
  --index-path ARG         Index path (directory where indices are stored)
  REF                      Name of reference to install
  --check-install          Check if ngless is correctly installed
  -v,--verbose             Print paths
  --color ARG              Color settings, one of 'auto' (color if writing to a
                           terminal, this is the default), 'force' (always
                           color), 'no' (no color).
  --trace                  Set highest verbosity mode
  --no-trace               opposite of --trace

ngless v1.5.0(C) NGLess Authors 2013-2022 For more information:
https://ngless.embl.de/ For comments/discussion:
https://groups.google.com/forum/#!forum/ngless Citation: LP Coelho et al., 2019.
https://doi.org/10.1186/s40168-019-0684-8.
```

