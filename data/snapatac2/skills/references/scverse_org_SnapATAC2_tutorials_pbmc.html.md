[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[SnapATAC2](../index.html)

Choose version

* [Installation](../install.html)
* [Tutorials](index.html)
* [API reference](../api/index.html)
* [Development](../develop.html)
* [Release notes](../changelog.html)
* [Learn](https://kzhang.org/epigenomics-analysis/)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/scverse/SnapATAC2 "GitHub")

Search
`Ctrl`+`K`

Choose version

* [Installation](../install.html)
* [Tutorials](index.html)
* [API reference](../api/index.html)
* [Development](../develop.html)
* [Release notes](../changelog.html)
* [Learn](https://kzhang.org/epigenomics-analysis/)

* [GitHub](https://github.com/scverse/SnapATAC2 "GitHub")

Section Navigation

* Standard pipeline: analyzing 5K PBMC dataset from 10X genomics
* [Annotating cell clusters by integrating single-cell RNA-seq data](annotation.html)
* [Identify differentially accessible regions](diff.html)
* [Multi-sample Pipeline: analyzing snATAC-seq data of human colon samples](integration.html)
* [Multi-modality pipeline: analyzing single-cell multiome data (ATAC + Gene Expression)](modality.html)
* [Atlas-scale Analysis: a cell atlas of human chromatin accessibility.](atlas.html)

* [Tutorials](index.html)
* Standard pipeline: analyzing 5K PBMC dataset from 10X genomics

# Standard pipeline: analyzing 5K PBMC dataset from 10X genomics[#](#Standard-pipeline:-analyzing-5K-PBMC-dataset-from-10X-genomics "Link to this heading")

## Introduction[#](#Introduction "Link to this heading")

In this tutorial we will analyze single-cell ATAC-seq data from Peripheral blood mononuclear cells (PBMCs).

## Import library and environment setup[#](#Import-library-and-environment-setup "Link to this heading")

```
[1]:
```

```
import snapatac2 as snap

snap.__version__
```

```
[1]:
```

```
'2.9.0.dev1'
```

To start, we need to download a fragment file. This can be achieved by calling the function below.

```
[2]:
```

```
# Input files
fragment_file = snap.datasets.pbmc5k()
fragment_file
```

```
[2]:
```

```
PosixPath('/data/kzhang/.cache/snapatac2/atac_pbmc_5k.tsv.gz')
```

A fragment file refers to a file containing information about the fragments of DNA that are accessible and have been sequenced. Here are more information about the [Fragment File](https://support.10xgenomics.com/single-cell-atac/software/pipelines/latest/output/fragments).

If you do not have a fragment file for your experiment, you can make one from a BAM file, see [pp.make\_fragment\_file()](../api/_autosummary/snapatac2.pp.make_fragment_file.html#snapatac2.pp.make_fragment_file).

## Preprocessing[#](#Preprocessing "Link to this heading")

We begin data preprocessing by importing fragment files and calculating basic quality control (QC) metrics using the [pp.import\_fragments()](../api/_autosummary/snapatac2.pp.import_fragments.html#snapatac2.pp.import_fragments) function.

This function compresses and stores the fragments in an AnnData object for later usage(To learn more about SnapATAC2’s anndata implementation, click [here](https://kzhang.org/epigenomics-analysis/anndata.html)). During this process, various quality control measures, such as TSS enrichment and the number of unique fragments per cell, are computed and stored in the anndata as well.

When the `file` argument is not specified, the AnnData object is created and stored in the computer’s memory. However, if the `file` argument is provided, the AnnData object will be backed by an hdf5 file. In “backed” mode, [pp.import\_fragments()](../api/_autosummary/snapatac2.pp.import_fragments.html#snapatac2.pp.import_fragments) processes the data in chunks and streams the results to the disk, using only a small, fixed amount of memory. Therefore, it is recommended to specify the
`file` parameter when working with large datasets and limited memory resources. Keep in mind that analyzing data in “backed” mode is slightly slower than in “memory” mode.

In this tutorial we will use the backed mode. To learn more about the differences between these two modes, click [here](https://kzhang.org/epigenomics-analysis/anndata.html).

```
[3]:
```

```
%%time
data = snap.pp.import_fragments(
    fragment_file,
    chrom_sizes=snap.genome.hg38,
    file="pbmc.h5ad",  # Optional
    sorted_by_barcode=False,
)
data
```

```
CPU times: user 6min 36s, sys: 19.6 s, total: 6min 55s
Wall time: 2min 31s
```

```
[3]:
```

```
AnnData object with n_obs x n_vars = 14225 x 0 backed at 'pbmc.h5ad'
    obs: 'n_fragment', 'frac_dup', 'frac_mito'
    uns: 'reference_sequences'
    obsm: 'fragment_paired'
```

[pp.import\_fragments()](../api/_autosummary/snapatac2.pp.import_fragments.html#snapatac2.pp.import_fragments) computes only basic QC metrics like the number of unique fragments per cell, fraction of duplicated reads and fraction of mitochondrial read. More advanced metrics can be computed by other functions.

We first use [pl.frag\_size\_distr()](../api/_autosummary/snapatac2.pl.frag_size_distr.html#snapatac2.pl.frag_size_distr) to calculate and plot the size distribution of fragments in this dataset. The typical fragment size distribution in ATAC-seq data exhibits several key characteristics:

1. Nucleosome-Free Region (NFR): The majority of fragments are short, typically around 80-300 base pairs (bp) in length. These short fragments represent regions of open chromatin where DNA is relatively accessible and not bound to nucleosomes. These regions are often referred to as nucleosome-free regions (NFRs) and correspond to regions of active transcriptional regulation.
2. Mono-Nucleosome Peaks: There is often a peak in the fragment size distribution at around 147-200 bp, which corresponds to the size of a single nucleosome wrapped DNA. These fragments result from the cutting of DNA by the transposase enzyme when it encounters a nucleosome, causing the DNA to be protected and resulting in fragments of the same size.
3. Di-Nucleosome Peaks: In addition to the mono-nucleosome peak, you may also observe a smaller peak at approximately 300-400 bp, corresponding to di-nucleosome fragments. These fragments occur when transposase cuts the DNA between two neighboring nucleosomes.
4. Large Fragments: Some larger fragments, greater than 500 bp in size, may be observed. These fragments can result from various sources, such as the presence of longer stretches of open chromatin or technical artifacts.

```
[4]:
```

```
snap.pl.frag_size_distr(data, interactive=False)
```

```
2025-10-08 11:02:06 - INFO - Computing fragment size distribution...
```

```
[4]:
```

![../_images/tutorials_pbmc_9_1.png](../_images/tutorials_pbmc_9_1.png)

The plotting functions in SnapATAC2 can optionally return a plotly [Figure](https://plotly.com/python-api-reference/generated/plotly.graph_objects.Figure.html) object that can be further customized using plotly’s API. In the example below, we change the y-axis to log-scale.

```
[5]:
```

```
fig = snap.pl.frag_size_distr(data, show=False)
fig.update_yaxes(type="log")
fig.show()
```

Another important QC metric is TSS enrichment (TSSe). TSSe in ATAC-seq data implies that there is an increased accessibility or fragmentation of chromatin around the transcription start sites of genes. This is often indicative of open and accessible promoter regions, which are typically devoid of nucleosomes and are involved in active gene transcription.

Researchers often use TSS enrichment as a quality control metric in these assays. If there is a clear and pronounced enrichment of reads or signal around TSS regions, it suggests that the experiment has captured relevant genomic features and is likely to yield biologically meaningful results. Conversely, a lack of TSS enrichment may indicate issues with the experiment’s quality or data processing.

TSSe scores of individual cells can be computed using the [metrics.tsse()](../api/_autosummary/snapatac2.metrics.tsse.html#snapatac2.metrics.tsse) function.

```
[6]:
```

```
%%time
snap.metrics.tsse(data, snap.genome.hg38)
```

```
CPU times: user 1min 25s, sys: 6.36 s, total: 1min 32s
Wall time: 5.67 s
```

To identify usable/high-quality cells, we can plot TSSe scores against number of unique fragments for each cell.

```
[7]:
```

```
snap.pl.tsse(data, interactive=False)
```

```
[7]:
```

![../_images/tutorials_pbmc_15_0.png](../_images/tutorials_pbmc_15_0.png)

The cells in the upper right represent valid or high-quality cells, whereas those in the lower left represent low-quality cells or empty droplets. Based on this plot, we decided to set a minimum TSS enrichment of 10 and a minimum number of fragments of 5,000 to filter the cells.

```
[8]:
```

```
%%time
snap.pp.filter_cells(data, min_counts=5000, min_tsse=10, max_counts=100000)
data
```

```
CPU times: user 4.48 s, sys: 851 ms, total: 5.33 s
Wall time: 5.27 s
```

```
[8]:
```

```
AnnData object with n_obs x n_vars = 4563 x 0 backed at 'pbmc.h5ad'
    obs: 'n_fragment', 'frac_dup', 'frac_mito', 'tsse'
    uns: 'reference_sequences', 'TSS_profile', 'library_tsse', 'frag_size_distr', 'frac_overlap_TSS'
    obsm: 'fragment_paired'
```

We next create a cell by bin matrix containing insertion counts across genome-wide 500-bp bins.

```
[9]:
```

```
%%time
snap.pp.add_tile_matrix(data)
```

```
CPU times: user 55.2 s, sys: 3.16 s, total: 58.3 s
Wall time: 11.2 s
```

Next, we perform feature selection using [pp.select\_features()](../api/_autosummary/snapatac2.pp.select_features.html#snapatac2.pp.select_features). The result is stored in `data.var['selected']` and will be automatically utilized by relevant functions such as [pp.scrublet()](../api/_autosummary/snapatac2.pp.scrublet.html#snapatac2.pp.scrublet) and [tl.spectral()](../api/_autosummary/snapatac2.tl.spectral.html#snapatac2.tl.spectral).

The default feature selection algorithm chooses the most accessible features. The `n_features` parameter determines the number of features or bins used in subsequent analysis steps. Generally, including more features improves resolution and reveals finer details, but it may also introduce noise. To optimize results, experiment with the `n_features` parameter to find the most appropriate value for your specific dataset.

Additionally, you can provide a filter list to the function, such as a blacklist or whitelist. For example, use `pp.select_features(data, blacklist='blacklist.bed')`.

```
[10]:
```

```
snap.pp.select_features(data, n_features=250000)
```

```
2025-10-08 11:02:53 - INFO - Selected 250000 features.
```

### Doublet removal[#](#Doublet-removal "Link to this heading")

Here we apply a customized scrublet algorithm to identify potential doublets. Calling [pp.scrublet()](../api/_autosummary/snapatac2.pp.scrublet.html#snapatac2.pp.scrublet) will assign probabilites of being doublets to the cells. We can then use `pp.filter_doublets` to get the rid of the doublets.

```
[11]:
```

```
%%time
snap.pp.scrublet(data)
```

```
2025-10-08 11:02:56 - INFO - Simulating doublets...
2025-10-08 11:02:57 - INFO - Spectral embedding ...
2025-10-08 11:05:11 - INFO - Calculating doublet scores...
```

```
CPU times: user 3min 59s, sys: 2.33 s, total: 4min 2s
Wall time: 2min 19s
```

This line does the actual filtering.

```
[12]:
```

```
snap.pp.filter_doublets(data)
data
```

```
2025-10-08 11:05:12 - INFO - Detected doublet rate = 2.893%
```

```
[12]:
```

```
AnnData object with n_obs x n_vars = 4431 x 6062095 backed at 'pbmc.h5ad'
    obs: 'n_fragment', 'frac_dup', 'frac_mito', 'tsse', 'doublet_probability', 'doublet_score'
    var: 'count', 'selected'
    uns: 'reference_sequences', 'TSS_profile', 'library_tsse', 'frag_size_distr', 'scrublet_sim_doublet_score', 'doublet_rate', 'frac_overlap_TSS'
    obsm: 'fragment_paired'
```

## Dimension reduction[#](#Dimension-reduction "Link to this heading")

To calculate the lower-dimensional representation of single-cell chromatin profiles, we employ spectral embedding for dimensionality reduction. The resulting data is stored in `data.obsm['X_spectral']`. Comprehensive information about the dimension reduction algorithm we utilize can be found in the [algorithm documentation](https://kzhang.org/epigenomics-analysis/dim_reduct.html).

```
[13]:
```

```
%%time
snap.tl.spectral(data)
```

```
CPU times: user 27.1 s, sys: 737 ms, total: 27.8 s
Wall time: 26.2 s
```

We then use UMAP to embed the cells to 2-dimension space for visualization purpose. This step will have to be run after `snap.tl.spectral` as it uses the lower dimesnional representation created by the spectral embedding.

```
[14]:
```

```
%%time
snap.tl.umap(data)
```

```
/data/kzhang/micromamba/lib/python3.10/site-packages/sklearn/utils/deprecation.py:132: FutureWarning:

'force_all_finite' was renamed to 'ensure_all_finite' in 1.6 and will be removed in 1.8.

/data/kzhang/micromamba/lib/python3.10/site-packages/umap/umap_.py:1945: UserWarning:

n_jobs value 1 overridden to 1 by setting random_state. Use no seed for parallelism.
```

```
CPU times: user 27.8 s, sys: 103 ms, total: 27.9 s
Wall time: 25 s
```

## Clustering analysis[#](#Clustering-analysis "Link to this heading")

We next perform graph-based clustering to identify cell clusters. We first build a k-nearest neighbour graph using `snap.pp.knn`, and then use the Leiden community detection algorithm to identify densely-connected subgraphs/clusters in the graph.

```
[15]:
```

```
%%time
snap.pp.knn(data)
snap.tl.leiden(data)
```

```
CPU times: user 803 ms, sys: 172 ms, total: 975 ms
Wall time: 412 ms
```

```
[16]:
```

```
snap.pl.umap(data, color='leiden', interactive=False, height=500)
```

```
[16]:
```

![../_images/tutorials_pbmc_34_0.png](../_images/tutorials_pbmc_34_0.png)

The plot can be saved to a file using the `out_file` parameter. The suffix of the filename will used to determined the output format.

```
[17]:
```

```
snap.pl.umap(data, color='leiden', show=False, out_file="umap.pdf", height=500)
snap.pl.umap(data, color='leiden', show=False, out_file="umap.html", height=500)
```

## Cell cluster annotation[#](#Cell-cluster-annotation "Link to this heading")

Now that we have the cell clusters, we will try to annotate the clusters and assign them to known cell types.

### Visualizing promoter accessibility at marker genes[#](#Visualizing-promoter-accessibility-at-marker-genes "Link to this heading")

Expressed genes often have more accessible promoters. Therefore, we can use promoter accessibility at known marker genes to annotate cell clusters. We can use the `pl.coverage` function to visualize the accessibility at the promoter regions of marker genes. Below we plot the coverage +/- 1kb region centered around the TSS of CD19, a B cell marker gene.

```
[ ]:
```

```
snap.pl.coverage(data, region='chr16:28930971-28932971', groupby='leiden')
```

![../_images/tutorials_pbmc_38_0.png](../_images/tutorials_pbmc_38_0.png)

From the plot we can see that cluster 6 and 10 has the highest accessibility at the promote