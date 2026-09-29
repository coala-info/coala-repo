Cell Ranger ARC Pipeline Telemetry | Official 10x Genomics Support

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

[Support home](/support)[Cell Ranger ARC](/support/software/cell-ranger-arc/latest)[Tutorials](/support/software/cell-ranger-arc/latest/tutorials)

Cell Ranger ARC Pipeline Telemetry

[Cell Ranger ARC](/support/software/cell-ranger-arc/latest)

---

* [Overview](/support/software/cell-ranger-arc/latest)
* [Getting Started](/support/software/cell-ranger-arc/latest/getting-started/what-is-cell-ranger-arc)
* [Download Center](/support/software/cell-ranger-arc/downloads)
* [Cloud Analysis](https://cloud.10xgenomics.com/cloud-analysis)
* [Analysis](/support/software/cell-ranger-arc/latest/analysis)
  + Inputs

    * [Specifying FASTQs](/support/software/cell-ranger-arc/latest/analysis/inputs/specifying-input-fastq-count)
    * [FASTQs with Illumina Software](/support/software/cell-ranger-arc/latest/analysis/inputs/direct-demultiplexing-with-illumina-software)
    * [Custom Reference (mkref)](/support/software/cell-ranger-arc/latest/analysis/inputs/mkref)
  + Running Pipelines

    * [Command Line Arguments](/support/software/cell-ranger-arc/latest/analysis/running-pipelines/command-line-arguments)
    * [Computing Options](/support/software/cell-ranger-arc/latest/analysis/running-pipelines/different-ways-of-running-cell-ranger-arc)
    * [Analyzing GEX + ATAC (count)](/support/software/cell-ranger-arc/latest/analysis/running-pipelines/single-library-analysis)
    * [Aggregating Multiple Samples (aggr)](/support/software/cell-ranger-arc/latest/analysis/running-pipelines/aggregating-multiple-gem-wells-aggr)
    * [Custom Analysis (reanalyze)](/support/software/cell-ranger-arc/latest/analysis/running-pipelines/customized-secondary-analysis-reanalyze)
    * [Cell Type Annotation](/support/software/cell-ranger-arc/latest/analysis/running-pipelines/cr-arc-cell-annotation-pipeline)
  + Outputs

    * [Overview](/support/software/cell-ranger-arc/latest/analysis/outputs/understanding-output)
    * [Web Summary](/support/software/cell-ranger-arc/latest/analysis/outputs/web-summary)
    * [Secondary Analysis](/support/software/cell-ranger-arc/latest/analysis/outputs/multiome-atac-gene-expression-analysis)
    * [Feature-Barcode Matrices](/support/software/cell-ranger-arc/latest/analysis/outputs/feature-barcode-matrices)
    * [Summary CSV](/support/software/cell-ranger-arc/latest/analysis/outputs/metrics)
    * [Per Barcode QC Metrics](/support/software/cell-ranger-arc/latest/analysis/outputs/per-barcode-qc-metrics)
    * [ATAC Barcoded BAM](/support/software/cell-ranger-arc/latest/analysis/outputs/atac-barcoded-bam)
    * [ATAC Fragments](/support/software/cell-ranger-arc/latest/analysis/outputs/fragments-file)
    * [ATAC Peaks](/support/software/cell-ranger-arc/latest/analysis/outputs/peaks-file)
    * [ATAC Peak Annotations](/support/software/cell-ranger-arc/latest/analysis/outputs/peak-annotations)
    * [ATAC Transposition Counts](/support/software/cell-ranger-arc/latest/analysis/outputs/transposition-counts)
    * [GEX Barcoded BAM](/support/software/cell-ranger-arc/latest/analysis/outputs/barcoded-bam)
    * [GEX Molecule Info (H5)](/support/software/cell-ranger-arc/latest/analysis/outputs/molecule-info-hdf5-h5)
    * [HDF5 Feature Barcode Matrix Format](/support/software/cell-ranger-arc/latest/analysis/outputs/outputs-h5-matrices)
    * [Cell Type Annotations](/support/software/cell-ranger-arc/latest/analysis/outputs/cr-arc-cell-annotation-outputs)
* [Tutorials](/support/software/cell-ranger-arc/latest/tutorials)
* [Algorithms](/support/software/cell-ranger-arc/latest/algorithms-overview)
* [Advanced](/support/software/cell-ranger-arc/latest/advanced)
* [Troubleshooting](/support/software/cell-ranger-arc/latest/analysis/troubleshooting)
* [Release Notes](/support/software/cell-ranger-arc/latest/release-notes)
* [Q&A](https://kb.10xgenomics.com/hc/en-us)
* [Datasets](/datasets)
* [Loupe Browser](/support/software/loupe-browser/latest)

Version

v2.2 (Latest)

Cell Ranger ARC Pipeline Telemetry
----------------------------------

### What is Telemetry?

Telemetry is the automated process of collecting, transmitting, and analyzing data from remote sources to monitor and improve system performance and user experience. These data include metrics collected from analysis software spanning categories such as product performance, user interactions, and application usage.

### Trust and data concerns

We understand that many customers work with sensitive data and may have restrictions on sharing any sample-derived information with third parties. To support these needs, our software does not collect sequence or any data that could be considered sensitive. Additionally, **telemetry collection is completely optional and can be disabled at any time without affecting software functionality**.

We provide detailed descriptions of all collected data, as well as the ability to inspect the information sent to us. This transparency is designed to give you confidence in making an informed choice about enabling telemetry collection.

### Categories of data collected and their uses

To improve our products and services, we collect specific types of data. Here is an overview of the types of data we collect and examples of how we use each:

#### 1) Usage Data:

*Examples*: Feature usage frequency, user interface interactions, duration of analysis.

*Purpose*: Our goal is to understand how users use our products, which features are most used, and identify areas needing improvement.

#### 2) Performance Data:

*Examples*: Assay and software usage patterns and performance metrics.

*Purpose*: Our goal is to continuously improve our assay performance for our customers. To this end, we collect high-level cell, library, and mapping quality metrics that are present in the web summary. Importantly, we do not collect experimental results, such as gene expression levels.

#### 3) Device Information:

*Examples*: Operating system versions, hardware specifications.

*Purpose*: Our goal is to optimize our software for different devices and operating systems.

#### 4) Crash Reports:

*Examples*: Error codes, conditions leading to a crash.

*Purpose*: To identify and fix bugs, improve application stability, and prevent crashes.

See the [list of all collected metrics](/support/software/cell-ranger-arc/latest/miscellaneous/cr-arc-telemetry-metrics-summary) in Cell Ranger ARC v2.1.

When commands initiating a pipestance are run (e.g., `cellranger-arc count`), a copy of the data from that run is saved in the `extras/` folder of that pipestance. An exception occurs with `cellranger-arc mkref`, where the default reference output is cleaned up to include only necessary reference files for data processing. As a result, the `extras/` folder will not be present in this case. If you wish to review telemetry data in this context, please specify the `output-dir` location.

### Modifying telemetry collection options

At 10x Genomics, we value your privacy and give you control over your data. You can manage telemetry collection and transmission in two ways: by using a command-line argument or setting an environment variable. If both options are used, the environment variable will take precedence. This setup is particularly useful for users on shared resources, allowing telemetry preferences to be set globally for all users of the pipeline installation. If you choose to disable telemetry, 10x will have no knowledge that telemetry has been disabled.

For those who prefer the command line, telemetry collection can be disabled with the following option:

#### Disabling Telemetry Collection

```
Copy

cellranger-arc telemetry disable
```

#### Enabling Telemetry Collection

```
Copy

cellranger-arc telemetry enable
```

#### Check Telemetry Settings

```
Copy

cellranger-arc telemetry check
```

### Environment settings

#### Disabling Telemetry Collection

To disable telemetry collection, set the `TENX_DISABLE_TELEMETRY` variable. This ensures that no telemetry data is collected or processed for any pipelines using this version of the software installation.

```
Copy

export TENX_DISABLE_TELEMETRY=1
```

#### Enabling Telemetry Collection

Telemetry is enabled by default with each installation, so no action is needed unless it has been previously turned off. Unsetting the variable `TENX_DISABLE_TELEMETRY` will re-enable telemetry collection.

```
Copy

unset TENX_DISABLE_TELEMETRY
```

To disable telemetry uploads for all users on a machine, create the file `/etc/tenx/telemetry/disable_upload`.

To disable downloading and updating the telemetry configuration for all users on a machine, create the file `/etc/tenx/telemetry/disable_update`.

To re-enable telemetry uploads, remove the file.

### How telemetry data are made secure

Protecting collected data is a top priority. We implement multiple layers of security to keep telemetry information safe:

* **Anonymization**: We do not collect personally identifiable information, ensuring both your identity and that of human sample donors remain protected. To further safeguard privacy, we do not collect any user-entered free-text fields or genetic data, minimizing the chance of inadvertently gathering identifiable information.
* **Access controls**: We enforce strict access controls to ensure that only authorized personnel can view or handle telemetry data, limiting access to those with explicit permission.
* **Data encryption**: Data is encrypted both during transmission and storage to protect against unauthorized access and ensure data security at all times.
* **Regular audits**: We perform regular internal security audits and assessments to proactively identify and address potential vulnerabilities in our data collection and storage processes.
* **Compliance**: We routinely review our data handling practices to ensure compliance with relevant legal and regulatory requirements, including GDPR and other data protection laws.

If you have any questions or concerns about our telemetry practices, please feel free to contact our support team at [support@10xgenomics.com](mailto:support@10xgenomics.com). Your privacy and security are our top priorities, and we are here to assist you.

On This Page
============

* [What is Telemetry?](#what-is-telemetry)
* [Trust and data concerns](#trust)
* [Categories of data collected and their uses](#data-categories)
* [Modifying telemetry collection options](#modify-telemetry-collection)
* [How telemetry data are made secure](#securing-data)

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