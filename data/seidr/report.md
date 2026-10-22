# seidr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seidr_adjacency | PASS |  |
| seidr_aggregate | PASS |  |
| seidr_anoverence | Not completed | no real experiment metadata: with planted all-NA metadata the tool writes only nan, and the docs say it is not recommended |
| seidr_backbone | PASS |  |
| seidr_cluster-enrichment | PASS |  |
| seidr_compare | PASS |  |
| seidr_convert | PASS |  |
| seidr_correlation | PASS |  |
| seidr_el-ensemble | PASS |  |
| seidr_genie3 | PASS |  |
| seidr_graphstats | PASS |  |
| seidr_import | PASS |  |
| seidr_index | PASS |  |
| seidr_llr-ensemble | PASS |  |
| seidr_mi | PASS |  |
| seidr_narromi | PASS |  |
| seidr_neighbours | Failed | tool bug: with --genes the edges go to standard output and the --outfile file is left empty, so the documented output option is silently ignored; the default mode is correct. |
| seidr_pcor | PASS |  |
| seidr_plsnet | PASS |  |
| seidr_reheader | PASS |  |
| seidr_resolve | PASS |  |
| seidr_roc | PASS |  |
| seidr_sample | PASS |  |
| seidr_stats | PASS |  |
| seidr_svm-ensemble | PASS |  |
| seidr_threshold | PASS |  |
| seidr_tigress | PASS |  |
| seidr_tomsimilarity | PASS |  |
| seidr_view | PASS |  |

## seidr_import

### Tool Description
Convert various text based network representations to SeidrFiles

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bschiffthaler/seidr
- **Stars**: N/A
### Original Help Text
```text
Convert various text based network representations to SeidrFiles:

Required:
  -i [ --infile ] arg        Input file name ['-' for stdin]
  -F [ --format ] arg        The input file format [el, lm, m, ara]
  -g [ --genes ] arg         Gene file for input
  -o [ --outfile ] arg       Output file name
  -n [ --name ] arg          Import name (algorithm name)

Ranking Options:
  -A [ --absolute ]          Rank on absolute of scores
  -r [ --reverse ]           Rank scores in descending order (highest first)
  -z [ --drop-zero ]         Drop edges with a weight of zero from the network
  -u [ --undirected ]        Force all edges to be interpreted as undirected

OpenMP Options:
  -O [ --threads ] arg (=1)  Number of OpenMP threads for parallel sorting

Common Options:
  -f [ --force ]             Force overwrite output file if it exists
  -h [ --help ]              Show this help message
```


## seidr_aggregate

### Tool Description
Aggregate multiple SeidrFiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Aggregate multiple SeidrFiles.:

Required Options:
  --in-file arg                         Input files

Aggregate Options:
  -m [ --method ] arg (=irp)            Method to aggregate networks [top1, 
                                        top2, borda, irp]
  -k [ --keep ]                         Keep directionality information

OpenMP Options:
  -O [ --threads ] arg (=1)             Number of OpenMP threads for parallel 
                                        sorting

Common Options:
  -f [ --force ]                        Force overwrite output file if it 
                                        exists
  -h [ --help ]                         Show this help message
  -o [ --outfile ] arg (=aggregated.sf) Output file name
  -T [ --tempdir ] arg (=auto)          Directory to store temporary data
```


## seidr_backbone

### Tool Description
Determine noisy network backbone scores. Optionally filter on these scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Determine noisy network backbone scores. Optionally filter on these scores:

Required [can be positional]:
  --in-file arg                     Input SeidrFile

Backbone Options:
  -i [ --index ] arg (=last index)  Score index to use
  -F [ --filter ] arg (=no filter)  Subset network to edges with at least this 
                                    SD. 1.28, 1.64, and 2.32 correspond to 
                                    ~P0.1, 0.05 and 0.01.

Common Options:
  -f [ --force ]                    Force overwrite output file if it exists
  -h [ --help ]                     Show this help message
  -o [ --out-file ] arg (=auto)     Output file name ['-' for stdout]
  -T [ --tempdir ] arg (=auto)      Directory to store temporary data
```


