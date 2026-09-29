Running Cell Ranger multi | Official 10x Genomics Support

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

Running Cell Ranger multi

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

Running Cell Ranger multi
-------------------------

This tutorial is written with Cell Ranger v7.0.0. Starting with Cell Ranger v8.0, it is mandatory to use the `--create-bam` parameter when executing the `cellranger count` and `cellranger multi` pipelines. This new parameter replaces the previously used `--no-bam` option. All other arguments remain compatible with newer versions, unless otherwise specified.

This tutorial describes how to run the `cellranger multi` pipeline (we recommend completing the [other Cell Ranger pipeline tutorials](/support/software/cell-ranger/latest/tutorials) in this series first).

The example data used in this tutorial is for a 3' Cell Multiplexing dataset. In Cell Ranger v7.0 and later, Single Cell Flex datasets can be analyzed with the `cellranger multi` pipeline as well. For specific `multi` pipeline details and outputs, see:

* [Running multi for Flex](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-flex-multi-frp)
* [Flex outputs](/support/software/cell-ranger/latest/analysis/outputs/cr-flex-outputs-frp)

### Get data

In this tutorial, we will analyze a 3' Cell Multiplexing [dataset](/datasets/10-k-1-1-mixture-of-raji-and-jurkat-cells-multiplexed-2-cm-os-3-1-standard-6-0-0) that consists of two cell lines, Jurkat and Raji, multiplexed at equal proportions with one CMO per cell line, resulting in a pooled sample labeled with two CMOs. Gene Expression (GEX) and Cell Multiplexing libraries were prepared with the Chromium Next GEM Single Cell 3ʹ Reagent Kits v3.1 (Dual Index) with Feature Barcode technology.

Use `wget` to download the FASTQ data (about 44 GB):

```
Copy

wget https://cg.10xgenomics.com/samples/cell-exp/6.0.0/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_Multiplex/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_Multiplex_fastqs.tar
```

As of this tutorial's publication, the most current reference transcriptome was the Human reference (GRCh38) - 2020-A. Download and decompress it:

```
Copy

wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz
tar -xf refdata-gex-GRCh38-2020-A.tar.gz
```

Decompress the FASTQ files:

```
Copy

tar -xf SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_Multiplex_fastqs.tar
```

Navigate to the FASTQ files and observe their filenames. There is one directory that contains the FASTQ files for the GEX library. There are two that contain FASTQ files for the Cell Multiplexing Capture library because the same physical library was sequenced twice for this particular dataset - first for a preliminary sample quality check and second for the actual analysis.
The simplest scenario is to analyze one Gene Expression and one Multiplexing Capture library, which we will demonstrate using the FASTQ files in the `..._1_gex` and `..._1_multiplexing_capture` directories.

```
Copy

.
├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L001_I1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L001_I2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L001_R1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L001_R2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L002_I1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L002_I2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L002_R1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L002_R2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L003_I1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L003_I2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L003_R1_001.fastq.gz
│   └── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex_S2_L003_R2_001.fastq.gz
├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L001_I1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L001_I2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L001_R1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L001_R2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L002_I1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L002_I2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L002_R1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L002_R2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L003_I1_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L003_I2_001.fastq.gz
│   ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L003_R1_001.fastq.gz
│   └── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture_S1_L003_R2_001.fastq.gz
└── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_2_multiplexing_capture
    ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_2_multiplexing_capture_S1_L001_I1_001.fastq.gz
    ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_2_multiplexing_capture_S1_L001_I2_001.fastq.gz
    ├── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_2_multiplexing_capture_S1_L001_R1_001.fastq.gz
    └── SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_2_multiplexing_capture_S1_L001_R2_001.fastq.gz
```

### Create multi config CSV

The `cellranger multi` pipeline has two inputs:

* `--id` is used to name the output directory that the pipeline runs in.
* `--csv` takes a CSV file that points to the FASTQ files, and contains other parameters from the [cellranger multi](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-3p-multi) pipeline.

In this tutorial, you only need to edit a few lines in a pre-made CSV using a text editor of your choice. We are using the text editor `nano` to edit the CSV:

```
Copy

nano SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K.csv
```

