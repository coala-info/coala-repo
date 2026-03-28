Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[PopPUNK 2.7.0 documentation](index.html)

[![Logo](_static/poppunk_v2.png)

PopPUNK 2.7.0 documentation](index.html)

Contents:

* [PopPUNK documentation](index.html)
* [Installation](installation.html)
* [Overview](overview.html)
* [Sketching (`--create-db`)](sketching.html)
* [Data quality control (`--qc-db`)](qc.html)
* [Fitting new models (`--fit-model`)](model_fitting.html)
* [Distributing PopPUNK models](model_distribution.html)
* [Query assignment (`poppunk_assign`)](query_assignment.html)
* [Creating visualisations](visualisation.html)
* [Minimum spanning trees](mst.html)
* [Subclustering with PopPIPE](subclustering.html)
* [Using GPUs](gpu.html)
* [Troubleshooting](troubleshooting.html)
* [Scripts](scripts.html)
* [Iterative PopPUNK](poppunk_iterate.html)
* [Citing PopPUNK](citing.html)
* Reference documentation
* [Roadmap](roadmap.html)
* [Miscellaneous](miscellaneous.html)

Back to top

[View this page](_sources/api.rst.txt "View this page")

# Reference documentation[¶](#reference-documentation "Link to this heading")

Documentation for module functions (for developers)

## assign.py[¶](#assign-py "Link to this heading")

`poppunk_assign` main function