## seidr_index

### Tool Description
Create index for SeidrFiles

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Create index for SeidrFiles:

Required [can be positional]:
  --in-file arg          Input SeidrFile

Common Options:
  -f [ --force ]         Force overwrite output file if it exists
  -h [ --help ]          Show this help message
```


## seidr_neighbours

### Tool Description
Get the top N first-degree neighbours for each node or a list of nodes

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Get the top N first-degree neighbours for each node or a list of nodes:

Required [can be positional]:
  --in-file arg                     Input SeidrFile

Neighbours Options:
  -i [ --index ] arg (=last score)
  -n [ --neighbours ] arg (=10)     Number of top first-degree neighbours to 
                                    return
  -g [ --genes ] arg                Gene names to search
  -r [ --rank ]                     Use rank instead of score
  -u [ --unique ]                   Print only unique edges

OpenMP Options:
  -O [ --threads ] arg (=1)         Number of OpenMP threads for parallel 
                                    sorting

Common Options:
  -f [ --force ]                    Force overwrite output file if it exists
  -s [ --strict ]                   Fail on all issues instead of warning
  -I [ --case-insensitive ]         Search case insensitive nodes
  -h [ --help ]                     Show this help message
  -o [ --outfile ] arg (=-)         Output file name ['-' for stdout]
```


## seidr_sample

### Tool Description
Sample edges from a SeidrFile

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Required:
  --in-file arg                Input SeidrFile

Sample options:
  -r [ --replacement ]         Sample with replacement
  -p [ --precision ] arg (=8)  Number of significant digits to report
  -n [ --nedges ] arg          Number of edges to sample
  -F [ --fraction ] arg        Fraction of edges to sample

Common Options:
  -f [ --force ]               Force overwrite output file if it exists
  -h [ --help ]                Show this help message
  -o [ --outfile ] arg (=-)    Output file name ['-' for stdout]
```


## seidr_threshold

### Tool Description
Pick hard network threshold according to topology

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Pick hard network threshold according to topology:

Required [can be positional]:
  --in-file arg                     Input SeidrFile

Threshold Options:
  -m [ --min ] arg (=0)             Lowest threshold value to check
  -M [ --max ] arg (=0)             Highest threshold value to check
  -i [ --index ] arg (=last score)  Score column to use as edge weights
  -n [ --nsteps ] arg (=100)        Number of breaks to create for testing

Formatting Options:
  -p [ --precision ] arg (=8)       Number of decimal points to print

OpenMP Options:
  -O [ --threads ] arg (=1)         Number of OpenMP threads for parallel 
                                    sorting

Common Options:
  -f [ --force ]                    Force overwrite output file if it exists
  -h [ --help ]                     Show this help message
  -o [ --outfile ] arg (=-)         Output file name ['-' for stdout]
```


## seidr_view

### Tool Description
View and filter contents of SeidrFiles

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
View and filter contents of SeidrFiles:

Required [can be positional]:
  --in-file arg                     Input SeidrFile

Filter Options:
  -t [ --threshold ] arg (=-inf)    Only print edges with a weight >= t
  -r [ --threshold-rank ]           Threshold edges with a rank of <= t instead
  -i [ --index ] arg (=last score)  Score column to use as edge weights
  -F [ --filter ] arg               Supply a filter function to select edges
  -n [ --nodelist ] arg             Include only these nodes
  -l [ --lines ] arg                View only first l results

Formatting Options:
  -N [ --no-names ]                 Print node index instead of name
  -c [ --column-headers ]           Print column headers
  -a [ --tags ]                     Print supplementary information tags
  -D [ --dense ]                    Print as much information as possible for 
                                    each edge
  -s [ --sc-delim ] arg (=;)        Delimiter for supplementary tags
  -d [ --delim ] arg (=;)           Delimiter for scores/ranks

