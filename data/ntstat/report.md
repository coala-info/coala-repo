# ntstat CWL Generation Report

## ntstat_count

### Tool Description
Count k-mers from sequencing data using a k-mer spectrum file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntstat:1.0.1--py311he264feb_2
- **Homepage**: https://github.com/bcgsc/ntStat
- **Package**: https://anaconda.org/channels/bioconda/packages/ntstat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ntstat/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/ntStat
- **Stars**: N/A
### Original Help Text
```text
Usage: count [--help] [--version] [-k VAR] [-s VAR] -f VAR [-e VAR] [-b VAR] [--long] [-t VAR] -o VAR [reads]...

Positional arguments:
  reads          path to sequencing data file(s) [nargs: 0 or more] [required]

Optional arguments:
  -h, --help     shows help message and exits 
  -v, --version  prints version information and exits 
  -k             k-mer length 
  -s             path to spaced seeds file (one per line, if -k not specified) 
  -f             path to k-mer spectrum file (from ntCard) [required]
  -e             target output count error rate [nargs=0..1] [default: 0.001]
  -b             output CBF size (bytes) 
  --long         optimize for long read data 
  -t             number of threads [nargs=0..1] [default: 1]
  -o             path to store output file [required]
```


## ntstat_filter

### Tool Description
Filters k-mer spectra based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntstat:1.0.1--py311he264feb_2
- **Homepage**: https://github.com/bcgsc/ntStat
- **Package**: https://anaconda.org/channels/bioconda/packages/ntstat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: filter [--help] [--version] [-k VAR] [-s VAR] -f VAR [-e VAR] [-b VAR] [-cmin VAR] [-cmax VAR] [--counts] [--long] [-t VAR] -o VAR [reads]...

Positional arguments:
  reads          path to sequencing data file(s) [nargs: 0 or more] [required]

Optional arguments:
  -h, --help     shows help message and exits 
  -v, --version  prints version information and exits 
  -k             k-mer length 
  -s             path to spaced seeds file (one per line, if -k not specified) 
  -f             path to k-mer spectrum file (from ntCard) [required]
  -e             target output error rate [nargs=0..1] [default: 0.001]
  -b             output BF/CBF size (bytes) 
  -cmin          minimum count threshold (>=1, or 0 for first minimum) [nargs=0..1] [default: 1]
  -cmax          maximum count threshold (<=255) [nargs=0..1] [default: 255]
  --counts       output counts (requires ~8x RAM for CBF) 
  --long         optimize for long read data 
  -t             number of threads [nargs=0..1] [default: 1]
  -o             path to store output file [required]
```


## ntstat_hist

### Tool Description
Generates a histogram from k-mer spectrum data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntstat:1.0.1--py311he264feb_2
- **Homepage**: https://github.com/bcgsc/ntStat
- **Package**: https://anaconda.org/channels/bioconda/packages/ntstat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ntstat [-h] [-p PLOIDY]
              [-f {asciidoc,double_grid,double_outline,fancy_grid,fancy_outline,github,grid,heavy_grid,heavy_outline,html,jira,latex,latex_booktabs,latex_longtable,latex_raw,mediawiki,mixed_grid,mixed_outline,moinmoin,orgtbl,outline,pipe,plain,presto,pretty,psql,rounded_grid,rounded_outline,rst,simple,simple_grid,simple_outline,textile,tsv,unsafehtml,youtrack}]
              [-m STYLE] [-t TITLE] [--y-log | --no-y-log] [-r PLOT_RANGE]
              [-o PLOT] [--probs PROBS] [--fit-gif FIT_GIF] [-c CONFIG]
              [--no-model]
              path

positional arguments:
  path                  k-mer spectrum file (in ntCard format)

options:
  -h, --help            show this help message and exit
  -p PLOIDY, --ploidy PLOIDY
                        genome ploidy
  -f {asciidoc,double_grid,double_outline,fancy_grid,fancy_outline,github,grid,heavy_grid,heavy_outline,html,jira,latex,latex_booktabs,latex_longtable,latex_raw,mediawiki,mixed_grid,mixed_outline,moinmoin,orgtbl,outline,pipe,plain,presto,pretty,psql,rounded_grid,rounded_outline,rst,simple,simple_grid,simple_outline,textile,tsv,unsafehtml,youtrack}, --table-format {asciidoc,double_grid,double_outline,fancy_grid,fancy_outline,github,grid,heavy_grid,heavy_outline,html,jira,latex,latex_booktabs,latex_longtable,latex_raw,mediawiki,mixed_grid,mixed_outline,moinmoin,orgtbl,outline,pipe,plain,presto,pretty,psql,rounded_grid,rounded_outline,rst,simple,simple_grid,simple_outline,textile,tsv,unsafehtml,youtrack}
                        stdout table format
  -m STYLE, --style STYLE
                        matplotlib style file, url, or one of available style
                        names: ntstat.hist.default, ntstat.hist.paper,
                        Solarize_Light2, _classic_test_patch, _mpl-gallery,
                        _mpl-gallery-nogrid, bmh, classic, dark_background,
                        fast, fivethirtyeight, ggplot, grayscale,
                        seaborn-v0_8, seaborn-v0_8-bright,
                        seaborn-v0_8-colorblind, seaborn-v0_8-dark,
                        seaborn-v0_8-dark-palette, seaborn-v0_8-darkgrid,
                        seaborn-v0_8-deep, seaborn-v0_8-muted,
                        seaborn-v0_8-notebook, seaborn-v0_8-paper,
                        seaborn-v0_8-pastel, seaborn-v0_8-poster,
                        seaborn-v0_8-talk, seaborn-v0_8-ticks,
                        seaborn-v0_8-white, seaborn-v0_8-whitegrid, tableau-
                        colorblind10
  -t TITLE, --title TITLE
                        title to put on plot
  --y-log, --no-y-log   plot y-axis in log scale
  -r PLOT_RANGE, --plot-range PLOT_RANGE
                        plot x-axis limits (inclusive) separated by a colon,
                        i.e., use a:b to show results in the range [a, b].
                        'auto' will automatically adjust the limits for better
                        visibility.
  -o PLOT, --plot PLOT  path to output plot
  --probs PROBS         path to output probabilities in csv format
  --fit-gif FIT_GIF     path to output model fit history animation
  -c CONFIG, --config CONFIG
                        path to differential evolution config file (json)
  --no-model
```


## ntstat_query

### Tool Description
Query ntstat database

### Metadata
- **Docker Image**: quay.io/biocontainers/ntstat:1.0.1--py311he264feb_2
- **Homepage**: https://github.com/bcgsc/ntStat
- **Package**: https://anaconda.org/channels/bioconda/packages/ntstat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: query [-h] -b B [-s S] -o O data [data ...]

positional arguments:
  data        path to query data

options:
  -h, --help  show this help message and exit
  -b B        path to BF/CBF file
  -s S        path to spaced seeds file
  -o O        path to output TSV file
```


## Metadata
- **Skill**: generated
