Analyze scRNA-Seq Data From a Publication Using 10x Software | Official 10x Genomics Support

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

Analyze scRNA-Seq Data From a Publication Using 10x Software

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

Analyze scRNA-Seq Data From a Publication Using 10x Software
------------------------------------------------------------

Exciting research is being done using the 10x Genomics Chromium Single Cell Gene Expression Solution. This guide outlines how to perform the analysis and highlights the results 10x Genomics assays and software produce using data from the *Nature* publication "[Single-cell transcriptomes of the regenerating intestine reveal a revival stem cell](https://www.nature.com/articles/s41586-019-1154-y)" (2019; doi: 10.1038/s41586-019-1154-y).

The *Nature* publication used Cell Ranger v2.0.0 for initial analysis and third-party tools for secondary analysis. This guide uses Cell Ranger v3.1.0 and Loupe Cell Browser v3.1.1 to perform initial and secondary analysis. Using default settings, we are able to reproduce some of the major results reported in the Nature publication.

Loupe Browser v7.0 introduced a new user interface and navigation experience. Visit [the single cell navigation tutorial](/support/software/loupe-browser/latest/tutorials/introduction/lb-sc-interface-and-navigation) for more details.

### About the example

Intestinal tissue can repair itself after an injury such as irradiation. However, the molecular mechanisms that underlie the process are not fully understood. The LGR5+ crypt base columnar cells are thought to drive intestinal epithelium regeneration, but these cells are lost after injury, while regeneration still takes place.

To identify the cells responsible for the regeneration process, a group of researchers in Toronto used the 10x Genomics Chromium Single Cell 3’ Gene Expression Solution to profile mouse intestine cells, with and without irradiation.

### Workflow overview

This guide focuses on two samples: crypts (enriched from the whole epithelia) from normal and irradiated mice. See the figure below.