View metadata:
  -H [ --header ]                   Print file header as text
  -C [ --centrality ]               Print node centrality scores if present

Output Options:
  -o [ --outfile ] arg (=-)         Output file name ['-' for stdout]
  -b [ --binary ]                   Output binary SeidrFile

Common Options:
  -f [ --force ]                    Force overwrite output file if it exists
  -h [ --help ]                     Show this help message
  -s [ --strict ]                   Fail on all issues instead of warning
  -I [ --case-insensitive ]         Search case insensitive nodes
  -T [ --tempdir ] arg (=auto)      Directory to store temporary data
```


## seidr_stats

### Tool Description
Calculate network centrality statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate network centrality statistics:

Required:
  --in-file arg                         Input SeidrFile [can be positional]

Stats Options:
  -i [ --index ] arg (=last score)      Index of score to use
  -n [ --nsamples ] arg (=0)            Use N samples for approximations
  -m [ --metrics ] arg (=PR,CLO,BTW,STR,EV,KTZ,LPC,SEC,EBC)
                                        String describing metrics to calculate
  -d [ --directed ]                     (Experimental) Use directionality 
                                        information.
  --eigenvector-tol arg (=1e-08)        Eigenvector centrality convergence 
                                        tolerance
  -e [ --exact ]                        Calculate exact stats.
  --weight-is-distance                  Edge weight represents a distance 
                                        (rather than similarity).
  --weight-rank                         Set weight value to rank rather than 
                                        score

Common Options:
  -h [ --help ]                         Show this help message
  -T [ --tempdir ] arg (=auto)          Directory to store temporary data
```


## seidr_graphstats

### Tool Description
Calculate graph level network statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate graph level network statistics:

Required Options [can be positional]:
  --in-file arg                     Input SeidrFile

Graphstat Options:
  -i [ --index ] arg (=last score)  Index of scores that should be used as 
                                    weights

Common Options:
  -f [ --force ]                    Force overwrite output file if it exists
  -h [ --help ]                     Show this help message
  -o [ --outfile ] arg (=-)         Output file name ['-' for stdout]
```


## seidr_adjacency

### Tool Description
Transform a SeidrFile into an adjacency matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Transform a SeidrFile into an adjacency matrix:

Required [can be positional]:
  --in-file arg                     Input SeidrFile

Adjacency Options:
  -i [ --index ] arg (=last index)  Score index to use

Formatting Options:
  -D [ --diagonal ]                 Print matrix diagonal for triangular output
                                    format
  -F [ --fmt ] arg (=m)             Output format ['m','lm']
  -m [ --missing ] arg (=0)         Fill character for missing edges
  -p [ --precision ] arg (=8)       Number of significant digits to report

Common Options:
  -f [ --force ]                    Force overwrite output file if it exists
  -h [ --help ]                     Show this help message
  -o [ --out-file ] arg (=-)        Output file name ['-' for stdout]
```


## seidr_convert

### Tool Description
Convert different text based formats

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Convert different text based formats:

Input Options:
  -i [ --infile ] arg (=-)          Input file name ['-' for stdin]
  -g [ --genes ] arg                Input gene file name
  -q [ --from ] arg                 Input file format [edge-list, sym-mat, 
                                    low-tri, up-tri, low-tri-diag, up-tri-diag,
                                    aracne]
  -s [ --in-separator ] arg (=\t)   Input separator

Output Options:
  -o [ --outfile ] arg (=-)         Output file name ['-' for stdout]
  -t [ --to ] arg                   Output file format [edge-list, sym-mat, 
                                    low-tri, up-tri, low-tri-diag, up-tri-diag,
                                    aracne]
  -S [ --out-separator ] arg (=\t)  Output separator

Format Options:
  -F [ --fill ] arg (=NaN)          Fill value for missing data (Number, NaN, 
                                    Inf, -Inf)
  -p [ --precision ] arg (=8)       Number of decimals to print

