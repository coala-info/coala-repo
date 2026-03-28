# panacus CWL Generation Report

## panacus_render

### Tool Description
Render an html report from one or more JSON result files

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2025-06-18
- **GitHub**: https://github.com/marschall-lab/panacus
- **Stars**: N/A
### Original Help Text
```text
Render an html report from one or more JSON result files

Usage: panacus render [OPTIONS] <json_files>...

Arguments:
  <json_files>...  Specifies one or more JSON files

Options:
  -t <COUNT>      Set the number of threads used (default: use all threads) [default: 0]
  -v, --verbose   Set the number of threads used (default: use all threads)
  -h, --help      Print help
```


## panacus_report

### Tool Description
Create an html report from a YAML config file

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
Create an html report from a YAML config file

Usage: panacus report [OPTIONS] [yaml_file]

Arguments:
  [yaml_file]  Specifies yaml config

Options:
  -d, --dry-run   If set, no actual computation is done, only the planned computation will be shown
  -j, --json      Instead of an HTML report, a json result will be delivered. These can later be
                  combined and rendered as a single HTML.
  -t <COUNT>      Set the number of threads used (default: use all threads) [default: 0]
  -v, --verbose   Set the number of threads used (default: use all threads)
  -h, --help      Print help
```


## panacus_hist

### Tool Description
Calculate coverage histogram

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate coverage histogram

Usage: panacus hist [OPTIONS] <GFA_FILE>

Arguments:
  <GFA_FILE>  graph in GFA1 format, accepts also compressed (.gz) file

Options:
  -s, --subset <FILE>      Produce counts by subsetting the graph to a given list of paths (1-column
                           list) or path coordinates (3- or 12-column BED file)
  -e, --exclude <FILE>     Exclude bp/node/edge in growth count that intersect with paths (1-column
                           list) or path coordinates (3- or 12-column BED-file) provided by the
                           given file; all intersecting bp/node/edge will be exluded also in other
                           paths not part of the given list
  -g, --groupby <FILE>     Merge counts from paths by path-group mapping from given tab-separated
                           two-column file
  -H, --groupby-haplotype  Merge counts from paths belonging to same haplotype
  -S, --groupby-sample     Merge counts from paths belonging to same sample
  -c, --count <count>      Graph quantity to be counted [default: node] [possible values: node, bp,
                           edge, all]
  -t <COUNT>               Set the number of threads used (default: use all threads) [default: 0]
  -v, --verbose            Set the number of threads used (default: use all threads)
  -h, --help               Print help
```


## panacus_growth

### Tool Description
Calculate growth curve from coverage histogram

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate growth curve from coverage histogram

Usage: panacus growth [OPTIONS] <FILE>

Arguments:
  <FILE>  EITHER graph in GFA1 format, accepts also compressed (.gz) file OR a histogram as a .tsv

Options:
  -s, --subset <FILE>        Produce counts by subsetting the graph to a given list of paths
                             (1-column list) or path coordinates (3- or 12-column BED file) (ONLY IN
                             GFA MODE)
  -e, --exclude <FILE>       Exclude bp/node/edge in growth count that intersect with paths
                             (1-column list) or path coordinates (3- or 12-column BED-file) provided
                             by the given file; all intersecting bp/node/edge will be exluded also
                             in other paths not part of the given list (ONLY IN GFA MODE)
  -g, --groupby <FILE>       Merge counts from paths by path-group mapping from given tab-separated
                             two-column file (ONLY IN GFA MODE)
  -H, --groupby-haplotype    Merge counts from paths belonging to same haplotype (ONLY IN GFA MODE)
  -S, --groupby-sample       Merge counts from paths belonging to same sample (ONLY IN GFA MODE)
  -a, --hist                 Also include histogram in output (ONLY IN GFA MODE)
  -l, --coverage <coverage>  Ignore all countables with a coverage lower than the specified
                             threshold. The coverage of a countable corresponds to the number of
                             path/walk that contain it. Repeated appearances of a countable in the
                             same path/walk are counted as one. You can pass a comma-separated list
                             of coverage thresholds, each one will produce a separated growth curve
                             (e.g., --coverage 2,3). Use --quorum to set a threshold in conjunction
                             with each coverage (e.g., --quorum 0.5,0.9) [default: 1]
  -q, --quorum <quorum>      Unlike the --coverage parameter, which specifies a minimum constant
                             number of paths for all growth point m (1 <= m <= num_paths), --quorum
                             adjust the threshold based on m. At each m, a countable is counted in
                             the average growth if the countable is contained in at least
                             floor(m*quorum) paths. Example: A quorum of 0.9 requires a countable to
                             be in 90% of paths for each subset size m. At m=10, it must appear in
                             at least 9 paths. At m=100, it must appear in at least 90 paths. A
                             quorum of 1 (100%) requires presence in all paths of the subset,
                             corresponding to the core. Default: 0, a countable counts if it is
                             present in any path at each growth point. Specify multiple quorum
                             values with a comma-separated list (e.g., --quorum 0.5,0.9). Use
                             --coverage to set static path thresholds in conjunction with variable
                             quorum percentages (e.g., --coverage 5,10). [default: 0]
  -t <COUNT>                 Set the number of threads used (default: use all threads) [default: 0]
  -v, --verbose              Set the number of threads used (default: use all threads)
  -h, --help                 Print help
