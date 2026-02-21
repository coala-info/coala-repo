---
name: r-shaman
description: R package shaman (documentation from project home).
homepage: https://cran.r-project.org/web/packages/shaman/index.html
---

# r-shaman

name: r-shaman
description: Specialized R package for resampling Hi-C contact matrices to generate expected distributions and compute normalized scores. Use this skill when you need to perform a-parametric normalization of Hi-C data, generate shuffled expected tracks, visualize normalized contact maps with genomic annotations, or analyze spatial contact enrichment between genomic features using the Misha database system.

# r-shaman

## Overview
The `shaman` package implements a-parametric normalization of Hi-C data by resampling observed contacts to generate expected distributions. It accounts for marginal coverage and contact-distance probability distributions. The package is built upon the `misha` genomic database system and uses C++ for efficient computation.

Key capabilities:
- Shuffling observed Hi-C data to generate expected contact tracks.
- Computing normalized scores (enrichment/depletion) for contact points.
- Visualizing normalized maps with genomic tracks (Gviz integration).
- Quantifying spatial contact enrichment between specific genomic landmarks (e.g., CTCF sites).

## Installation
To install the `shaman` package from CRAN:
```R
install.packages("shaman")
```
Note: `shaman` requires the `misha` package and Bioconductor dependencies `Gviz` and `GenomeInfoDb`.

## Workflow

### 1. Database Initialization and Import
`shaman` requires a Misha database. You must first initialize the database for your genome and import observed contacts.

```R
# Initialize a Misha DB (e.g., hg19)
library(shaman)
gdb.init("path/to/hg19_db")

# Import observed contacts (tab-delimited: chrom1, start1, end1, chrom2, start2, end2)
# Note: Misha uses 0-based coordinates.
gtrack.2d.import(track="hic_obs", description="observed hic data", file="hic.obs.txt")
```

### 2. Generating Expected Tracks (Distributed/Multi-core)
Normalization requires a shuffled "expected" track. This is computationally intensive.

```R
# Enable multi-core support
options(shaman.mc_support=1)

# Generate expected track
shaman_shuffle_hic_track(track_db=getwd(), obs_track_nm="hic_obs", work_dir=tempdir())

# Generate score track (normalized enrichment)
shaman_score_hic_track(track_db=getwd(), score_track_nm="hic_score", obs_track_nms="hic_obs", work_dir=tempdir())
```

### 3. Local Computation (Small Regions)
For specific small intervals, you can shuffle and score without pre-computing whole-genome tracks.

```R
interval <- gintervals.2d(2, 175e06, 178e06, 2, 175e06, 178e06)
point_score <- shaman_shuffle_and_score_hic_mat(obs_track_nms="hic_obs", interval=interval, work_dir=tempdir())
```

### 4. Visualization
Visualize normalized scores alongside other genomic tracks (ChIP-seq, RNA-seq) or annotations.

```R
# Plot map with annotations
shaman_plot_map_score_with_annotations(genome="hg19", 
                                       points=point_score, 
                                       interval=gintervals(2, 175e06, 178e06), 
                                       misha_tracks=list("K562.k27ac"), 
                                       annotations=list("ctcf_forward", "ctcf_reverse"))
```

### 5. Spatial Contact Enrichment
Analyze enrichment between two sets of features (e.g., enhancer-promoter pairs).

```R
grid <- shaman_generate_feature_grid(feature1, feature2, obs_track="hic_obs", exp_track="hic_exp", range=25000, resolution=500)
shaman_plot_feature_grid(grid, range=25000)
```

## Tips and Options
- **Parallelization**: Set `options(shaman.mc_support=1)` for multi-core or `options(shaman.sge_support=1)` for Sun Grid Engine clusters.
- **Memory**: Large Hi-C datasets require significant RAM and disk space for the Misha quad-tree structures.
- **Colors**: Customize the score palette using `shaman.score_pal_pos_col` and `shaman.score_pal_neg_col`.

## Reference documentation
- [The shaman package - sampling HiC contact matrices](./references/home_page.md)
- [Importing HiC data](./references/import.html.md)
- [Shaman usage and workflow](./references/shaman-package.html.md)