# physlr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| physlr_annotate-graph | PASS |  |
| physlr_annotate-graph-bxtochr | Failed | tool bug: node hue is the index of the last barcode of each chromosome (for example 49.0 or 24.5), not a value between 0 and 1 |
| physlr_backbone | PASS |  |
| physlr_backbone-graph | PASS |  |
| physlr_bed-to-path | PASS |  |
| physlr_best-edges | PASS |  |
| physlr_biconnected-components | PASS |  |
| physlr_common-neighbours | PASS |  |
| physlr_count-minimizers | PASS |  |
| physlr_count-molecules | PASS |  |
| physlr_degree | PASS |  |
| physlr_fasta-gaps | PASS |  |
| physlr_filter | PASS |  |
| physlr_filter-barcodes | PASS |  |
| physlr_filter-bed | PASS |  |
| physlr_filter-bxmx | PASS |  |
| physlr_filter-overlap | PASS |  |
| physlr_find-ntcard-mode | PASS |  |
| physlr_flesh-backbone | PASS |  |
| physlr_indexlr | PASS |  |
| physlr_intersect | PASS | all-pairs mode checked against Python; the -v option crashes in the tool (itertools.combinations called without a size) |
| physlr_liftover-paf | PASS |  |
| physlr_makebf | PASS |  |
| physlr_map | PASS |  |
| physlr_map-mkt | PASS |  |
| physlr_map-paf | PASS |  |
| physlr_molecules | PASS |  |
| physlr_mst | PASS |  |
| physlr_mst-troubleshoot | Failed | tool bug: always crashes with KeyError, the code loops over dict items as if they were edge pairs |
| physlr_overlap | PASS |  |
| physlr_paf-metrics | PASS |  |
| physlr_path-metrics | PASS |  |
| physlr_path-to-fasta | PASS |  |
| physlr_remove-bridges-graph | PASS |  |
| physlr_report-junctions-graph | PASS |  |
| physlr_split-minimizers | Failed | tool bug: it needs vertex names barcode_N_M, so the graph written by physlr molecules (barcode_N) gives empty output; correct only on a graph renamed by hand |
| physlr_split-minimizers-cpp | PASS |  |
| physlr_split-reads-molecules | PASS | synthetic data: molecule table built from the real read minimizers with one molecule per barcode |
| physlr_subgraph | PASS | vertex list (-d 0) works; -d 1 or more crashes in the tool with a set-changed-during-iteration error |
| physlr_subgraphs | Failed | tool bug: -d 1 writes only the source vertex and --exclude-source 1 is ignored, so documented options give wrong output |
| physlr_subgraphs-stats | Failed | tool bug: the vertices list file is ignored when threads is 1 (all barcodes are reported); the default thread count and the all-barcodes mode work |
| physlr_tiling-graph | PASS |  |

## physlr_filter

### Tool Description
Filter a graph: remove edges with few shared minimizers, barcodes with many molecules, and small components.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_best-edges

### Tool Description
Keep the best edges of each vertex of a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_flesh-backbone

### Tool Description
Flesh out the barcodes in the backbone paths: add each neighbour of a backbone barcode to the path next to its best-supported backbone barcode.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_subgraph

### Tool Description
Extract a vertex-induced subgraph.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_subgraphs

### Tool Description
Extract multiple vertex-induced subgraphs, one file per listed barcode, into an output directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_count-minimizers

### Tool Description
Count the frequency of each minimizer (the number of barcodes it occurs in) and print the depths.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_intersect

### Tool Description
Print the minimizers in the intersection of each pair of barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_filter-overlap

### Tool Description
Read a Physlr overlap graph and filter out the lowest-weight edges by a percentile.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_degree

### Tool Description
Print the degree of each vertex.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_common-neighbours

### Tool Description
Count the number of common neighbours for each edge and write the graph with these counts as edge weights.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_mst

### Tool Description
Determine the maximum spanning tree of the graph, pruned for small branches.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_mst-troubleshoot

### Tool Description
Determine the pruned maximum spanning tree and write it with the length of the shorter branch of each edge as edge weight.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_report-junctions-graph

### Tool Description
Report junctions in the maximum spanning tree of the graph and print a list of junction barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_remove-bridges-graph

