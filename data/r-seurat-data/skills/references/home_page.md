Toggle navigation

[Seurat](/seurat/)
5.2.0

* [Install](/seurat/articles/install_v5)
* [Get started](/seurat/articles/get_started_v5_new)
* Vignettes
  + Introductory Vignettes
  + [PBMC 3K guided tutorial](/seurat/articles/pbmc3k_tutorial)
  + [Data visualization vignette](/seurat/articles/visualization_vignette)
  + [SCTransform, v2 regularization](/seurat/articles/sctransform_vignette)
  + [Using Seurat with multi-modal data](/seurat/articles/multimodal_vignette)
  + [Seurat v5 Command Cheat Sheet](/seurat/articles/essential_commands)
  + Data Integration
  + [Introduction to scRNA-seq integration](/seurat/articles/integration_introduction)
  + [Integrative analysis in Seurat v5](/seurat/articles/seurat5_integration)
  + [Mapping and annotating query datasets](/seurat/articles/integration_mapping)
  + Multi-assay data
  + [Dictionary Learning for cross-modality integration](/seurat/articles/seurat5_integration_bridge)
  + [Weighted Nearest Neighbor Analysis](/seurat/articles/weighted_nearest_neighbor_analysis)
  + [Integrating scRNA-seq and scATAC-seq data](/seurat/articles/seurat5_atacseq_integration_vignette)
  + [Multimodal reference mapping](/seurat/articles/multimodal_reference_mapping)
  + [Mixscape Vignette](/seurat/articles/mixscape_vignette)
  + Massively scalable analysis
  + [Sketch-based analysis in Seurat v5](/seurat/articles/seurat5_sketch_analysis)
  + [Sketch integration using a 1 million cell dataset from Parse Biosciences](/seurat/articles/parsebio_sketch_integration)
  + [Map COVID PBMC datasets to a healthy reference](/seurat/articles/covid_sctmapping)
  + [BPCells Interaction](/seurat/articles/seurat5_bpcells_interaction_vignette)
  + Spatial analysis
  + [Analysis of spatial datasets (Imaging-based)](/seurat/articles/seurat5_spatial_vignette_2)
  + [Analysis of spatial datasets (Sequencing-based)](/seurat/articles/spatial_vignette)
  + [Analysis of Visium HD spatial datasets](articles/visiumhd_analysis_vignette)
  + Other
  + [Cell-cycle scoring and regression](/seurat/articles/cell_cycle_vignette)
  + [Differential expression testing](/seurat/articles/de_vignette)
  + [Demultiplexing with hashtag oligos (HTOs)](/seurat/articles/hashing_vignette)
