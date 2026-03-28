# schicexplorer CWL Generation Report

## schicexplorer_scHicDemultiplex

### Tool Description
scHicDemultiplex demultiplexes fastq files from Nagano 2017: "Cell-cycle dynamics of chromosomal organization at single-cell resolution" according their barcodes to a seperated forward and reverse strand fastq files per cell.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Total Downloads**: 20.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/joachimwolff/scHiCExplorer
- **Stars**: N/A
### Original Help Text
```text
usage: scHicDemultiplex --fastq list of fastq files to demultiplex
                        [list of fastq files to demultiplex ...] --barcodeFile
                        list of fastq files to demultiplex. Use
                        GSE94489_README.txt file. --srrToSampleFile
                        SRRTOSAMPLEFILE [--outputFolder FOLDER]
                        [--threads THREADS] [--bufferSize BUFFERSIZE] [--help]
                        [--version]

scHicDemultiplex demultiplexes fastq files from Nagano 2017: "Cell-cycle
dynamics of chromosomal organization at single-cell resolution" according
their barcodes to a seperated forward and reverse strand fastq files per cell.

Required arguments:
  --fastq list of fastq files to demultiplex [list of fastq files to demultiplex ...], -f list of fastq files to demultiplex [list of fastq files to demultiplex ...]
                        The fastq files to demultiplex of Nagano 2017 Cell
                        cycle dynamics of chromosomal organization at single-
                        cell resolutionGEO: GSE94489. Files need to have four
                        FASTQ lines per read:/1 forward; /2 barcode forward;
                        /3 bardcode reverse; /4 reverse read.Please be aware
                        the files can be downloaded via the command fastq-dump
                        to be in the right format:fastq-dump --accession
                        SRR5229025 --split-files --defline-seq
                        '@$sn[_$rn]/$ri' --defline-qual '+' --split-spot
                        --stdout SRR5229025 > SRR5229025.fastq (default: None)
  --barcodeFile list of fastq files to demultiplex. Use GSE94489_README.txt file., -bf list of fastq files to demultiplex. Use GSE94489_README.txt file.
                        The fastq files to demultiplex (default: None)
  --srrToSampleFile SRRTOSAMPLEFILE, -s SRRTOSAMPLEFILE
                        The mappings from SRR number to sample id as given in
                        the barcode file. (default: None)
  --outputFolder FOLDER, -o FOLDER
                        Path of folder to save the demultiplexed files
                        (default: demultiplexed)

Optional arguments:
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --bufferSize BUFFERSIZE, -bs BUFFERSIZE
                        Number of lines to buffer in memory, if full, write
                        the data to disk. (default: 20000000.0)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```


## schicexplorer_scHicMergeMatrixBins

### Tool Description
Merges bins from a Hi-C matrix. For example, using a matrix containing 5kb
bins, a matrix of 50kb bins can be derived using --numBins 10.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicMergeMatrixBins --matrix matrix.scool --outFileName OUTFILENAME
                            --numBins int [--runningWindow]
                            [--threads THREADS] [--help] [--version]

Merges bins from a Hi-C matrix. For example, using a matrix containing 5kb
bins, a matrix of 50kb bins can be derived using --numBins 10.

Required arguments:
  --matrix matrix.scool, -m matrix.scool
                        Matrix to reduce in scool format. (default: None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the resulting matrix. The output is
                        also a .scool file. But don't add the suffix.
                        (default: None)
  --numBins int, -nb int
                        Number of bins to merge. (default: None)

Optional arguments:
  --runningWindow       set to merge for using a running window of length
                        --numBins. Must be an odd number. (default: False)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```


## schicexplorer_scHicCorrectMatrices

### Tool Description
Correct each matrix of the given scool matrix with KR correction.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicCorrectMatrices --matrix matrix.h5 --outFileName OUTFILENAME
                            [--threads THREADS] [--help] [--version]

Correct each matrix of the given scool matrix with KR correction.

Required arguments:
  --matrix matrix.h5, -m matrix.h5
                        Matrix to reduce in h5 format. (default: None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the resulting matrix, please add the
                        scool prefix. (default: None)

Optional arguments:
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```


## schicexplorer_scHicNormalize

### Tool Description
Normalize scHi-C matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicNormalize --matrix scool scHi-C matrix --outFileName OUTFILENAME
                      [--threads THREADS] --normalize
                      {smallest,read_count,multiplicative}
                      [--setToZeroThreshold SETTOZEROTHRESHOLD]
                      [--value VALUE]
                      [--maximumRegionToConsider MAXIMUMREGIONTOCONSIDER]
                      [--help] [--version]

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to
                        investigate for QC. Needs to be in scool format
                        (default: None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name of the normalized scool matrix. (default:
                        None)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --normalize {smallest,read_count,multiplicative}, -n {smallest,read_count,multiplicative}
                        Normalize to a) all matrices to the lowest read count
                        of the given matrices, b) all to a given read coverage
                        value or c) to a multiplicative value (default:
                        smallest)