![](https://cdn.10xgenomics.com/image/upload/v1689651259/software-support/3p-Single-Cell-GEX/Tutorials/gex-analysis-nature-publication/gex-analysis-tour-1.png)

As illustrated above, the two samples were processed in two [GEM wells](/support/software/cell-ranger/latest/resources/cr-glossary#general) on the 10x Chromium Controller. The two libraries were then prepared following the [user guide](/support/user-guides/single-cell-gene-expression) and sequenced on a [recommended](/support/universal-three-prime-gene-expression/documentation/steps/sequencing/sequencing-requirements-for-single-cell-3) Illumina sequencer.

The sequencer generates raw data in the base call (BCL) format, which contains sequencing data of all the libraries in the sequencing run. Use a [demultiplexing tool](/support/software/cell-ranger/latest/analysis/inputs/cr-direct-demultiplexing) to demultiplex BCL files into FASTQ files. If the sequencing provider already completed this step, the FASTQ files of each library can be directly used for data analysis.

For this guide, the [Barcoded BAM](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-bam) files for the two samples was downloaded from the Data access tab of the Run Browser from these two Sequence Read Archive (SRA) pages:

* [SRR7611046](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR7611046)
* [SRR7611048](https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR7611048)

The Barcoded BAM files are converted to FASTQ files with the 10x Genomics [bamtofastq](/support/software/cell-ranger/latest/miscellaneous/cr-bamtofastq) tool as below:

```
Copy

bamtofastq C05.bam.1 normal
bamtofastq C07.bam.1 irradiated
```

After successfully completing the `bamtofastq`, both `normal` and `irradiated` folders contain two subfolders with FASTQ files in them.

### How to perform the data analysis

Once the FASTQ files for each sample are generated, the data analysis begins. The `cellranger count` pipeline can perform read alignment, UMI counting, and secondary analysis (dimensionality reduction, clustering, and visualization) for a single sample. The two samples shown in the figure above require running `cellranger count` for each sample separately.

Given that these are mouse samples, the [pre-built mouse reference](/support/software/cell-ranger/downloads#reference-downloads) is used. After determining the path to the reference folder and FASTQ files, run `cellranger count` for the normal sample:

```
Copy

cd ./normal/
cellranger count --id=normal \
                  --transcriptome=/path/to/refdata-cellranger-mm10-3.0.0 \
                  --fastqs=./indepth_C05_MissingLibrary_1_HL5G3BBXX,./indepth_C05_MissingLibrary_1_HNNWNBBXX
```

Similarly, run `cellranger count` for the irradiated sample in a separate command:

```
Copy

cd ./irradiated/
cellranger count --id=irradiated \
                  --transcriptome=/path/to/refdata-cellranger-mm10-3.0.0 \
                  --fastqs=./indepth_C07_MissingLibrary_1_HL5G3BBXX,./indepth_C07_MissingLibrary_1_HNNWNBBXX
```

### What results can I get from Cell Ranger?

After successfully completing the pipeline, find the `outs/` directory for each run to review many useful [result files](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-overview). Start by checking the results using the following files:

* The `web_summary.html` contains summary metrics and automated secondary analysis results. Click the **?** in the top of each dashboard for more information on each metric. If there are any metrics with abnormal values, Cell Ranger automatically generates [alerts](/support/software/cell-ranger/latest/resources/cr-troubleshooting) to help you identify any potential issues. If you have specific questions, you can search our [Q&A articles](https://kb.10xgenomics.com/hc/en-us) or contact support.
* If the metrics look reasonable, load the `cloupe.cloupe` into [Loupe Browser](/support/software/loupe-browser/latest) to visualize and explore the [results](#loupe).
* For additional analysis, load the [`filtered_feature_bc_matrix`](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-h5-matrices) into third-party tools, such as Seurat.

For the example data here, there were no alerts for both normal and irradiated samples. To identify the cells that contribute to the intestine regeneration, we need to compare the results for normal versus irradiated cells.

### How to compare results from different samples

To compare two or more samples, use the [`cellranger aggr`](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-3p-aggr) pipeline (also see the getting started tutorial for [Running cellranger aggr](/support/software/cell-ranger/latest/tutorials/cr-tutorial-ag)) to aggregate outputs from multiple runs of `cellranger count`, normalize runs to the same effective sequencing depth, and then perform secondary analysis on the combined data.

In this example, there are two samples, so the `cellranger aggr` pipeline requires a `libraries.csv` file that looks like this:

```
Copy

library_id,molecule_h5
normal,/path/to/count/normal/outs/molecule_info.h5
irradiated,/path/to/count/irradiated/outs/molecule_info.h5
```

For Cell Ranger v6.0+ and Loupe Browser v5.1.0+, the libraries CSV header should be 'sample\_id,molecule\_h5'. For prior software versions, it should be 'library\_id,molecule\_h5'.

Here is an example of the `cellranger aggr` command:

```
Copy

cellranger aggr --id=aggr --csv=libraries.csv
```

Upon completion, this pipeline generates a set of outputs with the combined data from the two samples. Next, we can visualize and explore the results using the `cloupe.cloupe` file.

### Visualizing and exploring the results with Loupe Browser

The combined data from two samples can be analyzed using [Loupe Browser](/support/software/loupe-browser/latest). Some key functions of the Loupe Browser are presented in this guide. For more detailed information, see the Loupe Browser tutorials.

To identify the cell type contributing to intestine regeneration, locate the major known cell types in the results. This step heavily relies on understanding the gene markers in the tissue of interest. There are also third-party computational tools developed for automated identification of cell types. For this guide, the typical method is used, which utilizes unsupervised clustering to identify the signature genes and associate them to known cell types based on the literature.

First, review the clustering results. The graph-based clustering results from the combined normal and irradiated samples showed 22 clusters. See the screenshot below. While not exactly the same as reported in the publication due mainly to software and version differences, the following sections of this guide illustrate some of the major results that were reproduced from the publication using Cell Ranger v3.1.0 pipelines.

![](https://cdn.10xgenomics.com/image/upload/v1689651265/software-support/3p-Single-Cell-GEX/Tutorials/gex-analysis-nature-publication/gex-analysis-tour-2.png)

To identify the cell types of each cluster, use the differentially expressed genes shown in the data panel on the bottom. For example, in the above screenshot, see the top up-regulated genes in Cluster 3. Some of the genes are known immune cell markers (e.g., Cd3g and Cd3e), indicating that the cells in Cluster 3 are immune cells. Rename the Cluster 3 to "Immune Cells (Cd3g, Cd3e)".

To further confirm that Cluster 3 represents immune cells, use the Gene/Feature Expression mode to view the expression level of Cd3g and Cd3e across the dataset. See the screenshot below. The cells expressing these immune cell markers are neatly clustered into Cluster 3, indicating that this distinct region of cells represents immune cells.

![](https://cdn.10xgenomics.com/image/upload/v1689651264/software-support/3p-Single-Cell-GEX/Tutorials/gex-analysis-nature-publication/gex-analysis-tour-3.png)

Similarly, identify the cell types of all the other clusters based on the top up-regulated genes and associate them with known cell types based on the literature. Depending on the complexity of the dataset and prior knowledge of the cell types, this process could be time-consuming.

Consistent with results reported in the publication, all but one cluster was assigned to known cell types. The cell types and marker genes identified in Loupe Browser are shown in the screenshot below.

![](https://cdn.10xgenomics.com/image/upload/v1689651265/software-support/3p-Single-Cell-GEX/Tutorials/gex-analysis-nature-publication/gex-analysis-tour-4.png)

The most up-regulated gene in the unknown cell cluster is clusterin (Clu), which is consistent with the publication.

Next, continue using Loupe Browser to explore if the cluster of unknown cells is enriched or lost in the irradiated sample compared to the normal one. To see that more cells in this unknown cluster were from the irradiated sample, split the view by LibraryID category (see the screenshot below) and select only the unknown cluster.

![](https://cdn.10xgenomics.com/image/upload/v1689651261/software-support/3p-Single-Cell-GEX/Tutorials/gex-analysis-nature-publication/gex-analysis-tour-5.png)

For more accurate numbers, use the Filters panel (see the screenshot below). 213 cell barcodes from the irradiated sample were found in this unknown cluster, while only 13 cells from the normal sample were in this cluster. This result is also similar to what was reported in the publication.

![](https://cdn.10xgenomics.com/image/upload/v1689651261/software-support/3p-Single-Cell-GEX/Tutorials/gex-analysis-nature-publication/gex-analysis-tour-6.png)

Following these initial findings, the authors performed additional experiments and validated that the Clu+ cell induced by injury is essential for intestine regeneration.

### Moving forward

This was a quick tour of how to use the 10x Genomics Chromium Single Cell Gene Expression Solution and analysis tools to identify a novel cell type. Additional analyses can be done using 10x Genomics tools or third-party tools.

For example, in the results, several clusters of cells are enriched for mitochondrial (MT) genes. They can be excluded in the secondary analysis by following the instructions in this article: [How can I exclude cells that show enrichment of MT genes from secondary data analysis?](https://kb.10xgenomics.com/hc/en-us/articles/360026508452-How-can-I-exclude-poor-quality-cells-such-as-those-that-show-enrichment-of-MT-genes)

Output data from Cell Ranger can be loaded into third-party tools to perform trajectory analysis, which can be used to explore the role of the Clu+ cells in the dynamic process of intestine regeneration.

To get started with your own single cell gene expression experiments, visit our [gene expression support website](/support) for more details on workflow and software.

On This Page
============

* [About the example](#example)
* [Workflow overview](#overview)
* [How to perform the data analysis](#perform_analysis)
* [What results can I get from Cell Ranger?](#results)
* [How to compare results from different samples](#compare)
* [Visualizing and exploring the results with Loupe Browser](#loupe)
* [Moving forward](#forward)

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