Common Options:
  -f [ --force ]                    Force overwrite output file if it exists
  -h [ --help ]                     Show this help message
```


## seidr_resolve

### Tool Description
Resolve node indices in text file to node names.

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Resolve node indices in text file to node names.:

Required [can be positional]:
  --in-file arg                   Input SeidrFile

Resolve Options:
  -s [ --seidr-file ] arg         Seidr file which should be used to resolve 
                                  input
  -F [ --format ] arg (=infomap)  File format to resolve

Common Options:
  -f [ --force ]                  Force overwrite output file if it exists
  -h [ --help ]                   Show this help message
  -o [ --outfile ] arg (=-)       Output file name ['-' for stdout]
```


## seidr_cluster-enrichment

### Tool Description
Test whether clusters of two networks show significant overlap or extract clusters

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Test wether clusters of two networks show significant overlap or extract clusters:

Required Options [can be positional]:
  -1 [ --first ] arg                    First cluster->gene mapping

Cluster-Compare Options:
  -2 [ --second ] arg                   Another cluster->gene mapping [can be 
                                        positional]
  -d [ --delim ] arg (=,)               Output delimiter
  -a [ --alpha ] arg (=SEIDR_COMPARE_CLUST_DEF_ALPHA)
                                        Adjusted p-value cutoff
  -m [ --min-members ] arg (=20)        Minimum members of a cluster
  -M [ --max-members ] arg (=200)       Maximum members of a cluster

Common Options:
  -f [ --force ]                        Force overwrite output file if it 
                                        exists
  -h [ --help ]                         Show this help message
  -o [ --outfile ] arg (=-)             Output file name ['-' for stdout]
```


## seidr_compare

### Tool Description
Compare edges or nodes in two networks.

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Compare edges or nodes in two networks.:

Required Options [can be positional]:
  --network-1 arg                     Input SeidrFile for network A
  --network-2 arg                     Input SeidrFile for network B

Compare Options:
  -i [ --index-a ] arg (=last score)  Merge scores on this index for network A
  -j [ --index-b ] arg (=last score)  Merge scores on this index for network B
  -t [ --translate ] arg              Translate node names in network A 
                                      according to this table
  -n [ --nodes ]                      Print overlap of nodes instead of edges

Common Options:
  -f [ --force ]                      Force overwrite output file if it exists
  -h [ --help ]                       Show this help message
  -o [ --outfile ] arg (=-)           Output file name ['-' for stdout]
  -T [ --tempdir ] arg (=auto)        Directory to store temporary data
```


## seidr_roc

### Tool Description
Calculate ROC curves of predictions in SeidrFiles given true edges

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate ROC curves of predictions in SeidrFiles given true edges:

Required:
  -g [ --gold ] arg                 Gold standard (true edges) input file
  -n [ --network ] arg              Input SeidrFile [can be positional]

ROC Options:
  -i [ --index ] arg (=last score)  Index of score to use
  -e [ --edges ] arg (=all)         Number of top edges to consider
  -E [ --fraction ] arg (=all)      Fraction of gold standard edges to include
  -p [ --points ] arg (=all)        Number of data points to print
  -t [ --tfs ] arg                  List of transcription factors to consider
  -x [ --neg ] arg                  True negative edges
  -a [ --all ]                      Calculate ROC for all scores in the 
                                    SeidrFile

OpenMP Options:
  -O [ --threads ] arg (=1)         Number of OpenMP threads for parallel 
                                    sorting

Common Options:
  -f [ --force ]                    Force overwrite output file if it exists
  -h [ --help ]                     Show this help message
  -o [ --outfile ] arg (=-)         Output file name ['-' for stdout]
