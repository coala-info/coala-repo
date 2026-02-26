# halla CWL Generation Report

## halla

### Tool Description
HAllA: Hierarchical All-against-All significance association testing version 0.8.40

### Metadata
- **Docker Image**: quay.io/biocontainers/halla:0.8.40--pyhdfd78af_0
- **Homepage**: http://huttenhower.sph.harvard.edu/halla
- **Package**: https://anaconda.org/channels/bioconda/packages/halla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/halla/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-10-31
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: halla [-h] -x X_FILE [-y Y_FILE] [--alla]
             [--max_freq_thresh MAX_FREQ_THRESH]
             [--transform_data_funcs TRANSFORM_DATA_FUNCS [TRANSFORM_DATA_FUNCS ...]]
             [--disable_bypass_discretization_if_possible]
             [--discretize_func {None,quantile,kmeans,uniform,jenks}]
             [--discretize_num_bins DISCRETIZE_NUM_BINS]
             [-m {spearman,pearson,dcor,mi,nmi,xicor}]
             [--sim2dist_disable_abs] [--linkage_method LINKAGE_METHOD]
             [--permute_func {gpd,ecdf}] [--permute_iters PERMUTE_ITERS]
             [--disable_permute_speedup] [--fdr_alpha FDR_ALPHA]
             [--fdr_method FDR_METHOD] [--fnr_thresh FNR_THRESH]
             [--rank_cluster {best,average}] -o OUT_DIR [--disable_verbose]
             [--seed SEED] [--hallagram] [--no_hallagram] [--clustermap]
             [--x_dataset_label X_DATASET_LABEL]
             [--y_dataset_label Y_DATASET_LABEL] [--cbar_label CBAR_LABEL]
             [-n BLOCK_NUM] [--trim TRIM] [--plot_file_type PLOT_TYPE]
             [--no_progress] [--dont_copy] [--force_permutations]
             [--num_threads NUM_THREADS] [--version]
             [--dont_skip_large_blocks]
             [--large_diagnostic_subset LARGE_DIAGNOSTIC_SUBSET]
             [--splitting_diagnostic_mode]
             [--gini_uncertainty_level GINI_UNCERTAINTY_LEVEL]
             [--diagnostic_plot]

HAllA: Hierarchical All-against-All significance association testing version
0.8.40

options:
  -h, --help            show this help message and exit
  -x, --x_file X_FILE   Path to X dataset: a tab-delimited input file, one row
                        per feature, one column per measurement
  -y, --y_file Y_FILE   Path to Y dataset: a tab-delimited input file, one row
                        per feature, one column per measurement
  --alla                Use AllA instead of HAllA
  --max_freq_thresh MAX_FREQ_THRESH
                        The maximum frequency threshold - features with max
                        frequences >= the threshold will be removed
  --transform_data_funcs TRANSFORM_DATA_FUNCS [TRANSFORM_DATA_FUNCS ...]
                        Continuous data transformation function - a list
  --disable_bypass_discretization_if_possible
                        Disable bypassing discretization when all features are
                        continuous
  --discretize_func {None,quantile,kmeans,uniform,jenks}
                        Discretization - function {None, quantile, kmeans,
                        uniform, jenks}
  --discretize_num_bins DISCRETIZE_NUM_BINS
                        Discretization - number of bins
  -m, --pdist_metric {spearman,pearson,dcor,mi,nmi,xicor}
                        Distance/similarity metric {spearman, pearson, dcor,
                        mi, nmi, xicor}
  --sim2dist_disable_abs
                        Hierarchical clustering - disable setting similarity
                        scores as absolute when computing distance
  --linkage_method LINKAGE_METHOD
                        Hierarchical clustering linkage method - check
                        scipy.cluster.hierarchy.linkage()
  --permute_func {gpd,ecdf}
                        P-value approximation function in the p-value
                        permutation test
  --permute_iters PERMUTE_ITERS
                        # iterations in the p-value permutation test
  --disable_permute_speedup
                        Disable breaking early in the permutation test if
                        p-value is insignificant
  --fdr_alpha FDR_ALPHA
                        FDR threshold
  --fdr_method FDR_METHOD
                        FDR method - check
                        statsmodels.stats.multitest.multipletests()
  --fnr_thresh FNR_THRESH
                        FNR threshold
  --rank_cluster {best,average}
                        Procedure to rank cluster using the p-values within
                        the cluster {best, average}
  -o, --out_dir OUT_DIR
                        Directory path to store results
  --disable_verbose     Disable verbose
  --seed SEED           Randomization seed
  --hallagram           Generates hallagram
  --no_hallagram        Turn off the automatically generated hallagram
  --clustermap          Generates clustermap
  --x_dataset_label X_DATASET_LABEL
                        Hallagram/clustermap: label for X dataset
  --y_dataset_label Y_DATASET_LABEL
                        Hallagram/clustermap: label for Y dataset
  --cbar_label CBAR_LABEL
                        Hallagram/clustermap: label for the colorbar
  -n, --block_num BLOCK_NUM
                        Number of top clusters to show (for hallagram only);
                        if -1, show all clusters
  --trim TRIM           Trim hallagram to features containing at least one
                        significant block
  --plot_file_type PLOT_TYPE
                        File type of hallagram output
  --no_progress         Turn off the progress bar for p-value table
                        calculations
  --dont_copy           Don't make a copy of the data files in the output
                        directory
  --force_permutations  If turned on, force permutation testing
  --num_threads NUM_THREADS
                        Number of threads to use when running permutation
                        tests in parallel, default=4
  --version             show program's version number and exit
  --dont_skip_large_blocks
                        Don't skip very large (>45 features) blocks in
                        diagnostic plots
  --large_diagnostic_subset LARGE_DIAGNOSTIC_SUBSET
                        Subset the feature pairs plotted in large block (>15,
                        <45) diagnostic plots.
  --splitting_diagnostic_mode
                        Diagnostic mode to write out tree descent algorithm
                        progress. Prints branches being considered at each
                        step and Gini score improvement (the latter only if
                        applicable). Values listed in brackets are indices
                        (0-indexed) of features in X and Y datasets
                        respectively.
  --gini_uncertainty_level GINI_UNCERTAINTY_LEVEL
                        Gini uncertainty mode opts to split larger
                        hierarchical branches when the difference in Gini
                        impurity improvement is less than the given level.
  --diagnostic_plot     Generates diagnostic plot
```

