# gappa CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gappa_analyze_correlation | PASS |  |
| gappa_analyze_dispersion | PASS |  |
| gappa_analyze_edgepca | PASS |  |
| gappa_analyze_imbalance-kmeans | PASS |  |
| gappa_analyze_krd | PASS |  |
| gappa_analyze_phylogenetic-kmeans | PASS |  |
| gappa_analyze_placement-factorization | PASS |  |
| gappa_analyze_squash | PASS |  |
| gappa_edit_accumulate | PASS |  |
| gappa_edit_extract | PASS |  |
| gappa_edit_filter | PASS |  |
| gappa_edit_merge | PASS |  |
| gappa_edit_multiplicity | PASS |  |
| gappa_edit_split | PASS |  |
| gappa_examine_assign | PASS | synthetic data: taxon file planted on the real gappa test tree and jplace sample. |
| gappa_examine_edpl | PASS |  |
| gappa_examine_graft | PASS |  |
| gappa_examine_heat-tree | PASS |  |
| gappa_examine_info | PASS |  |
| gappa_examine_lwr-distribution | PASS |  |
| gappa_examine_lwr-histogram | PASS |  |
| gappa_examine_lwr-list | PASS |  |
| gappa_prepare_chunkify | PASS |  |
| gappa_prepare_clean-tree | PASS |  |
| gappa_prepare_phat | PASS | synthetic data: taxonomy planted on a real epa-ng test alignment. |
| gappa_prepare_taxonomy-tree | PASS | synthetic data: small planted taxonomy. |
| gappa_prepare_unchunkify | PASS |  |
| gappa_simulate_random-alignment | PASS |  |
| gappa_simulate_random-placements | PASS |  |
| gappa_simulate_random-tree | PASS |  |

## gappa_analyze_correlation

