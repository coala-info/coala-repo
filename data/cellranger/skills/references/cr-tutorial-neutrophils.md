Capturing Neutrophils in 10x Single Cell Gene Expression Data | Official 10x Genomics Support

[10x Genomics Homepage](/)

* Products
* Resources
* [Support Hub](/support)
* Company
* [Search](/search)

[Order status](/store/order-status)

[Store](/store)

[10x Genomics Homepage](/)

[Order status](/store/order-status)

[Store](/store)

* Products
* Resources
* [Support Hub](/support)
* Company
* [Search](/search)

* [Order Status](/store/order-status)
* [Store](/store)

[Support home](/support)[Cell Ranger](/support/software/cell-ranger/latest)[Tutorials](/support/software/cell-ranger/latest/tutorials)

Capturing Neutrophils in 10x Single Cell Gene Expression Data

[Cell Ranger](/support/software/cell-ranger/latest)

---

* [Overview](/support/software/cell-ranger/latest)
* [Getting Started](/support/software/cell-ranger/latest/getting-started)
* [Supported Libraries](/support/software/cell-ranger/latest/resources/supported-libraries)
* [Download Center](/support/software/cell-ranger/downloads)
* [Cloud Analysis](https://cloud.10xgenomics.com/cloud-analysis)
* [Cell Ranger Commands](/support/software/cell-ranger/latest/resources/cr-command-line-arguments)
* [Analysis](/support/software/cell-ranger/latest/analysis)
  + Inputs

    * [Inputs Overview](/support/software/cell-ranger/latest/analysis/inputs/cr-inputs-overview)
    * [Generating FASTQs](/support/software/cell-ranger/latest/analysis/inputs/cr-direct-demultiplexing)
    * [Specifying FASTQs](/support/software/cell-ranger/latest/analysis/inputs/cr-specifying-fastqs)
    * [Libraries CSV](/support/software/cell-ranger/latest/analysis/inputs/cr-libraries-csv)
    * [Feature Reference CSV](/support/software/cell-ranger/latest/analysis/inputs/cr-feature-ref-csv)
    * [Multi Config CSV](/support/software/cell-ranger/latest/analysis/inputs/cr-multi-config-csv-opts)
    * [Custom Reference with mkref](/support/software/cell-ranger/latest/analysis/inputs/cr-3p-references)
    * [Custom V(D)J Reference](/support/software/cell-ranger/latest/analysis/inputs/cr-5p-references)
  + Running Pipelines

    * [Choosing a Pipeline](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-choosing-a-pipeline)
    * [Computing Options](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-choosing-how-to-run)
    * Primary Analysis
    * [multi (3'/5'/Flex)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-multi)
    * [count (GEX + Antibody/CRISPR)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-gex-count)
    * [vdj (VDJ-T/B only)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-5p-vdj)
    * Secondary Analysis
    * [Data Integration Workflows](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-data-integration)
    * [Cell Annotation (annotate)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-cell-annotation-pipeline)
    * [Custom Analysis (reanalyze)](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-3p-reanalyze)
  + Outputs

    * [Overview](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-overview)
    * [Web Summary](/support/software/cell-ranger/latest/analysis/cr-outputs-web-summary)
    * [QC Report](/support/software/cell-ranger/latest/analysis/cr-outputs-qc-report)
    * [Metrics](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-metrics)
    * [Feature-Barcode Matrices](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-matrices)
    * [BAM](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-bam)
    * [Molecule Info (H5)](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-molecule-info)
    * [Secondary Analysis](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-secondary-analysis)
    * [Cell Type Annotations](/support/software/cell-ranger/latest/analysis/outputs/cr-cell-annotation-outputs)
    * [Results of aggr](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-aggr-outputs)
    * Library types
    * [Flex (Singleplex & Multiplex)](/support/software/cell-ranger/latest/analysis/outputs/cr-flex-outputs-frp)
    * [3'/5' Singleplex (GEX + VDJ + FB)](/support/software/cell-ranger/latest/analysis/outputs/cr-5p-outputs-overview-multi)
    * [3'/5' Sample Multiplexing (GEX + VDJ + FB)](/support/software/cell-ranger/latest/analysis/outputs/cr-3p-outputs-cellplex)
    * [Gene Expression](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-gex-overview)
    * [Antibody Capture](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-ab-overview)
    * [CRISPR Guide Capture](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-crispr-overview)
    * [VDJ-T/B](/support/software/cell-ranger/latest/analysis/outputs/cr-5p-outputs-overview-vdj)
* [Tutorials](/support/software/cell-ranger/latest/tutorials)
* [Algorithms](/support/software/cell-ranger/latest/algorithms-overview)
* [Advanced](/support/software/cell-ranger/latest/advanced)
* [Troubleshooting](/support/software/cell-ranger/latest/resources/cr-troubleshooting)
* [Miscellaneous](/support/software/cell-ranger/latest/miscellaneous)
* [Release Notes](/support/software/cell-ranger/latest/release-notes)
* [Q&A](https://kb.10xgenomics.com/hc/en-us)
* [Glossary](/support/software/cell-ranger/latest/resources/cr-glossary)
* [Datasets](/support/software/cell-ranger/latest/getting-started/cr-datasets)
* [Loupe Browser](/support/software/loupe-browser/latest)

Version

v10.1 (Latest)

[View source code](https://github.com/10XGenomics/cellranger)

Capturing Neutrophils in 10x Single Cell Gene Expression Data
-------------------------------------------------------------

Loupe Browser v7.0 introduced a new user interface and navigation experience. Visit [the single cell navigation tutorial](/support/software/loupe-browser/latest/tutorials/introduction/lb-sc-interface-and-navigation) for more details.

This tutorial was written with Cell Ranger v6.1.0 and Loupe Browser v5.1.0. Results may vary slightly with other versions of software. If running this tutorial with Cell Ranger v7.0 or later, `--include-introns` is set to true by default and does not need to be specified.

### Introduction

Neutrophils are the most abundant cell type in human white blood cells (leukocytes). If you have followed our workflow recommendations for [processing neutrophils (or other granulocytes) using 10x Genomics Single Cell applications](https://kb.10xgenomics.com/hc/en-us/articles/360004024032-Can-I-process-neutrophils-or-other-granulocytes-using-10x-Single-Cell-applications), then neutrophils should be present in your single cell gene expression data. However, neutrophils only express around a few hundred genes ([Hay et al. 2018](https://www.sciencedirect.com/science/article/pii/S0301472X18308051)). By default, Cell Ranger may filter out neutrophils in the final results.

This tutorial will demonstrate how to preserve and annotate the neutrophils in your data. For additional discussion, refer to the [Neutrophil Analysis in 10x Genomics Single Cell Gene Expression Assays Technical Note](/support/universal-three-prime-gene-expression/documentation/steps/sample-prep/neutrophil-analysis-in-10-x-genomics-single-cell-gene-expression-assays).

**High-level overview**

To capture neutrophils from 3' or 5' Single Cell Gene Expression data, you need to:

* Run `cellranger count` with `--force-cells` to include low-UMI barcodes.
* Use the `--include-introns` option to accommodate increased intron retention in neutrophils.
* Filter out background and annotate neutrophils using Loupe Browser (this tutorial), or other third-party tools.

### Software and dataset

To begin this tutorial, download and install [Loupe Browser](/support/software/loupe-browser/latest) (version 5.1 or later). This tutorial will not cover the basics of running Cell Ranger or using Loupe Browser.

This dataset is generated from whole leukocytes of a healthy donor and prepared with Single Cell 3' Gene Expression assay. The raw FASTQs and output `.cloupe` files used in this tutorial can be [downloaded here](/datasets/whole-blood-rbc-lysis-for-pbmcs-neutrophils-granulocytes-3-3-1-standard). Although we use 3' Gene Expression data in this tutorial, all the steps also apply to Single Cell 5' Gene Expression data.

### Run Cell Ranger

For this dataset, when using the default Cell Ranger cell calling algorithm, there are only 1,886 cells identified (left plot below). This is because the RNA profile of neutrophils is more similar to the background (low UMI, low gene count) and the cell calling algorithm cannot readily distinguish between the neutrophils and background.

Therefore, to capture the neutrophils, we need to override the cell calling algorithm to ensure that low-UMI cells such as neutrophils are included in the filtered feature-barcode matrix. At this stage, there is no need to be concerned about including some background GEMs (Gelbeads-in-Emulsion) to the filtered matrix because we can filter them out later using Loupe Browser or other third-party tools. To override the cell calling algorithm, run `cellranger count` with the `--force-cells` option. 10x Genomics recommends starting with the number of cells targeted. If you are unsure about the number of cells expected, it is better to overestimate at this stage.

Given that 8,000 cells are expected to be recovered for this sample, use `--force-cells=8000` to analyze this dataset. In the barcode rank plot (right plot below), note a group of lower UMI count barcodes (second "knee") being included as cells, which are likely the neutrophils of interest.

If using Chromium GEM-X assays, `--force-cells` may not be necessary for neutrophil analysis due to the increased assay sensitivity. This parameter is still recommended for Chromium Next GEM assays.

![](https://cdn.10xgenomics.com/image/upload/v1665524909/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig1.png)

In addition, we also recommend running Cell Ranger with the `--include-introns` option, which enables Cell Ranger to count reads that map to intronic regions. As neutrophils retain a large number of introns ([Ulrich & Guigo, 2020](https://academic.oup.com/nar/article/48/3/1327/5687827)), mapping intronic reads improves the gene sensitivity, which may be useful when analyzing subpopulations.

Given that these are human samples, we will use the [pre-built human reference](/support/software/cell-ranger/downloads#reference-downloads) (refdata-gex-GRCh38-2020-A). After determining the path to the reference folder and FASTQ files, run `cellranger count`:

```
Copy

 cellranger count --id=mysample \
                  --transcriptome=/path/to/refdata-gex-GRCh38-2020-A \
                  --fastqs=/path/to/fastqs --sample=mysample \
                  --force-cells=8000 \
                  --include-introns
```

### Annotate cell types with Loupe Browser

After the pipeline completes successfully, find the `.cloupe` file in the output directory. Alternatively, [download the `cloupe.cloupe` file](/datasets/whole-blood-rbc-lysis-for-pbmcs-neutrophils-granulocytes-3-3-1-standard) for this example dataset. Load this file into Loupe Browser for cell-type annotation and data filtering.

To annotate known cell types, we will use cell markers (neutrophils, B cells, T cells, and monocytes) from this file: [BloodCell.csv](https://cdn.10xgenomics.com/raw/upload/v1689648502/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/BloodCell.csv).

These cell markers are selected from the literature and designed for blood samples. If you prefer using other blood cell markers, you can make your own cell marker CSV files. To import the CSV file, in the 'Gene/Feature Expression' view, click on the three dots to the right of the 'Active Feature List', then select 'Import Lists' from the dropdown menu. Select the CSV file. After import, you should be able to choose the different cell types from the feature list selector.

First, annotate the neutrophils. To select the potential neutrophils, use all the genes in the 'Neutrophil Markers' list and set 'Scale & Attribute' as 'Feature Max' > 0. This means that barcodes that express (UMI > 0) any neutrophil genes are defined as potential neutrophils. This is a relatively comprehensive marker list, and some of the genes may also be expressed in other blood cell types. In this tutorial, we first select this more extensive group of potential neutrophils and then refine it later.

![](https://cdn.10xgenomics.com/image/upload/v1665524925/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig3.png)

Next, annotate other cell types. For example, with the monocyte marker (CD14), observe
a cluster of monocytes on the t-SNE plot. Select these barcodes with the polygonal
selection tool.

![](https://cdn.10xgenomics.com/image/upload/v1665524920/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig4.png)

Similarly, you can annotate the B cells and T cells with marker genes and the polygonal selection tool.

After annotating these four major blood cell types, assign the remaining barcodes into the last cluster. You can label them 'Background' for now, given that many of these barcodes are probably background noise.

### Filter out background GEMs

After annotating the barcodes, we can now use the interactive filtering and reclustering workflow (implemented in Loupe Browser 5.0 and later, see [tutorial](/support/software/loupe-browser/latest/tutorials/assay-analysis/lb-sc-recluster)) to filter out the background GEMs and perform reclustering.

For simplicity, we will only use the 'Threshold by Features' and 'Mitochondrial UMIs' filters for this tutorial. You could implement the other steps when running your own data.

In the 'Threshold by Features' step, the 'Log2' view shows a violin plot with the number of distinct genes found for each barcode. For this dataset, the violin plot reveals three separate groups of barcodes:

* The first group has higher numbers of features (genes) detected, mostly B cells, T cells, and monocytes.
* The group in the middle could be neutrophils because neutrophils are known to only express a small number of genes.
* The group with the lowest gene counts are likely empty droplets.

Given that we forced Cell Ranger to call a very high number of cells, it is expected to have empty droplets in the results.

You can drag the lower slider to somewhere in between the middle and lowest groups, the minimum (Min) value will change as you drag the slider. For example, in this dataset, set the Min to 7.5 in Log2 scale. This value may vary for different datasets, for example, the suitable Min for this example 5' Gene Expression dataset is 6.

The 'Annotation' box on the right reveals that by setting this threshold, the majority (> 98%) of the empty droplets are removed, but < 40% of the tentative neutrophils are removed.

![](https://cdn.10xgenomics.com/image/upload/v1665524915/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig6.png)

After setting the 'Threshold by Features' in the Loupe Recluster window, use the 'Mitochondrial UMIs' filter to remove poor quality or dying cells. Try using 15% as the maximum threshold, which removes a small number (16) of unhealthy cells. This threshold may also vary depending on the datasets.

When finishing setting the threshold, click the 'Next' to select the type of plot(s) to generate and name the filtered dataset. In this tutorial, we will use UMAP projection due to shorter run time and more clear separation of different cell types. Name it as 'Filtered' and then click 'Recluster' to run the analysis.

Running reclustering may take a few minutes, depending on your computer's specifications. Upon completion, the window will show 'Success'. After clicking 'Done', you will be directed back to Loupe Browser to view the new 'Filtered' category.

### Refine cell type annotations

Using the reclustered results, you can refine cell type annotation, using the same process as shown [above](#annotate). You can annotate major cell types (neutrophils, B cells, T cells, and monocytes) using the same set of markers in this file mentioned above (`BloodCell.csv`).

First, refine our annotation of the neutrophils. Given that some of the neutrophil markers are also expressed in other immune cells, it could be useful to view the 'LogNorm' value (UMI normalized by total UMI associated with the barcode) of individual marker genes to identify which groups of cells are neutrophils. For example, the profile of FCGR3B expression indicates that the large group of cells at the upper left-hand corner are neutrophils. Therefore, we can select these cells and annotate them as neutrophils.

![](https://cdn.10xgenomics.com/image/upload/v1665524920/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig7.png)

Similarly, we can annotate the B cells, T cells, and monocytes with the marker genes in the CSV file. After annotating the above four cell types, there are still two small clusters of cells, which you can temporarily label as 'Unknown1' and 'Unknown2'.

![](https://cdn.10xgenomics.com/image/upload/v1665524928/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig8.png)

To further annotate the unknown clusters, run a differential expression analysis. The results revealed that the top up-regulated genes for 'Unknown1' are PPBP and TUBB1, which are platelet marker genes. Therefore, rename the cluster 'Unknown1' as 'Platelets'.

![](https://cdn.10xgenomics.com/image/upload/v1665524930/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig9.png)

The top up-regulated genes for the 'Unknown2' cluster includes HDC, CLC, and IL3RA, indicating that these are other granulocytes (eosinophils or basophils).

All the steps mentioned above also apply to 5' Gene Expression data. Example Cell Ranger output from the 5' data can be found [here](/datasets/whole-blood-rbc-lysis-for-pbmcs-and-neutrophils-granulocytes-5-3-1-standard).

### Explore neutrophil subtypes

We identified 3,343 neutrophils in the earlier step. If you are interested in neutrophil subtypes, run the reclustering step again on these neutrophils. To run reclustering on only neutrophils, uncheck all the other cell types and then run Recluster.

![](https://cdn.10xgenomics.com/image/upload/v1665524933/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig10.png)

In the reclustering workflow, you can directly 'Skip to final step', name it 'Neutrophils Recluster', and click 'Recluster' to run analysis on only the 3,343 neutrophils.

To explore the substructure of the neutrophil subtypes, you can run a differential expression analysis on the Neutrophils Recluster results. You can further annotate each cluster by checking the top differentially expressed genes. For example, the cells at the bottom of the UMAP (Cluster 4) are enriched for some marker genes (LTF, S100A12) of neutrophil early maturation ([Combes et al. 2021](https://www.nature.com/articles/s41586-021-03234-7)).

![](https://cdn.10xgenomics.com/image/upload/v1665524934/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig11.png)

Furthermore, you can load the data to third-party tools for additional analysis. In this case, we used scVelo ([Bergen et al. 2020](https://doi.org/10.1038/s41587-020-0591-3)) to infer the dynamics involved in neutrophil maturation. We projected the maturation dynamics and latent time (represents the biological process) in the UMAP.

This analysis identifies transitions starting in Cluster 4 and ending in Cluster 2. This is also represented by the latent time values in each of the different subpopulations. Finally, we inspected the expression of genes previously described in neutrophil maturation ([Combes et al. 2021](https://www.nature.com/articles/s41586-021-03234-7)) and observed transcriptional dynamics following the previously described transitions.

![](https://cdn.10xgenomics.com/image/upload/v1665524948/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-3rd-party.png)

For additional detail on how to perform the analysis illustrated in the figure above, please refer to this Analysis Guide tutorial: [Trajectory Analysis using 10x Genomics Single Cell Gene Expression Data](/analysis-guides/trajectory-analysis-using-10x-Genomics-single-cell-gene-expression-data). Note: 10x Genomics does not provide support for community-developed tools and makes no guarantees regarding their function or performance. Please contact tool developers with any questions. If you have feedback about Analysis Guides, please email [analysis-guides@10xgenomics.com](mailto:analysis-guides@10xgenomics.com).

### Discussion

The example dataset we used in this tutorial showed clear separation between neutrophils and background GEMs (shown in step 5 above). For some other datasets, there might not be a clear separation between them. One possibility is that the neutrophils in the sample were not in good condition, and their profiles are indeed more similar to empty droplets.

If you have determined that there is no workflow issue and would still like to detect the neutrophils, you can analyze the marker genes and clustering results. In the example below, we can see a group of cells (in red) has higher expression of neutrophil markers, such as NAMPT.

![](https://cdn.10xgenomics.com/image/upload/v1665524929/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig12.png)

These cells are in 'Cluster 6' from Graph-Based clustering. You could also check the top differentially expressed genes in the Feature Table. For datasets with large amounts of neutrophils, it might be necessary to uncheck the 'Hide Genes With Low Average Count' option. This is because of the overall low gene expression levels in neutrophils.

![](https://cdn.10xgenomics.com/image/upload/v1665524931/software-support/3p-Single-Cell-GEX/Tutorials/neutrophil/Neu-Fig13.png)

Therefore, for this dataset, although we cannot observe a clear separation between neutrophils and background based on UMI or feature counts (data not shown), we could still use clustering results and marker genes to identify neutrophils. The underlying rationale is that neutrophils may have similar total UMI counts as background, but the overall gene expression profile is distinct from the background. Alternatively, you could try using third-party tools (for example, [CellBender](https://github.com/broadinstitute/CellBender)) to separate the neutrophils from the background.

### References

* Bergen V, et al. [Generalizing RNA velocity to transient cell states through dynamical modeling](https://doi.org/10.1038/s41587-020-0591-3). *Nature Biotechnology* 38: 1408-1414, 2020.
* Combes A, et al. [Global absence and targeting of protective immune states in severe COVID-19](https://www.nature.com/articles/s41586-021-03234-7). *Nature* 591: 124-130, 2021.
* Hay S, et al. [The Human Cell Atlas bone marrow single-cell interactive web portal](https://www.sciencedirect.com/science/article/pii/S0301472X18308051). *Experimental Hematology* 68: 51-61, 2018.
* Ullrich S and Guigo R. [Dynamic changes in intron retention are tightly associated with regulation of splicing factors and proliferative activity during B-cell development](https://academic.oup.com/nar/article/48/3/1327/5687827). *Nucleic Acids Research* 48: 1327-1340, 2020.

On This Page
============

* [Introduction](#introduction)
* [Software and dataset](#software_dataset)
* [Run Cell Ranger](#run_cr)
* [Annotate cell types with Loupe Browser](#annotate)
* [Filter out background GEMs](#filter_background_gems)
* [Refine cell type annotations](#refine)
* [Explore neutrophil subtypes](#subtypes)
* [Discussion](#discussion)
* [References](#references)

---

### Company

* [About us](/company)
* [Investors](https://investors.10xgenomics.com/overview/default.aspx)
* [Careers](https://careers.kula.ai/10xgenomics)
* [Contact](/contact)
* [News](/news)
* [Distributors](/distributors)

### Platforms

* [Chromium Single Cell](/platforms/chromium)
* [Atera In Situ](/platforms/atera)
* [Visium Spatial](/platforms/visium)
* [Xenium In Situ](/platforms/xenium)

### Resources

* [Datasets](/datasets)
* [Publications](/publications)
* [Support Hub](/support)
* [Blog](/blog)
* [Compatible Products](/compatible-products)
* [Certifications & Compliance](/support/certifications-and-compliance)

### Legal Notices

* [Privacy Policy](/legal/privacy-policy)
* [Terms of Use](/legal/terms-of-use)
* [Other Legal Notices](/legal/legal-notices)

### Manage Preferences

* [Email Preferences](https://pages.10xgenomics.com/subscription.html)
* [Manage Cookie Preferences](#)
* [Do Not Sell or Share My Personal Information](#)

### Questions? We're here to help

* [support@10xgenomics.com](mailto:support@10xgenomics.com)
* [+1 925 401 7300](tel:+19254017300)

[Sign Up for Product and Support Updates](/subscribe)

### Follow us on social media

© 2026 10x Genomics. All Rights Reserved.

[English](/support)[中文](/cn/support)[日本語](/jp/support)