### Tool Description
Iteratively remove bridges from the graph (bridges are found in its maximum spanning tree) and write the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_backbone

### Tool Description
Determine the backbone paths of the graph and print one path per line.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_backbone-graph

### Tool Description
Determine the backbone-induced subgraph: remove poorly supported (chimeric) barcodes iteratively and write the subgraph of the backbone paths.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_biconnected-components

### Tool Description
Separate a graph into its biconnected components by removing its cut vertices.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_tiling-graph

### Tool Description
Determine the minimum-tiling-path-induced subgraph.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_count-molecules

### Tool Description
Estimate the number of molecules per barcode (counts the biconnected components of at least 4 vertices in the neighbourhood subgraph of each barcode).

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_molecules

### Tool Description
Separate barcodes into molecules: partition the neighbourhood of each barcode and write a graph whose vertices are molecules (barcode_N).

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_split-minimizers

### Tool Description
Given the molecule overlap graph, split the minimizers of each barcode into molecules. The vertices of the graph must be named barcode_N_M (for example barcode_0_0); a graph with barcode_N names gives an empty result.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_split-reads-molecules

### Tool Description
Given the molecule to minimizers table and the reads, partition the reads into molecules by adding the molecule number to the BX tag.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_subgraphs-stats

### Tool Description
Report the number of vertices, edges and the density of the neighbourhood subgraph of each barcode (or of the barcodes listed in a second file; this list is used only when more than one thread is used).

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_map-mkt

### Tool Description
Map sequences to a physical map, orienting each hit with the Mann-Kendall trend test, and write the hits as BED.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_map

### Tool Description
Map sequences to a physical map and write the hits as BED (target index, start, end, query name, score, orientation).

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_map-paf

### Tool Description
Map sequences to a physical map and write the hits in PAF format (minimizer coordinates).

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_liftover-paf

### Tool Description
Lift over the query coordinates of a PAF file from minimizer index to nucleotide position.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_annotate-graph-bxtochr

### Tool Description
Annotate a graph with a file of barcode to chromosome mappings and write it in GraphViz format.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_annotate-graph

### Tool Description
Annotate a graph with a BED or PAF file of mappings and write it in GraphViz format.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_bed-to-path

### Tool Description
Convert BED mappings to scaffold paths: queries are ordered and oriented on the physical map.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_path-to-fasta

### Tool Description
Produce scaffold sequences in FASTA format from paths, joining oriented contigs with gaps of N.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_filter-bed

### Tool Description
Select records of a BED file in the order given by a path file; a line of NA separates the paths.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_path-metrics

### Tool Description
Report assembly metrics (Max, NG25, NG50, NG75, Min, number of paths and nodes) of path files.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_paf-metrics

### Tool Description
Report assembly metrics (Max, NG25, NG50, NG75, Min, Count, Sum) of PAF files, using the query interval lengths.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_fasta-gaps

### Tool Description
Print the coordinates in BED format of the gaps (runs of N) in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_find-ntcard-mode

### Tool Description
Find the first mode after the minimum in an ntCard k-mer histogram (written by ntcard -o) and print it.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: physlr [-h] [-t THREADS] [-k K] [-w W] [--separation-strategy STRATEGY]
              [--separation-skip-small SKIP_SMALL] [--coef COEF] [-c C] [-C C]
              [-g G] [-M M] [-n N] [-m M] [--bestm BESTM]
              [--min-length MIN_LENGTH]
              [--min-component-size MIN_COMPONENT_SIZE]
              [--min-path-size MIN_PATH_SIZE] [--molecule-bed MOLECULE_BED]
              [--molecules-bx-only MOLECULES_BX_ONLY] [-v V]
              [--exclude-vertices EXCLUDE_VERTICES]
              [--exclude-source EXCLUDE_SOURCE] [-d D] [--distance-max D_MAX]
              [-o OUTPUT] [-O GRAPH_FORMAT] [-p P] [-s S]
              [--mkt-median-threshold MKT_MEDIAN_THRESHOLD] [-V VERBOSE]
              [--version] [--prune-branches PRUNE_BRANCHES]
              [--prune-bridges PRUNE_BRIDGES]
              [--prune-junctions PRUNE_JUNCTIONS]
              [--junction-depth JUNCTION_DEPTH] [--gap-size GAP_SIZE]
              [--cost COST] [--sqcost SQCOST]
              [--minimizer-overlap MINIMIZER_OVERLAP] [--arcs-pair ARCS_PAIR]
              [--dist-est DIST_EST] [--dist-type {min,avg,max}]
              [--mx-type {unsplit,split}] [--map-pos MAP_POS]
              command FILES [FILES ...]