### Tool Description
Calculate the Edge Correlation of samples and metadata features.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate the Edge Correlation of samples and metadata features.
Usage: gappa analyze correlation [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --mass-norm TEXT:{absolute,relative}=absolute REQUIRED
                              Set the per-sample normalization method. With `absolute`, the total mass is not changed, so that input jplace samples with more pqueries (more placed sequences) have a higher influence on the result. With `relative`, the total mass of each sample is normalized to 1.0, so that each sample has the same influence on the result, independent of its number of sequences and their abundances.
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.
  --edge-values TEXT:{both,imbalances,masses}=both
                              Values per edge used to calculate the correlation.
  --method TEXT:{all,pearson,spearman,kendall}=all
                              Method of correlation.


Metadata Table Input:
  --metadata-table-file TEXT:FILE REQUIRED
                              Tabular char-separated input file.
  --metadata-separator-char TEXT:{comma,tab,space,semicolon}=comma
                              Separator char for tabular data.
  --metadata-select-columns TEXT Excludes: --metadata-ignore-columns
                              Set the columns to select, by their name in the first (header) line of the table. All others columns are ignored. The options expects either a file with one column name per line, or an actual list of column names separated by --metadata-separator-char
  --metadata-ignore-columns TEXT Excludes: --metadata-select-columns
                              Set the columns to ignore, by their name in the first (header) line of the table. All others columns are selected. The options expects either a file with one column name per line, or an actual list of column names separated by --metadata-separator-char


Color:
  --color-list TEXT=spectral  List of colors to use for the palette. Can either be the name of a color list, a file containing one color per line, or an actual comma-separated list of colors. Colors can be specified in the format `#rrggbb` using hex values, or by web color names.
  --reverse-color-list FLAG   If set, the order of colors of the `--color-list` is reversed.
  --mask-color TEXT=#dfdfdf   Color used to indicate masked or invalid values, such as infinities or NaNs. Color can be specified in the format `#rrggbb` using hex values, or by web color names.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Tree Output:
  --write-newick-tree FLAG    If set, the tree is written to a Newick file. This format cannot store color information.
  --write-nexus-tree FLAG     If set, the tree is written to a Nexus file. This can for example be opened in FigTree.
  --write-phyloxml-tree FLAG  If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx.
  --write-svg-tree FLAG       If set, the tree is written to a SVG file. This gives a file for vector graphics editors.


Newick Tree Output:
  --newick-tree-branch-length-precision INT=6 Needs: --write-newick-tree
                              Number of digits to print for branch lengths in Newick format.
  --newick-tree-quote-invalid-chars FLAG  Needs: --write-newick-tree
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Svg Tree Output:
  --svg-tree-shape TEXT:{circular,rectangular}=circular Needs: --write-svg-tree
                              Shape of the tree.
  --svg-tree-type TEXT:{cladogram,phylogram}=cladogram Needs: --write-svg-tree
                              Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`).
  --svg-tree-stroke-width FLOAT=5 Needs: --write-svg-tree
                              Svg stroke width for the branches of the tree.
  --svg-tree-ladderize FLAG  Needs: --write-svg-tree
                              If set, the tree is ladderized.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_analyze_dispersion

### Tool Description
Calculate the Edge Dispersion between samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate the Edge Dispersion between samples.
Usage: gappa analyze dispersion [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --mass-norm TEXT:{absolute,relative}=absolute REQUIRED
                              Set the per-sample normalization method. With `absolute`, the total mass is not changed, so that input jplace samples with more pqueries (more placed sequences) have a higher influence on the result. With `relative`, the total mass of each sample is normalized to 1.0, so that each sample has the same influence on the result, independent of its number of sequences and their abundances.
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.
  --edge-values TEXT:{both,imbalances,masses}=both
                              Values per edge used to calculate the dispersion. Using `masses` focuses on per-branch dispersion, while using `imbalances` focuses on per-clade dispersion; see the paper for details.
  --method TEXT:{all,cv,cv-log,sd,sd-log,var,var-log,vmr,vmr-log}=all
                              Method of dispersion. Either `all` (as far as they are applicable), or any of: coefficient of variation (`cv`, standard deviation divided by mean), coefficient of variation log-scaled (`cv-log`), standard deviation (`sd`), standard deviation log-scaled (`sd-log`)variance (`var`), variance log-scaled (`var-log`), variance to mean ratio (`vmr`, also called Index of Dispersion), variance to mean ratio log-scaled (`vmr-log`). It typically is useful to use `all`, in order to spot all patterns that can emerge from this method.


Color:
  --color-list TEXT=viridis   List of colors to use for the palette. Can either be the name of a color list, a file containing one color per line, or an actual comma-separated list of colors. Colors can be specified in the format `#rrggbb` using hex values, or by web color names.
  --reverse-color-list FLAG   If set, the order of colors of the `--color-list` is reversed.
  --mask-color TEXT=#dfdfdf   Color used to indicate masked or invalid values, such as infinities or NaNs. Color can be specified in the format `#rrggbb` using hex values, or by web color names.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Tree Output:
  --write-newick-tree FLAG    If set, the tree is written to a Newick file. This format cannot store color information.
  --write-nexus-tree FLAG     If set, the tree is written to a Nexus file. This can for example be opened in FigTree.
  --write-phyloxml-tree FLAG  If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx.
  --write-svg-tree FLAG       If set, the tree is written to a SVG file. This gives a file for vector graphics editors.


Newick Tree Output:
  --newick-tree-branch-length-precision INT=6 Needs: --write-newick-tree
                              Number of digits to print for branch lengths in Newick format.
  --newick-tree-quote-invalid-chars FLAG  Needs: --write-newick-tree
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Svg Tree Output:
  --svg-tree-shape TEXT:{circular,rectangular}=circular Needs: --write-svg-tree
                              Shape of the tree.
  --svg-tree-type TEXT:{cladogram,phylogram}=cladogram Needs: --write-svg-tree
                              Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`).
  --svg-tree-stroke-width FLOAT=5 Needs: --write-svg-tree
                              Svg stroke width for the branches of the tree.
  --svg-tree-ladderize FLAG  Needs: --write-svg-tree
                              If set, the tree is ladderized.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_analyze_edgepca

### Tool Description
Perform Edge PCA (Principal Component Analysis) for a set of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Perform Edge PCA (Principal Component Analysis) for a set of samples.
Usage: gappa analyze edgepca [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --kappa FLOAT=1             Exponent for scaling between weighted and unweighted splitification.
  --epsilon FLOAT=1e-05       Epsilon to use to determine if a split matrix’s column is constant for filtering. Set to a negative value to deavtivate constant columnn filtering.
  --components UINT=5         Number of principal coordinates to calculate. Use 0 to calculate all possible coordinates.
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.


Color:
  --color-list TEXT=spectral  List of colors to use for the palette. Can either be the name of a color list, a file containing one color per line, or an actual comma-separated list of colors. Colors can be specified in the format `#rrggbb` using hex values, or by web color names.
  --reverse-color-list FLAG   If set, the order of colors of the `--color-list` is reversed.
  --mask-color TEXT=#dfdfdf   Color used to indicate masked or invalid values, such as infinities or NaNs. Color can be specified in the format `#rrggbb` using hex values, or by web color names.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Tree Output:
  --write-newick-tree FLAG    If set, the tree is written to a Newick file. This format cannot store color information.
  --write-nexus-tree FLAG     If set, the tree is written to a Nexus file. This can for example be opened in FigTree.
  --write-phyloxml-tree FLAG  If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx.
  --write-svg-tree FLAG       If set, the tree is written to a SVG file. This gives a file for vector graphics editors.


Newick Tree Output:
  --newick-tree-branch-length-precision INT=6 Needs: --write-newick-tree
                              Number of digits to print for branch lengths in Newick format.
  --newick-tree-quote-invalid-chars FLAG  Needs: --write-newick-tree
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Svg Tree Output:
  --svg-tree-shape TEXT:{circular,rectangular}=circular Needs: --write-svg-tree
                              Shape of the tree.
  --svg-tree-type TEXT:{cladogram,phylogram}=cladogram Needs: --write-svg-tree
                              Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`).
  --svg-tree-stroke-width FLOAT=5 Needs: --write-svg-tree
                              Svg stroke width for the branches of the tree.
  --svg-tree-ladderize FLAG  Needs: --write-svg-tree
                              If set, the tree is ladderized.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_analyze_imbalance-kmeans

### Tool Description
Run Imbalance k-means clustering on a set of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Run Imbalance k-means clustering on a set of samples.
Usage: gappa analyze imbalance-kmeans [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --k TEXT REQUIRED           Number of clusters to find. Can be a comma-separated list of multiple values or ranges for k, such as `"1-5,8,10,12"`
  --write-overview-file FLAG  If provided, a table file is written that summarizes the average distance and variance of the clusters for each k. Useful for elbow plots.
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.


Color:
  --color-list TEXT=BuPuBk    List of colors to use for the palette. Can either be the name of a color list, a file containing one color per line, or an actual comma-separated list of colors. Colors can be specified in the format `#rrggbb` using hex values, or by web color names.
  --reverse-color-list FLAG   If set, the order of colors of the `--color-list` is reversed.
  --log-scaling FLAG          If set, the sequential color list is logarithmically scaled instead of linearily.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT=ikmeans_ File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Tree Output:
  --write-newick-tree FLAG    If set, the tree is written to a Newick file. This format cannot store color information.
  --write-nexus-tree FLAG     If set, the tree is written to a Nexus file. This can for example be opened in FigTree.
  --write-phyloxml-tree FLAG  If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx.
  --write-svg-tree FLAG       If set, the tree is written to a SVG file. This gives a file for vector graphics editors.


Newick Tree Output:
  --newick-tree-branch-length-precision INT=6 Needs: --write-newick-tree
                              Number of digits to print for branch lengths in Newick format.
  --newick-tree-quote-invalid-chars FLAG  Needs: --write-newick-tree
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Svg Tree Output:
  --svg-tree-shape TEXT:{circular,rectangular}=circular Needs: --write-svg-tree
                              Shape of the tree.
  --svg-tree-type TEXT:{cladogram,phylogram}=cladogram Needs: --write-svg-tree
                              Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`).
  --svg-tree-stroke-width FLOAT=5 Needs: --write-svg-tree
                              Svg stroke width for the branches of the tree.
  --svg-tree-ladderize FLAG  Needs: --write-svg-tree
                              If set, the tree is ladderized.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_analyze_krd

### Tool Description
Calculate the pairwise Kantorovich-Rubinstein (KR) distance matrix between samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate the pairwise Kantorovich-Rubinstein (KR) distance matrix between samples.
Usage: gappa analyze krd [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --exponent FLOAT=1          Exponent for KR integration.
  --normalize FLAG            Divide the KR distance by the tree length to get normalized values.
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.


Matrix Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress FLAG             If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.
  --matrix-format TEXT:{list,matrix,triangular}=matrix
                              Format of the output matrix file.
  --omit-matrix-labels FLAG   If set, the output matrix is written without column and row labels.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_analyze_phylogenetic-kmeans

### Tool Description
Run Phylogenetic k-means clustering on a set of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Run Phylogenetic k-means clustering on a set of samples.
Usage: gappa analyze phylogenetic-kmeans [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --k TEXT REQUIRED           Number of clusters to find. Can be a comma-separated list of multiple values or ranges for k, such as `"1-5,8,10,12"`
  --write-overview-file FLAG  If provided, a table file is written that summarizes the average distance and variance of the clusters for each k. Useful for elbow plots.
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.
  --bins UINT=0               Bin the masses per-branch in order to save time and memory, with only minor differences in the cluster assignments. Default is 0, that is, no binning. If set, we recommend to use 50 bins or more.


Color:
  --color-list TEXT=BuPuBk    List of colors to use for the palette. Can either be the name of a color list, a file containing one color per line, or an actual comma-separated list of colors. Colors can be specified in the format `#rrggbb` using hex values, or by web color names.
  --reverse-color-list FLAG   If set, the order of colors of the `--color-list` is reversed.
  --log-scaling FLAG          If set, the sequential color list is logarithmically scaled instead of linearily.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT=pkmeans_ File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Tree Output:
  --write-newick-tree FLAG    If set, the tree is written to a Newick file. This format cannot store color information.
  --write-nexus-tree FLAG     If set, the tree is written to a Nexus file. This can for example be opened in FigTree.
  --write-phyloxml-tree FLAG  If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx.
  --write-svg-tree FLAG       If set, the tree is written to a SVG file. This gives a file for vector graphics editors.


Newick Tree Output:
  --newick-tree-branch-length-precision INT=6 Needs: --write-newick-tree
                              Number of digits to print for branch lengths in Newick format.
  --newick-tree-quote-invalid-chars FLAG  Needs: --write-newick-tree
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Svg Tree Output:
  --svg-tree-shape TEXT:{circular,rectangular}=circular Needs: --write-svg-tree
                              Shape of the tree.
  --svg-tree-type TEXT:{cladogram,phylogram}=cladogram Needs: --write-svg-tree
                              Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`).
  --svg-tree-stroke-width FLOAT=5 Needs: --write-svg-tree
                              Svg stroke width for the branches of the tree.
  --svg-tree-ladderize FLAG  Needs: --write-svg-tree
                              If set, the tree is ladderized.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_analyze_placement-factorization

### Tool Description
Perform Placement-Factorization on a set of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Perform Placement-Factorization on a set of samples.
Usage: gappa analyze placement-factorization [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Metadata Table Input:
  --metadata-table-file TEXT:FILE REQUIRED
                              Tabular char-separated input file.
  --metadata-separator-char TEXT:{comma,tab,space,semicolon}=comma
                              Separator char for tabular data.
  --metadata-select-columns TEXT Excludes: --metadata-ignore-columns
                              Set the columns to select, by their name in the first (header) line of the table. All others columns are ignored. The options expects either a file with one column name per line, or an actual list of column names separated by --metadata-separator-char
  --metadata-ignore-columns TEXT Excludes: --metadata-select-columns
                              Set the columns to ignore, by their name in the first (header) line of the table. All others columns are selected. The options expects either a file with one column name per line, or an actual list of column names separated by --metadata-separator-char


Settings:
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.
  --factors UINT=5            Number of phylogenetic factors to compute.
  --taxon-weight-tendency TEXT:{geometric-mean,arithmetic-mean,median,none}=geometric-mean
                              Tendency term to use for calculating taxon weights.
  --taxon-weight-norm TEXT:{manhattan,euclidean,maximum,aitchison,none}=euclidean
                              Norm term to use for calculating taxon weights.
  --pseudo-count-summand-all FLOAT=0.65
                              Constant that is added to all taxon masses to avoid zero counts.
  --pseudo-count-summand-zeros FLOAT=0
                              Constant that is added to taxon masses that are zero, to avoid zero counts.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Tree Output:
  --write-newick-tree FLAG    If set, the tree is written to a Newick file. This format cannot store color information.
  --write-nexus-tree FLAG     If set, the tree is written to a Nexus file. This can for example be opened in FigTree.
  --write-phyloxml-tree FLAG  If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx.
  --write-svg-tree FLAG       If set, the tree is written to a SVG file. This gives a file for vector graphics editors.


Newick Tree Output:
  --newick-tree-branch-length-precision INT=6 Needs: --write-newick-tree
                              Number of digits to print for branch lengths in Newick format.
  --newick-tree-quote-invalid-chars FLAG  Needs: --write-newick-tree
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Svg Tree Output:
  --svg-tree-shape TEXT:{circular,rectangular}=circular Needs: --write-svg-tree
                              Shape of the tree.
  --svg-tree-type TEXT:{cladogram,phylogram}=cladogram Needs: --write-svg-tree
                              Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`).
  --svg-tree-stroke-width FLOAT=5 Needs: --write-svg-tree
                              Svg stroke width for the branches of the tree.
  --svg-tree-ladderize FLAG  Needs: --write-svg-tree
                              If set, the tree is ladderized.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_analyze_squash

