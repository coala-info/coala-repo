Running Cell Ranger aggr | Official 10x Genomics Support

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

Running Cell Ranger aggr

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

Running Cell Ranger aggr
------------------------

This tutorial is written with Cell Ranger v6.1.2. Commands are compatible with later versions of Cell Ranger, unless noted otherwise.

The [cellranger aggr](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-3p-aggr) pipeline is optional. It is used to aggregate, or combine two `cellranger count` runs together. With experiments involving multiple samples, and multiple 10x Chromium GEM wells, libraries must each be processed in separate runs of `cellranger count`. To compare samples to each other for differential expression analysis, `cellranger aggr` is used to combine output files from each run of `cellranger count` to produce one single feature-barcode matrix and a `.cloupe` file for visualizing with Loupe Browser.

### Get data

Use the following publicly available `molecule_info.h5` files:

* [1,000 PBMC experiment](/datasets/1-k-pbm-cs-from-a-healthy-donor-v-3-chemistry-3-standard-3-0-0)
* [10,000 PBMC data set](/datasets/10-k-pbm-cs-from-a-healthy-donor-v-3-chemistry-3-standard-3-0-0)

Start by making a directory to run the `aggr` pipeline in:

```
Copy

mkdir run_cellranger_aggr
cd run_cellranger_aggr
```

Next, download the data files.

```
Copy

wget https://cf.10xgenomics.com/samples/cell-exp/3.0.0/pbmc_1k_v3/pbmc_1k_v3_molecule_info.h5
wget https://cf.10xgenomics.com/samples/cell-exp/3.0.0/pbmc_10k_v3/pbmc_10k_v3_molecule_info.h5
```

These are small files, less than 1GB each and usually take less than one minute to download.

### Create aggregation CSV

The next step is to build the CSV file. CSV stands for comma separated value. For specific instructions for creating this CSV, see the [cellranger aggr page](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-3p-aggr#csv_setup).

The CSV file is a two-column file. The first column is for the `sample id`. This id name can be anything you want. Choose descriptive ids since they are used later in the analysis. The second column contains the paths to the [molecule\_info.h5](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-molecule-info) output files from the `cellranger count` pipelines.

For Cell Ranger v6.0+ and Loupe Browser v5.1.0+, the libraries CSV header should be 'sample\_id,molecule\_h5'. For prior software versions, it should be 'library\_id,molecule\_h5'.

From the same directory where the HDF5 files were downloaded, use the `pwd` command to print out the path:

```
Copy

pwd
```

The output is similar to the following:

```
Copy

/path/to/run_cellranger_aggr
```

Copy the path to make the CSV file. Use the text editor of your choice to make this file. This example uses [nano](https://astrobiomike.github.io/unix/working-with-files-and-dirs#a-terminal-text-editor).

```
Copy

nano pbmc_aggr.csv
```

This opens the `nano` text editor. Paste the text into the editor. Edit the `/path/to/` part for each `molecule_info.h5` file so it matches the absolute path of the file on your system.

```
Copy

sample_id,molecule_h5
1k_pbmcs,/path/to/run_cellranger_aggr/pbmc_1k_v3_molecule_info.h5
10k_pbmcs,/path/to/run_cellranger_aggr/pbmc_10k_v3_molecule_info.h5
```

Exit out of the nano text editor by pressing CTRL+X keys and then pressing Y for "Yes" to save the file.

```
Copy

Save modified buffer (ANSWERING "No" WILL DESTROY CHANGES) ?
Y Yes
N No           ^C Cancel
```

Nano then asks you:

```
Copy

File Name to Write: pbmc_aggr.csv
```

Press the Enter key to confirm keeping this filename and saving the file. Now you are back to the command prompt.

We have now saved our Linux-formatted CSV file and exited out of the `nano` text editor.

### Set up the command for cellranger aggr

Run the `--help` command to print the usage statement and view the input requirements.

```
Copy

cellranger aggr --help
```

This command prints the following:

```
Copy

cellranger-aggr
Aggregate data from multiple Cell Ranger runs
USAGE:
   cellranger aggr [FLAGS] [OPTIONS] --id <ID> --csv <CSV>

FLAGS:
        --nosecondary    Disable secondary analysis, e.g. clustering
        --dry            Do not execute the pipeline. Generate a pipeline invocation (.mro) file and stop
        --disable-ui     Do not serve the web UI
        --noexit         Keep web UI running after pipestance completes or fails
        --nopreflight    Skip preflight checks
     -h, --help           Prints help information

 OPTIONS:
         --id <ID>               A unique run id and output folder name [a-zA-Z0-9_-]+
 ...
```

This pipeline has two inputs:

* `--id` is used to name the output directory that the pipeline runs in.
* `--csv` takes a CSV file that points to the outputs from the [cellranger count](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-gex-count) pipeline.

### Run cellranger aggr

Next, build the command line and run it.

```
Copy

cellranger aggr --id=1k_10k_pbmc_aggr --csv=pbmc_aggr.csv
```

The output is similar to the following:

```
Copy

2021-10-28 19:59:07 [perform] Serializing pipestance performance data.
Waiting 6 seconds for UI to do final refresh.
Pipestance completed successfully!

2021-10-28 19:59:13 Shutting down.
```

### Explore the output of cellranger aggr

Just like the other pipelines, when you see “Pipestance completed successfully!” the job is done, and the pipeline outputs are in the pipestance directory in the `outs/` folder. List the contents of this directory:

```
Copy

ls -1 1k_10k_pbmc_aggr/outs/
```

The output is similar to the following:

```
Copy

├── aggregation.csv
├── count
│   ├── analysis
│   │   ├── clustering
│   │   ├── diffexp
│   │   ├── pca
│   │   ├── tsne
│   │   └── umap
│   ├── cloupe.cloupe
│   ├── filtered_feature_bc_matrix
│   │   ├── barcodes.tsv.gz
│   │   ├── features.tsv.gz
│   │   └── matrix.mtx.gz
│   ├── filtered_feature_bc_matrix.h5
│   └── summary.json
└── web_summary.html
```

The outputs are similar to those from the [cellranger count](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-gex-count) pipeline, with the exception of the [BAM](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-bam) files and [molecule\_info.h5](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-molecule-info) files. More information about outputs is available in the [Understanding Outputs section](/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-overview).

On This Page
============

* [Get data](#getdata)
* [Create aggregation CSV](#createcsv)
* [Set up the command for cellranger aggr](#aggrcommand)
* [Run cellranger aggr](#runaggr)
* [Explore the output of cellranger aggr](#exploreaggr)

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