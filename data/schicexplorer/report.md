# schicexplorer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| schicexplorer_scHicAdjustMatrix | PASS | keep and remove match the repo expected files; --createSubmatrix crashes (AttributeError: no attribute regions) |
| schicexplorer_scHicCluster | PASS |  |
| schicexplorer_scHicClusterCompartments | PASS |  |
| schicexplorer_scHicClusterMinHash | PASS |  |
| schicexplorer_scHicClusterMinHashHyperopt | PASS |  |
| schicexplorer_scHicClusterSVL | PASS |  |
| schicexplorer_scHicConsensusMatrices | PASS |  |
| schicexplorer_scHicConvertFormat | PASS |  |
| schicexplorer_scHicCorrectMatrices | Failed | image problem: crashes when saving the corrected scool (hicmatrix scool.save: TypeError unhashable type csr_matrix); the repo test for this tool is also disabled |
| schicexplorer_scHicCorrelate | Failed | tool bug: --outFileNameScatter is a required option but the scatter plot is never written (only the heatmap is) |
| schicexplorer_scHicCreateBulkMatrix | PASS |  |
| schicexplorer_scHicDemultiplex | PASS |  |
| schicexplorer_scHicInfo | PASS |  |
| schicexplorer_scHicManageScool | PASS |  |
| schicexplorer_scHicMergeMatrixBins | PASS |  |
| schicexplorer_scHicMergeToSCool | PASS |  |
| schicexplorer_scHicNormalize | PASS |  |
| schicexplorer_scHicPlotClusterProfiles | PASS |  |
| schicexplorer_scHicPlotConsensusMatrices | PASS |  |
| schicexplorer_scHicQualityControl | PASS |  |
| schicexplorer_scHicTxtToSCool | PASS |  |

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


## schicexplorer_scHicAdjustMatrix