```


## panacus_info

### Tool Description
Return general graph and paths info

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
Return general graph and paths info

Usage: panacus info [OPTIONS] <GFA_FILE>

Arguments:
  <GFA_FILE>  graph in GFA1 format, accepts also compressed (.gz) file

Options:
  -s, --subset <FILE>      Produce counts by subsetting the graph to a given list of paths (1-column
                           list) or path coordinates (3- or 12-column BED file)
  -e, --exclude <FILE>     Exclude bp/node/edge in growth count that intersect with paths (1-column
                           list) or path coordinates (3- or 12-column BED-file) provided by the
                           given file; all intersecting bp/node/edge will be exluded also in other
                           paths not part of the given list
  -g, --groupby <FILE>     Merge counts from paths by path-group mapping from given tab-separated
                           two-column file
  -H, --groupby-haplotype  Merge counts from paths belonging to same haplotype
  -S, --groupby-sample     Merge counts from paths belonging to same sample
  -t <COUNT>               Set the number of threads used (default: use all threads) [default: 0]
  -v, --verbose            Set the number of threads used (default: use all threads)
  -h, --help               Print help
```


## panacus_ordered-histgrowth

### Tool Description
Calculate growth curve based on group file order (if order is unspecified, use path order in GFA)

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate growth curve based on group file order (if order is unspecified, use path order in GFA)

Usage: panacus ordered-histgrowth [OPTIONS] <GFA_FILE>

Arguments:
  <GFA_FILE>  graph in GFA1 format, accepts also compressed (.gz) file

Options:
  -s, --subset <FILE>        Produce counts by subsetting the graph to a given list of paths
                             (1-column list) or path coordinates (3- or 12-column BED file)
  -e, --exclude <FILE>       Exclude bp/node/edge in growth count that intersect with paths
                             (1-column list) or path coordinates (3- or 12-column BED-file) provided
                             by the given file; all intersecting bp/node/edge will be exluded also
                             in other paths not part of the given list
  -g, --groupby <FILE>       Merge counts from paths by path-group mapping from given tab-separated
                             two-column file
  -H, --groupby-haplotype    Merge counts from paths belonging to same haplotype
  -S, --groupby-sample       Merge counts from paths belonging to same sample
  -O, --order <FILE>         The ordered histogram will be produced according to order of
                             paths/groups in the supplied file (1-column list). If this option is
                             not used, the order is determined by the rank of paths/groups in the
                             subset list, and if that option is not used, the order is determined by
                             the rank of paths/groups in the GFA file.
  -c, --count <count>        Graph quantity to be counted [default: node] [possible values: node,
                             bp, edge]
  -l, --coverage <coverage>  Ignore all countables with a coverage lower than the specified
                             threshold. The coverage of a countable corresponds to the number of
                             path/walk that contain it. Repeated appearances of a countable in the
                             same path/walk are counted as one. You can pass a comma-separated list
                             of coverage thresholds, each one will produce a separated growth curve
                             (e.g., --coverage 2,3). Use --quorum to set a threshold in conjunction
                             with each coverage (e.g., --quorum 0.5,0.9) [default: 1]
  -q, --quorum <quorum>      Unlike the --coverage parameter, which specifies a minimum constant
                             number of paths for all growth point m (1 <= m <= num_paths), --quorum
                             adjust the threshold based on m. At each m, a countable is counted in
                             the average growth if the countable is contained in at least
                             floor(m*quorum) paths. Example: A quorum of 0.9 requires a countable to
                             be in 90% of paths for each subset size m. At m=10, it must appear in
                             at least 9 paths. At m=100, it must appear in at least 90 paths. A
                             quorum of 1 (100%) requires presence in all paths of the subset,
                             corresponding to the core. Default: 0, a countable counts if it is
                             present in any path at each growth point. Specify multiple quorum
                             values with a comma-separated list (e.g., --quorum 0.5,0.9). Use
                             --coverage to set static path thresholds in conjunction with variable
                             quorum percentages (e.g., --coverage 5,10). [default: 0]
  -t <COUNT>                 Set the number of threads used (default: use all threads) [default: 0]
  -v, --verbose              Set the number of threads used (default: use all threads)
  -h, --help                 Print help