Copy and paste the code block below into your text editor. For this example, there are three sections: `[gene-expression]`, `[libraries]`, and `[samples]`. **Important:** replace the `/path/to/` text with the full paths to the reference (in `[gene-expression]` section) and FASTQ files (in `[libraries]` section) that you downloaded before saving the CSV file.

```
Copy

[gene-expression]
ref,/path/to/refdata-gex-GRCh38-2020-A
create-bam,true

[libraries]
fastq_id,fastqs,lanes,feature_types
SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex,/path/to/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex,any,Gene Expression
SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture,/path/to/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture,any,Multiplexing Capture

[samples]
sample_id,cmo_ids,description
Jurkat,CMO301,Jurkat
Raji,CMO302,Raji
```

Alternatively, [download a multi config CSV template](/support/software/cell-ranger/latest/resources/cr-command-line-arguments) and customize it. Cell Ranger v7.1 enables users to download a multi config CSV template by running:

```
Copy

cellranger multi-template --output=/path/to/FILE.csv
```

Replace path above with the path to the directory in which you wish to output the template. Omitting the file path downloads the file into your working directory. After downloading, customize the template as shown above.

To print a list and description of all configurable parameters available in `cellranger multi`, run:

```
Copy

cellranger multi-template --parameters
```

Learn more about the multi [config CSV](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-3p-multi) on the running `cellranger multi` page, which also describes all the available sections, fields, and optional parameters.

**Optional:** If you want to analyze both sequence runs of the Multiplexing Capture library from this example dataset, add an additional line to the `[libraries]` section for the 2nd sequence run:

```
Copy

[libraries]
fastq_id,fastqs,lanes,feature_types
SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex,/path/to/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K/ SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_gex,any,Gene Expression
 SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture,/path/to/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_1_multiplexing_capture,any,Multiplexing Capture
 SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_2_multiplexing_capture,/path/to/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K/SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K_2_multiplexing_capture,any,Multiplexing Capture
```

### Set up the command for cellranger multi

Next run the `cellranger multi` command with `--help` to get the usage and a full list of modifiable parameters.

```
Copy

cellranger multi --help
```

The output looks similar to this:

```
Copy

cellranger-multi
Analyze multiplexed data or combined gene expression/immune profiling/feature barcode data

USAGE:
    cellranger multi [OPTIONS] --id <ID> --csv <CSV>

OPTIONS:
        --id                        A unique run id and output folder name [a-zA-Z0-9_-]+
        --description &ltTEXT&gt    Sample description to embed in output files [default: ]
        --csv &ltCSV&gt             Path of CSV file enumerating input libraries and analysis parameters
        --dry                   Do not execute the pipeline. Generate a pipeline invocation (.mro) file and stop
 ...
```

### Run cellranger multi

To run `cellranger multi`, enter a command such as:

```
Copy

cellranger multi --id=Jurkat_Raji_10K --csv=SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K.csv
```

Cell Ranger 6.0+ should start with a message like this:

```
Copy

Martian Runtime - v4.0.8
Running preflight checks (please wait)...
```

Depending on your computational resources, it may take some time for the pipeline to complete. When it does, it should conclude with a message like this:

```
Copy

Waiting 6 seconds for UI to do final refresh.
Pipestance completed successfully!
2022-05-09 19:20:44 Shutting down.
```

### Explore the output of cellranger multi

Next, examine the output files using the `tree` command:

```
Copy

cd Jurkat_Raji_10K/outs
tree
```

The `tree` command will list 73 directories with 96 files. (If you are used to a `cellranger count` run, recall that multiplexing two samples necessitates doubling the per-sample outputs, and these numbers will grow correspondingly as more samples are multiplexed into a single GEM well). Additionally, some output files are general to the entire experiment rather than a specific CMO.

The first section of the outputs contains the `config.csv` file, a duplicate of the input config CSV (`SC3_v3_NextGem_DI_CellPlex_Jurkat_Raji_10K.csv`). The `multi` directory contains a `count` directory and a `multiplexing_analysis` directory:

```
Copy

 └─ config.csv
 └─ multi
    ├── count
    │   ├── feature_reference.csv
    │   ├── raw_cloupe.cloupe
    │   ├── raw_feature_bc_matrix
    │   │   ├── barcodes.tsv.gz
    │   │   ├── features.tsv.gz
    │   │   └── matrix.mtx.gz
    │   ├── raw_feature_bc_matrix.h5
    │   ├── raw_molecule_info.h5
    │   ├── unassigned_alignments.bam
    │   └── unassigned_alignments.bam.bai
    └── multiplexing_analysis
        ├── assignment_confidence_table.csv
        ├── cells_per_tag.json
        ├── tag_calls_per_cell.csv
        └── tag_calls_summary.csv
```

For more information on these files, see [Cell Multiplexing Outputs](/support/software/cell-ranger/latest/analysis/outputs/cr-3p-outputs-cellplex).

The `per_sample_outs` directory contains two directories, one for `Jurkat` and one for `Raji`. For brevity, only the Jurkat outputs are shown here.

In the `Jurkat/count/analysis` directory, the `clustering` directory contains CSV files with the results of graph-based clusters and K-means clustering from 2-10:

```
Copy

 └── clustering
 ├── graphclust
 │   └── clusters.csv
 ├── kmeans_10_clusters
 │   └── clusters.csv
 ├── kmeans_2_clusters
 │   └── clusters.csv
 ├── kmeans_3_clusters
 │   └── clusters.csv
 ├── kmeans_4_clusters
 │   └── clusters.csv
 ├── kmeans_5_clusters
 │   └── clusters.csv
 ├── kmeans_6_clusters
 │   └── clusters.csv
 ├── kmeans_7_clusters
 │   └── clusters.csv
 ├── kmeans_8_clusters
 │   └── clusters.csv
 └── kmeans_9_clusters
     └── clusters.csv
```

The `diffexp` directory likewise contains CSV files with the results of differential expression analysis between the clusters reported above:

```
Copy

 └── diffexp
 ├── graphclust
 │   └── differential_expression.csv
 ├── kmeans_10_clusters
 │   └── differential_expression.csv
 ├── kmeans_2_clusters
 │   └── differential_expression.csv
 ├── kmeans_3_clusters
 │   └── differential_expression.csv
 ├── kmeans_4_clusters
 │   └── differential_expression.csv
 ├── kmeans_5_clusters
 │   └── differential_expression.csv
 ├── kmeans_6_clusters
 │   └── differential_expression.csv
 ├── kmeans_7_clusters
 │   └── differential_expression.csv
 ├── kmeans_8_clusters
 │   └── differential_expression.csv
 └── kmeans_9_clusters
     └── differential_expression.csv
```

The `pca`, `tsne`, and, `umap` directories contain CSV files for dimensionality reduction:

```
Copy

 ├── pca
 │   └── 10_components
 │       ├── components.csv
 │       ├── dispersion.csv
 │       ├── features_selected.csv
 │       ├── projection.csv
 │       └── variance.csv
 ├── tsne
 │   ├── 2_components
 │   │   └── projection.csv
 │   └── multiplexing_capture_2_components
 │       └── projection.csv
 └── umap
     ├── 2_components
     │   └── projection.csv
     └── multiplexing_capture_2_components
         └── projection.csv
```

The remaining `per_sample_outs` are described in the [Cell Multiplexing Outputs](/support/software/cell-ranger/latest/analysis/outputs/cr-3p-outputs-cellplex).

```
Copy

├── sample_cloupe.cloupe
├── feature_reference.csv
├── sample_alignments.bam
├── sample_alignments.bam.bai
├── sample_filtered_barcodes.csv
├── sample_filtered_feature_bc_matrix
│   ├── barcodes.tsv.gz
│   ├── features.tsv.gz
│   └── matrix.mtx.gz
├── sample_filtered_feature_bc_matrix.h5
├── sample_molecule_info.h5
├── metrics_summary.csv
└── web_summary.html
```

Questions or feedback about this tutorial? Contact [support@10xgenomics.com](mailto:support@10xgenomics.com).

On This Page
============

* [Get data](#data)
* [Create multi config CSV](#csv)
* [Set up the command for cellranger multi](#multisetup)
* [Run cellranger multi](#runmulti)
* [Explore the output of cellranger multi](#output)

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