```


## seidr_reheader

### Tool Description
Modify SeidrFile headers. Currently only drops disconnected nodes and resets stats.

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Modify SeidrFile headers.
Currently only drops disconnected nodes and resets
stats.:

Required [can be positional]:
  --in-file arg                 Input SeidrFile

Common Options:
  -h [ --help ]                 Show this help message
  -T [ --tempdir ] arg (=auto)  Directory to store temporary data
```


## seidr_anoverence

### Tool Description
ANOVERENCE network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
ANOVERENCE implementation for Seidr:

Required Options:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names
  -e [ --features ] arg                 File containing experiment metadata

ANOVERENCE specific Options:
  -w [ --weight ] arg (=1.0)            Weight for knockout genes

Common Options:
  -h [ --help ]                         Show this help message
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=anova_scores.tsv)
                                        Output file path
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -V [ --version ]                      Print the program version
```

## seidr_correlation

### Tool Description
Pearson/Spearman correlation network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Pearson/Spearman correlation for Seidr:

Required Options:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

Correlation specific Options:
  -m [ --method ] arg (=pearson)        Correlation method
  -a [ --absolute ]                     Report absolute values
  -s [ --scale ]                        (deprecated) Transform data to z-scores
  --no-scale                            Do not transform data to z-scores

Common Options:
  -h [ --help ]                         Show this help message
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=<method>_scores.tsv)
                                        Output file path
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -V [ --version ]                      Print the program version
```

## seidr_el-ensemble

### Tool Description
Elastic net ensemble network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Elastic net ensemble implementation for Seidr:

Required Options:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

ElNet Options:
  -s [ --scale ]                        (deprecated) Transform data to z-scores
  --no-scale                            Do not transform data to z-scores
  -n [ --nlambda ] arg (=10)            The maximum number of lambda values
  -l [ --min-lambda ] arg (=0.3)        The minimum lambda as a fraction of the
                                        maximum.
  -a [ --alpha ] arg (=0.3)             The elastic net mixing value alpha. 1.0
                                        is LASSO, 0 is Ridge.

Bootstrap Options:
  -e [ --ensemble ] arg (=1000)         The ensemble size
  -p [ --min-predictor-size ] arg (=20% of predictors)
                                        The minimum absolute number of 
                                        predictors (genes) to be sampled.
  -P [ --max-predictor-size ] arg (=80% of predictors)
                                        The maximum absolute number of 
                                        predictors (genes) to be sampled
  -x [ --min-experiment-size ] arg (=20% of experiments)
                                        The minimum absolute number of 
                                        experiments (samples) to be sampled
  -X [ --max-experiment-size ] arg (=80% of experiments)
                                        The maximum absolute number of 
                                        experiments (samples) to be sampled

MPI Options:
  -B [ --batch-size ] arg (=0)          Number of genes in MPI batch
  -T [ --tempdir ] arg                  Temporary directory path

OpenMP Options:
  -O [ --threads ] arg (=20)            Number of OpenMP threads per MPI task

Common Options:
  -h [ --help ]                         Show this help message
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=elnet_scores.tsv)
                                        Output file path
  --save-resume arg                     Path to a file that stores job resume 
                                        info.
  --resume-from arg                     Try to resume job from this file.
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -V [ --version ]                      Print the program version
```

## seidr_genie3

### Tool Description
GENIE3 random forest network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
GENIE3 implementation for Seidr:

Required:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

GENIE3 Options:
  -s [ --scale ]                        (deprecated) Transform data to z-scores
  --no-scale                            Do not transform data to z-scores
  -N [ --min-node-size ] arg (=5)       Minimum node size
  -p [ --min-prop ] arg (=0.1)          Minimal proportion in random forest
  -a [ --alpha ] arg (=0.5)             Alpha value for random forests

Bootstrap Options:
  -n [ --ntree ] arg (=1000)            Number of random forest trees to grow
  -m [ --mtry ] arg (=sqrt(m))          Number of features to sample in each 
                                        tree

MPI Options:
  -B [ --batch-size ] arg (=0)          Number of genes in MPI batch
  -T [ --tempdir ] arg                  Temporary directory path

OpenMP Options:
  -O [ --threads ] arg (=20)            Number of OpenMP threads per MPI task

Common Options:
  -h [ --help ]                         Show this help message
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=genie3_scores.tsv)
                                        Output file path
  --save-resume arg                     Path to a file that stores job resume 
                                        info.
  --resume-from arg                     Try to resume job from this file.
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -V [ --version ]                      Print the program version
```

