# Ularcirc: A shiny application for canonical and back splicing analysis

David Humphreys1, Nicolas Fossat2, Patrick Tam2 and Joshua Ho3

1Genomics Core, Victor Chang Cardiac Research Institute
2Embryology Unit, Children's Medical Research Institute
3Bioinformatics and Systems Medicine Laboratory, Victor Chang Cardiac Research Institute

#### October 30, 2025

#### Abstract

This vignette provides walkthroughs on how to install and use Ularcirc. Ularcirc provides a broad spectrum of analysis tools for circRNA analysis inlcuding identification, backsplice junction visualisation, sequence analysis (ORF and miRNA binding sites). One sample data set is provided with installation.

# Contents

* [1 Introduction](#introduction)
* [2 Quickstart](#quickstart)
* [3 Preparing input data sets](#preparing-input-data-sets)
  + [3.1 Splice junction files](#splice-junction-files)
  + [3.2 Annotation databases](#annotation-databases)
* [4 Workflow](#workflow)
  + [4.1 Step 1a: Loading annotation data](#step-1a-loading-annotation-data)
  + [4.2 Step 1b: Setting filters](#step-1b-setting-filters)
    - [4.2.1 Genomic filters](#genomic-filters)
    - [4.2.2 circRNA filters](#circrna-filters)
  + [4.3 Step 1c: Loading new data sets](#step-1c-loading-new-data-sets)
  + [4.4 Step 2a: Saving/loading a project and grouping samples](#step-2a-savingloading-a-project-and-grouping-samples)
  + [4.5 Step 2b: Grouping samples](#step-2b-grouping-samples)
  + [4.6 Step 3a : Generating BSJ counts](#step-3a-generating-bsj-counts)
  + [4.7 Step 3b : Visualising gene splicing patterns](#step-3b-visualising-gene-splicing-patterns)
  + [4.8 Exploring slicing patterns from any genomic region](#exploring-slicing-patterns-from-any-genomic-region)
  + [4.9 Step 5: Sequence analysis of splice/backsplice junctions](#step-5-sequence-analysis-of-splicebacksplice-junctions)
* [5 Session Information———————————–](#session-information)

# 1 Introduction

Splicing is the removal of intronic sequences from a nascent pre-mRNA transcript resulting in the formation of mature mRNA. There are numerous mechanisms of splicing and is a regulated process that typically involves multiple RNA-binding proteins. In Eukaryotes splicing can result in gene isoforms, poly-cistronic transcripts, gene fusions and circular RNA (circRNA).

The complexities of splicing can be captured by RNA-Sequencing. Ularcirc takes canonical forward slice junction (FSJ) and backsplice junction (BSJ) outputs generated from a variety of programs (STAR aligner, Regtools, circExplorer2, CIRI2) and provides a platform to integrate and analyse these datasets. Ularcirc provides visualisation and analysis tools for both forward canonical splice junctions (generated from mature mRNAs) and backsplice junctions (generated from circRNAs). Ularcirc dynamically generates visualisations, including the ability to a zoom to defined regions within a gene locus, and furthermore can extract the transcript sequence that spans specific exon junctions.

In theory Ularcirc can be operated on any hardware capable of running the R-programing language. All operations proceed in real time via a menu driven interactive analysis where data tables and visualization are generated dynamically. Ularcirc does not require significant computational resources and is currently implemented to operate on one CPU thread. The saved project data sets are small (typically in the low MB range) which enables easy sharing of data files. Introductory tutorials on how to use Ularcirc can be found on youtube.

Ularcirc is comprised of numerous interactive screens that comprise of a main and side panel. The main panel allows the selection of one of four tabs which are titled `Setup`, `Project`, `Gene_View`, `Genome_View`, `Junction_View`. A different side panel exists for each main panel and display specific options that help direct and assemble analysis. The main panel will display output relevant for each stage of circRNA analysis which this vignette describes in detail. Users should be aware that some analysis may take time to complete and floating status bars will notify of the progress.
\end{abstract}

# 2 Quickstart

The following demonstrates how to download Ularcirc, install the required databases, and then visualise canonical and backsplice junctions counts of the gene Slc8a1.

STEP1: Install Ularcirc package

```
if (!requireNamespace("BiocManager", quietly=TRUE))
        install.packages("BiocManager")
BiocManager::install("Ularcirc")
```

STEP2: Load annotation databases: Ularcirc comes with one existing data set that has been aligned to hg38. While annotation is not required to identify circRNAs we recomment to download the respective human annotation databases as follows:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
        install.packages("BiocManager")

\dontrun {
  BiocManager::install(c("BSgenome.Hsapiens.UCSC.hg38",         # Genome; enables sequence analysis
                      "TxDb.Hsapiens.UCSC.hg38.knownGene",    # Transcript database
                      "org.Hs.eg.db"))                        # Annotation database
      }
```

STEP3: Start Ularcirc, load annotation database, load project data

```
library(Ularcirc)
Ularcirc()
```

If the annotation + transcript + genome databases have been loaded `LOAD TRANSCRIPT DATABASE` they should automatically populate on the left panel (as shown in figure [1](#fig:HG38AvailableDatabases). Press `LOAD TRANSCRIPT DATABASE` and below this button will appear the text `Hsapiens.UCSC.hg38`.

![Screenshot of Ularcirc available annotations](data:image/png;base64...)

Figure 1: Screenshot of Ularcirc available annotations

The preloaded data set is called TwoSzabo which is loaded via the Project tab. Upon loading a popup window will appear displaying Associated meta data (contains information for your reference). Click any where outside this window to close it. Two data files should now appear under `Selected Sample` and `Grouped analysis` headings on main tab.

STEP4:

Navigate to `Gene_View` tab. The TwoSzabo data set contains two sources of BSJ and one source of FSJ data. The BSJ data is generated from either the STAR Chimeric output junction file or from circExplorer2. There is a radio button under
`BSJ data source` that allows you to select which data set you wish to analyse. Before analysing either BSJ you will need
to assemble collated BSJ data tables. To do this for circExplorer2 data ensure that the circExplorer2 radio button is selected and then press `build table` on left hand panel under `Table Display Options`. For STAR derived BSJ data select the STAR radio button then select `Annotate with parental gene` as shown in figure [2](#fig:AnnotatingTwoSzabo). For STAR BSJ data you need to select how many BSJ you wish to identify by selecting a number under `Number of BS junctions to display` (i.e the higher the number the more time it will take to assemble. Note that during this process the most abundant BSJ first). Next select `build table` and thereafter Ularcirc will build a table of annotated backspice junction counts.

![Screenshot of Ularcirc Gene view tab.](data:image/png;base64...)

Figure 2: Screenshot of Ularcirc Gene view tab

Select the first entry in the table (it will highlight in blue). Next select `Display_Gene_Transcripts` from the left side tab under heading `DISPLAY MODE`. This will dynamically generate a visualisation of Slc8a1 with both backsplice and canonical forward splice junctions.

![Screenshot of Slc8a1 back splice  and canonical splice junctions.](data:image/png;base64...)

Figure 3: Screenshot of Slc8a1 back splice and canonical splice junctions

View [this 5 minute screencast](https://youtu.be/96rcxlh_aLA) which will cover the above points and more.

# 3 Preparing input data sets

## 3.1 Splice junction files

Ularcirc requires canonical and chimeric splice junction output files generated from the STAR aligner which MUST contain the default file extensions of SJ.out.tab and Chimeric.out.junction respectively. For detailed instructions on how to use the STAR aligner read the [STAR manual](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=3&cad=rja&uact=8&ved=2ahUKEwj0gvya2bTlAhXHZSsKHY2lD4EQjBAwAnoECAYQDw&url=https%3A%2F%2Fgithub.com%2Falexdobin%2FSTAR%2Fblob%2Fmaster%2Fdoc%2FSTARmanual.pdf&usg=AOvVaw1EesFwxpCNWl9z5B4XIFuf). Note that the STAR aligner requires significant computational resources. There are publically available GALAXY resources to run STAR if you do not have access to other high performance computational resources <https://usegalaxy.org>).
To generate the required chimeric junction files the following two parameters must be supplied to the STAR aligner. The numeric value provided to each parameter describes features used to detect chimeric reads and therefore may need to be altered to improve sensitivity and accuracy.

```
--chimSegmentMin 15  --chimJunctionOverhangMin 15
```

Ularcirc can only add files to individual projects via one upload. Attempting to upload multiple times will only result in previous upload being overwritten by the current upload. Individual or multiple samples are identified by a common file prefix. Therefore for a given project all splice junction files must be located in a common directory and have the appropriate file prefix. For example if the following files were uploaded into Ularcirc:

```
SRR12345678_e17.5_heart.Chimeric.out.junction
SRR12345678_e17.5_heart.SJ.out.tab
SRR87654321_P10_heart.Chimeric.out.junction
SRR87654321_P10_heart.SJ.out.tab
```

The above example would result in two samples IDs being imported into Ularcirc, SRR123456768\_e17.5\_heart and SRR87654321\_P10\_heart. It is highly recommended to provide a descriptive name as Ularcirc provides no functionality at this time to rename samples. After files are uploaded the Project filename can be entered and saved. The STAR aligner can be instructed to assign a common prefix to output files. This can be specified with the following option:

```
--outFileNamePrefix Type_your_prefix_here
```

## 3.2 Annotation databases

Ularcirc can annotate backsplice and canonical splice junctions via integrating bioconductor databases. Three installations are required per organism, examples of the required datasets for the most recent human and mouse is shown below.

| Database type | Database name for hg38 |
| --- | --- |
| BSGenome | BSgenome.Hsapiens.UCSC.hg38 |
| TxDb | TxDb.Hsapiens.UCSC.hg38.knownGene |
| OrgDatabase | org.Hs.eg.db |

| Database type | Database names for mm10 |
| --- | --- |
| BSGenome | BSgenome.Mmusculus.UCSC.mm10 |
| TxDb | TxDb.Mmusculus.UCSC.mm10.knownGene |
| OrgDatabase | org.Mm.eg.db |

# 4 Workflow

Ularcirc is designed to follow a logical systematic workflow which is broken down into five key steps. Each step is can be performed via a tabs that can be selected via the main panel as shown in figure . The workflow commences on the left most tab (setup) which is the initial screen displayed. The setup tab also provides a quickstart guide that briely describes the workflow. This chapter provides a more in depth overview of each of these steps and users are encouraged to familiarise themselves with the contents of this chapter to make the most out of Ularcirc.

## 4.1 Step 1a: Loading annotation data

Upon startup Ularcirc loads and displays contents on the `setup` tab within the main panel. The side panel can be configured to one of three options which is selected via the pulldown menu under `Step configuration`. The default configuration is Load transcript database which enables the selection of organism, genome and transcriptome databases via separate pulldown menus under the heading `ORGANISM`. If three pulldown menus are not populated this indicates that databases have not been installed from bioconductor.

## 4.2 Step 1b: Setting filters

### 4.2.1 Genomic filters

Ularcirc provides both genomic filtering options and circRNA filtering options. Genomic filtering provides options to limit chimeric (BSJ) detection to defined genomic distances/locations. The default limits are designed to capture the majority of mammalian circRNAs. However these limits can be relaxed which will increase the number of chimeric candidates and potentially false positives. Below is a description of the genomic filters:

| Filter | Description |
| --- | --- |
| Same chromosomes | Selecting this checkbox will only select chimeric reads that span a common chromosome. |
| Chimeric genomic distance | This is the maximum and minimum chimeric distance considered for chimeric junctions that are identified on the same chromosome. The default settings will not detect and chimeric junction that spans less than 200nt or longer than 100000nt. |
| Same strand | Will only select chimeric junctions that are from the same strand. |

### 4.2.2 circRNA filters

Two circRNA filters are designed to discriminate between FALSE and TRUE positives. The first filter is the read alignment distribution (RAD) score which is the ratio of type II and type III alignments. It can only be calculated for paired end sequencing data and should only be applied to BSJ that have a reasonable depth (eg > 9).

The second filter is called `FSJ support` which identifies if each of the BSJ coordinates are also utilised in FSJ. Given that there are two coordinates that define a BSJ the corresponding FSJ support metric can have a value of 0, 1 or 2. A FSJ support score can be calculated for all BSJ irrespective of read count.

Ularcirc provides functionality to filter BSJ against pre-defined values for both the RAD and FSJ support metrics. The default thresholds can be modified under the gene tab after selecting DisplayFilterOptions checkbox (see image below)

## 4.3 Step 1c: Loading new data sets

Ularcirc requires output files that can be generated from the following programs: STAR aligner, circExplorer2, CIRI2, regtools. For full functionality at least one FSJ, one BSJ, and one gene count data set be loaded per sample. The STAR aligner produces FSJ, BSJ and gene count output files which have the following preset file extensions: SJ.out.tab (FSJ), Chimeric.out.junction (chimeric junctions), and ReadsPerGene.tab.out (gene counts). CircExplorer2 and CIRI2 output files are required to have the file extension `ce` and `ciri` repsectively.

It is very important that the prefx of input files for individual samples are comon (example is shown below). To upload files users must navigate to the Setup tab select `upload new data` and then select `Browse` under the heading `Upload input data files`. Prior to file upload a number of genomic filtering configuration options are available. The default filters require that chimeric alignments exist on the same strand of the same chromosome and that the chimera junction occurs over a distance less than 100,000 nucleotides. These values can be adjusted via the interactive options displayed on this screen. There are currently no filters implemented for canonical splice junctions and Ularcirc will utilise all information from input FSJ files. For STAR FSJ files Ularcirc only utilises the unique alignment counts.

Multiple samples can be uploaded into Ularcirc but this can only be done in one upload event. Therefore all files must reside within a comon directory so that they can all be selected for upload. Attempting to upload files separately will only result in previous upload being overwritten by the current upload. During the upload process Ularcirc displays a status tab notifying of the progress. Users will be notified about any any selected file not recognised by Ularcirc (i.e has incorrect file extension). During a multi-file upload samples are identified by a common file prefix. For example if the following files were uploaded into Ularcirc

```
SRR12345678_e17.5_heart.Chimeric.out.junction
SRR12345678_e17.5_heart.SJ.out.tab
SRR12345678_e17.5_heart.ReadsPerGene.tab.out
SRR12345678_e17.5_heart.ce
SRR87654321_P10_heart.Chimeric.out.junction
SRR87654321_P10_heart.SJ.out.tab
SRR87654321_P10_heart.ReadsPerGene.tab.out
SRR87654321_P10_heart.ce
```

The above example would result in two samples IDs being imported into Ularcirc, SRR123456768\_e17.5\_heart and SRR87654321\_P10\_heart. Each sample would contain four data sets (one FSJ, one gene count and two BSJ data files), and each would be referred to by these names throughout Ularcirc. It is highly recommended to provide a descriptive project name when saving as Ularcirc provides no functionality at this time to rename samples.

After files are uploaded the Project filename can be entered and saved (refer Step2 Saving/loading a project).

## 4.4 Step 2a: Saving/loading a project and grouping samples

New data sets or existing project data sets can be saved or loaded through the Projects tab. Data sets that are loaded through Ularcirc can be saved as a project file which can then be reloaded at a later date. Projects should be saved in a common folder/directory that exists on the local file system. This folder/directory is defined at the top of the main page of the projects tab. This directory should NOT be set to the R Ularcirc library directory as any future upgrades will overwrite pre-existing files.

There are large number of options for RNA-Seq library prep kits. Users should be aware if the library prep kit is stranded or unstranded. Stranded RNA-Seq kits either reproduce cDNA in either the same or opposing strand to that of the RNA. For example the Illumina TruSeq stranded RNA-seq libray prep kit produce cDNA to the opposite strand to that of the RNA. Ularcirc need to know this information to correctly built tables and assemble sequences. Users provide this information to Ularcirc in the `Project tab` under the heading `library prep` on the left side bar.

All saved projects that are present in the working directory will be listed in the pulldown menu located under the “Load” title on sidebar. Note that any new data sets that may have been loaded in the current Ularcirc session will not be visable until Ularcirc is restarted. To load selecting the project name and press load. Data is loaded when sample names are listed on the main tab.

To save a project a unique project name must be entered into the sidebar under entry`Name of project` and then pressing the save button. Ularcirc will not overwrite an existing project file and will warn users if the entered name is not unique.

## 4.5 Step 2b: Grouping samples

After loading a project file or uploading new junction data the associated sample IDs will be listed with checkboxes in two locations on the main tab. These two listings are referred to as “Selected samples” and “Data groupings” and provide provide flexibility in the way downstream analysis can be performed.

The first listing which is under `Selected Samples` provides users the option to analyse a subset of specific data sets to analyse. This option is useful to explore circRNA expression patterns in individual data sets that are available within a project. Data sets that are selected in this list are the only samples that contribute to the integrated genomic visualisations under the Gene\_View tab. Data sets delected in this listing can be be used to tabulate backsplice junction counts via the Gene\_View tab by selecting the “Selected Samples”.

The second listing of sample IDs is provided under the heading`Grouped analysis` data sets. Here users can assign samples to specific groups, which is useful for whole project analysis. The number of groups is defined in the sidebar, and can range between 1 and 10. After defining the number of groups individual samples can be assigned to a group via the main panel. Samples selected in this listing can be analysed via the name “Grouped analysis” under the Gene\_View tab.

## 4.6 Step 3a : Generating BSJ counts

The Gene\_view tab is the location where results tables and visualisation of data take place. There are two display modes available `Display gene transcripts` and `Tabulated counts` which either can be selected on the side bar. The “tabulated counts” provides real time collation, annotation and analysis of back splice junctions. Data sets that were defined on the `Projects` tab are referred to as `Grouped analysis` or `Selected sample` under heading `Data sets to analyse`.

Ularcirc provides a number of annotation options that are incorporated into tables. The first annotation option is `Display % of parental transcripts`. This annotation is the most CPU intensive operation as Ularcirc calculates average forward splicing junctions (FSJ) across different gene features. This includes calculating average FSJ counts within the boundaries of a BSJ, average FSJ across the parental gene, and average FSJ counts outside the boundary of the BSJ.

The read alignment distrbution (RAD) annotation provides a scoring metric that helps assess if a BSJ is likely to be a false positive. This score can only be calculated from paired end reads and reflects the proportion of alignments that capture a BSJ derive from one of the read pairs. We define alignments that capture a BSJ in the primary read as Type II and BSJ detected in the paired read as Type III. A value of 0.5 reflects that BSJ were detected from equalt proportions of both Type II and Type III alignments. The default setting is to accept all BSJ that have a RAD score between 0.05 and 0.95 and this score is authomatically populated in all assembled tables. The `Apply RAD filter` check option provides a quick option to disable RAD score filtering of BSJs.

Ularcirc will automatically annotate all entries with the gene names of overlapping parental genes. Ularcirc does not filter BSJ based on any parental gene filter such as exon boundaries. If a BSJ overlaps two genes both gene entries will be populated into the final table. BSJ that do not overlap a known gene are populated with `unknown`.

The generated tables provide provide functionality to select individual splice juntions (FSJ and BSJ). By selecting a table row will prime Ularcirc to display that gene entry and highlight the specific junction in colour. It also primes the junction to be analysed in the “Junction\_View” tab.

## 4.7 Step 3b : Visualising gene splicing patterns

Ularcirc dynamically generates insightful visualisation of forward splice junctions integrated with backsplice junctions. This feature is accessed via the “Display gene Transcripts” option located on the Gene\_view tab. At the top of the main panel is a grey box that lists what samples were used to generate the image. The pulldown menu provides the ability to select gene names that of the defined transcript data base (which users selected on the setup tab). Users can select gene names by typing part of a gene name. When typing be aware that gene names are dynamically loaded from the server and therefore if the gene name is typed too fast the gene will not be found. Alternatively genes can be selected via selecting corresponding rows of the tables generated under Tabulated\_Counts.

Once a gene is selected visualisation of that gene commences when the `View Gene` button is selected. Ularcirc will dynamically prepare two loop graph and one gene model images.

## 4.8 Exploring slicing patterns from any genomic region

The genome tab within Ularcirc provides explorative analysis within defined genomic regions. This is particularly useful to explore splice junctions that exist outside annotated transcript regions. Note that Ularcirc pre-fills in the chromosome entries from all identified entries listed within the slice junction files. Users cannot visualise chromosomes where there are no splice junctions. The start and end fields are to be entered manually. Finally users must select either the positive or negative strand. Remember the captured strand varies between RNA-Seq kits.

## 4.9 Step 5: Sequence analysis of splice/backsplice junctions

To obtain detailed information on a particular junction (either forward splice or backsplice) the junction must be selected. Splice junctions can be selected after displaying either the `Backsplice junction count data` or `Canonical junction count data`. Note that only one backsplice junction and one canonical splice junction can be selected at any one time. A number of features that relate to the selected splice and/or backsplice junction are populated in the `Junction view` tab. The sidebar menu of the junction view tab provides an option to display information on the selected backsplice or the canonical junction. The sequence of either a backsplice or canonical junction contains a `.` character in the position of the joining exon ends as shown below. Ularcirc can also predict the complete circRNA sequence which is a concatenation of the longest combinations of exons that reside within the boundaries of the backsplice junction.

![Ularcirc Junction view tab showing a backsplice junction for Slc8a1. Note that the . character defines splice junction](data:image/png;base64...)

(#fig:HG38Slc8a1\_BSJ)Ularcirc Junction view tab showing a backsplice junction for Slc8a1. Note that the . character defines splice junction

For backsplice junctions Ularcirc provides further sequence analysis in the form of open reading frame (ORF) and microRNA binding site analysis. Output of these analyses can be selected from the side bar tab. The ORF analysis displays the longest ORF as a graphic on the main tab (see figure below for an example). There are options that can display the amino acid sequence of this ORF on the side tab.

![Ularcirc Junction view tab showing the potential ORF within Slc8a1](data:image/png;base64...)

(#fig:HG38Slc8a1\_ORF)Ularcirc Junction view tab showing the potential ORF within Slc8a1

For microRNA binding site analysis Ularcirc can analyse the predicted circRNA sequence. By default Ularcirc searches for complementary
7nt miRNA seed sequence that exist within the circRNA. There are options to increase or descrease the definition of the miRNA seed in a pull down menu. Ularcirc by default will only display miRNA bindings sites that are found at least two times. This threshold can also be modified via a pulldown menu as shown in the figure below .

![Ularcirc Junction view tab showing potential miRNA binding sites that reside within Slc8a1](data:image/png;base64...)

(#fig:HG38Slc8a1\_miRNA)Ularcirc Junction view tab showing potential miRNA binding sites that reside within Slc8a1

# 5 Session Information———————————–

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] htmltools_0.5.8.1   rmarkdown_2.30      lifecycle_1.0.4
## [10] cli_3.6.5           sass_0.4.10         jquerylib_0.1.4
## [13] compiler_4.5.1      tools_4.5.1         evaluate_1.0.5
## [16] bslib_0.9.0         yaml_2.3.10         BiocManager_1.30.26
## [19] jsonlite_2.0.0      rlang_1.1.6
```