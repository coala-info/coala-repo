# smudgeplot CWL Generation Report

## smudgeplot_cutoff

### Tool Description
Calculate meaningful values for lower kmer histogram cutoff.

### Metadata
- **Docker Image**: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
- **Homepage**: https://github.com/KamilSJaron/smudgeplot
- **Package**: https://anaconda.org/channels/bioconda/packages/smudgeplot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smudgeplot/overview
- **Total Downloads**: 39.7K
- **Last updated**: 2025-12-18
- **GitHub**: https://github.com/KamilSJaron/smudgeplot
- **Stars**: N/A
### Original Help Text
```text
usage: smudgeplot cutoff [-h] infile boundary

Calculate meaningful values for lower kmer histogram cutoff.

positional arguments:
  infile      Name of the input kmer histogram file (default "kmer.hist")."
  boundary    Which bounary to compute L (lower) or U (upper).

options:
  -h, --help  show this help message and exit
```


## smudgeplot_hetmers

### Tool Description
Calculate unique kmer pairs from FastK k-mer database.

### Metadata
- **Docker Image**: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
- **Homepage**: https://github.com/KamilSJaron/smudgeplot
- **Package**: https://anaconda.org/channels/bioconda/packages/smudgeplot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: smudgeplot hetmers [-h] [-L L] [-t T] [-o O] [-tmp TMP] [--verbose]
                          infile

Calculate unique kmer pairs from FastK k-mer database.

positional arguments:
  infile      Input FastK database (.ktab) file.

options:
  -h, --help  show this help message and exit
  -L L        Count threshold below which k-mers are considered erroneous.
  -t T        Number of threads (default 4).
  -o O        The pattern used to name the output (kmerpairs).
  -tmp TMP    Directory where all temporary files will be stored (default
              /tmp).
  --verbose   Verbose mode.
```


## smudgeplot_peak_aggregation

### Tool Description
Aggregates smudges using local aggregation algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
- **Homepage**: https://github.com/KamilSJaron/smudgeplot
- **Package**: https://anaconda.org/channels/bioconda/packages/smudgeplot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: smudgeplot peak_aggregation [-h] [-nf NF] [-d D] [--mask_errors]
                                   [-title TITLE]
                                   infile

Aggregates smudges using local aggregation algorithm.

positional arguments:
  infile                Name of the input smu file with covarages and
                        frequencies.

options:
  -h, --help            show this help message and exit
  -nf, -noise_filter NF
                        k-mer pairs with frequencies lower than this value
                        will not be aggregated into smudges.
  -d, -distance D       Manthattan distance of k-mer pairs that are considered
                        neighbouring for the local aggregation purposes.
  --mask_errors         All k-mer pairs belonging to smudges with the peak
                        distant less than -d from the error line will be
                        labeled as -1 (errors).
  -title TITLE          name printed at the top of the smudgeplot (default:
                        infile prefix).
```


## smudgeplot_plot

### Tool Description
Generate 2d histogram; infer ploidy and plot a smudgeplot.

### Metadata
- **Docker Image**: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
- **Homepage**: https://github.com/KamilSJaron/smudgeplot
- **Package**: https://anaconda.org/channels/bioconda/packages/smudgeplot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: smudgeplot plot [-h] [-o O] [-t TITLE] [-ylim YLIM]
                       [-col_ramp COL_RAMP] [--invert_cols]
                       [--format {pdf,png,svg}] [--json_report]
                       infile smudgefile n

Generate 2d histogram; infer ploidy and plot a smudgeplot.

positional arguments:
  infile                Mame of the input tsv file with coverages and
                        frequencies.
  smudgefile            Name of the input tsv file with sizes of individual
                        smudges.
  n                     The expected haploid coverage.

options:
  -h, --help            show this help message and exit
  -o O                  The pattern used to name the output (smudgeplot).
  -t, --title TITLE     name printed at the top of the smudgeplot (default:
                        infile prefix).
  -ylim YLIM            The upper limit for the coverage sum (the y axis)
  -col_ramp COL_RAMP    Palette used for the plot (default "viridis", other
                        sensible options are "magma", "mako" or "grey.colors"
                        - recommended in combination with --invert_cols).
  --invert_cols         Invert the colour palette (default False).
  --format {pdf,png,svg}
                        Output format for the plots (default png)
  --json_report         Generate a JSON format report alongside the plots
                        (default False)
```


## smudgeplot_all

### Tool Description
Runs all the steps (with default options).

### Metadata
- **Docker Image**: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
- **Homepage**: https://github.com/KamilSJaron/smudgeplot
- **Package**: https://anaconda.org/channels/bioconda/packages/smudgeplot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: smudgeplot all [-h] [-o O] [-cov_min COV_MIN] [-cov_max COV_MAX]
                      [-cov COV] [-d D] [-t TITLE] [-ylim YLIM]
                      [-col_ramp COL_RAMP] [--invert_cols]
                      [--format {pdf,png,svg}] [--json_report]
                      infile

Runs all the steps (with default options).

positional arguments:
  infile                Name of the input tsv file with covarages and
                        frequencies.

options:
  -h, --help            show this help message and exit
  -o O                  The pattern used to name the output (smudgeplot).
  -cov_min COV_MIN      Minimal coverage to explore (default 6)
  -cov_max COV_MAX      Maximal coverage to explore (default 100)
  -cov COV              The assumed coverage (no inference of 1n coverage is
                        made).
  -d, -distance D       Manthattan distance of k-mer pairs that are considered
                        neighbouring for local aggregation purposes.
  -t, --title TITLE     name printed at the top of the smudgeplot (default:
                        infile prefix).
  -ylim YLIM            The upper limit for the coverage sum (the y axis)
  -col_ramp COL_RAMP    Palette used for the plot (default "viridis", other
                        sensible options are "magma", "mako" or "grey.colors"
                        - recommended in combination with --invert_cols).
  --invert_cols         Invert the colour palette (default False).
  --format {pdf,png,svg}
                        Output format for the plots (default png)
  --json_report         Generate a JSON format report alongside the plots
                        (default False)
```


## smudgeplot_extract

### Tool Description
Extract kmer pair sequences from a FastK k-mer database.

### Metadata
- **Docker Image**: quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0
- **Homepage**: https://github.com/KamilSJaron/smudgeplot
- **Package**: https://anaconda.org/channels/bioconda/packages/smudgeplot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: smudgeplot extract [-h] [-t T] [-o O] [-tmp TMP] [--verbose] infile sma

Extract kmer pair sequences from a FastK k-mer database.

positional arguments:
  infile      Input FastK database (.ktab) file.
  sma         Input annotated k-mer pair file (.sma).

options:
  -h, --help  show this help message and exit
  -t T        Number of threads (default 4)
  -o O        The pattern used to name the output (kmerpairs).
  -tmp TMP    Directory where all temporary files will be stored (default
              /tmp).
  --verbose   verbose mode
```


## Metadata
- **Skill**: generated