### Tool Description
Keeps or removes a list of chromosomes in all Hi-C matrices of a scool file.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicAdjustMatrix --matrix MATRIX --outFileName OUTFILENAME
                         [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                         [--createSubmatrix CREATESUBMATRIX]
                         [--action {keep,remove}] [--threads THREADS] [--help]
                         [--version]

scHicAdjustMatrix is a tool to keep or remove a list of chromosomes of all
Hi-C matrices stored in the scool file.

Required arguments:
  --matrix MATRIX, -m MATRIX
                        The matrix to adjust in the scool format. (default:
                        None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the adjusted matrix. (default: None)

Optional arguments:
  --chromosomes CHROMOSOMES [CHROMOSOMES ...], -c CHROMOSOMES [CHROMOSOMES ...]
                        List of chromosomes to keep / remove (default: None)
  --createSubmatrix CREATESUBMATRIX, -cs CREATESUBMATRIX
                        Keep only first n matrices and remove the rest. Good
                        for test data creation. (default: None)
  --action {keep,remove}
                        Keep, remove or mask the list of specified chromosomes
                        / regions (default: keep)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicClusterCompartments

### Tool Description
Clusters single-cell Hi-C matrices with kmeans or spectral clustering on the A/B compartment tracks.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicClusterCompartments --matrix scool scHi-C matrix
                                [--numberOfClusters NUMBEROFCLUSTERS]
                                --outFileName OUTFILENAME
                                [--clusterMethod {spectral,kmeans}]
                                [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                                [--norm] [--binarization]
                                [--extraTrack EXTRATRACK]
                                [--histonMarkType HISTONMARKTYPE]
                                [--threads THREADS] [--help] [--version]

scHicClusterCompartments uses kmeans or spectral clustering to associate each
cell to a cluster and therefore to its cell cycle. The clustering is applied
on dimension reduced data based on the A/B compartments track. This approach
reduces the number of dimensions from samples * (number of bins)^2 to samples
* (number of bins). Please consider also the other clustering and dimension
reduction approaches of the scHicExplorer suite. They can give you better
results, can be faster or less memory demanding.

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to cluster.
                        Needs to be in scool format (default: None)
  --numberOfClusters NUMBEROFCLUSTERS, -c NUMBEROFCLUSTERS
                        Number of to be computed clusters (default: 12)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the resulting clusters (default:
                        clusters.txt)
  --clusterMethod {spectral,kmeans}, -cm {spectral,kmeans}
                        Algorithm to cluster the Hi-C matrices (default:
                        spectral)

Optional arguments:
  --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        List of chromosomes to be included in the correlation.
                        (default: None)
  --norm                Different obs-exp normalization as used by Homer
                        software. (default: False)
  --binarization        Set all positive values of eigenvector to 1 and all
                        negative ones to 0. (default: False)
  --extraTrack EXTRATRACK
                        Either a gene track or a histon mark coverage
                        file(preferably a broad mark) is needed to decide if
                        the values of the eigenvector need a sign flip or not.
                        (default: None)
  --histonMarkType HISTONMARKTYPE
                        set it to active or inactive. This is only necessary
                        if a histon mark coverage file is given as an
                        extraTrack. (default: active)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicClusterMinHash

### Tool Description
Clusters single-cell Hi-C matrices on dimension-reduced data from an approximate kNN search with MinHash.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicClusterMinHash --matrix scool scHi-C matrix
                           [--numberOfClusters NUMBEROFCLUSTERS]
                           [--clusterMethod {spectral,kmeans,agglomerative_ward,agglomerative_complete,agglomerative_average,agglomerative_single,birch}]
                           --outFileName OUTFILENAME [--euclideanModeMinHash]
                           [--intraChromosomalContactsOnly]
                           [--saveIntermediateRawMatrix SAVEINTERMEDIATERAWMATRIX]
                           [--createScatterPlot CREATESCATTERPLOT] [--dpi DPI]
                           [--numberOfHashFunctions NUMBEROFHASHFUNCTIONS]
                           [--numberOfNearestNeighbors NUMBEROFNEARESTNEIGHBORS]
                           [--shareOfMatrixToBeTransferred SHAREOFMATRIXTOBETRANSFERRED]
                           [--saveMemory]
                           [--cell_coloring_type CELL_COLORING_TYPE]
                           [--cell_coloring_batch CELL_COLORING_BATCH]
                           [--noPCA] [--noUMAP]
                           [--dimensionsPCA DIMENSIONSPCA]
                           [--colorMap COLORMAP] [--fontsize FONTSIZE]
                           [--distance DISTANCE] [--figuresize x-size y-size]
                           [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                           [--absoluteValues ABSOLUTEVALUES]
                           [--latexTable LATEXTABLE] [--runInHyperoptMode]
                           [--threads THREADS] [--help] [--version]
                           [--umap_n_neighbors UMAP_N_NEIGHBORS]
                           [--umap_n_components UMAP_N_COMPONENTS]
                           [--umap_metric UMAP_METRIC]
                           [--umap_n_epochs UMAP_N_EPOCHS]
                           [--umap_learning_rate UMAP_LEARNING_RATE]
                           [--umap_init UMAP_INIT]
                           [--umap_min_dist UMAP_MIN_DIST]
                           [--umap_spread UMAP_SPREAD]
                           [--umap_set_op_mix_ratio UMAP_SET_OP_MIX_RATIO]
                           [--umap_local_connectivity UMAP_LOCAL_CONNECTIVITY]
                           [--umap_repulsion_strength UMAP_REPULSION_STRENGTH]
                           [--umap_negative_sample_rate UMAP_NEGATIVE_SAMPLE_RATE]
                           [--umap_transform_queue_size UMAP_TRANSFORM_QUEUE_SIZE]
                           [--umap_a UMAP_A] [--umap_b UMAP_B]
                           [--umap_angular_rp_forest]
                           [--umap_target_n_neighbors UMAP_TARGET_N_NEIGHBORS]
                           [--umap_target_metric UMAP_TARGET_METRIC]
                           [--umap_target_weight UMAP_TARGET_WEIGHT]
                           [--umap_force_approximation_algorithm]
                           [--umap_verbose] [--umap_unique]

scHicClusterMinHash uses kmeans, spectral, agglomerative (ward, complete,
average or single) or birch clustering to associate each cell to a cluster and
therefore to its cell cycle. The clustering is applied on dimension reduced
data based on an approximate kNN search with the local sensitive hashing
technique MinHash. This approach reduces the number of dimensions from samples
* (number of bins)^2 to samples * samples. Please consider also the other
clustering and dimension reduction approaches of the scHicExplorer suite. They
can give you better results, can be faster or less memory demanding.

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to cluster.
                        Needs to be in scool format (default: None)
  --numberOfClusters NUMBEROFCLUSTERS, -c NUMBEROFCLUSTERS
                        Number of to be computed clusters (default: 12)
  --clusterMethod {spectral,kmeans,agglomerative_ward,agglomerative_complete,agglomerative_average,agglomerative_single,birch}, -cm {spectral,kmeans,agglomerative_ward,agglomerative_complete,agglomerative_average,agglomerative_single,birch}
                        Algorithm to cluster the Hi-C matrices (default:
                        spectral)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the resulting clusters (default:
                        clusters.txt)

Optional arguments:
  --euclideanModeMinHash, -em
                        This option uses the number of hash collisions is only
                        for a candidate set selection and computes on them the
                        euclidean distance. (default: True)
  --intraChromosomalContactsOnly, -ic
                        This option loads only the intra-chromosomal contacts.
                        Can improve the cluster result if data is very noisy.
                        (default: False)
  --saveIntermediateRawMatrix SAVEINTERMEDIATERAWMATRIX, -sirm SAVEINTERMEDIATERAWMATRIX
                        This option activates the save of the intermediate raw
                        scHi-C matrix. (default: None)
  --createScatterPlot CREATESCATTERPLOT, -csp CREATESCATTERPLOT
                        Create a scatter plot for the clustering, the x and y
                        are the first and second principal component of the
                        computed k-nn graph. (default: scatterPlot.eps)
  --dpi DPI             The dpi of the scatter plot. (default: 300)
  --numberOfHashFunctions NUMBEROFHASHFUNCTIONS, -nh NUMBEROFHASHFUNCTIONS
                        Number of to be used hash functions for minHash
                        (default: 4000)
  --numberOfNearestNeighbors NUMBEROFNEARESTNEIGHBORS, -k NUMBEROFNEARESTNEIGHBORS
                        Number of to be used computed nearest neighbors for
                        the knn graph. (default: None)
  --shareOfMatrixToBeTransferred SHAREOFMATRIXTOBETRANSFERRED, -s SHAREOFMATRIXTOBETRANSFERRED
                        Which share of rows shall be transferred from Python
                        to C++ at once. If `--saveMemory` is active, value is
                        interpreted as the share to loaded at once to memory.
                        Values between 0 and 1, the more are transferred at
                        once, the larger the memory usage is. The less rows
                        are transferred, the slower the computation is.
                        (default: 0.25)
  --saveMemory, -sm     Load data only with one core, this method saves memory
                        but is significantly slower. (default: False)
  --cell_coloring_type CELL_COLORING_TYPE, -cct CELL_COLORING_TYPE
                        A two column list, first colum the cell names as
                        stored in the scool file, second column the associated
                        coloring for the scatter plot (default: None)
  --cell_coloring_batch CELL_COLORING_BATCH, -ccb CELL_COLORING_BATCH
                        A two column list, first colum the cell names as
                        stored in the scool file, second column the associated
                        coloring for the scatter plot (default: None)
  --noPCA               Do not computes PCA on top of a k-nn. (default: False)
  --noUMAP              Do not computes UMP on top of a k-nn/PCA. (default:
                        False)
  --dimensionsPCA DIMENSIONSPCA, -dim_pca DIMENSIONSPCA
                        The number of dimensions from the PCA matrix that
                        should be considered for clustering. Can improve the
                        cluster result. (default: 100)
  --colorMap COLORMAP   Color map to use for the heatmap, supported are the
                        categorical colormaps from holoviews:
                        http://holoviews.org/user_guide/Colormaps.html
                        (default: glasbey_dark)
  --fontsize FONTSIZE   Fontsize in the plot for x and y axis. (default: 15)
  --distance DISTANCE, -d DISTANCE
                        Contact distance to consider (default: None)
  --figuresize x-size y-size
                        Fontsize in the plot for x and y axis. (default: (15,
                        6))
  --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        List of to be computed chromosomes (default: None)
  --absoluteValues ABSOLUTEVALUES, -av ABSOLUTEVALUES
                        Return the number of hash collisions as measure
                        instead of 0 - 1 normalized values. (default: None)
  --latexTable LATEXTABLE, -lt LATEXTABLE
                        Return the overlap statistics if --cell_coloring_type
                        is given as a latex table. (default: None)
  --runInHyperoptMode   Compute the correct associated average of the given
                        clusters to (default: False)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 8)
  --help, -h            show this help message and exit
  --version             show program's version number and exit

Optional umap arguments:
  Arguments for umap embedding. Please consider its documentation for
  details: https://umap-
  learn.readthedocs.io/en/latest/api.html#umap.umap_.UMAP

  --umap_n_neighbors UMAP_N_NEIGHBORS
                        Number of neighbors (default: 30)
  --umap_n_components UMAP_N_COMPONENTS
                        Number of components (default: 2)
  --umap_metric UMAP_METRIC
                        Metric of umap. (default: canberra)
  --umap_n_epochs UMAP_N_EPOCHS
                        Number of epochs (default: None)
  --umap_learning_rate UMAP_LEARNING_RATE
                        Learning rate (default: 1.0)
  --umap_init UMAP_INIT
                        Initialization method (default: spectral)
  --umap_min_dist UMAP_MIN_DIST
                        Minimum distance of two neighbors (default: 0.3)
  --umap_spread UMAP_SPREAD
                        Spread (default: 1.0)
  --umap_set_op_mix_ratio UMAP_SET_OP_MIX_RATIO
                        set_op_mix_ratio (default: 1.0)
  --umap_local_connectivity UMAP_LOCAL_CONNECTIVITY
                        local connectivity (default: 1.0)
  --umap_repulsion_strength UMAP_REPULSION_STRENGTH
                        repulsion strength (default: 1.0)
  --umap_negative_sample_rate UMAP_NEGATIVE_SAMPLE_RATE
                        negative sample rate (default: 5)
  --umap_transform_queue_size UMAP_TRANSFORM_QUEUE_SIZE
                        transform queue size (default: 4.0)
  --umap_a UMAP_A       a (default: None)
  --umap_b UMAP_B       b (default: None)
  --umap_angular_rp_forest
                        angular rp forest (default: False)
  --umap_target_n_neighbors UMAP_TARGET_N_NEIGHBORS
                        target number of neighbors (default: -1)
  --umap_target_metric UMAP_TARGET_METRIC
                        target metric (default: categorical)
  --umap_target_weight UMAP_TARGET_WEIGHT
                        target weight (default: 0.5)
  --umap_force_approximation_algorithm
                        force approximation algorithm (default: False)
  --umap_verbose        verbose (default: False)
  --umap_unique         Contact distance to consider (default: False)
```

## schicexplorer_scHicClusterMinHashHyperopt

### Tool Description
Optimizes the parameters of scHicClusterMinHash with hyperopt.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicClusterMinHashHyperopt --matrix MATRIX --cellColor CELLCOLOR
                                   [--outputFileName OUTPUTFILENAME]
                                   [--runs RUNS]
                                   [--nearestNeighbors NEARESTNEIGHBORS]
                                   [--numberOfHashfunctions NUMBEROFHASHFUNCTIONS NUMBEROFHASHFUNCTIONS NUMBEROFHASHFUNCTIONS]
                                   [--numberOfClusters NUMBEROFCLUSTERS NUMBEROFCLUSTERS]
                                   [--numberPCADimensions NUMBERPCADIMENSIONS NUMBERPCADIMENSIONS NUMBERPCADIMENSIONS]
                                   [--umap_numberOfNeighbors UMAP_NUMBEROFNEIGHBORS UMAP_NUMBEROFNEIGHBORS UMAP_NUMBEROFNEIGHBORS]
                                   [--umap_n_components UMAP_N_COMPONENTS UMAP_N_COMPONENTS UMAP_N_COMPONENTS]
                                   [--umap_min_dist UMAP_MIN_DIST UMAP_MIN_DIST]
                                   --method {random,tpe,atpe}
                                   [--threads THREADS] [--help] [--version]

Required arguments:
  --matrix MATRIX, -m MATRIX
                        The matrix to compute the loops on.
  --cellColor CELLCOLOR, -c CELLCOLOR
                        The file with the associated cell types or cell cycle
                        stages.
  --outputFileName OUTPUTFILENAME, -o OUTPUTFILENAME
                        File names for the result of the optimization
                        (Default: hyperoptMinHash_result.txt).
  --method {random,tpe,atpe}, -me {random,tpe,atpe}
                        Method to optimize by hyperopt: random tree, tpe,
                        adaptive tpe

Optional arguments:
  --runs RUNS           Number of runs of hyperopt.
  --nearestNeighbors NEARESTNEIGHBORS, -k NEARESTNEIGHBORS
                        Number of runs of hyperopt.
  --numberOfHashfunctions NUMBEROFHASHFUNCTIONS NUMBEROFHASHFUNCTIONS NUMBEROFHASHFUNCTIONS, -noh NUMBEROFHASHFUNCTIONS NUMBEROFHASHFUNCTIONS NUMBEROFHASHFUNCTIONS
                        Number of hash functions range: start, stop, stepsize
                        (Default: (1000, 20000, 1000)).
  --numberOfClusters NUMBEROFCLUSTERS NUMBEROFCLUSTERS, -noc NUMBEROFCLUSTERS NUMBEROFCLUSTERS
                        Number of cluster range (Default: (6, 15)).
  --numberPCADimensions NUMBERPCADIMENSIONS NUMBERPCADIMENSIONS NUMBERPCADIMENSIONS, -nop NUMBERPCADIMENSIONS NUMBERPCADIMENSIONS NUMBERPCADIMENSIONS
                        Number of PCA range: start, stop, stepsize (Default:
                        (30, 60, 1)).
  --umap_numberOfNeighbors UMAP_NUMBEROFNEIGHBORS UMAP_NUMBEROFNEIGHBORS UMAP_NUMBEROFNEIGHBORS, -unon UMAP_NUMBEROFNEIGHBORS UMAP_NUMBEROFNEIGHBORS UMAP_NUMBEROFNEIGHBORS
                        Number of umap neighbors range: start, stop, stepsize
                        (Default: (30, 60, 1)).
  --umap_n_components UMAP_N_COMPONENTS UMAP_N_COMPONENTS UMAP_N_COMPONENTS, -unoc UMAP_N_COMPONENTS UMAP_N_COMPONENTS UMAP_N_COMPONENTS
                        Number of umap n_components range: start, stop,
                        stepsize (Default: (2, 10, 1)).
  --umap_min_dist UMAP_MIN_DIST UMAP_MIN_DIST, -umin UMAP_MIN_DIST UMAP_MIN_DIST
                        Number of umap neighbors range: start, stop (Default:
                        (0.0, 0.5)).
  --threads THREADS, -t THREADS
                        Number of threads (uses the python multiprocessing
                        module) (Default: 16).
  --help, -h            Show this help message and exit.
  --version             show program's version number and exit
```

## schicexplorer_scHicClusterSVL

### Tool Description
Clusters single-cell Hi-C matrices on the ratio of short to long range contacts per chromosome.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicClusterSVL --matrix scool scHi-C matrix
                       [--numberOfClusters NUMBEROFCLUSTERS]
                       [--clusterMethod {spectral,kmeans}] --outFileName
                       OUTFILENAME [--distanceShortRange DISTANCESHORTRANGE]
                       [--distanceLongRange DISTANCELONGRANGE]
                       [--threads THREADS] [--help] [--version]

scHicClusterSVL uses kmeans or spectral clustering to associate each cell to a
cluster and therefore to its cell cycle. The clustering is applied on
dimension reduced data based on the ratio of short vs long range contacts per
chromosome. This approach reduces the number of dimensions from samples *
(number of bins)^2 to samples * (number of chromosomes). Please consider also
the other clustering and dimension reduction approaches of the scHicExplorer
suite. They can give you better results, can be faster or less memory
demanding.

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to cluster.
                        Needs to be in scool format (default: None)
  --numberOfClusters NUMBEROFCLUSTERS, -c NUMBEROFCLUSTERS
                        Number of to be computed clusters (default: 7)
  --clusterMethod {spectral,kmeans}, -cm {spectral,kmeans}
                        Algorithm to cluster the Hi-C matrices (default:
                        spectral)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the resulting clusters (default:
                        clusters.txt)

Optional arguments:
  --distanceShortRange DISTANCESHORTRANGE, -ds DISTANCESHORTRANGE
                        Distance which should be considered as short range.
                        Default 2MB. (default: 2000000)
  --distanceLongRange DISTANCELONGRANGE, -dl DISTANCELONGRANGE
                        Distance which should be considered as short range.
                        Default 12MB. (default: 12000000)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicConvertFormat

### Tool Description
Converts a scool matrix to other single-cell Hi-C formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicConvertFormat --matrix MATRIX --outputFolder OUTPUTFOLDER
                          [--outputCellNameFile OUTPUTCELLNAMEFILE]
                          [--outputChromosomeSize OUTPUTCHROMOSOMESIZE]
                          [--format {schicluster,sparse-matrix-files}]
                          [--threads THREADS] [--help] [--version]

scHicConvertFormat is a tool to convert a scool matrix to other single-cell
Hi-C formats. So far only the structure of scHiCluster is supported:
https://github.com/zhoujt1994/scHiCluster

Required arguments:
  --matrix MATRIX, -m MATRIX
                        The matrix to adjust in the scool format. (default:
                        None)
  --outputFolder OUTPUTFOLDER, -of OUTPUTFOLDER
                        Folder name to save the files (default: .)
  --outputCellNameFile OUTPUTCELLNAMEFILE, -oc OUTPUTCELLNAMEFILE
                        File name to save the cell names and their location
                        (default: cellNameFile.txt)
  --outputChromosomeSize OUTPUTCHROMOSOMESIZE, -os OUTPUTCHROMOSOMESIZE
                        File name to save the chromosome sizes (default:
                        chromosomeSize.txt)

Optional arguments:
  --format {schicluster,sparse-matrix-files}, -f {schicluster,sparse-matrix-files}
                        The format of the output files (default: schicluster)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicCreateBulkMatrix

### Tool Description
Sums all single-cell matrices of a scool file into one bulk cool matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicCreateBulkMatrix --matrix scool scHi-C matrix --outFileName
                             OUTFILENAME [--threads THREADS] [--help]
                             [--version]

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to cluster.
                        Needs to be in scool format (default: None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the exported cooler matrix. Please
                        add .cool appendix. (default: None)

Optional arguments:
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicInfo

### Tool Description
Prints information about a scool matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicInfo --matrix scool scHi-C matrix [--writeOutNames WRITEOUTNAMES]
                 [--help] [--version]

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to
                        investigate for QC. Needs to be in scool format
                        (default: None)

Optional arguments:
  --writeOutNames WRITEOUTNAMES, -w WRITEOUTNAMES
                        Write out the names of the individual cells to the
                        here specified file. (default: None)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicManageScool

### Tool Description
Extracts cool files from a scool file or updates a scool file to the format of scHiCExplorer 5.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicManageScool --matrix MATRIX --outFileName OUTFILENAME
                        [--action {update,extractToCool,extractScool}]
                        [--cellList CELLLIST] [--threads THREADS] [--help]
                        [--version]

This script offers methods to extract cool files or to update a scool file for
scHiCExplorer version 5

Required arguments:
  --matrix MATRIX, -m MATRIX
                        The scool matrix (default: None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the exported matrix, in case of
                        extract the folder name (default: None)

Optional arguments:
  --action {update,extractToCool,extractScool}, -a {update,extractToCool,extractScool}
                        The different actions this tool is able to do. Update
                        can be used to update scool files from scHiCExplorer
                        version 4 to the file format as it is used starting
                        from scHiCExplorer 5.ExtractToCool extracts either a
                        given scool file to individual cool files or only a
                        subset given by a list. ExtractScool requires a list
                        of internal cells that should be copied to a new scool
                        file. (default: none)
  --cellList CELLLIST, -cl CELLLIST
                        A text file with the cells that should be extracted or
                        copied to the a new scool file. (default: None)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicMergeToSCool

### Tool Description
Creates one scool file from n cool files.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicMergeToSCool --matrices MATRICES [MATRICES ...] --outFileName
                         OUTFILENAME [--threads THREADS] [--help] [--version]

Creates out of n cool files one scool file.

Required arguments:
  --matrices MATRICES [MATRICES ...], -m MATRICES [MATRICES ...]
                        input file(s). (default: None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the exported matrix. (default: None)

Optional arguments:
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicPlotClusterProfiles

### Tool Description
Plots the short to long range contact ratio profiles of the clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicPlotClusterProfiles --matrix scool scHi-C matrix --clusters
                                cluster file
                                [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                                [--maximalDistance MAXIMALDISTANCE]
                                [--distanceShortRange DISTANCESHORTRANGE]
                                [--distanceLongRange DISTANCELONGRANGE]
                                [--orderBy {svl,orderByFile}]
                                [--fontsize FONTSIZE] [--rotationX ROTATIONX]
                                [--ticks | --legend]
                                [--outFileName OUTFILENAME] [--dpi DPI]
                                [--colorMap COLORMAP] [--threads THREADS]
                                [--help] [--version]

optional arguments:
  --ticks               Plot the cluster names as ticks. Use legend if they
                        overlap. (default: False)
  --legend              Plot the cluster names as legend. Might be helpful if
                        the ticks overlap. (default: False)

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to
                        investigate for QC. Needs to be in scool format
                        (default: None)
  --clusters cluster file, -c cluster file
                        Text file which contains per matrix the associated
                        cluster. (default: None)

Optional arguments:
  --chromosomes CHROMOSOMES [CHROMOSOMES ...]
                        List of to be plotted chromosomes (default: None)
  --maximalDistance MAXIMALDISTANCE, -md MAXIMALDISTANCE
                        Maximal distance in bases to consider for ratio
                        computation. (default: 50000000)
  --distanceShortRange DISTANCESHORTRANGE, -ds DISTANCESHORTRANGE
                        Distance which should be considered as lower distance
                        for svl ordering. Values from distances smaller this
                        value are not considered. Default 2MB. (default:
                        2000000)
  --distanceLongRange DISTANCELONGRANGE, -dl DISTANCELONGRANGE
                        Distance which should be considered as upper distance
                        for svl ordering. Values from distances greater this
                        value are not considered. Default 12MB. (default:
                        12000000)
  --orderBy {svl,orderByFile}, -ob {svl,orderByFile}
                        Algorithm to cluster the Hi-C matrices (default: svl)
  --fontsize FONTSIZE   Fontsize in the plot for x and y axis. (default: 10)
  --rotationX ROTATIONX
                        Rotation in degrees for the labels of x axis.
                        (default: 0)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the resulting cluster profile.
                        (default: clusters_profile.png)
  --dpi DPI, -d DPI     The dpi of the plot. (default: 300)
  --colorMap COLORMAP   Color map to use for the heatmap. Available values can
                        be seen here: http://matplotlib.org/examples/color/col
                        ormaps_reference.html (default: RdYlBu_r)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicQualityControl

### Tool Description
Quality control of single-cell Hi-C matrices: filters cells by read coverage and density.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicQualityControl --matrix scool scHi-C matrix
                           [--outputScool OUTPUTSCOOL]
                           [--minimumReadCoverage MINIMUMREADCOVERAGE]
                           [--minimumDensity MINIMUMDENSITY]
                           [--maximumRegionToConsider MAXIMUMREGIONTOCONSIDER]
                           [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                           [--outFileNameDensity OUTFILENAMEDENSITY]
                           [--outFileNameReadCoverage OUTFILENAMEREADCOVERAGE]
                           [--outFileNameQCReport OUTFILENAMEQCREPORT]
                           [--plotOnly] [--runChromosomeCheck] [--dpi DPI]
                           [--threads THREADS] [--help] [--version]

Required arguments:
  --matrix scool scHi-C matrix, -m scool scHi-C matrix
                        The single cell Hi-C interaction matrices to
                        investigate for QC. Needs to be in scool format
                        (default: None)

Optional arguments:
  --outputScool OUTPUTSCOOL, -o OUTPUTSCOOL
                        scool matrix which contains only the filtered matrices
                        (default: filtered_matrices.scool)
  --minimumReadCoverage MINIMUMREADCOVERAGE
                        Remove all samples with a lower read coverage as this
                        value. (default: 1000000)
  --minimumDensity MINIMUMDENSITY
                        Remove all samples with a lower density as this value.
                        The density is given by: number of non-zero
                        interactions / all possible interactions. (default:
                        0.001)
  --maximumRegionToConsider MAXIMUMREGIONTOCONSIDER
                        To compute the density, consider only this genomic
                        distance around the diagonal. (default: 30000000)
  --chromosomes CHROMOSOMES [CHROMOSOMES ...], -c CHROMOSOMES [CHROMOSOMES ...]
                        List of chromosomes that a cell needs to have to be
                        not deleted. However, other chromosomes/contigs and
                        scaffolds which may exist are not deleted. Use
                        scHicAdjustMatrix for this. (default: None)
  --outFileNameDensity OUTFILENAMEDENSITY, -od OUTFILENAMEDENSITY
                        File name of the density histogram (default:
                        density.png)
  --outFileNameReadCoverage OUTFILENAMEREADCOVERAGE, -or OUTFILENAMEREADCOVERAGE
                        File name of the read coverage (default:
                        readCoverage.png)
  --outFileNameQCReport OUTFILENAMEQCREPORT, -oqc OUTFILENAMEQCREPORT
                        File name of the quality report (default:
                        qc_report.txt)
  --plotOnly            Do not create a new matrix, create only the plots.
                        (default: False)
  --runChromosomeCheck  Skip the data integrity check for the chromosomes.
                        (default: False)
  --dpi DPI, -d DPI     The dpi of the plot. (default: 300)
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## schicexplorer_scHicTxtToSCool

### Tool Description
Creates one scool file from n text files from Ramani 2017.

### Metadata
- **Docker Image**: quay.io/biocontainers/schicexplorer:7--py_0
- **Homepage**: https://github.com/joachimwolff/scHiCExplorer
- **Package**: https://anaconda.org/channels/bioconda/packages/schicexplorer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scHicTxtToSCool --matrices MATRICES [MATRICES ...] --chromosomeSizes
                       CHROMOSOMESIZES --resolution RESOLUTION --outFileName
                       OUTFILENAME [--threads THREADS] [--help] [--version]

Creates out of n txt files from Ramani 2017 one scool file.

Required arguments:
  --matrices MATRICES [MATRICES ...], -m MATRICES [MATRICES ...]
                        input file(s). (default: None)
  --chromosomeSizes CHROMOSOMESIZES, -cs CHROMOSOMESIZES
                        Text file with two columns, first column is the name
                        of the chromosome, second one its length. (default:
                        None)
  --resolution RESOLUTION, -r RESOLUTION
                        The resolution of the matrix. (default: None)
  --outFileName OUTFILENAME, -o OUTFILENAME
                        File name to save the scool matrix. (default: None)

Optional arguments:
  --threads THREADS, -t THREADS
                        Number of threads. Using the python multiprocessing
                        module. (default: 4)
  --help, -h            show this help message and exit
  --version             show program's version number and exit
```

## Metadata
- **Skill**: generated
