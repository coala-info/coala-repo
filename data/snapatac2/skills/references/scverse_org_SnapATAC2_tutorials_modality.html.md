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

* [Standard pipeline: analyzing 5K PBMC dataset from 10X genomics](pbmc.html)
* [Annotating cell clusters by integrating single-cell RNA-seq data](annotation.html)
* [Identify differentially accessible regions](diff.html)
* [Multi-sample Pipeline: analyzing snATAC-seq data of human colon samples](integration.html)
* Multi-modality pipeline: analyzing single-cell multiome data (ATAC + Gene Expression)
* [Atlas-scale Analysis: a cell atlas of human chromatin accessibility.](atlas.html)

* [Tutorials](index.html)
* Multi-modality pipeline: analyzing single-cell multiome data (ATAC + Gene Expression)

# Multi-modality pipeline: analyzing single-cell multiome data (ATAC + Gene Expression)[#](#Multi-modality-pipeline:-analyzing-single-cell-multiome-data-(ATAC-+-Gene-Expression) "Link to this heading")

## Introduction[#](#Introduction "Link to this heading")

In this tutorial we will analyze single-cell multiome data data from Peripheral blood mononuclear cells (PBMCs). The dataset used in this tutorial can be found here: <http://renlab.sdsc.edu/kai/10x-Multiome/>.

In addition to SnapATAC2, we will utilize [scanpy](https://scanpy.readthedocs.io/en/stable/) to preprocess the scRNA-seq data.

```
[1]:
```

```
import snapatac2 as snap
import scanpy as sc
```

## Analyze gene expression data[#](#Analyze-gene-expression-data "Link to this heading")

```
[2]:
```

```
rna = snap.read(snap.datasets.pbmc10k_multiome(modality='RNA'), backed=None)
rna
```

```
[2]:
```

```
AnnData object with n_obs × n_vars = 9631 × 29095
    obs: 'domain', 'cell_type'
    var: 'gene_ids', 'feature_types'
```

```
[3]:
```

```
sc.pp.highly_variable_genes(rna, flavor='seurat_v3', n_top_genes=3000)
rna = rna[:, rna.var.highly_variable]
```

```
[4]:
```

```
sc.pp.normalize_total(rna, target_sum=1e4)
sc.pp.log1p(rna)
```

```
/projects/ps-renlab2/kai/software/micromamba/lib/python3.9/site-packages/scanpy/preprocessing/_normalization.py:170: UserWarning: Received a view of an AnnData. Making a copy.
  view_to_actual(adata)
```

```
[5]:
```

```
snap.tl.spectral(rna, features=None)
snap.tl.umap(rna)
```

```
[6]:
```

```
snap.pl.umap(rna, color='cell_type', interactive=False, height=550)
```

```
[6]:
```

![../_images/tutorials_modality_8_0.png](../_images/tutorials_modality_8_0.png)

## Analyze chromatin accessibility data[#](#Analyze-chromatin-accessibility-data "Link to this heading")

```
[7]:
```

```
atac = snap.read(snap.datasets.pbmc10k_multiome(modality='ATAC'), backed=None)
atac
```

```
[7]:
```

```
AnnData object with n_obs × n_vars = 9631 × 107194
    obs: 'domain', 'cell_type'
    var: 'feature_types'
    uns: 'spectral_eigenvalue'
    obsm: 'X_spectral', 'X_umap'
```

```
[8]:
```

```
snap.tl.spectral(atac, features=None)
snap.tl.umap(atac)
```

```
[9]:
```

```
snap.pl.umap(atac, color="cell_type", interactive=False, height=550)
```

```
[9]:
```

![../_images/tutorials_modality_12_0.png](../_images/tutorials_modality_12_0.png)

## Perform joint embedding[#](#Perform-joint-embedding "Link to this heading")

```
[10]:
```

```
assert (rna.obs_names == atac.obs_names).all()
```

```
[13]:
```

```
embedding = snap.tl.multi_spectral([rna, atac], features=None)[1]
```

```
2023-04-13 23:04:40 - INFO - Compute normalized views...
2023-04-13 23:05:44 - INFO - Compute embedding...
```

```
[14]:
```

```
atac.obsm['X_joint'] = embedding
snap.tl.umap(atac, use_rep='X_joint')
```

```
[15]:
```

```
snap.pl.umap(atac, color="cell_type", interactive=False, height=550)
```

```
[15]:
```

![../_images/tutorials_modality_17_0.png](../_images/tutorials_modality_17_0.png)

[previous

Multi-sample Pipeline: analyzing snATAC-seq data of human colon samples](integration.html "previous page")
[next

Atlas-scale Analysis: a cell atlas of human chromatin accessibility.](atlas.html "next page")

On this page

* [Introduction](#Introduction)
* [Analyze gene expression data](#Analyze-gene-expression-data)
* [Analyze chromatin accessibility data](#Analyze-chromatin-accessibility-data)
* [Perform joint embedding](#Perform-joint-embedding)

© Copyright 2022-2025, Kai Zhang.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.