### Tool Description
Perform Squash Clustering for a set of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Perform Squash Clustering for a set of samples.
Usage: gappa analyze squash [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --exponent FLOAT=1          Exponent for KR integration.
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.


Color:
  --color-list TEXT=BuPuBk    List of colors to use for the palette. Can either be the name of a color list, a file containing one color per line, or an actual comma-separated list of colors. Colors can be specified in the format `#rrggbb` using hex values, or by web color names.
  --reverse-color-list FLAG   If set, the order of colors of the `--color-list` is reversed.
  --log-scaling FLAG          If set, the sequential color list is logarithmically scaled instead of linearily.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Tree Output:
  --write-newick-tree FLAG    If set, the tree is written to a Newick file. This format cannot store color information.
  --write-nexus-tree FLAG     If set, the tree is written to a Nexus file. This can for example be opened in FigTree.
  --write-phyloxml-tree FLAG  If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx.
  --write-svg-tree FLAG       If set, the tree is written to a SVG file. This gives a file for vector graphics editors.


Newick Tree Output:
  --newick-tree-branch-length-precision INT=6 Needs: --write-newick-tree
                              Number of digits to print for branch lengths in Newick format.
  --newick-tree-quote-invalid-chars FLAG  Needs: --write-newick-tree
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Svg Tree Output:
  --svg-tree-shape TEXT:{circular,rectangular}=circular Needs: --write-svg-tree
                              Shape of the tree.
  --svg-tree-type TEXT:{cladogram,phylogram}=cladogram Needs: --write-svg-tree
                              Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`).
  --svg-tree-stroke-width FLOAT=5 Needs: --write-svg-tree
                              Svg stroke width for the branches of the tree.
  --svg-tree-ladderize FLAG  Needs: --write-svg-tree
                              If set, the tree is ladderized.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_edit_accumulate

### Tool Description
Accumulate the masses of each query in jplace files into basal branches so that they exceed a given mass threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Accumulate the masses of each query in jplace files into basal branches so that they exceed a given mass threshold.
Usage: gappa edit accumulate [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --threshold FLOAT:FLOAT in [0.5 - 1]=0.95
                              Threshold of how much mass needs to be accumulated into a basal branch.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_edit_extract

### Tool Description
Extract placements from clades of the tree and write per-clade jplace files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Extract placements from clades of the tree and write per-clade jplace files.
Usage: gappa edit extract [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.
  --clade-list-file TEXT:FILE REQUIRED
                              File containing a tab-separated list of taxon to clade mapping.
  --fasta-path TEXT:PATH(existing)=[] ...
                              List of fasta files or directories to process. For directories, only files with the extension `.(fasta|fas|fsa|fna|ffn|faa|frn)[.gz]` are processed.


Settings:
  --threshold FLOAT:FLOAT in [0.5 - 1]=0.95
                              Threshold of how much placement mass needs to be in a clade for extracting a pquery.
  --exclude-clade-stems FLAG  By default, the branch connecting a specified clade to the rest of the tree is considered part of the clade. With this option, these branches are excluded, and instead considered as basal branches.
  --basal-clade-name TEXT=basal
                              The name of the clade used for queries that do not fall into one of the specified clades.
  --uncertain-clade-name TEXT=uncertain
                              The name of the clade used for queries that do not fall into any clade with more than the threshold amount of their mass.
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.


Output:
  --color-tree-file TEXT:PATH(non-existing)
                              If a path is provided, an svg file with a tree colored by clades is written.
  --samples-out-dir TEXT=samples
                              Directory to write output samples files to.
  --samples-file-prefix TEXT  File prefix for samples files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --samples-file-suffix TEXT  File suffix for samples files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --sequences-out-dir TEXT=sequences
                              Directory to write output sequences files to.
  --sequences-file-prefix TEXT
                              File prefix for sequences files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --sequences-file-suffix TEXT
                              File suffix for sequences files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_edit_filter

### Tool Description
Filter jplace files according to some criteria, that is, remove all queries and/or placement locations that do not pass the provided filter(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Filter jplace files according to some criteria, that is, remove all queries and/or placement locations that do not pass the provided filter(s).
Usage: gappa edit filter [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Placement Filters:
  --normalize-before FLAG     Before filtering placements, normalize the initial placement masses (likelihood weight ratios) by proportially scaling them so that they sum to one per pquery.
  --min-accumulated-mass FLOAT:FLOAT in [0 - 1]=0
                              Only keep the most likely placements per query so that their accumulated mass is above the given minimum value.
  --min-mass-threshold FLOAT:FLOAT in [0 - 1]=0
                              Only keep those placements per query whose mass is above the given minimum threshold.
  --max-n-placements UINT=0   Only keep the n most likely placements per query.
  --min-pendant-len FLOAT=0   Only keep placements with at least the given pendant length.
  --max-pendant-len FLOAT=0   Only keep placements with at most the given pendant length.
  --no-remove-empty FLAG      After filtering placements, there might be pqueries that do not have any placement locations remaining. By default, the whole pquery is removed in this case, as it is useless. However, if this flag is set, they are kept as empty pqueries with just their name.
  --normalize-after FLAG      After filtering placements, normalize the remaining placement masses (likelihood weight ratios) by proportially scaling them so that they sum to one per pquery.


Name Filters:
  --keep-names TEXT           Keep queries whose name matches the given names, which can be provided either as a regular expression (regex), or as a file with one name per line. Remove all others.
  --remove-names TEXT         Remove queries whose name matches the given names, which can be provided either as a regular expression (regex), or as a file with one name per line. Keep all others.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress FLAG             If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_edit_merge

### Tool Description
Merge jplace files by combining their pqueries into one file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Merge jplace files by combining their pqueries into one file.
Usage: gappa edit merge [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress FLAG             If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_edit_multiplicity

### Tool Description
Edit the multiplicities of queries in jplace files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Edit the multiplicities of queries in jplace files.
Usage: gappa edit multiplicity [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.
  --multiplicity-file TEXT:FILE Excludes: --fasta-path --write-multiplicity-file
                              File containing a tab-separated list of [sample name,] query name, and multiplicity.
  --fasta-path TEXT:PATH(existing)=[] ... Excludes: --multiplicity-file --write-multiplicity-file
                              List of fasta files or directories to process. For directories, only files with the extension `.(fasta|fas|fsa|fna|ffn|faa|frn)[.gz]` are processed.
  --keep-full-label FLAG  Needs: --fasta-path
                              If fasta files are used, keep their whole label as the name for jplace pqueries, instead of removing the abundance annotation.


Output:
  --write-multiplicity-file FLAG  Excludes: --multiplicity-file --fasta-path
                              Do not change the existing multiplicities, but instead produce a file that lists them.
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress FLAG             If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_edit_split

### Tool Description
Split the queries in jplace files into multiple files, for example, according to an OTU table.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Split the queries in jplace files into multiple files, for example, according to an OTU table.
Usage: gappa edit split [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.
  --split-file TEXT:FILE Excludes: --otu-table-file
                              File containing a comma-separated mapping of query names to sample names.
  --otu-table-file TEXT:FILE Excludes: --split-file
                              File containing a tab-separated OTU table.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress FLAG             If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_examine_assign

### Tool Description
Taxonomically assign placed query sequences and output tabulated summarization.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Taxonomically assign placed query sequences and output tabulated summarization.
Usage: gappa examine assign [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.
  --taxon-file TEXT:FILE REQUIRED
                              File containing a tab-separated list of reference taxon to taxonomic string assignments.
  --root-outgroup TEXT:FILE   Root the tree by the outgroup taxa defined in the specified file.
  --taxonomy TEXT:FILE        EXPERIMENTAL: File containing a tab-separated list defining the taxonomy. If mapping is incomplete (for example if the output taxonomy shall be NCBI, but SILVA was used as the basis in the --taxon-file) a best-effort mapping is attempted.
  --ranks-string TEXT=superkingdom|phylum|class|order|family|genus|species
                              String specifying the rank names, in order, to which the taxonomy adheres. Required when using the CAMI output format. Assignments not adhereing to this constrained will be collapsed to the last valid mapping
                              EXAMPLE: superkingdom|phylum|class|order|family|genus|species


Settings:
  --sub-taxopath TEXT         Taxopath (example: Eukaryota;Animalia;Chordata) by which the high level summary should be filtered. Doesn't affect intermediate results, and an unfiltered verison will be printed as well.
  --max-level UINT=0          Maximal level of the taxonomy to be printed. Default is 0, that is, the whole taxonomy is printed. If set to a value about 0, only this many levels are printed. That is, taxonomic levels below the specified one are omitted.
  --distribution-ratio FLOAT:FLOAT in [0 - 1]=-1
                              Ratio by which LWR is split between annotations if an edge has two possible annotations. Specifies the amount going to the proximal annotation. If not set program will determine the ratio automatically from the 'distal length' specified per placement.
  --consensus-thresh FLOAT:FLOAT in [0 - 1]=1
                              For assignment of taxonomic labels to the reference tree, require this consensus threshold. Example: if set to 0.6, and 60% of an inner node's descendants share a taxonomic path, set that path at the inner node.
  --resolve-missing-paths FLAG 
                              Should the taxon file be incomplete and leave some taxa without taxopaths, fill in the missing node labels using the closest (in the tree) label.
                              If not specified, those parts of the tree remain unlabelled, and their placements unassigned.
  --distant-label FLAG        Take into account the pendant length of the placements, assigning the LWR to a new label called 'DISTANT' in proportion to the pendant length. Assigns no LWR to 'DISTANT' if the pednant length is below the insertion branch length, and assigns all LWR to 'DISTANT' is the pendant length exceeds the radius of the reference tree.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --cami FLAG  Needs: --taxonomy
                              EXPERIMENTAL: Print result in the CAMI Taxonomic Profiling Output Format.
  --sample-id TEXT Needs: --cami
                              Sample-ID string to be used in the CAMI output file
  --krona FLAG                Print result in the Krona text format.
  --sativa FLAG               Print result as SATIVA would.
  --per-query-results FLAG    Print intermediate / per-query results (per_query.tsv).
  --best-hit FLAG             In the per-query results, only print the taxonomic path with the highest LWR.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_examine_edpl

### Tool Description
Calcualte the Expected Distance between Placement Locations (EDPL) for all pqueries.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Calcualte the Expected Distance between Placement Locations (EDPL) for all pqueries.
Usage: gappa examine edpl [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --histogram-bins UINT=25    Number of histogram bins for binning the EDPL values.
  --histogram-max FLOAT=-1    Maximum value to use in the histogram for binning the EDPL values. To use the maximal EDPL found in the samples, use a negative value (default).
  --no-list-file FLAG         If set, do not write out the EDPL per pquery, but just the histogram file. As the list needs to keep all pquery names in memory (to get the correct order), the memory requirements might be too large. In that case, this option can help.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_examine_graft

### Tool Description
Make a tree with each of the query sequences represented as a pendant edge.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Make a tree with each of the query sequences represented as a pendant edge.
Usage: gappa examine graft [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --fully-resolve FLAG        If set, branches that contain multiple pqueries are resolved by creating a new branch for each of the pqueries individually, placed according to their distal/proximal lengths. If not set (default), all pqueries at one branch are collected in a subtree that branches off from the branch.
  --name-prefix TEXT          Specify a prefix to be added to all new leaf nodes, i.e., to the query sequence names.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Newick Tree Output:
  --newick-tree-quote-invalid-chars FLAG 
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_examine_heat-tree

### Tool Description
Make a tree with edges colored according to the placement mass of the samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Make a tree with edges colored according to the placement mass of the samples.
Usage: gappa examine heat-tree [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --mass-norm TEXT:{absolute,relative}=absolute
                              Set the per-sample normalization method. With `absolute`, the total mass is not changed, so that input jplace samples with more pqueries (more placed sequences) have a higher influence on the result. With `relative`, the total mass of each sample is normalized to 1.0, so that each sample has the same influence on the result, independent of its number of sequences and their abundances.
  --point-mass FLAG           Treat every pquery as a point mass concentrated on the highest-weight placement. In other words, ignore all but the most likely placement location (the one with the highest LWR), and set its LWR to 1.0.
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.


Color:
  --color-list TEXT=BuPuBk    List of colors to use for the palette. Can either be the name of a color list, a file containing one color per line, or an actual comma-separated list of colors. Colors can be specified in the format `#rrggbb` using hex values, or by web color names.
  --reverse-color-list FLAG   If set, the order of colors of the `--color-list` is reversed.
  --under-color TEXT=#ff00ff  Color used to indicate values below the min value. Color can be specified in the format `#rrggbb` using hex values, or by web color names.
  --clip-under FLAG           Clip (i.e., clamp) values less than min to be inside `[ min, max ]`, by setting values that are too low to the specified min value. If set, `--under-color` is not used to indicate values out of range.
  --over-color TEXT=#00ffff   Color used to indicate values above the max value. Color can be specified in the format `#rrggbb` using hex values, or by web color names.
  --clip-over FLAG            Clip (i.e., clamp) values greater than max to be inside `[ min, max ]`, by setting values that are too high to the specified max value. If set, `--over-color` is not used to indicate values out of range.
  --clip FLAG                 Clip (i.e., clamp) values to be inside `[ min, max ]`, by setting values outside of that interval to the nearest boundary of it. This option is a shortcut to set `--clip-under` and `--clip-over` at once.
  --mask-color TEXT=#ffff00   Color used to indicate masked or invalid values, such as infinities or NaNs. Color can be specified in the format `#rrggbb` using hex values, or by web color names.
  --log-scaling FLAG          If set, the sequential color list is logarithmically scaled instead of linearily.
  --min-value FLOAT=0         Minimum value that is represented by the color scale. If not set, the minimum value of the data is used.
  --max-value FLOAT=1         Maximum value that is represented by the color scale. If not set, the maximum value of the data is used.
  --mask-value FLOAT=nan      Mask value that identifies invalid values (in addition to infinities and NaN values, which are always considered invalid, and hence always masked). Value of the data that compare equal to the mask value are colored using --mask-color. This is meant as a simple means of filtering and visualizing invalid values. If not set, no masking value is applied.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Tree Output:
  --write-newick-tree FLAG    If set, the tree is written to a Newick file. This format cannot store color information.
  --write-nexus-tree FLAG     If set, the tree is written to a Nexus file. This can for example be opened in FigTree.
  --write-phyloxml-tree FLAG  If set, the tree is written to a Phyloxml file. This can for example be used in Archaeopteryx.
  --write-svg-tree FLAG       If set, the tree is written to a SVG file. This gives a file for vector graphics editors.


Newick Tree Output:
  --newick-tree-branch-length-precision INT=6 Needs: --write-newick-tree
                              Number of digits to print for branch lengths in Newick format.
  --newick-tree-quote-invalid-chars FLAG  Needs: --write-newick-tree
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Svg Tree Output:
  --svg-tree-shape TEXT:{circular,rectangular}=circular Needs: --write-svg-tree
                              Shape of the tree.
  --svg-tree-type TEXT:{cladogram,phylogram}=cladogram Needs: --write-svg-tree
                              Type of the tree, either using branch lengths (`phylogram`), or not (`cladogram`).
  --svg-tree-stroke-width FLOAT=5 Needs: --write-svg-tree
                              Svg stroke width for the branches of the tree.
  --svg-tree-ladderize FLAG  Needs: --write-svg-tree
                              If set, the tree is ladderized.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_examine_info

### Tool Description
Print basic information about placement files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Print basic information about placement files.
Usage: gappa examine info [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_examine_lwr-distribution

### Tool Description
Print a summary table that represents the distribution of the likelihood weight ratios (LWRs) of all pqueries.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Print a summary table that represents the distribution of the likelihood weight ratios (LWRs) of all pqueries.
Usage: gappa examine lwr-distribution [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --num-entries UINT=100      Number of entries representing the pqueries. This is the length of the output table, representing the pquery LWR distribution. If set to 0, or if the input has fewer pqueries that the given number, the output table will contain all pqueries.
  --num-lwrs UINT=5           Number of LWRs per pquery to output (the most likely, second most likely, etc); all remaining LWRs are accumulated into the Remainder column. This is the number of LWR columns of the output table.
  --numerical-sort FLAG       By default, we sort the entries in the output table using a weighted sum of the LWRs of each pquery, with weight 1 for the most likely LWR, weight 1/2 for the second most likely LWR, weight 1/3 for the third most likely, etc. If this option is set however, the entries in the output table are sorted by the most likely LWR first, then sorting identical entries by the second most likely LWR, and so forth.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_examine_lwr-histogram

### Tool Description
Print a table with histograms of the likelihood weight ratios (LWRs) of all pqueries.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Print a table with histograms of the likelihood weight ratios (LWRs) of all pqueries.
Usage: gappa examine lwr-histogram [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --ignore-multiplicities FLAG 
                              Set the multiplicity of each pquery to 1.0. The multiplicity is the equvalent of abundances for placements, and hence ignored with this flag.
  --histogram-bins UINT=20    Number of histogram bins for binning the LWR values. This is the number of rows of the output table.
  --num-lwrs UINT=5           Number of histograms to print. That is, how many of the LWRs per pquery to output (most likely, second most likely, etc), or in other words, how many LWR columns the output table should have.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_examine_lwr-list

### Tool Description
Print a list of all pqueries with their likelihood weight ratios (LWRs).

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Print a list of all pqueries with their likelihood weight ratios (LWRs).
Usage: gappa examine lwr-list [OPTIONS]

Input:
  --jplace-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.


Settings:
  --num-lwrs UINT=5           Number of LWR columns to print. That is, how many of the LWRs per pquery to output (most likely, second most likely, etc). If set to 0, all LWRs of each pquery are printed; as that can differ between pqueries though, the output won't be a proper table any more.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_prepare_chunkify

### Tool Description
Chunkify a set of fasta files and create abundance maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Chunkify a set of fasta files and create abundance maps.
Usage: gappa prepare chunkify [OPTIONS]

Input:
  --fasta-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of fasta files or directories to process. For directories, only files with the extension `.(fasta|fas|fsa|fna|ffn|faa|frn)[.gz]` are processed.


Settings:
  --chunk-size UINT=50000     Number of sequences per chunk file.
  --min-abundance UINT=1      Minimum abundance of a single sequence. Sequences below are filtered out.
  --hash-function TEXT:{SHA1,SHA256,MD5}=SHA1
                              Hash function for re-naming and identifying sequences.


Output:
  --chunks-out-dir TEXT=.     Directory to write output chunks files to.
  --chunks-file-prefix TEXT   File prefix for chunks files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --chunks-file-suffix TEXT   File suffix for chunks files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --abundances-out-dir TEXT=. Directory to write output abundances files to.
  --abundances-file-prefix TEXT
                              File prefix for abundances files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --abundances-file-suffix TEXT
                              File suffix for abundances files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_prepare_clean-tree

### Tool Description
Clean a tree in Newick format by removing parts that other parsers have difficulties with.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Clean a tree in Newick format by removing parts that other parsers have difficulties with.
Usage: gappa prepare clean-tree [OPTIONS]

Input:
  --tree-file TEXT:FILE REQUIRED
                              Tree file in Newick format.


Settings:
  --remove-inner-labels FLAG  Some Newick trees contain inner node labels, which can confuse some parsers. This option removes them.
  --replace-invalid-chars FLAG 
                              Replace invalid characters in node labels (` ,:;"()[]`) by underscores. The Newick format requires node labels to be wrapped in double quotation marks if they contain these characters, but many parsers cannot handle this. For such cases, replacing the characters can help.
  --remove-comments-and-nhx FLAG 
                              The Newick format allows for comments in square brackets `[]`, which are also often (mis-)used for ad-hoc and more established extensions such as the New Hampshire eXtended (NHX) format `[&&NHX:key=value:...]`. Many parsers cannot handle this; this option removes such annotations.
  --remove-extra-numbers FLAG 
                              The Rich/Rice Newick format extension allows to annotate bootstrap values and probabilities per branch, by adding additional `:[bootstrap]:[prob]` fields after the branch length. Many parsers cannot handle this; this option removes such annotations.
  --remove-jplace-tags FLAG   The Jplace file format for phylogenetic placements also uses a custom Newick extension, by introducing curly brackets to annotate edge numbers in the tree `{1}`. We are not aware of any other Newick extension that uses this style, but still, with this option, all annotations in curly brackets is removed.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_prepare_phat

### Tool Description
Generate consensus sequences from a sequence database according to the PhAT method.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Generate consensus sequences from a sequence database according to the PhAT method.
Usage: gappa prepare phat [OPTIONS]

Input:
  --taxonomy-file TEXT:FILE REQUIRED
                              File that lists the taxa of the database.
  --sequence-file TEXT:FILE REQUIRED
                              Fasta file containing the sequences of the database.


Taxonomy Expansion:
  --target-size UINT=0 REQUIRED
                              Target size of how many taxa to select for building consensus sequences.
  --sub-taxonomy TEXT         If a taxopath from the taxonomy is provided, only the respective sub-taxonomy is used.
  --min-subclade-size UINT=0  Minimal size of sub-clades. Everything below is expanded.
  --max-subclade-size UINT=0  Maximal size of a non-expanded sub-clades. Everything bigger is first expanded.
  --min-tax-level UINT=0      Minimal taxonomic level. Taxa below this level are always expanded.
  --allow-approximation FLAG  Allow to expand taxa that help getting closer to the --target-size, even if they are not the ones with the highest entropy.
  --no-taxa-selection FLAG    If set, no taxa selection using entropy is performed. Instead, all taxa on all levels/ranks are used and consensus sequences for all of them are calculated. This is useful for testing and to try out new ideas.


Consensus Method:
  --consensus-method TEXT:{majorities,cavener,threshold}=majorities
                              Consensus method to use for combining sequences.
  --consensus-threshold FLOAT:FLOAT in [0 - 1]=0.5 Needs: --consensus-method
                              Threshold value to use with --consensus-method threshold. Has to be in [ 0.0, 1.0 ].


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --write-info-files FLAG     If set, two additional info files are written, containing the new pruned taxonomy, as well as the entropy of all clades of the original taxonomy.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_prepare_taxonomy-tree

### Tool Description
Turn a taxonomy into a tree that can be used as a constraint for tree inference.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Turn a taxonomy into a tree that can be used as a constraint for tree inference.
Usage: gappa prepare taxonomy-tree [OPTIONS]

Input:
  --taxon-list-file TEXT:FILE File that maps taxon names to taxonomic paths.
  --taxonomy-file TEXT:FILE   File that lists the taxa of the taxonomy as taxonomic paths.


Settings:
  --keep-singleton-inner-nodes FLAG 
                              Taxonomic paths can go down several levels without any furcation. Use this option to keep such paths, instead of collapsing them into a single level.
  --keep-inner-node-names FLAG 
                              Taxonomies contain names at every level, while trees usually do not. Use this option to also set taxonomic names for the inner nodes of the tree.
  --max-level INT=-1          Maximum taxonomic level to process (0-based). Taxa below this level are not added to the tree.
  --replace-invalid-chars FLAG 
                              Replace invalid characters in node labels (` ,:;"()[]`) by underscores, which can occur if the input taxonomic paths contain such characters. The Newick format requires node labels to be wrapped in double quotation marks if they contain these characters, but many parsers cannot handle this. For such cases, replacing the characters can help.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Newick Tree Output:
  --newick-tree-quote-invalid-chars FLAG 
                              If set, node labels that contain characters that are invalid in the Newick format (i.e., spaces and `:;()[],{}`) are put into quotation marks. If not set (default), these characters are instead replaced by underscores, which changes the names, but works better with most downstream tools.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_prepare_unchunkify

### Tool Description
Unchunkify a set of jplace files using abundance map files and create per-sample jplace files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Unchunkify a set of jplace files using abundance map files and create per-sample jplace files.
Usage: gappa prepare unchunkify [OPTIONS]

Input:
  --abundances-path TEXT:PATH(existing)=[] ... REQUIRED
                              List of abundances files or directories to process. For directories, only files with the extension `.json[.gz]` are processed.
  --jplace-path TEXT:PATH(existing)=[] ... Excludes: --chunk-list-file --chunk-file-expression
                              List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed.
  --sequence-path TEXT:PATH(existing)=[] ...
                              List of sequence files or directories to process. For directories, only files with the extension `.(fasta|fas|fsa|fna|ffn|faa|frn|phylip|phy)[.gz]` are processed.
  --chunk-list-file TEXT Excludes: --jplace-path --chunk-file-expression
                              If provided, needs to contain a list of chunk file paths in the numerical order that was produced by the chunkify command.
  --chunk-file-expression TEXT Excludes: --jplace-path --chunk-list-file
                              If provided, the expression is used to load jplace files by replacing any '@' character with the chunk number.


Settings:
  --jplace-cache-size UINT=0  Cache size to determine how many jplace files are kept in memory. Default (0) means all. Use this if the command runs out of memory. It however comes at the cost of longer runtime.
  --hash-function TEXT:{SHA1,SHA256,MD5}=SHA1
                              Hash function that was used for re-naming and identifying sequences in the chunkify command.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_simulate_random-alignment

### Tool Description
Create a random alignment with a given numer of sequences of a given length.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Create a random alignment with a given numer of sequences of a given length.
Usage: gappa simulate random-alignment [OPTIONS]

Input:
  --sequence-count UINT=0 REQUIRED
                              Number of sequences to create.
  --sequence-length UINT=0 REQUIRED
                              Length of the sequences to create.
  --characters TEXT=-ACGT     Set of characters to use for the sequences.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress FLAG             If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.
  --write-fasta FLAG          Write sequences to a fasta file.
  --write-strict-phylip FLAG  Excludes: --write-relaxed-phylip
                              Write sequences to a strict phylip file.
  --write-relaxed-phylip FLAG  Excludes: --write-strict-phylip
                              Write sequences to a relaxed phylip file.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_simulate_random-placements

### Tool Description
Create a set of random phylogenetic placements on a given reference tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Create a set of random phylogenetic placements on a given reference tree.
Usage: gappa simulate random-placements [OPTIONS]

Input:
  --reference-tree TEXT REQUIRED
                              File containing a reference tree in newick format.
  --pquery-count UINT=0 REQUIRED
                              Number of pqueries to create.
  --subtree INT=-1            If given, only generate random placements in one of the subtrees of the root node. For example, if the root is a trifurcation, values 0-2 are allowed.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress FLAG             If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## gappa_simulate_random-tree

### Tool Description
Create a random tree with a given numer of leaf nodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
- **Homepage**: https://github.com/lczech/gappa
- **Package**: https://anaconda.org/channels/bioconda/packages/gappa/overview
- **Validation**: PASS

### Original Help Text
```text
Create a random tree with a given numer of leaf nodes.
Usage: gappa simulate random-tree [OPTIONS]

Input:
  --leaf-count UINT=0 REQUIRED
                              Number of leaf nodes (taxa) to create.


Output:
  --out-dir TEXT=.            Directory to write output files to.
  --file-prefix TEXT          File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --file-suffix TEXT          File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data.
  --compress FLAG             If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`.


Global Options:
  --allow-file-overwriting FLAG 
                              Allow to overwrite existing output files instead of aborting the command.
  --verbose FLAG              Produce more verbose output.
  --threads UINT=10           Number of threads to use for calculations.
  --log-file TEXT             Write all output to a log file, in addition to standard output to the terminal.
  --help FLAG                 Print this help message and exit.

gappa - a toolkit for analyzing and visualizing phylogenetic (placement) data
```

## Metadata
- **Skill**: generated
