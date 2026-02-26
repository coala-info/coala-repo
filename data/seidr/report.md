# seidr CWL Generation Report

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


## Metadata
- **Skill**: generated
