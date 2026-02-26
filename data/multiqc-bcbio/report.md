# multiqc-bcbio CWL Generation Report

## multiqc-bcbio_multiqc

### Tool Description
Main MultiQC run command for use with the click command line, complete with all click function decorators. To make it easy to use MultiQC within notebooks and other locations that don't need click, we simply pass the parsed variables on to a vanilla python function.

### Metadata
- **Docker Image**: quay.io/biocontainers/multiqc-bcbio:0.2.9--pyh3252c3a_0
- **Homepage**: http://multiqc.info
- **Package**: https://anaconda.org/channels/bioconda/packages/multiqc-bcbio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/multiqc-bcbio/overview
- **Total Downloads**: 163.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: multiqc [OPTIONS] <analysis directory>

  Main MultiQC run command for use with the click command line, complete
  with all click function decorators. To make it easy to use MultiQC within
  notebooks and other locations that don't need click, we simply pass the
  parsed variables on to a vanilla python function.

Options:
  -f, --force                     Overwrite any existing reports
  -d, --dirs                      Prepend directory to sample names
  -dd, --dirs-depth INTEGER       Prepend [INT] directories to sample names.
                                  Negative number to take from start of path.

  -s, --fullnames                 Do not clean the sample names (leave as full
                                  file name)

  -i, --title TEXT                Report title. Printed as page header, used
                                  for filename if not otherwise specified.

  -b, --comment TEXT              Custom comment, will be printed at the top
                                  of the report.

  -n, --filename TEXT             Report filename. Use 'stdout' to print to
                                  standard out.

  -o, --outdir TEXT               Create report in the specified output
                                  directory.

  -t, --template [default|default_dev|gathered|geo|sections|simple]
                                  Report template to use.
  --tag TEXT                      Use only modules which tagged with this
                                  keyword, eg. RNA

  --view-tags, --view_tags        View the available tags and which modules
                                  they load

  -x, --ignore TEXT               Ignore analysis files (glob expression)
  --ignore-samples TEXT           Ignore sample names (glob expression)
  --ignore-symlinks               Ignore symlinked directories and files
  --sample-names PATH             File containing alternative sample names
  --sample-filters PATH           File containing show/hide patterns for the
                                  report

  -l, --file-list                 Supply a file containing a list of file
                                  paths to be searched, one per row

  -e, --exclude [module name]     Do not use this module. Can specify multiple
                                  times.

  -m, --module [module name]      Use only this module. Can specify multiple
                                  times.

  --data-dir                      Force the parsed data directory to be
                                  created.

  --no-data-dir                   Prevent the parsed data directory from being
                                  created.

  -k, --data-format [tsv|json|yaml]
                                  Output parsed data in a different format.
                                  Default: tsv

  -z, --zip-data-dir              Compress the data directory.
  -p, --export                    Export plots as static images in addition to
                                  the report

  -fp, --flat                     Use only flat plots (static images)
  -ip, --interactive              Use only interactive plots (HighCharts
                                  Javascript)

  --lint                          Use strict linting (validation) to help code
                                  development

  --pdf                           Creates PDF report with 'simple' template.
                                  Requires Pandoc to be installed.

  --no-megaqc-upload              Don't upload generated report to MegaQC,
                                  even if MegaQC options are found

  -c, --config PATH               Specific config file to load, after those in
                                  MultiQC dir / home dir / working dir.

  --cl-config, --cl_config TEXT   Specify MultiQC config YAML on the command
                                  line

  -v, --verbose                   Increase output verbosity.
  -q, --quiet                     Only show log warnings
  --profile-runtime               Add analysis of how long MultiQC takes to
                                  run to the report

  --no-ansi                       Disable coloured log output
  --version                       Show the version and exit.
  -h, --help                      Show this message and exit.
```