## seidr_llr-ensemble

### Tool Description
Linear support vector regression (LLR) ensemble network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
NIMEFI SVM implementation for Seidr:

Required Options:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

SVM options:
  -s [ --scale ]                        (deprecated) Transform data to z-scores
  --no-scale                            Do not transform data to z-scores
  -C [ --penalty ] arg (=1)             Penalty C value
  -l [ --tol ] arg (=0.001)             Epsilon/tolerance (stopping criterion)
  -E [ --eps ] arg (=0.1)               Epsilon (for EPSILON_SVR)
  -S [ --solver ] arg (=L2R_L2LOSS_SVR) SVM solver to use [L2R_L2LOSS_SVR, 
                                        L2R_L2LOSS_SVR_DUAL, 
                                        L2R_L1LOSS_SVR_DUAL]

Bootstrap Options:
  -e [ --ensemble ] arg (=1000)         The ensemble size
  -p [ --min-predictor-size ] arg (=20% of predictors)
                                        The minimum absolute number of 
                                        predictors (genes) to be sampled.
  -P [ --max-predictor-size ] arg (=80% of predictors)
                                        The maximum absolute number of 
                                        predictors (genes) to be sampled
  -x [ --min-experiment-size ] arg (=20% of experiments)
                                        The minimum absolute number of 
                                        experiments (samples) to be sampled
  -X [ --max-experiment-size ] arg (=80% of experiments)
                                        The maximum absolute number of 
                                        experiments (samples) to be sampled

MPI Options:
  -B [ --batch-size ] arg (=0)          Number of genes in MPI batch
  -T [ --tempdir ] arg                  Temporary directory path

OpenMP Options:
  -O [ --threads ] arg (=20)            Number of OpenMP threads per MPI task

Common Options:
  -h [ --help ]                         Show this help message
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=llr_scores.tsv)
                                        Output file path
  --save-resume arg                     Path to a file that stores job resume 
                                        info.
  --resume-from arg                     Try to resume job from this file.
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -V [ --version ]                      Print the program version
```

## seidr_mi

### Tool Description
Mutual information based network inference for Seidr (RAW, CLR, ARACNE)

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
MI based algorithms for seidr.
These include post processing schemes like CLR or DPI (==ARACNE).:

Required:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

MI Options:
  -s [ --spline ] arg (=3)              Spline order
  -b [ --bins ] arg (=auto)             Number of bins
  -M [ --mi-file ] arg                  Save/load raw MI to/from this file
  -m [ --mode ] arg (=RAW)              Post processing [RAW, CLR, ARACNE]

MPI Options:
  -B [ --batch-size ] arg (=0)          Number of genes in MPI batch
  -T [ --tempdir ] arg                  Temporary directory path

OpenMP Options:
  -O [ --threads ] arg (=20)            Number of OpenMP threads per MPI task

Common Options:
  -h [ --help ]                         Show this help message
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=mi_scores.tsv) Output file path
  --save-resume arg                     Path to a file that stores job resume 
                                        info.
  --resume-from arg                     Try to resume job from this file.
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -V [ --version ]                      Print the program version
```

## seidr_narromi

### Tool Description
NARROMI network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Narromi implementation for Seidr:

Required:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

NARROMI Options:
  -m [ --algorithm ] arg (=simplex)     Method for linear programming 
                                        optimisaton. One of 'interior-point' or
                                        'simplex'.
  -a [ --alpha ] arg (=0.05)            Alpha cutoff for MI selection.