positional arguments:
  command               A command
  FILES                 FASTA/FASTQ, TSV, or GraphViz format

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        number of threads [16 or number of CPU]
  -k K, --k K           size of a k-mer (bp)
  -w W, --window W      number of k-mers in a window of size k + w - 1 bp
  --separation-strategy STRATEGY
                        strategy for barcode to molecule separation [bc+k3].
                        Use a combination of bc, k3, k3bin, cos, sqcos,
                        sqcosbin, louvain, and distributed concatenated via
                        plus sign (example:bc+k3+bc)
  --separation-skip-small SKIP_SMALL
                        Skip splitting the barcode if neighborhood subgraph is
                        smaller than this [0]
  --coef COEF           ignore minimizers that occur in Q3+c*(Q3-Q1) or more
                        barcodes [0]
  -c C, --min-count C   ignore minimizers that occur in less than c barcodes
                        [2]
  -C C, --max-count C   ignore minimizers that occur in C or more barcodes
                        [None]
  -g G, --expected-molecules G
                        the expected number of molecules in the assembly, for
                        computing NGxx [None]
  -M M, --max-molecules M
                        remove barcodes with M or more molecules [None]
  -n N                  remove mappings with score less than n [0]
  -m M, --min-m M       remove edges with fewer than n shared minimizers [0]
  --bestm BESTM         Keep the best m edges of each vertex [None]
  --min-length MIN_LENGTH
                        remove sequences with length less than N bp [0]
  --min-component-size MIN_COMPONENT_SIZE
                        remove components with fewer than N vertices [0]
  --min-path-size MIN_PATH_SIZE
                        skip paths with fewer than N barcodes [200]
  --molecule-bed MOLECULE_BED
                        Retain molecule splits in filtered BED (0 or 1) [0]
  --molecules-bx-only MOLECULES_BX_ONLY
                        Only print reads with barcodes that have been split to
                        molecules (0 or 1) [1]
  -v V, --vertices V    list of vertices [None]
  --exclude-vertices EXCLUDE_VERTICES
                        list of vertices to exclude [None]
  --exclude-source EXCLUDE_SOURCE
                        exclude the barcode itself from the subgraph (0 or 1)
                        [1]
  -d D, --distance D    include vertices within d edges away [0]
  --distance-max D_MAX  maximum acceptable value for -d (--distance) argument
                        to avoid slow runs [20]
  -o OUTPUT, --output OUTPUT
                        the output file or directory
  -O GRAPH_FORMAT, --output-format GRAPH_FORMAT
                        the output graph file format [tsv]
  -p P, --min_p_val P   Minimum significance threshold (FPR) for Mann-Kendall
                        Test
  -s S, --support S     Minimum number of barcodes required to support a
                        position
  --mkt-median-threshold MKT_MEDIAN_THRESHOLD
                        Max number of backbones before using only medians in
                        Mann-Kendall Test
  -V VERBOSE, --verbose VERBOSE
                        the level of verbosity: 0:silent, 1:periodic,
                        2:progress, 3:verbose [2]
  --version             show program's version number and exit
  --prune-branches PRUNE_BRANCHES
                        size of the branches to be pruned [10]. set to 0 to
                        skip prunning.
  --prune-bridges PRUNE_BRIDGES
                        size of the bridges to be pruned [0]. set to 0 to skip
                        bridge prunning.
  --prune-junctions PRUNE_JUNCTIONS
                        split a backbone path when the alternative branch is
                        longer thanprune-junctions [0]. set to 0 to skip.
  --junction-depth JUNCTION_DEPTH
                        depth for expanding the junctions by collecting all
                        neighbors of this depth [0].
  --gap-size GAP_SIZE   gap size used in scaffolding [100].
  --cost COST           threshold for `cos` molecule separation [0.5].
  --sqcost SQCOST       threshold for `sqcos` molecule separation [0.75].
  --minimizer-overlap MINIMIZER_OVERLAP
                        Percent of edges to remove [0].
  --arcs-pair ARCS_PAIR
                        ARCS scaffold pairing file.
  --dist-est DIST_EST   ARCS scaffold pairing distance estimation file.
  --dist-type {min,avg,max}
                        ARCS scaffold pairing distance type.Accepted values
                        are: min, avg, or max [avg].
  --mx-type {unsplit,split}
                        Type of minimizers used to map sequence to backbone
                        graph.Accepted values are: unsplit or split [unsplit].
  --map-pos MAP_POS     Number of positions to use during the orientation
                        process [1].
