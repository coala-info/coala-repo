# crispresso2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| crispresso2_CRISPRessoAggregate | PASS |  |

## Metadata
- **Skill**: generated

## crispresso2_CRISPRessoAggregate

### Tool Description
Aggregate CRISPResso2 Runs

### Metadata
- **Docker Image**: quay.io/biocontainers/crispresso2:2.3.3--py39hff726c5_0
- **Homepage**: https://github.com/pinellolab/CRISPResso2
- **Package**: https://anaconda.org/channels/bioconda/packages/crispresso2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: CRISPRessoAggregate [-h] [-p PREFIX] [-s SUFFIX] -n NAME
                           [--min_reads_for_inclusion MIN_READS_FOR_INCLUSION]
                           [--place_report_in_output_folder]
                           [--suppress_report] [--suppress_plots]
                           [--max_samples_per_summary_plot MAX_SAMPLES_PER_SUMMARY_PLOT]
                           [--n_processes N_PROCESSES] [--debug]
                           [-v VERBOSITY] [--halt_on_plot_fail]
                           [--use_matplotlib]

Aggregate CRISPResso2 Runs

optional arguments:
  -h, --help            show this help message and exit
  -p PREFIX, --prefix PREFIX
                        Prefix for CRISPResso folders to aggregate (may be
                        specified multiple times)
  -s SUFFIX, --suffix SUFFIX
                        Suffix for CRISPResso folders to aggregate
  -n NAME, --name NAME  Output name of the report
  --min_reads_for_inclusion MIN_READS_FOR_INCLUSION
                        Minimum number of reads for a run to be included in
                        the run summary
  --place_report_in_output_folder
                        If true, report will be written inside the CRISPResso
                        output folder. By default, the report will be written
                        one directory up from the report output.
  --suppress_report     Suppress output report
  --suppress_plots      Suppress output plots
  --max_samples_per_summary_plot MAX_SAMPLES_PER_SUMMARY_PLOT
                        Maximum number of samples on each page of the pdf
                        report plots. If this number gets above ~150, they
                        will be too big for matplotlib.
  --n_processes N_PROCESSES
                        Specify the number of processes to use for analysis.
                        Please use with caution since increasing this
                        parameter will significantly increase the memory
                        required to run CRISPResso. Can be set to 'max'.
  --debug               Show debug messages
  -v VERBOSITY, --verbosity VERBOSITY
                        Verbosity level of output to the console (1-4), 4 is
                        the most verbose
  --halt_on_plot_fail   Halt execution if a plot fails to generate
  --use_matplotlib      Use matplotlib for plotting instead of plotly/d3 when
                        CRISPRessoPro is installed
```
