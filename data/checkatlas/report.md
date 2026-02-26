# checkatlas CWL Generation Report

## checkatlas

### Tool Description
CheckAtlas is a one liner tool to check the quality of your single-cell atlases. For every atlas, it produces the quality control tables and figures which can be then processed by multiqc. CheckAtlas is able to load Scanpy, Seurat, and CellRanger files.

### Metadata
- **Docker Image**: quay.io/biocontainers/checkatlas:0.7.1--pyhdfd78af_0
- **Homepage**: https://checkatlas.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/checkatlas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/checkatlas/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-10-20
- **GitHub**: https://github.com/becavin-lab/checkatlas
- **Stars**: N/A
### Original Help Text
```text
usage: checkatlas [OPTIONS] process atlas_name your_search_folder/

CheckAtlas is a one liner tool to check the quality of your single-cell
atlases. For every atlas, it produces the quality control tables and figures
which can be then processed by multiqc. CheckAtlas is able to load Scanpy,
Seurat, and CellRanger files.

positional arguments:
  process               Required argument: Type of process to run among
                        ['summary', 'qc', 'metric_cluster', 'metric_annot',
                        'metric_dimred']
  atlas_name            Required argument: The name of the atlas to
                        process.Atlas_name should be found in one of the
                        samplesheet provided tonf-checkatlas, or directly
                        created by checkatlas.list_all_atlases() function
  path                  Required argument: Your folder containing Scanpy,
                        CellRanger and Seurat atlasesv

options:
  -h, --help            show this help message and exit
  -d, --debug           Print out all debug messages.
  -v, --version         Display checkatlas version.

QC options:
  --qc_display QC_DISPLAY [QC_DISPLAY ...]
                        List of QC to display. Available qc = violin_plot,
                        total_counts, n_genes_by_counts, pct_counts_mt.
                        Default: --qc_display violin_plot total_counts
                        n_genes_by_counts pct_counts_mt
  --plot_celllimit PLOT_CELLLIMIT
                        Set the maximum number of cellsto plot in QC, UMAP,
                        t-SNE, etc....If plot_celllimit=0, no limit willbe
                        applied.

Metric options:
  --obs_cluster OBS_CLUSTER [OBS_CLUSTER ...]
                        List of obs from the adata file to use in the
                        clustering metric calculus.Example: --obs_cluster
                        celltype leuven seurat_clusters
  --metric_cluster METRIC_CLUSTER [METRIC_CLUSTER ...]
                        Specify the list of clustering metrics to calculate.
                        Example: --metric_cluster silhouette davies_bouldin
                        List of cluster metrics: ['silhouette',
                        'davies_bouldin', 'calinski_harabasz']
  --metric_annot METRIC_ANNOT [METRIC_ANNOT ...]
                        Specify the list of clustering metrics to calculate.
                        Example: --metric_annot rand_index List of annotation
                        metrics: ['rand_index', 'fowlkes_mallow',
                        'adj_mutual_info', 'vmeasure', 'dunn_index',
                        'adj_rand_index', 'normalized_mutual_info',
                        'mutual_info', 'isolated_f1_score']
  --metric_dimred METRIC_DIMRED [METRIC_DIMRED ...]
                        Specify the list of dimensionality reduction metrics
                        to calculate. Example: --metric_dimred kruskal_stress
                        List of dim. red. metrics: ['kruskal_stress',
                        'spearman_rho', 'entourage']

Enjoy the checkatlas functionality!
```