PopPUNK.assign.assign\_query(*dbFuncs*, *ref\_db*, *q\_files*, *output*, *qc\_dict*, *update\_db*, *write\_references*, *distances*, *serial*, *stable*, *threads*, *overwrite*, *plot\_fit*, *graph\_weights*, *model\_dir*, *strand\_preserved*, *previous\_clustering*, *external\_clustering*, *core*, *accessory*, *gpu\_sketch*, *gpu\_dist*, *gpu\_graph*, *deviceid*, *save\_partial\_query\_graph*, *use\_full\_network*)[[source]](_modules/PopPUNK/assign.html#assign_query)[¶](#PopPUNK.assign.assign_query "Link to this definition")
:   Code for assign query mode for CLI

PopPUNK.assign.assign\_query\_hdf5(*dbFuncs*, *ref\_db*, *qNames*, *output*, *qc\_dict*, *update\_db*, *write\_references*, *distances*, *serial*, *stable*, *threads*, *overwrite*, *plot\_fit*, *graph\_weights*, *model\_dir*, *strand\_preserved*, *previous\_clustering*, *external\_clustering*, *core*, *accessory*, *gpu\_dist*, *gpu\_graph*, *save\_partial\_query\_graph*, *use\_full\_network*)[[source]](_modules/PopPUNK/assign.html#assign_query_hdf5)[¶](#PopPUNK.assign.assign_query_hdf5 "Link to this definition")
:   Code for assign query mode taking hdf5 as input. Written as a separate function so it can be called
    by web APIs

PopPUNK.assign.main()[[source]](_modules/PopPUNK/assign.html#main)[¶](#PopPUNK.assign.main "Link to this definition")
:   Main function. Parses cmd line args and runs in the specified mode.

## bgmm.py[¶](#bgmm-py "Link to this heading")

Functions used to fit the mixture model to a database. Access using
[`BGMMFit`](#PopPUNK.models.BGMMFit "PopPUNK.models.BGMMFit").

BGMM using sklearn

PopPUNK.bgmm.findBetweenLabel\_bgmm(*means*, *assignments*)[[source]](_modules/PopPUNK/bgmm.html#findBetweenLabel_bgmm)[¶](#PopPUNK.bgmm.findBetweenLabel_bgmm "Link to this definition")
:   Identify between-strain links

    Finds the component with the largest number of points
    assigned to it

    Args:
    :   means (numpy.array)
        :   K x 2 array of mixture component means

        assignments (numpy.array)
        :   Sample cluster assignments

    Returns:
    :   between\_label (int)
        :   The cluster label with the most points assigned to it

PopPUNK.bgmm.findWithinLabel(*means*, *assignments*, *rank=0*)[[source]](_modules/PopPUNK/bgmm.html#findWithinLabel)[¶](#PopPUNK.bgmm.findWithinLabel "Link to this definition")
:   Identify within-strain links

    Finds the component with mean closest to the origin and also makes sure
    some samples are assigned to it (in the case of small weighted
    components with a Dirichlet prior some components are unused)

    Args:
    :   means (numpy.array)
        :   K x 2 array of mixture component means

        assignments (numpy.array)
        :   Sample cluster assignments

        rank (int)
        :   Which label to find, ordered by distance from origin. 0-indexed.
            (default = 0)

    Returns:
    :   within\_label (int)
        :   The cluster label for the within-strain assignments

PopPUNK.bgmm.fit2dMultiGaussian(*X*, *dpgmm\_max\_K=2*)[[source]](_modules/PopPUNK/bgmm.html#fit2dMultiGaussian)[¶](#PopPUNK.bgmm.fit2dMultiGaussian "Link to this definition")
:   Main function to fit BGMM model, called from [`fit()`](#PopPUNK.models.BGMMFit.fit "PopPUNK.models.BGMMFit.fit")

    Fits the mixture model specified, saves model parameters to a file, and assigns the samples to
    a component. Write fit summary stats to STDERR.

    Args:
    :   X (np.array)
        :   n x 2 array of core and accessory distances for n samples.
            This should be subsampled to 100000 samples.

        dpgmm\_max\_K (int)
        :   Maximum number of components to use with the EM fit.
            (default = 2)

    Returns:
    :   dpgmm (sklearn.mixture.BayesianGaussianMixture)
        :   Fitted bgmm model

PopPUNK.bgmm.log\_likelihood(*X*, *weights*, *means*, *covars*, *scale*)[[source]](_modules/PopPUNK/bgmm.html#log_likelihood)[¶](#PopPUNK.bgmm.log_likelihood "Link to this definition")
:   modified sklearn GMM function predicting distribution membership

    Returns the mixture LL for points X. Used by `assign_samples()` and
    [`plot_contours()`](#PopPUNK.plot.plot_contours "PopPUNK.plot.plot_contours")

    Args:
    :   X (numpy.array)
        :   n x 2 array of core and accessory distances for n samples

        weights (numpy.array)
        :   Component weights from [`fit2dMultiGaussian()`](#PopPUNK.bgmm.fit2dMultiGaussian "PopPUNK.bgmm.fit2dMultiGaussian")

        means (numpy.array)
        :   Component means from [`fit2dMultiGaussian()`](#PopPUNK.bgmm.fit2dMultiGaussian "PopPUNK.bgmm.fit2dMultiGaussian")

        covars (numpy.array)
        :   Component covariances from [`fit2dMultiGaussian()`](#PopPUNK.bgmm.fit2dMultiGaussian "PopPUNK.bgmm.fit2dMultiGaussian")

        scale (numpy.array)
        :   Scaling of core and accessory distances from [`fit2dMultiGaussian()`](#PopPUNK.bgmm.fit2dMultiGaussian "PopPUNK.bgmm.fit2dMultiGaussian")

    Returns:
    :   logprob (numpy.array)
        :   The log of the probabilities under the mixture model

        lpr (numpy.array)
        :   The components of the log probability from each mixture component

PopPUNK.bgmm.log\_multivariate\_normal\_density(*X*, *means*, *covars*, *min\_covar=1e-07*)[[source]](_modules/PopPUNK/bgmm.html#log_multivariate_normal_density)[¶](#PopPUNK.bgmm.log_multivariate_normal_density "Link to this definition")
:   Log likelihood of multivariate normal density distribution

    Used to calculate per component Gaussian likelihood in
    `assign_samples()`

    Args:
    :   X (numpy.array)
        :   n x 2 array of core and accessory distances for n samples

        means (numpy.array)
        :   Component means from [`fit2dMultiGaussian()`](#PopPUNK.bgmm.fit2dMultiGaussian "PopPUNK.bgmm.fit2dMultiGaussian")

        covars (numpy.array)
        :   Component covariances from [`fit2dMultiGaussian()`](#PopPUNK.bgmm.fit2dMultiGaussian "PopPUNK.bgmm.fit2dMultiGaussian")

        min\_covar (float)
        :   Minimum covariance, added when Choleksy decomposition fails
            due to too few observations (default = 1.e-7)

    Returns:
    :   log\_prob (numpy.array)
        :   An n-vector with the log-likelihoods for each sample being in
            this component

## dbscan.py[¶](#dbscan-py "Link to this heading")

Functions used to fit DBSCAN to a database. Access using
[`DBSCANFit`](#PopPUNK.models.DBSCANFit "PopPUNK.models.DBSCANFit").

DBSCAN using hdbscan

PopPUNK.dbscan.evaluate\_dbscan\_clusters(*model*)[[source]](_modules/PopPUNK/dbscan.html#evaluate_dbscan_clusters)[¶](#PopPUNK.dbscan.evaluate_dbscan_clusters "Link to this definition")
:   Evaluate whether fitted dbscan model contains non-overlapping clusters

    Args:
    :   model (DBSCANFit)
        :   Fitted model from [`fit()`](#PopPUNK.models.DBSCANFit.fit "PopPUNK.models.DBSCANFit.fit")

    Returns:
    :   indistinct (bool)
        :   Boolean indicating whether putative within- and
            between-strain clusters of points overlap

PopPUNK.dbscan.findBetweenLabel(*assignments*, *within\_cluster*)[[source]](_modules/PopPUNK/dbscan.html#findBetweenLabel)[¶](#PopPUNK.dbscan.findBetweenLabel "Link to this definition")
:   Identify between-strain links from a DBSCAN model

    Finds the component containing the largest number of between-strain
    links, excluding the cluster identified as containing within-strain
    links.

    Args:
    :   assignments (numpy.array)
        :   Sample cluster assignments

        within\_cluster (int)
        :   Cluster ID assigned to within-strain assignments, from [`findWithinLabel()`](#PopPUNK.bgmm.findWithinLabel "PopPUNK.bgmm.findWithinLabel")

    Returns:
    :   between\_cluster (int)
        :   The cluster label for the between-strain assignments

PopPUNK.dbscan.fitDbScan(*X*, *min\_samples*, *min\_cluster\_size*, *cache\_out*, *use\_gpu=False*)[[source]](_modules/PopPUNK/dbscan.html#fitDbScan)[¶](#PopPUNK.dbscan.fitDbScan "Link to this definition")
:   Function to fit DBSCAN model as an alternative to the Gaussian

    Fits the DBSCAN model to the distances using hdbscan

    Args:
    :   X (np.array)
        :   n x 2 array of core and accessory distances for n samples

        min\_samples (int)
        :   Parameter for DBSCAN clustering ‘conservativeness’

        min\_cluster\_size (int)
        :   Minimum number of points in a cluster for HDBSCAN

        cache\_out (str)
        :   Prefix for DBSCAN cache used for refitting

        use\_gpu (bool)
        :   Whether GPU algorithms should be used in DBSCAN fitting

    Returns:
    :   hdb (hdbscan.HDBSCAN or cuml.cluster.HDBSCAN)
        :   Fitted HDBSCAN to subsampled data

        labels (list)
        :   Cluster assignments of each sample

        n\_clusters (int)
        :   Number of clusters used

## mandrake.py[¶](#module-PopPUNK.mandrake "Link to this heading")

PopPUNK.mandrake.generate\_embedding(*seqLabels*, *accMat*, *perplexity*, *outPrefix*, *overwrite*, *kNN=50*, *maxIter=10000000*, *n\_threads=1*, *use\_gpu=False*, *device\_id=0*)[[source]](_modules/PopPUNK/mandrake.html#generate_embedding)[¶](#PopPUNK.mandrake.generate_embedding "Link to this definition")
:   Generate t-SNE projection using accessory distances

    Writes a plot of t-SNE clustering of accessory distances (.dot)

    Args:
    :   seqLabels (list)
        :   Processed names of sequences being analysed.

        accMat (numpy.array)
        :   n x n array of accessory distances for n samples.

        perplexity (int)
        :   Perplexity parameter passed to t-SNE

        outPrefix (str)
        :   Prefix for all generated output files, which will be placed in
            outPrefix subdirectory

        overwrite (bool)
        :   Overwrite existing output if present
            (default = False)

        kNN (int)
        :   Number of neigbours to use with SCE (cannot be > n\_samples)
            (default = 50)

        maxIter (int)
        :   Number of iterations to run
            (default = 1000000)

        n\_threads (int)
        :   Number of CPU threads to use
            (default = 1)

        use\_gpu (bool)
        :   Whether to use GPU libraries

        device\_id (int)
        :   Device ID of GPU to be used
            (default = 0)

    Returns:
    :   mandrake\_filename (str)
        :   Filename with .dot of embedding

## models.py[¶](#module-PopPUNK.models "Link to this heading")

Classes used for model fits

*class* PopPUNK.models.BGMMFit(*outPrefix*, *max\_samples=100000*, *max\_batch\_size=100000*, *assign\_points=True*)[[source]](_modules/PopPUNK/models.html#BGMMFit)[¶](#PopPUNK.models.BGMMFit "Link to this definition")
:   Class for fits using the Gaussian mixture model. Inherits from [`ClusterFit`](#PopPUNK.models.ClusterFit "PopPUNK.models.ClusterFit").

    Must first run either [`fit()`](#PopPUNK.models.BGMMFit.fit "PopPUNK.models.BGMMFit.fit") or [`load()`](#PopPUNK.models.BGMMFit.load "PopPUNK.models.BGMMFit.load") before calling
    other functions

    Args:
    :   outPrefix (str)
        :   The output prefix used for reading/writing

        max\_samples (int)
        :   The number of subsamples to fit the model to
            (default = 100000)

    assign(*X*, *max\_batch\_size=100000*, *values=False*, *progress=True*)[[source]](_modules/PopPUNK/models.html#BGMMFit.assign)[¶](#PopPUNK.models.BGMMFit.assign "Link to this definition")
    :   Assign the clustering of new samples using `assign_samples()`

        Args:
        :   X (numpy.array)
            :   Core and accessory distances

            values (bool)
            :   Return the responsibilities of assignment rather than most likely cluster

            max\_batch\_size (int)
            :   Size of batches to be assigned

            progress (bool)
            :   Show progress bar

                [default = True]

        Returns:
        :   y (numpy.array)
            :   Cluster assignments or values by samples

    fit(*X*, *max\_components*)[[source]](_modules/PopPUNK/models.html#BGMMFit.fit)[¶](#PopPUNK.models.BGMMFit.fit "Link to this definition")
    :   Extends [`fit()`](#PopPUNK.models.ClusterFit.fit "PopPUNK.models.ClusterFit.fit")

        Fits the BGMM and returns assignments by calling
        [`fit2dMultiGaussian()`](#PopPUNK.bgmm.fit2dMultiGaussian "PopPUNK.bgmm.fit2dMultiGaussian").

        Fitted parameters are stored in the object.

        Args:
        :   X (numpy.array)
            :   The core and accessory distances to cluster. Must be set if
                preprocess is set.

            max\_components (int)
            :   Maximum number of mixture components to use.

        Returns:
        :   y (numpy.array)
            :   Cluster assignments of samples in X

    load(*fit\_npz*, *fit\_obj*)[[source]](_modules/PopPUNK/models.html#BGMMFit.load)[¶](#PopPUNK.models.BGMMFit.load "Link to this definition")
    :   Load the model from disk. Called from [`loadClusterFit()`](#PopPUNK.models.loadClusterFit "PopPUNK.models.loadClusterFit")

        Args:
        :   fit\_npz (dict)
            :   Fit npz opened with `numpy.load()`

            fit\_obj (sklearn.mixture.BayesianGaussianMixture)
            :   The saved fit object

    plot(*X*, *y*)[[source]](_modules/PopPUNK/models.html#BGMMFit.plot)[¶](#PopPUNK.models.BGMMFit.plot "Link to this definition")
    :   Extends [`plot()`](#PopPUNK.models.ClusterFit.plot "PopPUNK.models.ClusterFit.plot")

        Write a summary of the fit, and plot the results using
        [`PopPUNK.plot.plot_results()`](#PopPUNK.pl