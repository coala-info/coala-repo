Analyzing Barcode Enabled Antigen Mapping for B Cells (BEAM-Ab) with Cell Ranger multi | Official 10x Genomics Support

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

Analyzing Barcode Enabled Antigen Mapping for B Cells (BEAM-Ab) with Cell Ranger multi

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

Analyzing Barcode Enabled Antigen Mapping for B Cells (BEAM-Ab) with Cell Ranger multi
--------------------------------------------------------------------------------------

This tutorial is written with Cell Ranger v7.1.0. Starting with Cell Ranger v8.0, it is mandatory to use the `--create-bam` parameter when executing the `cellranger count` and `cellranger multi` pipelines. This new parameter replaces the previously used `--no-bam` option. All other arguments remain compatible with newer versions, unless otherwise specified.

### Prerequisites

To follow along, you must:

* Have basic UNIX command line experience
* [Fulfill these system requirements](/support/software/cell-ranger/downloads)
* [Download and install the Cell Ranger software](/support/software/cell-ranger/downloads)
* [Choose a compute platform](/support/software/cell-ranger/downloads)
* Have access to a UNIX command prompt

### Example dataset

We will work with the [2k Transgenic HEL Mouse Splenocytes (BEAM-Ab)](/datasets/2k-transgenic-hel-mouse-splenocytes-beam-ab-2-standard) dataset.

### Download example FASTQs

Open up a terminal window. You may log in to a remote server or choose to perform the compute on your local machine. Refer to the [System Requirements](/support/software/cell-ranger/downloads) page for details.

In the working directory, create a new folder called `beam-ab` and `cd` into that folder:

```
Copy

mkdir beam-ab
cd beam-ab
```

Download the input FASTQ files:

```
Copy

curl -O https://cf.10xgenomics.com/samples/cell-vdj/7.1.0/2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex/2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_fastqs.tar
```

A file named `2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_fastqs.tar` should appear in your directory when you list files with the `ls -lt` command.

Decompress the FASTQs:

```
Copy

tar -xvf 2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_fastqs.tar
```

You should now see a folder called `2k_BEAM-Ab_Mouse_HEL_5pv2_fastqs`

```
Copy

cd 2k_BEAM-Ab_Mouse_HEL_5pv2_fastqs
ls
```

The folder contains three subfolders with library-specific FASTQS files: `antigen_capture`, `gex`, and `vdj`.

Navigate back to the working directory:

```
Copy

cd ..
```

Double check you are in the correct directory by running the ls command; the working directory should have the FASTQs `2k_BEAM-Ab_Mouse_HEL_5pv2_fastq` folder.

### Download example Feature Reference CSV