* [Extensions](/seurat/articles/extensions)
* [FAQ](https://github.com/satijalab/seurat/discussions)
* [News](/seurat/articles/announcements)
* [Reference](/seurat/reference/)
* [Archive](/seurat/articles/archive)

![](articles/assets/seurat_banner.jpg)

## **Seurat v5**

We are excited to release Seurat v5! To install, please follow the instructions in our [install page](install_v5.html). This update brings the following new features and functionality:

* **Integrative multimodal analysis:** The cellular transcriptome is just one aspect of cellular identity, and recent technologies enable routine profiling of chromatin accessibility, histone modifications, and protein levels from single cells. In Seurat v5, we introduce ‘bridge integration’, a statistical method to integrate experiments measuring different modalities (i.e. separate scRNA-seq and scATAC-seq datasets), using a separate multiomic dataset as a molecular ‘bridge’. For example, we demonstrate how to map scATAC-seq datasets onto scRNA-seq datasets, to assist users in interpreting and annotating data from new modalities.

  We recognize that while the goal of matching shared cell types across datasets may be important for many problems, users may also be concerned about which method to use, or that integration could result in a loss of biological resolution. In Seurat v5, we also introduce flexible and streamlined workflows for the integration of multiple scRNA-seq datasets. This makes it easier to explore the results of different integration methods, and to compare these results to a workflow that excludes integration steps.

  + Paper: [Dictionary learning for integrative, multimodal, and scalable single-cell analysis](https://www.nature.com/articles/s41587-023-01767-y)
  + Vignette: [Streamlined integration of scRNA-seq data](/seurat/articles/seurat5_integration)
  + Vignette: [Cross-modality bridge integration](/seurat/articles/seurat5_integration_bridge)
  + Website: [Azimuth-ATAC, reference-mapping for scATAC-seq datasets](https://azimuth.hubmapconsortium.org/references/)
* **Flexible, interactive, and highly scalable analsyis:** The size and scale of single-cell sequencing datasets is rapidly increasing, outpacing even Moore’s law. In Seurat v5, we introduce new infrastructure and methods to analyze, interpret, and explore exciting datasets spanning millions of cells, even if they cannot be fully loaded into memory. We introduce support for ‘sketch’-based analysis, where representative subsamples of a large dataset are stored in-memory to enable rapid and iterative analysis - while the full dataset remains accessible via on-disk storage.

  We enable high-performance via the BPCells package, developed by Ben Parks in the Greenleaf Lab. The BPCells package enables high-performance analysis via innovative bit-packing compression techniques, optimized C++ code, and use of streamlined and lazy operations.

  + Vignette: [Sketch-based clustering of 1.3M brain cells (10x Genomics)](/seurat/articles/seurat5_sketch_analysis)
  + Vignette: [Sketch-based integration of 1M healthy and diabetic PBMC (Parse Biosciences)](/seurat/articles/parsebio_sketch_integration)
  + Vignette: [Mapping 1.5M cells from multiple studies to an Azimuth reference](/seurat/articles/covid_sctmapping)
  + Vignette: [Interacting with BPCell matrices in Seurat v5](/seurat/articles/seurat5_bpcells_interaction_vignette)
  + BPCells R Package: [Scaling Single Cell Analysis to Millions of Cells](https://bnprks.github.io/BPCells/)
* **Analysis of sequencing and imaging-based spatial datasets:** Spatially resolved datasets are redefining our understanding of cellular interactions and the organization of human tissues. Both sequencing-based(i.e. Visium, SLIDE-seq, etc.), and imaging-based (MERFISH/Vizgen, Xenium, CosMX, etc.) technologies have unique advantages, and require tailored analytical methods and software infrastructure. In Seurat v5, we introduce flexible and diverse support for a wide variety of spatially resolved data types, and support for analytical techniqiues for scRNA-seq integration, deconvolution, and niche identification.

  + Vignette: [Analysis of spatial datasets (Sequencing-based)](/seurat/articles/spatial_vignette)
  + Vignette: [Analysis of spatial datasets (Imaging-based)](/seurat/articles/seurat5_spatial_vignette_2)
* **Backwards compatibility:** While Seurat v5 introduces new functionality, we have ensured that the software is backwards-compatible with previous versions, so that users will continue to be able to re-run existing workflows. Previous versions of Seurat, such as Seurat v4, can also be installed following the instructions in our [install page](install_v5.html).

## **Changes between v4 and v5**

We have documented major changes between Seurat v4 and v5 in our [News page](announcements.html) for reference.

## **About Seurat**

Seurat is an R package designed for QC, analysis, and exploration of single-cell RNA-seq data. Seurat aims to enable users to identify and interpret sources of heterogeneity from single-cell transcriptomic measurements, and to integrate diverse types of single-cell data.

If you use Seurat in your research, please considering citing:

* [Hao, et al., Nature Biotechnology 2023](https://www.nature.com/articles/s41587-023-01767-y) [Seurat v5]
* [Hao\*, Hao\*, et al., Cell 2021](https://doi.org/10.1016/j.cell.2021.04.048) [Seurat v4]
* [Stuart\*, Butler\*, et al., Cell 2019](https://www.cell.com/cell/fulltext/S0092-8674%2819%2930559-8) [Seurat v3]
* [Butler, et al., Nat Biotechnol 2018](https://doi.org/10.1038/nbt.4096) [Seurat v2]
* [Satija\*, Farrell\*, et al., Nat Biotechnol 2015](https://doi.org/10.1038/nbt.3192) [Seurat v1]

All methods emphasize clear, attractive, and interpretable visualizations, and were designed to be [easily used](/seurat/articles/get_started) by both dry-lab and wet-lab researchers.

Seurat is developed and maintained by the [Satija lab](/seurat/authors) and is released under the MIT license.

## Links

* [View on CRAN](https://cloud.r-project.org/package%3DSeurat)
* [Browse source code](https://github.com/satijalab/seurat/)
* [Report a bug](https://github.com/satijalab/seurat/issues)

## License

* [Full license](/seurat/license)
* [MIT](https://opensource.org/licenses/mit-license.php) + file [LICENSE](/seurat/license-text)

## Community

* [Code of conduct](/seurat/code_of_conduct)

## Citation

* [Citing Seurat](/seurat/authors#citation)

## Developers

* Rahul Satija
   Author, maintainer
* Satija Lab and Collaborators
   Funder
* [More about authors...](/seurat/authors)

Developed by Rahul Satija, Satija Lab and Collaborators.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.0.7.