Optional arguments:
  --setToZeroThreshold SETTOZEROTHRESHOLD, -z SETTOZEROTHRESHOLD
                        Values smaller as this threshold are set to 0.
                        (default: 1.0)
  --value VALUE, -v VALUE
                        This value is used to either be interpreted as the
                        desired read_count or the multiplicative value. This
                        depends on the value for --normalize (default: 1)
  --maximumRegionToConsider MAXIMUMREGIONTOCONSIDER
                        To compute the normalization factor for the
                        normalization mode 'smallest' and 'read_count',
                        consider only this genomic distance around the
                        diagonal. (default: 30000000)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```


## schicexplorer_scHicCluster

### Tool Description
Uses kmeans or spectral clustering to associate each cell to a cluster and therefore to its cell cycle. The clustering can be run on the raw data, on a kNN computed via the exact euclidean distance or via PCA. Please consider also the other clustering and dimension reduction approaches of the scHicExplorer suite. They can give you better results, can be faster or less memory demanding.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicCluster --matrix scool scHi-C matrix
                    [--numberOfClusters NUMBEROFCLUSTERS]
                    [--clusterMethod {spectral,kmeans}]
                    [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                    [--intraChromosomalContactsOnly] [--additionalPCA]
                    [--dimensionsPCA DIMENSIONSPCA]
                    [--dimensionReductionMethod {none,knn,pca}]
                    [--createScatterPlot CREATESCATTERPLOT]
                    [--numberOfNearestNeighbors NUMBEROFNEARESTNEIGHBORS]
                    [--dpi DPI] --outFileName OUTFILENAME
                    [--cell_coloring_type CELL_COLORING_TYPE]
                    [--cell_coloring_batch CELL_COLORING_BATCH]
                    [--latexTable LATEXTABLE] [--figuresize x-size y-size]
                    [--colorMap COLORMAP] [--fontsize FONTSIZE]
                    [--threads THREADS] [--help] [--version]

scHicCluster uses kmeans or spectral clustering to associate each cell to a
cluster and therefore to its cell cycle. The clustering can be run on the raw
data, on a kNN computed via the exact euclidean distance or via PCA. Please
consider also the other clustering and dimension reduction approaches of the
scHicExplorer suite. They can give you better results, can be faster or less
memory demanding.

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to cluster.
                        Needs to be in scool format (default: None)
  --numberOfClusters NUMBEROFCLUSTERS, -c NUMBEROFCLUSTERS
                        Number of to be computed clusters (default: 12)
  --clusterMethod {spectral,kmeans}, -cm {spectral,kmeans}
                        Algorithm to cluster the Hi-C matrices (default:
                        spectral)

Optional arguments:
  --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        List of to be plotted chromosomes (default: None)
  --intraChromosomalContactsOnly, -ic
                        This option loads only the intra-chromosomal contacts.
                        Can improve the cluster result if data is very noisy.
                        (default: False)
  --additionalPCA, -pca
                        Computes PCA on top of a k-nn. Can improve the cluster
                        result. (default: False)
  --dimensionsPCA DIMENSIONSPCA, -dim_pca DIMENSIONSPCA
                        The number of dimensions from the PCA matrix that
                        should be considered for clustering. Can improve the
                        cluster result. (default: 20)
  --dimensionReductionMethod {none,knn,pca}, -drm {none,knn,pca}
                        Dimension reduction methods, knn with euclidean
                        distance, pca (default: none)
  --createScatterPlot CREATESCATTERPLOT, -csp CREATESCATTERPLOT
                        Create a scatter plot for the clustering, the x and y
                        are the first and second principal component of the
                        computed k-nn graph. (default: None)
  --numberOfNearestNeighbors NUMBEROFNEARESTNEIGHBORS, -k NUMBEROFNEARESTNEIGHBORS
                        Number of to be used computed nearest neighbors for
                        the knn graph. Default is either the default value or
                        the number of the provided cells, whatever is smaller.
                        (default: 100)
  --dpi DPI, -d DPI     The dpi of the scatter plot. (default: 300)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the resulting clusters (default:
                        clusters.txt)
  --cell_coloring_type CELL_COLORING_TYPE, -cct CELL_COLORING_TYPE
                        A two column list, first colum the cell names as
                        stored in the scool file, second column the associated
                        coloring for the scatter plot (default: None)
  --cell_coloring_batch CELL_COLORING_BATCH, -ccb CELL_COLORING_BATCH
                        A two column list, first colum the cell names as
                        stored in the scool file, second column the associated
                        coloring for the scatter plot (default: None)
  --latexTable LATEXTABLE, -lt LATEXTABLE
                        Return the overlap statistics if --cell_coloring_type
                        is given as a latex table. (default: None)
  --figuresize x-size y-size
                        Fontsize in the plot for x and y axis. (default: (15,
                        6))
  --colorMap COLORMAP   Color map to use for the heatmap, supported are the
                        categorical colormaps from holoviews:
                        http://holoviews.org/user_guide/Colormaps.html
                        (default: glasbey_dark)
  --fontsize FONTSIZE   Fontsize in the plot for x and y axis. (default: 15)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 8)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```