Download the [Feature Reference CSV](https://cf.10xgenomics.com/samples/cell-vdj/7.1.0/2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex/2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_count_feature_reference.csv) available for this example dataset.

```
Copy

curl -O https://cf.10xgenomics.com/samples/cell-vdj/7.1.0/2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex/2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_count_feature_reference.csv
```

To view the contents of the Feature Reference CSV, open it in your text editor of choice (e.g., nano)

```
Copy

nano 2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_count_feature_reference.csv
```

The contents should look like this:

```
Copy

id,name,read,pattern,sequence,feature_type
SARS-TRI-S_WT,SARS-TRI-S_WT,R2,^(BC),CGATGCCGGACGATC,Antigen Capture
Anti-Hen_Egg_Lysozyme,Anti-Hen_Egg_Lysozyme,R2,^(BC),CCGTCTCACCGATAT,Antigen Capture
gp120,gp120,R2,^(BC),GATTGGCTACTCAAT,Antigen Capture
H5N1,H5N1,R2,^(BC),CGGCTCACCGCGTCT,Antigen Capture
negative_control,negative_control,R2,^(BC),CTATCTACCGGCTCG,Antigen Capture
```

Since this is a BEAM-Ab (BCR Antigen Capture) dataset, the Feature Reference CSV does NOT contain the additional mhc\_allele column. The [BEAM-T tutorial](/support/software/cell-ranger/latest/tutorials/cr-tutorial-multi-beam-t) tutorial guides you through analyzing a TCR Antigen Capture dataset.

You do not need to change the Feature Reference CSV for this tutorial. Remember to customize it when working with your own data. Learn more about the [Feature Reference CSV](/support/software/cell-ranger/latest/analysis/running-pipelines/cr-5p-antigen#feature-ref).

### Download the mouse reference transcriptome and custom-made mouse V(D)J reference

As of this tutorial's publication, the most current is the Mouse reference (mm10) - 2020-A. Download the [pre-built mouse reference transcriptome](https://cf.10xgenomics.com/supp/cell-vdj/refdata-gex-mm10-2020-A.tar.gz) to the working directory (beam-ab) and decompress it:

```
Copy

curl -O https://cf.10xgenomics.com/supp/cell-vdj/refdata-gex-mm10-2020-A.tar.gz
tar -xvf refdata-gex-mm10-2020-A.tar.gz
```

Download the custom built mouse V(D)J reference in the working directory and decompress it:

```
Copy

curl -O https://cf.10xgenomics.com/samples/cell-vdj/7.1.0/2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex/2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_vdj_reference.tar.gz
tar -xvf 2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_vdj_reference.tar.gz
```

### Download or create a multi config CSV

In your working directory, create a new CSV file called `2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_config.csv` using your text editor of choice. For example, you can create a file with nano using this command:

```
Copy

nano 2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_config.csv
```

Copy and paste this text into the newly created file and customize the `/path/to/...` part of file paths:

```
Copy

[gene-expression]
ref,/path/to/references/refdata-gex-mm10-2020-A
create-bam,true

[feature]
ref,/path/to/feature_references/2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_count_feature_reference.csv

[vdj]
ref,/path/to/references/vdj_reference

[libraries]
fastq_id,fastqs,lanes,feature_types
beamab_mouse_hel_ag,/path/to/fastqs/2k_BEAM-Ab_Mouse_HEL_5pv2_fastqs/antigen_capture,1|2|3|4,Antigen Capture
beamab_mouse_hel_vdj,/path/to/fastqs/2k_BEAM-Ab_Mouse_HEL_5pv2_fastqs/vdj,1|2|3|4,VDJ-B
beamab_mouse_hel_gex,/path/to/fastqs/2k_BEAM-Ab_Mouse_HEL_5pv2_fastqs/gex,1|2|3|4,Gene Expression

[antigen-specificity]
control_id,
negative_control
```

Use your text editor's save command to save the file. In nano, save by typing `CTRL`+`X` → `y` → `ENTER`.

A customizable multi config CSV template is available for download on the [example dataset page](/datasets/2k-transgenic-hel-mouse-splenocytes-beam-ab-2-standard), under the Input Files tab.

### Set up the directory for running multi

Once you have all the necessary files, make a new directory called `runs/` in your `beam-ab/` working directory:

```
Copy

mkdir runs/
cd runs/
```

You will run `cellranger multi` in the runs/ directory.

### Set up the command for running multi

After downloading/creating the FASTQ files, Feature Reference CSV, reference transcriptome, and V(D)J reference, you are ready to run `cellranger multi`.

Print the usage statement to get a list of all the options:

```
Copy

cellranger multi --help
```

The output should look similar to:

```
Copy

user_prompt$ cellranger multi --help
cellranger-multi
Analyze multiplexed data or combined gene expression/immune profiling/feature
barcode data
USAGE:
    cellranger multi [FLAGS] [OPTIONS] --id  --csv
FLAGS:
        --dry            Do not execute the pipeline. Generate a pipeline
                        invocation (.mro) file and stop
        --disable-ui     Do not serve the web UI
        --noexit         Keep web UI running after pipestance completes or fails
        --nopreflight    Skip preflight checks
    -h, --help           Prints help information
OPTIONS:
        --id                A unique run id and output folder name [a-zA-Z0-
                                9_-]+
        --description     Sample description to embed in output files
                                [default: ]
        --csv              Path of CSV file enumerating input libraries and
                                analysis parameters
        --jobmode         Job manager to use. Valid options: local
                                (default), sge, lsf, slurm or path to a
                                .template file. Search for help on "Cluster
                                Mode" at 10xgenomics.com/support for more
                                details on configuring the pipeline to use a
                                compute cluster [default: local]
        --localcores       Set max cores the pipeline may request at one
                                time. Only applies to local jobs
        ....
```

**Options used in this tutorial**

| Option | Description |
| --- | --- |
| `--id` | The id argument must be a unique run ID. We will call this run `HumanB_Cell_multi` based on the sample type in the example dataset. |
| `--csv` | Path to the multi config CSV file enumerating input libraries and analysis parameters. Your `multi_config.csv` file is in the working directory. When executing `cellranger multi` from the runs directory, the relative path should be: `../multi_config.csv` |

### Run the multi pipeline

From within the `beam-ab/runs/` directory, run `cellranger multi`

```
Copy

/path/to/cellranger-7.1.0/cellranger multi --id=beam-ab-run --csv=../2k_BEAM-Ab_Mouse_HEL_5pv2_Multiplex_config.csv
```

The run begins similarly to this:

```
Copy

    Martian Runtime - v4.0.10

    2023-06-15 11:44:24 [jobmngr] WARNING: configured to use 334GB of local memory, but only 194.9GB is currently available.

    Serving UI at http://bespin3.fuzzplex.com:34513?auth=-Sm5gsg6_G8FjcUX0_YD5J8SYoBODz4IWoVIK9ec0jg


    Running preflight checks (please wait)...
    2023-06-15 11:44:33 [runtime] (ready)           ID.beam-ab-run.SC_MULTI_CS.PARSE_MULTI_CONFIG
    2023-06-15 11:44:33 [runtime] (run:local)       ID.beam-ab-run.SC_MULTI_CS.PARSE_MULTI_CONFIG.fork0.chnk0.main
    2023-06-15 11:44:56 [runtime] (chunks_complete) ID.beam-ab-run.SC_MULTI_CS.PARSE_MULTI_CONFIG
    2023-06-15 11:44:56 [runtime] (ready)           ID.beam-ab-run.SC_MULTI_CS.FULL_COUNT_INPUTS.WRITE_GENE_INDEX
    2023-06-15 11:44:56 [runtime] (run:local)       ID.beam-ab-run.SC_MULTI_CS.FULL_COUNT_INPUTS.WRITE_GENE_INDEX.fork0.chnk0.main
    ....
```

When the output of the `cellranger multi` command says, “Pipestance completed successfully!”, the job is done:

```
Copy

      web_summary:      /jane.doe/ab/runs/beam-ab-run/outs/per_sample_outs/beam-ab/web_summary.html
    metrics_summary:  /jane.doe/beam-ab/runs/beam-ab-run/runs/beam-ab/outs/per_sample_outs/beam-ab/metrics_summary$
    }

    Waiting 6 seconds for UI to do final refresh.
    Pipestance completed successfully!
```

### Generate and explore the output files

A successful `cellranger multi` run produces a new directory called `beam-ab-run` (based on the `--id` flag specified during the run). The contents of the `beam-ab-run/` directory:

```
Copy

    .
    ├── beam-ab-run
    │   ├── beam-ab.mri.tgz
    │   ├── _cmdline
    │   ├── _filelist
    │   ├── _finalstate
    │   ├── _invocation
    │   ├── _jobmode
    │   ├── _log
    │   ├── _mrosource
    │   ├── outs
    │   ├── _perf
    │   ├── _perf._truncated_
    │   ├── SC_MULTI_CS
    │   ├── _sitecheck
    │   ├── _tags
    │   ├── _timestamp
    │   ├── _uuid
    │   ├── _vdrkill
    │   └── _versions
```

The `outs/` directory contains all important output files generated by the `cellranger multi` pipeline:

```
Copy


── runs
    └── beam-ab-run
        └──outs
            ├── config.csv
            ├── multi
            │   ├── count
            │   │   ├── feature_reference.csv
            │   │   ├── raw_cloupe.cloupe
            │   ├── raw_feature_bc_matrix
            │   │   ├── raw_feature_bc_matrix.h5
            │   │   ├── raw_molecule_info.h5
            │   │   ├── unassigned_alignments.bam
            │   │   └── unassigned_alignments.bam.bai
            │   └── vdj_b
            │       ├── all_contig_annotations.bed
            │       ├── all_contig_annotations.csv
            │       ├── all_contig_annotations.json
            │       ├── all_contig.bam
            │       ├── all_contig.bam.bai
            │       ├── all_contig.fasta
            │       ├── all_contig.fasta.fai
            │       └── all_contig.fastq
            ├── per_sample_outs
            │   └── beam-ab
            │       ├── antigen_analysis
            │       ├── count
            │       ├── metrics_summary.csv
            │       ├── vdj_t
            │       └── web_summary.html
            └── vdj_reference
                ├── fasta
                │   ├── donor_regions.fa
                │   └── regions.fa
                └── reference.json
```

On This Page
============

* [Prerequisites](#prerequisites)
* [Example dataset](#example-data)
* [Download example FASTQs](#download-fastq)
* [Download example Feature Reference CSV](#multi-feature-ref)
* [Download the mouse reference transcriptome and custom-made mouse V(D)J reference](#download-reference)
* [Download or create a multi config CSV](#multi-config-csv)
* [Set up the directory for running multi](#setup)
* [Set up the command for running multi](#setup-command)
* [Run the multi pipeline](#run-pipeline)
* [Generate and explore the output files](#outputs)

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