```


## panacus_path

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'path'

Usage: panacus [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## panacus_table

### Tool Description
Compute coverage table for count type

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
Compute coverage table for count type

Usage: panacus table [OPTIONS] <GFA_FILE>

Arguments:
  <GFA_FILE>  graph in GFA1 format, accepts also compressed (.gz) file

Options:
  -s, --subset <FILE>      Produce counts by subsetting the graph to a given list of paths (1-column
                           list) or path coordinates (3- or 12-column BED file)
  -e, --exclude <FILE>     Exclude bp/node/edge in growth count that intersect with paths (1-column
                           list) or path coordinates (3- or 12-column BED-file) provided by the
                           given file; all intersecting bp/node/edge will be exluded also in other
                           paths not part of the given list
  -g, --groupby <FILE>     Merge counts from paths by path-group mapping from given tab-separated
                           two-column file
  -H, --groupby-haplotype  Merge counts from paths belonging to same haplotype
  -S, --groupby-sample     Merge counts from paths belonging to same sample
  -a, --total              Summarize by totaling presence/absence over all groups
  -O, --order <FILE>       The ordered histogram will be produced according to order of paths/groups
                           in the supplied file (1-column list). If this option is not used, the
                           order is determined by the rank of paths/groups in the subset list, and
                           if that option is not used, the order is determined by the rank of
                           paths/groups in the GFA file.
  -c, --count <count>      Graph quantity to be counted [default: node] [possible values: node, bp,
                           edge]
  -t <COUNT>               Set the number of threads used (default: use all threads) [default: 0]
  -v, --verbose            Set the number of threads used (default: use all threads)
  -h, --help               Print help
```


## panacus_node-distribution

### Tool Description
Return the list of bins with there coverages, log10-lengths and log10-sizes. Due to this being the values for the centers of the hexagons shown in the html plot and not real values, some values might be negative.

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
Return the list of bins with there coverages, log10-lengths and log10-sizes. Due to this being the
values for the centers of the hexagons shown in the html plot and not real values, some values might
be negative.

Usage: panacus node-distribution [OPTIONS] <GFA_FILE>

Arguments:
  <GFA_FILE>  graph in GFA1 format, accepts also compressed (.gz) file

Options:
  -r, --radius <radius>  Radius of the hexagons used to bin [default: 20]
  -t <COUNT>             Set the number of threads used (default: use all threads) [default: 0]
  -v, --verbose          Set the number of threads used (default: use all threads)
  -h, --help             Print help
```


## panacus_Due

### Tool Description
For more information, try '--help'.

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'Due'

Usage: panacus [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## panacus_plot

### Tool Description
Panacus is a tool for analyzing and visualizing genomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
error: unrecognized subcommand 'plot'

  tip: a similar subcommand exists: 'report'

Usage: panacus [OPTIONS] <COMMAND>

For more information, try '--help'.
```


## panacus_similarity

### Tool Description
Compute coverage table for count type

### Metadata
- **Docker Image**: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
- **Homepage**: https://github.com/marschall-lab/panacus
- **Package**: https://anaconda.org/channels/bioconda/packages/panacus/overview
- **Validation**: PASS

### Original Help Text
```text
Compute coverage table for count type

Usage: panacus similarity [OPTIONS] <GFA_FILE>

Arguments:
  <GFA_FILE>  graph in GFA1 format, accepts also compressed (.gz) file

Options:
  -s, --subset <FILE>            Produce counts by subsetting the graph to a given list of paths
                                 (1-column list) or path coordinates (3- or 12-column BED file)
  -e, --exclude <FILE>           Exclude bp/node/edge in growth count that intersect with paths
                                 (1-column list) or path coordinates (3- or 12-column BED-file)
                                 provided by the given file; all intersecting bp/node/edge will be
                                 exluded also in other paths not part of the given list
  -g, --groupby <FILE>           Merge counts from paths by path-group mapping from given
                                 tab-separated two-column file
  -H, --groupby-haplotype        Merge counts from paths belonging to same haplotype
  -S, --groupby-sample           Merge counts from paths belonging to same sample
  -a, --total                    Summarize by totaling presence/absence over all groups
  -c, --count <count>            Graph quantity to be counted [default: node] [possible values:
                                 node, bp, edge]
  -m, --method <cluster_method>  Method for clustering results [default: centroid] [possible values:
                                 single, complete, average, weighted, ward, centroid, median]
  -t <COUNT>                     Set the number of threads used (default: use all threads) [default:
                                 0]
  -v, --verbose                  Set the number of threads used (default: use all threads)
  -h, --help                     Print help
```


## Metadata
- **Skill**: generated