MPI Options:
  -B [ --batch-size ] arg (=0)          Number of genes in MPI batch
  -T [ --tempdir ] arg                  Temporary directory path

OpenMP Options:
  -O [ --threads ] arg (=20)            Number of OpenMP threads per MPI task

Common Options:
  -h [ --help ]                         Show this help message
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=narromi_scores.tsv)
                                        Output file path
  --save-resume arg                     Path to a file that stores job resume 
                                        info.
  --resume-from arg                     Try to resume job from this file.
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -V [ --version ]                      Print the program version
```

## seidr_pcor

### Tool Description
Partial correlation network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Partial correlation for Seidr:

Required Options:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

PCor Options:
  -a [ --absolute ]                     Report absolute values
  -s [ --scale ]                        (deprecated) Transform data to z-scores
  --no-scale                            Do not transform data to z-scores

Common Options:
  -h [ --help ]                         Show this help message
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=pcor_scores.tsv)
                                        Output file path
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -V [ --version ]                      Print the program version
```

## seidr_plsnet

### Tool Description
PLSNET partial least squares network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
PLSNET implementation for Seidr:

Required Options:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

PLSNET Options:
  -s [ --scale ]                        (deprecated) Transform data to z-scores
  -S [ --no-scale ]                     Do not transform data to z-scores
  -c [ --components ] arg (=5)          The number of PLS components to be 
                                        considered

Bootstrap Options:
  -e [ --ensemble ] arg (=1000)         The ensemble size
  -p [ --predictor-size ] arg (=sqrt(m))
                                        The number of predictors (genes) to be 
                                        sampled.

MPI Options:
  -B [ --batch-size ] arg (=0)          Number of genes in MPI batch
  -T [ --tempdir ] arg                  Temporary directory path

OpenMP Options:
  -O [ --threads ] arg (=20)            Number of OpenMP threads per MPI task

Common Options:
  -h [ --help ]                         Show this help message
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=plsnet_scores.tsv)
                                        Output file path
  --save-resume arg                     Path to a file that stores job resume 
                                        info.
  --resume-from arg                     Try to resume job from this file.
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -V [ --version ]                      Print the program version
```

## seidr_svm-ensemble

### Tool Description
SVM ensemble network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
NIMEFI SVM implementation for Seidr:

Required:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

SVM options:
  -s [ --scale ]                        (deprecated) Transform data to z-scores
  --no-scale                            Do not transform data to z-scores
  -y [ --type ] arg (=EPSILON_SVR)      SVM type [NU_SVR, EPSILON_SVR]
  -k [ --kernel ] arg (=LINEAR)         SVM kernel [LINEAR, POLY, RBF, SIGMOID]
  -d [ --degree ] arg (=3)              Polynomial degree (for POLY kernel)
  -G [ --gamma ] arg (=0.01)            Kernel coefficient for POLY/RBF/SIGMOID
                                        kernels
  -c [ --coef ] arg (=0.01)             Independent term in kernel function 
                                        (for POLY/SIGMOID kernels)
  -n [ --nu ] arg (=0.5)                nu value (for NU_SVR)
  -C [ --penalty ] arg (=1)             Penalty C value
  -l [ --tol ] arg (=0.001)             Epsilon/tolerance (stopping criterion)
  -E [ --eps ] arg (=0.1)               Epsilon (for EPSILON_SVR)
  -S [ --shrinking ] arg (=1)           Whether to use the shrinking heuristic 
                                        [0: off, 1: on]

Bootstrap Options:
  -e [ --ensemble ] arg (=1000)         The ensemble size
  -p [ --min-predictor-size ] arg (=20% of predictors)
                                        The minimum absolute number of 
                                        predictors (genes) to be sampled.
  -P [ --max-predictor-size ] arg (=80% of predictors)
                                        The maximum absolute number of 
                                        predictors (genes) to be sampled
  -x [ --min-experiment-size ] arg (=20% of experiments)
                                        The minimum absolute number of 
                                        experiments (samples) to be sampled
  -X [ --max-experiment-size ] arg (=80% of experiments)
                                        The maximum absolute number of 
                                        experiments (samples) to be sampled

MPI Options:
  -B [ --batch-size ] arg (=0)          Number of genes in MPI batch
  -T [ --tempdir ] arg                  Temporary directory path

OpenMP Options:
  -O [ --threads ] arg (=20)            Number of OpenMP threads per MPI task

Common Options:
  -h [ --help ]                         Show this help message
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=svm_scores.tsv)
                                        Output file path
  --save-resume arg                     Path to a file that stores job resume 
                                        info.
  --resume-from arg                     Try to resume job from this file.
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -V [ --version ]                      Print the program version
```