## schicexplorer_scHicCorrelate

### Tool Description
Computes pairwise correlations between Hi-C matrices data. The correlation is computed taking the values from each pair of matrices and discarding values that are zero in both matrices.Parameters that strongly affect correlations are bin size of the Hi-C matrices and the considered range. The smaller the bin size of the matrices, the finer differences you score. The --range parameter should be selected at a meaningful genomic scale according to, for example, the mean size of the TADs in the organism you work with.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicCorrelate --matrix MATRIX [--zMin ZMIN] [--zMax ZMAX] [--colorMap]
                      [--plotFileFormat FILETYPE] [--plotNumbers]
                      [--method {pearson,spearman}] [--log1p]
                      [--labels sample1 sample2] [--range RANGE]
                      --outFileNameHeatmap OUTFILENAMEHEATMAP
                      --outFileNameScatter OUTFILENAMESCATTER
                      [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                      [--fontsize FONTSIZE] [--figuresize x-size y-size]
                      [--threads THREADS] [--help] [--version]

Computes pairwise correlations between Hi-C matrices data. The correlation is
computed taking the values from each pair of matrices and discarding values
that are zero in both matrices.Parameters that strongly affect correlations
are bin size of the Hi-C matrices and the considered range. The smaller the
bin size of the matrices, the finer differences you score. The --range
parameter should be selected at a meaningful genomic scale according to, for
example, the mean size of the TADs in the organism you work with.

Required arguments:
  --matrix MATRIX, -m MATRIX
                        Cells to correlate stored in scool hicCorrelate is
                        better used on un-corrected matrices in order to
                        exclude any changes introduced by the correction.
                        (default: None)

Heatmap arguments:
  Options for generating the correlation heatmap

  --zMin ZMIN, -min ZMIN
                        Minimum value for the heatmap intensities. If not
                        specified the value is set automatically. (default:
                        None)
  --zMax ZMAX, -max ZMAX
                        Maximum value for the heatmap intensities.If not
                        specified the value is set automatically. (default:
                        None)
  --colorMap            Color map to use for the heatmap. Available values can
                        be seen here: http://matplotlib.org/examples/color/col
                        ormaps_reference.html (default: jet)
  --plotFileFormat FILETYPE
                        Image format type. If given, this option overrides the
                        image format based on the plotFile ending. The
                        available options are: png, emf, eps, pdf and svg.
                        (default: None)
  --plotNumbers         If set, then the correlation number is plotted on top
                        of the heatmap. (default: False)

Optional arguments:
  --method {pearson,spearman}
                        Correlation method to use. (default: pearson)
  --log1p               If set, then the log1p of the matrix values is used.
                        This parameter has no effect for Spearman correlations
                        but changes the output of Pearson correlation and, for
                        the scatter plot, if set, the visualization of the
                        values is easier. (default: False)
  --labels sample1 sample2, -l sample1 sample2
                        User defined labels instead of default labels from
                        file names. Multiple labels have to be separated by
                        space, e.g. --labels sample1 sample2 sample3 (default:
                        None)
  --range RANGE         In bp with the format low_range:high_range, for
                        example 1000000:2000000. If --range is given only
                        counts within this range are considered. The range
                        should be adjusted to the size of interacting domains
                        in the genome you are working with. (default: None)
  --outFileNameHeatmap OUTFILENAMEHEATMAP, -oh OUTFILENAMEHEATMAP
                        File name to save the resulting heatmap plot.
                        (default: None)
  --outFileNameScatter OUTFILENAMESCATTER, -os OUTFILENAMESCATTER
                        File name to save the resulting scatter plot.
                        (default: None)
  --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        List of chromosomes to be included in the correlation.
                        (default: None)
  --fontsize FONTSIZE   Fontsize in the plot for x and y axis. (default: 30)
  --figuresize x-size y-size
                        Fontsize in the plot for x and y axis. (default: (25,
                        20))
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. Is only used with 'cool' matrix format. One
                        master process which is used to read the input file
                        into the buffer and one process which is merging the
                        output bam files of the processes into one output bam
                        file. All other threads do the actual computation.
                        (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```


## schicexplorer_scHicConsensusMatrices

### Tool Description
scHicConsensusMatrices creates based on the clustered samples one consensus matrix for each cluster. The consensus matrices are normalized to an equal read coverage level and are stored all in one scool matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicConsensusMatrices --matrix scool scHi-C matrix --clusters cluster
                              file --outFileName OUTFILENAME
                              [--no_normalization] [--threads THREADS]
                              [--help] [--version]

scHicConsensusMatrices creates based on the clustered samples one consensus
matrix for each cluster. The consensus matrices are normalized to an equal
read coverage level and are stored all in one scool matrix.

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to
                        investigate for QC. Needs to be in scool format
                        (default: None)
  --clusters cluster file, -c cluster file
                        Text file which contains per matrix the associated
                        cluster. (default: None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name of the consensus scool matrix. (default:
                        None)

Optional arguments:
  --no_normalization    Do not plot a header. (default: True)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```


## schicexplorer_scHicPlotConsensusMatrices

### Tool Description
Plot consensus matrices from scool files.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicPlotConsensusMatrices --matrix scool scHi-C matrix
                                  [--outFileName OUTFILENAME] [--dpi DPI]
                                  [--threads THREADS]
                                  [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                                  [--region REGION] [--colorMap COLORMAP]
                                  [--fontsize FONTSIZE] [--no_header]
                                  [--log1p] [--individual_scale] [--help]
                                  [--version]

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The consensus matrix created by scHicConsensusMatrices
                        (default: None)

Optional arguments:
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the resulting cluster profile.
                        (default: consensus_matrices.png)
  --dpi DPI, -d DPI     The dpi of the plot. (default: 300)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --chromosomes CHROMOSOMES [CHROMOSOMES ...], -c CHROMOSOMES [CHROMOSOMES ...]
                        List of to be plotted chromosomes (default: None)
  --region REGION, -r REGION
                        Region to be plotted for each consensus matrix. Mutual
                        exclusion with the usage of --chromosomes parameter
                        (default: None)
  --colorMap COLORMAP   Color map to use for the heatmap. Available values can
                        be seen here: http://matplotlib.org/examples/color/col
                        ormaps_reference.html (default: RdYlBu_r)
  --fontsize FONTSIZE   Fontsize in the plot for x and y axis. (default: 10)
  --no_header           Do not plot a header. (default: True)
  --log1p               Apply log1p operation to plot the matrices. (default:
                        False)
  --individual_scale    Use an individual value range for all cluster
                        consensus matrices. If not set, the same scale is
                        applied to all. (default: True)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```


## Metadata
- **Skill**: generated