```

## physlr_indexlr

### Tool Description
Index linked reads (or sequences) with minimizers: write one line per read with its barcode (BX tag, or NA) and its minimizer hashes.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  physlr-indexlr  -k K -w W [-r repeat_bf_path] [-s solid_bf_path] [-v] [-o FILE] FILE...

  -k K        use K as k-mer size
  -w W        use W as sliding-window size
  -r repeat_bf_path  use a Bloom filter to filter out repetitive minimizers
  -s solid_bf_path  use a Bloom filter to only select solid minimizers
  --pos       include minimizer positions in the output
  --strand    include minimizer strand in the output
  -v          enable verbose output
  -o FILE     write output to FILE, default is stdout
  -t N        use N number of threads (default 1, max 5)
  --help      display this help and exit
  FILE        space separated list of FASTQ files
```

## physlr_makebf

### Tool Description
Make a Bloom filter of repetitive k-mers from ntHits output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  physlr-makebf  -k K [-v] [-o FILE] FILE...

  -k K       use K as k-mer size
  -b B       Bloom filter size in Bytes
  -v         enable verbose output
  -o FILE    write Bloom filter to FILE [required]
  -t N       use N number of threads [1]
  --help     display this help and exit
  FILE       space separated list of ntHits tsv output files
```

## physlr_filter-barcodes

### Tool Description
Filter barcodes by the number of minimizers they have: keep barcodes with between n and N minimizers.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  physlr-filterbarcodes  -n n -N N [-s] [-o file] file...

  -s         silent; disable verbose output
  -o file    write output to file, default is stdout
  -n         minimum number of minimizers per barcode
  -N         maximum number of minimizers per barcode
  --help     display this help and exit
  file       space separated list of FASTQ files
```

## physlr_filter-bxmx

### Tool Description
Filter barcodes by the number of minimizers, and minimizers by their multiplicity (number of barcodes they occur in).

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  physlr-filter-barcodes-minimizers  -n n -N N [-s] [-o file] file...

  -s         silent; disable verbose output
  -o file    write output to file, default is stdout
  -n         minimum number of minimizers per barcode
  -N         maximum number of minimizers per barcode
  -C         maximum minimizer multiplicity
  --help     display this help and exit
  file       space separated list of FASTQ files
```

## physlr_overlap

### Tool Description
Read a sketch of linked reads and find overlapping barcodes: write the graph of barcodes that share at least m minimizers.

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/bin/share/physlr-1.0.4-0/src/physlr-overlap: unrecognized option '--help'
Missing Input Files
Usage: physlr-overlap [OPTION]... [MINIMIZERS.tsv]
Read a sketch of linked reads and find overlapping barcodes.
  -m, --min-m=INT   Remove edges with fewer than m shared markers [10].
  -t, --threads     threads [1]
  -v, --version     Print version
Report bugs to <cjustin@bcgsc.ca>.
```

## physlr_split-minimizers-cpp

### Tool Description
Given the molecule overlap graph, split the minimizers of each barcode into molecules (compiled version of physlr split-minimizers; vertices are named barcode_N).

### Metadata
- **Docker Image**: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
- **Homepage**: https://github.com/BirolLab/physlr
- **Package**: https://anaconda.org/channels/bioconda/packages/physlr/overview
- **Validation**: PASS

### Original Help Text
```text
physlr-split-minimizers (physlr) pre-autotools
Written by Johnathan Wong.

Copyright 2020 Canada's Michael Smith Genome Science Centre
```