## seidr_tigress

### Tool Description
TIGRESS network inference for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
TIGRESS implementation for Seidr:

Required Options:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

TIGRESS Options:
  -s [ --scale ]                        (deprecated) Transform data to z-scores
  -S [ --no-scale ]                     Do not transform data to z-scores
  -n [ --nlambda ] arg (=10)            The maximum number of lambda values
  -l [ --min-lambda ] arg (=0.3)        The minimum lambda as a fraction of the
                                        maximum.
  --allow-low-var                       Disable low variance filter when 
                                        subsampling data (at your own risk)

Bootstrap Options:
  -e [ --ensemble ] arg (=1000)         The ensemble size

MPI Options:
  -B [ --batch-size ] arg (=0)          Number of genes in MPI batch
  -T [ --tempdir ] arg                  Temporary directory path

OpenMP Options:
  -O [ --threads ] arg (=20)            Number of OpenMP threads per MPI task

Common Options:
  -h [ --help ]                         Show this help message
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=tigress_scores.tsv)
                                        Output file path
  --save-resume arg                     Path to a file that stores job resume 
                                        info.
  --resume-from arg                     Try to resume job from this file.
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -V [ --version ]                      Print the program version
```

## seidr_tomsimilarity

### Tool Description
Topological overlap matrix as implemented in WGCNA, for Seidr

### Metadata
- **Docker Image**: quay.io/biocontainers/seidr:0.14.2--mpi_mpich_h0475154
- **Homepage**: https://github.com/bschiffthaler/seidr
- **Package**: https://anaconda.org/channels/bioconda/packages/seidr/overview
- **Validation**: PASS

### Original Help Text
```text
Topological overlap matrix as implemented in WGCNA:

Required Options:
  -i [ --infile ] arg                   The expression table (without headers)
  -g [ --genes ] arg                    File containing gene names

Correlation specific Options:
  -m [ --method ] arg (=pearson)        Correlation method: [bicor, pearson]
  -a [ --absolute ]                     Report absolute values
  -s [ --scale ]                        (deprecated) Transform data to z-scores
  -S [ --no-scale ]                     Do not transform data to z-scores
  -b [ --sft ] arg (=0)                 Soft threshold to apply (0 for 
                                        autodetection)
  -M [ --max-power ] arg (=30)          Maximum power to check for SFT test in 
                                        auto detection mode
  -c [ --sft-cutoff ] arg (=0.8)        Soft threshold R^2 cutoff in 
                                        autodetection mode
  -T [ --tom-type ] arg (=signed)       TOM type: unsigned, signed, 
                                        signed-hybrid

Common Options:
  -h [ --help ]                         Show this help message
  -t [ --targets ] arg                  File containing gene names of genes of 
                                        interest. The network will only be 
                                        calculated using these as the sources 
                                        of potential connections.
  -o [ --outfile ] arg (=tom_scores.tsv)
                                        Output file path
  -v [ --verbosity ] arg (=3)           Verbosity level (lower is less verbose)
  -f [ --force ]                        Force overwrite if output already 
                                        exists
  -V [ --version ]                      Print the program version
```

## Metadata
- **Skill**: generated
