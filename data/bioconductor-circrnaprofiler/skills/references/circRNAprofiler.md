# circRNAprofiler: An R-based computational framework for the downstream analysis of circular RNAs

#### Simona Aufiero

#### 2025-10-29

## Table of Contents

* [Introduction](#introduction)
* [Install the package](#install-the-package)
* [Load the package](#load-the-package)
* [Running circRNAprofiler](#running-circrnaprofiler)
  + [Module 1 - Set up project folder](#module-1---set-up-project-folder)
    - [*initCircRNAprofiler()*](#_initcircrnaprofiler()_)
    - [*checkProjectFolder()*](#_checkprojectfolder()_)
  + [Module 2 - Import predicted circRNAs](#module-2---import-predicted-circrnas)
    - [*formatGTF()*](#_formatgtf()_)
    - [*getBackSplicedJunctions()*](#_getbacksplicedjunctions()_)
  + [Module 3 - Merge commonly identified circRNAs](#module-3---merge-commonly-identified-circrnas)
    - [*mergeBSJunctions()*](#_mergebsjunctions()_)
  + [Module 4 - Filter circRNAs](#module-4---filter-circrnas)
    - [*filterCirc()*](#_filtercirc()_)
  + [Module 5 - Find differentially expressed circRNAs](#module-5---find-differentially-expressed-circrnas)
    - [*getDeseqRes()*](#_getdeseqres()_)
    - [*getEdgerRes()*](#_getedgerres()_)
  + [Module 6 - Map BSJ coordinates between species and genome assemblies](#module-6---map-bsj-coordinates-between-species-and-genome-assemblies)
    - [*liftBSJcoords()*](#_liftbsjcoords()_)
  + [Module 7 - Annotate circRNAs internal structure and flanking introns](#module-7---annotate-circrnas-internal-structure-and-flanking-introns--)
    - [*annotateBSJs()*](#_annotatebsjs()_)
  + [Module 8 - Generate random BSJs](#module-8---generate-random-bsjs)
    - [*getRandomBSJunctions()*](#_getrandombsjunctions()_)
  + [**Retrieve target sequences**](#**retrieve-target-sequences**)
  + [Module 9 - Retrieve internal circRNA sequences](#module-9---retrieve-internal-circrna-sequences)
    - [*getCircSeqs()*](#_getcircseqs()_)
  + [Module 10 - Retrieve BSJ sequences](#module-10---retrieve-bsj-sequences)
    - [*getSeqsAcrossBSJs()*](#_getseqsacrossbsjs()_)
  + [Module 11 - Retrieve sequences flanking the BSJs](#module-11---retrieve-sequences-flanking-the-bsjs)
    - [*getSeqsFromGRs()*](#_getseqsfromgrs()_)
  + [**Screen target sequences**](#**screen-target-sequences**)
  + [Module 12 - Screen target sequences for RBP/de Novo motifs](#module-12---screen-target-sequences-for-rbp/de-novo-motifs)
    - [*getMotifs()*](#_getmotifs()_)
    - [*mergeMotifs()*](#_mergemotifs()_)
  + [Module 13 - Screen circRNA sequences for miRNA binding sites](#module-13---screen-circrna-sequences-for-mirna-binding-sites)
    - [*getMiRsites()*](#_getmirsites()_)
    - [*rearrageMiRres()*](#_rearragemirres()_)
  + [**Annotate target sequences**](#**annotate-target-sequences**)
  + [Module 14 - Annotate GWAS SNPs](#module-14---annotate-gwas-snps)
    - [*annotateSNPsGWAS()*](#_annotatesnpsgwas()_)
  + [Module 15 - Annotate repetitive elements](#module-15---annotate-repetitive-elements)
    - [*annotateRepeats()*](#_annotaterepeats()_)
* [Support](#support)
* [Citation](#citation)
* [Acknowledgement](#acknowledgement)
* [Note](#note)
* [References](#references)

## Introduction

circRNAprofiler is an R-based framework that only requires an R installation and offers 15 modules for a comprehensive in silico analysis of circRNAs. This computational framework allows to combine and analyze circRNAs previously detected by multiple publicly available annotation-based circRNA detection tools. It covers different aspects of circRNAs analysis from differential expression analysis, evolutionary conservation, biogenesis to functional analysis. The pipeline used by circRNAprofiler is highly automated and customizable. Furthermore, circRNAprofiler includes additional functions for data visualization which facilitate the interpretation of the results.

![\label{fig:figs} Figure 1: Schematic representation of the circRNA analysis workflow implemented by circRNAprofiler. The grey boxes represent the 15 modules with the main R-functions reported in italics. The different type of sequences that can be selected are depicted in the dashed box. BSJ, Back-Spliced Junction.](data:image/png;base64...)

Figure 1: Schematic representation of the circRNA analysis workflow implemented by circRNAprofiler. The grey boxes represent the 15 modules with the main R-functions reported in italics. The different type of sequences that can be selected are depicted in the dashed box. BSJ, Back-Spliced Junction.

This vignettes provides a guide of how to use the R package circRNAProfiler.

As practical example the RNA-sequencing data from human left ventricle tissues previously analyzed by our group for the presence of circRNAs (Khan et al. 2016), was here re-analyzed. Multiple detection tools (CircMarker(cm), MapSplice2 (ms) and NCLscan (ns)) were used this time for the detection of circRNAs and an additional sample for each condition was included reaching a total of 9 samples: 3 control hearts, 3 hearts of patients with dilated cardiomyopathies (DCM) and 3 hearts with hypertrophic cardiomyopathies (HCM).**After the circRNA detection we locally setup the project folder as described in Module 1 and ran through Modules 2 and 3 to generate the data object backSplicedJunctions and mergedBSJunctions which can be loaded and used as an example in the package vignettes.**

Raw RNA sequencing data are available at NCBI BioProject accession number PRJNA533243.

## Install the package

First install:

```
if (!requireNamespace("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")
}
```

You can install circRNAprofiler from Bioconductor using:

```
BiocManager::install("circRNAprofiler")
```

To download the latest development version use:

```
# The following initializes usage of Bioc devel
BiocManager::install(version='devel')

BiocManager::install("circRNAprofiler")
```

## Load the package

```
library(circRNAprofiler)

# Packages needed for the vignettes
library(ggpubr)
library(ggplot2)
library(VennDiagram)
library(gridExtra)
```

## Running circRNAprofiler

### Module 1 - Set up project folder

#### *initCircRNAprofiler()*

An important step of the analysis workflow is to initialize the project folder, which can be done with the helper function initCircRNAprofiler() available in the package. The project folder should be structured as in the example Figure 2 if seven detection tools are used to detect circRNAs in 6 samples.

![\label{fig:figs} Figure 2: Example of a project folder structure](data:image/png;base64...)

Figure 2: Example of a project folder structure

***Helper function***

Project folder contains project files and circRNA prediction results. In detail, project files include the genome-annotation file (.gtf), the file containing information about the experimental design (experiment.txt) and optional files (motifs.txt, miRs.txt, transcripts.txt, traits.txt) which contain user specifications that are used to customize the analysis to execute. In order to initialize the project folder the helper function initCircRNAprofiler() can be used to streamline the process. To initialize the project folder run the following command specifying the tools used to predict circRNAs. The following options are allowed: “mapsplice”, “nclscan”, “knife”, “circexplorer2”, “uroborus”, “circmarker”, “tool1”, “tool2” or “tool3”. The last 3 options are for unsupported tools. For now, a maximum of 3 unsupported tools can be used. The function will automatically create the project folder with the corresponding subfolders named as the circRNA detection tools used, and the 5 \*.txt files templates with the corresponding headers. These files should be filled with the appropriate information (see files description below).

If only MapSplice is used for the circRNA detection run the following command:

```
initCircRNAprofiler(projectFolderName = "projectCirc", detectionTools =
                      "mapsplice")
```

If circRNA detection is performed by using multiple detection tools then run the command with the name of the detection tools used, e.g.:

```
initCircRNAprofiler(
    projectFolderName = "projectCirc",
    detectionTools = c("mapsplice", "nclscan", "circmarker")
)
```

**IMPORTANT**

**Next, set project folder projectFolderName (in this case projectCirc) as your working directory.**

***Project files description***

The file **experiment.txt** contains the experiment design information. It must have at least 3 columns with headers (tab separated):

* label (1st column): unique names of the samples (short but informative).
* fileName (2nd column): name of the input files - e.g. circRNAs\_X.txt, where x can be can be 001, 002 etc.
* condition (3rd column): biological conditions - e.g. A or B; healthy or diseased if you have only 2 conditions.

The functions for the filtering and the differential expression analysis depend on the information reported in this file. The differential expression analysis is performed by comparing the condition positioned forward against the conditions positioned backward in the alphabet (column condition of experiment.txt), so that, circRNAs with positive log2FC are up-regulated in condition B compared to condition A (and vice versa for circRNA with negative log2FC).

```
##   label         fileName condition
## 1    C1 circRNAs_006.txt         A
## 2    C2 circRNAs_009.txt         A
## 3    C3 circRNAs_007.txt         A
## 4    D1 circRNAs_005.txt         B
## 5    D2 circRNAs_002.txt         B
## 6    D3 circRNAs_001.txt         B
```

The file \***.gtf** contains the genome annotation. circRNAprofiler works well and was tested with ensamble gencode, UCSC or NCBI based-genome annotations. It is suggested to use the same annotation file used during the read mapping procedure.

The file **motifs.txt (optional)** contains motifs/regular expressions specified by the user. It must have 3 columns with header (tab separated):

* id (1st column): name of the motif. - e.g. RBM20 or motif1.
* motif (2nd column): motif/pattern to search.
* length (3rd column): length of the motif.

If this file is absent or empty only the motifs of RNA Binding Proteins in the ATtRACT database (Giudice et al. 2016) are considered in the motifs analysis.

```
##      id          motif length
## 1 RBM20 [ACU]UUCU[ACU]      6
```

The file **traits.txt (optional)** contains diseases/traits specified by the user. It must have one column with header id. Type data(“gwasTraits”) to have an image (dated on the 31st October 2018) of the traits reported in the GWAS catalog (MacArthur et al. 2017). The GWAS catalog is a curated collection of all published genome-wide association studies and contains~ 90000 unique SNP-trait associations. If the file traits.txt is absent or empty, all SNPs associated with all diseases/traits in the GWAS catalog are considered in the SNPs analysis.

```
##                                                                                         id
## 1 AR-C124910XX levels in individuals with acute coronary syndromes treated with ticagrelor
## 2                                 Anthracycline-induced cardiotoxicity in childhood cancer
## 3                                                                     Atrial Septal Defect
## 4                                                                      Atrial fibrillation
## 5                                                Atrial fibrillation (SNPxSNP interaction)
## 6                                                        Atrial fibrillation (interaction)
```

The file **miRs.txt (optional)** contains the microRNA ids from miRBase (Griffiths-Jones et al. 2006) specified by the user. It must have one column with header id. The first row must contain the miR name starting with the “>”, e.g >hsa-miR-1-3p. The sequences of the miRs will be automatically retrieved from the mirBase latest release or from the given mature.fa file, that should be present in the project folder. If this file is absent or empty, all miRs of the specified species are considered in the miRNA analysis.

```
##                 id
## 1    >hsa-miR-1-3p
## 2  >hsa-miR-126-3p
## 3  >hsa-miR-145-5p
## 4 >hsa-miR-133a-3p
## 5    >hsa-miR-451a
## 6  >hsa-miR-23b-3p
```

The file **transcripts.txt (optional)** contains the transcript ids of the circRNA host genes. It must have one column with header id. If this file is empty the longest transcript of the circRNA host genes whose exon coordinates overlap with that of the detected back-spliced junctions are considered in the annotation analysis.

```
##                  id
## 1 ENST00000514743.1
```

***circRNA prediction results***

The **circRNAs\_X.txt** contains the detected circRNAs. Once the project folder has been initialized the circRNAs\_X.txt file/s must go in the corresponding subfolders. There must be one .txt file per sample named circRNAs\_X.txt, where X can be 001, 002 etc. If there are 6 samples, 6 .txt files named circRNAs\_001.txt, circRNAs\_002.txt, circRNAs\_003.txt, circRNAs\_004.txt, circRNAs\_005.txt, circRNAs\_006.txt must be present in each subfolder named as the name of the tool that has been used for the circRNA detection. If the detection tool used is mapsplice, nclscan, knife, circexplorer2, uroborus or circmarker, the only thing to do after the detection is to rename the files to circRNAs\_X.txt and put them in the corresponding subfolder. A specific import function will be called internally to adapt and format the content as reported below.

In detail circRNAprofiler has been tested on the following output files: MapSplice2-v2.2.0 output file (circularRNAs.txt),NCLscan v1.4 output file (e.g. MyProject.result),circExplorer2 v2.3.4 output file (circularRNA\_full.txt), KNIFE v1.5 output file (circJuncProbs.txt),CircMarker (July.24.2018) output file (Brief\_sum.txt),UROBORUS v2.0.0 output file (circRNA\_list.txt).

If the tool is not mapsplice, nclscan, knife, circexplorer2, uroborus or circmarker, first check that the tool used is an annotation-based circRNA detection tool, then rename the files to circRNAs\_X.txt and put them in the subfolders “tool1”, “tool2” or “tool3”. In these last cases, you must ensure that each circRNAs\_X.txt file must have at least the following 6 columns with the header (tab separated):

* chrom: represents the chromosome from which the circRNA is derived.
* gene: represents the gene from which the circRNA arises.
* strand: is the strand where the gene is transcribed.
* startUpBSE: is the 5’ coordinate of the upstream back-spliced exon in the transcript. This corresponds with the back-spliced junction / acceptor site.
* endDownBSE: is the 3’ coordinate of the downstream back-spliced exon in the transcript. This corresponds with the back-spliced junction / donor site.
* coverage: corresponds to the number of reads mapping to the back-spliced junction in the sample.

E.g.

```
##   chrom    gene strand startUpBSE endDownBSE coverage
## 1 chr15   ABHD2      +   89656956   89659752       35
## 2 chr19 AGTPBP1      -   88248289   88190230       40
```

NOTE: If more columns are present they will be discared.

The coordinates for startUpBSE and endDownBSE are relative to the reference strand, i.e. if strand is positive startUpBSE < endDownBSE, if strand is negative startUpBSE > endDownBSE.

The circRNAprofiler package can be extended in the future with further import functions specifically designed to import the output files of the different circRNA detection tools. At the moment only import functions for circRNA detection from annotation-based circRNA detection tools (e.g. MapSplice2, NCLscan, CircMarker, CircExplorer2, KNIFE, UROBORUS) are supported.

For example purpose a project folder named **projectCirc** was created in **inst/extdata** folder of the R package circRNAprofiler as specified by Module 1. The project folder projectCirc contains a **short version of the raw files containing the detected circRNAs** and the **optional files motifs.txt, miRs.txt, transcripts.txt and traits.txt.**

**Alternatively** load the data object backSplicedJunctions and mergedBSJunctions containing the whole set of circRNAs detected in the heart and specify the path to experiment.txt.

```
# Path to experiment.txt
pathToExperiment <- system.file("extdata", "experiment.txt",
                                package ="circRNAprofiler")
```

**Note: The user should download gencode.V19.annotation.gtf from <https://www.gencodegenes.org/> and put it in the working directory projectCirc. Next, set projectCirc as working directory and ran Module 2.**

A short version of the above .gtf file has been generated and can be use for example purpose.

#### *checkProjectFolder()*

The function checkProjectFolder() helps to verify that the project folder is set up correctly. It checks that the mandatory files ( .gtf file, the folders with the circRNAs\_X.txt files and experiment.txt) are present in the working directory.

```
# Set project folder projectCirc as your working directory and run:
check <- checkProjectFolder()
check
```

If the project folder is set up correctly, check should be equal to 0.

### Module 2 - Import predicted circRNAs

#### *formatGTF()*

The function formatGTF() formats the given annotation file from ensemble, gencode, UCSC or NCBI. The gtf object is then used in other functions.

Type ?formatGTF for more information about the argument of the function and its example.

```
# Set project folder projectCirc as your working directory.
# Download gencode.V19.annotation.gtf from https://www.gencodegenes.org/ and
# put it in the working directory, then run:
# gtf <- formatGTF("gencode.V19.annotation.gtf")

# For example purpose load a short version of the formatted gtf file generated
# using the command above.
data("gtf")
head(gtf)
##   chrom     start       end width strand type gene_name     transcript_id
## 1  chr1 237205505 237205869   365      + exon      RYR2 ENST00000366574.2
## 2  chr1 237433797 237433916   120      + exon      RYR2 ENST00000366574.2
## 3  chr1 237494178 237494282   105      + exon      RYR2 ENST00000366574.2
## 4  chr1 237519265 237519285    21      + exon      RYR2 ENST00000366574.2
## 5  chr1 237527658 237527672    15      + exon      RYR2 ENST00000366574.2
## 6  chr1 237532834 237532908    75      + exon      RYR2 ENST00000366574.2
##   exon_number
## 1           1
## 2           2
## 3           3
## 4           4
## 5           5
## 6           6
```

#### *getBackSplicedJunctions()*

The function getBackSplicedJunctions() reads the circRNAs\_X.txt (stored in the specified subfolders), adapts the content and generates a unique data frame with the circRNAs detected by each detection tool and the occurrences found in each sample.

Type ?getBackSplicedJunctions for more information about the arguments of the function and its example.

```
# Set working directory to projectCirc which contains a short version of the raw
# files containing the detected circRNAs. The run:
# backSplicedJunctions <- getBackSplicedJunctions(gtf)

# Alternatively, you can load the object containing the whole set of circRNAs detected
# in the heart generated running the command above.
data("backSplicedJunctions")
head(backSplicedJunctions)
##                                  id    gene strand chrom startUpBSE endDownBSE
## 1   ABHD2:+:chr15:89656956:89659752   ABHD2      + chr15   89656956   89659752
## 2 ACVR2A:+:chr2:148653870:148657467  ACVR2A      +  chr2  148653870  148657467
## 3     AFF1:+:chr4:87967318:87968746    AFF1      +  chr4   87967318   87968746
## 4  AGTPBP1:-:chr9:88248289:88190230 AGTPBP1      -  chr9   88248289   88190230
## 5  AGTPBP1:-:chr9:88248289:88200378 AGTPBP1      -  chr9   88248289   88200378
## 6  AGTPBP1:-:chr9:88248289:88211277 AGTPBP1      -  chr9   88248289   88211277
##   tool C1 C2 C3 D1  D2 D3 H1 H2  H3
## 1   ms 35 11 38 48  38 12 34 44  41
## 2   ms 56 11 76 56 121 10 37 85 112
## 3   ms 47  5 34 48  47  5 54 10  30
## 4   ms 40 23 63 56  65 18 95 67  53
## 5   ms 13  3 19 26  43  7 20 32  23
## 6   ms  5 11 24 27  38  5 54 28  41
```

Plot the number of circRNAs identified by each detection tool.

```
# Plot
p <- ggplot(backSplicedJunctions, aes(x = tool)) +
    geom_bar() +
    labs(title = "", x = "Detection tool", y = "No. of circRNAs") +
    theme_classic()

# Run getDetectionTools() to get the code corresponding to the circRNA
# detection tools.
dt <- getDetectionTools() %>%
    dplyr::filter( name %in% c("mapsplice","nclscan", "circmarker"))%>%
    gridExtra::tableGrob(rows=NULL)

# Merge plots
gridExtra::grid.arrange(p, dt, nrow=1)
```

![](data:image/png;base64...)

### Module 3 - Merge commonly identified circRNAs

#### *mergeBSJunctions()*

The function mergeBSJunctions() is called to shrink the data frame by grouping back-spliced junction coordinates commonly identified by multiple detection tools. For the grouped back-spliced junction coordinates, the counts of the tool which detected the highest total mean across all analyzed samples will be taken. All the tools that detected the back-spliced junction are then listed in the column “tool” of the final table. Run getDetectionTools() to get the code corresponding to each circRNA detection tool.

Since different detection tools can report slightly different coordinates before grouping the back-spliced junctions, it is possible to fix the latter using the gtf file. In this way the back-spliced junctions coordinates will correspond to the exon coordinates reported in the gtf file. A difference of maximum 2 nucleodites is allowed between the bsj and exon coordinates.
See param fixBSJsWithGTF.

You can run mergeBSJunctions() also if you used only 1 circRNA detection tool, or in this case you can also skip this step and use directly the backSplicedJunctions dataframe generated by getBackSplicedJunctions() in the downstream steps, e.g. in filterCirc(), getDeseqRes(), liftBSJcoords(), annotateBSJs().

NOTE:

In this module circRNAs that derived from the antisense strand of the reported gene are identified. In detail, in our pipeline a circRNA is defined antisense if the strand from which the circRNA arises (i.e. reported in the prediction results) is different from the strand where the gene is transcribed (i.e. reported in the genome annotation file). This might be explained by technical artifacts or by the presence of a gene transcribed from the opposite strand that is not annotated. Due to the ambiguous nature of these predictions the antisense circRNAs (if any) are removed from the dataset and if specified by the user they can be exported in a file (i.e. antisenseCircRNAs.txt) for user consultation. Modules in circRNAprofiler are specific for the analysis of circRNAs that derive from the sense strand of the corresponding gene.

Type ?mergeBSJunctions for more information about the arguments of the function and its example.

```
# If you set projectCirc as your working directory, then run:
# mergedBSJunctions <- mergeBSJunctions(backSplicedJunctions, gtf)

# Alternatively, you can load the object containing the whole set of circRNAs
# detected in the heart merged using the code above.
data("mergedBSJunctions")
head(mergedBSJunctions)
##                                       id       gene strand chrom startUpBSE
## 1        SYCP2:-:chr20:58497514:58497445      SYCP2      - chr20   58497514
## 2 AL132709.8:+:chr14:101432017:101432103 AL132709.8      + chr14  101432017
## 3        SLC8A1:-:chr2:40657441:40655613     SLC8A1      -  chr2   40657441
## 4        SLC8A1:-:chr2:40657444:40655613     SLC8A1      -  chr2   40657444
## 5         LGMN:-:chr14:93207524:93200027       LGMN      - chr14   93207524
## 6        EXOC6B:-:chr2:72960247:72945232     EXOC6B      -  chr2   72960247
##   endDownBSE     tool   C1  C2   C3   D1   D2  D3    H1   H2   H3
## 1   58497445       cm 4858 577 4256 6561 6347 253 11050 8792 5804
## 2  101432103       cm 4310 502 3824 5870 5609 203 10094 7953 5256
## 3   40655613    cm,ms 2687 539 2718 2862 5623 428  2527 4446 6113
## 4   40655613 cm,ms,ns 2064 389 2357 2263 4677 324  2196 3894 5291
## 5   93200027       cm 1367 194 1114 1652 2164 195  1428 1551 1579
## 6   72945232 cm,ms,ns  641  89  764  741 1186 277  1974 1154 1649
```

Plot commonly identified circRNAs.

```
# Plot
p <- ggplot(mergedBSJunctions, aes(x = tool)) +
    geom_bar() +
    labs(title = "", x = "Detection tool", y = "No. of circRNAs") +
    theme_classic()

gridExtra::grid.arrange(p, dt, nrow=1)
```

![](data:image/png;base64...)

### Module 4 - Filter circRNAs

#### *filterCirc()*

The use of multiple detection tools leads to the identification of a higher number of circRNAs. To rule out false positive candidates a filtering step can be applied to the detected circRNAs. The function filterCirc() filters circRNAs on different criteria: condition and read counts. The user can decide the filtering criteria. In the example below by setting allSamples = FALSE the filter is applied to the samples of each condition separately meaning that a circRNA is kept if at least 5 read counts are present in all samples of one of the conditions (A or B or C). If allSamples = TRUE, the filter is applied to all samples. We suggest to set allSamples = FALSE, since the presence of a disease/treatment can decrease the expression of subset of circRNAs thus by applying the filtering to all samples(allSamples = TRUE) those circRNAs are discarded.

Type ?filterCirc for more information about the arguments of the function and and its example.

```
# If you set projectCirc as your working directory, then run:
filteredCirc <-
filterCirc(mergedBSJunctions, allSamples = FALSE, min = 5)
```

Plot circRNAs after the filtering step.

```
# Plot
p <- ggplot(filteredCirc, aes(x = tool)) +
    geom_bar() +
    labs(title = "", x = "Detection tool", y = "No. of circRNAs") +
    theme_classic()

gridExtra::grid.arrange(p, dt, nrow=1)
```

![](data:image/png;base64...)

Alternatively:

```
# Plot using Venn diagram
cm <- filteredCirc[base::grep("cm", filteredCirc$tool), ]
ms <- filteredCirc[base::grep("ms", filteredCirc$tool), ]
ns <- filteredCirc[base::grep("ns", filteredCirc$tool), ]

p <- VennDiagram::draw.triple.venn(
    area1 = length(cm$id),
    area2 = length(ms$id),
    area3 = length(ns$id),
    n12 = length(intersect(cm$id, ms$id)),
    n23 = length(intersect(ms$id, ns$id)),
    n13 = length(intersect(cm$id, ns$id)),
    n123 = length(Reduce(
        intersect, list(cm$id, ms$id, ns$id)
    )),
    category = c("cm", "ms", "ns"),
    lty = "blank",
    fill = c("skyblue", "pink1", "mediumorchid")
)
```

![](data:image/png;base64...)

### Module 5 - Find differentially expressed circRNAs

#### *getDeseqRes()*

The helper functions getDeseqRes() identifies differentially expressed circRNAs. The latter uses the R Bioconductor package DESeq2 which implement a beta-binomial model to model changes in circRNA expression. The differential expression analysis is performed by comparing the condition positioned forward against the condition positioned backward in the alphabet (values in the column condition in experiment.txt). E.g. if there are 2 conditions A and B then a negative log2FC means that in the conditions B there is a downregulation of the corresponding circRNA. If a positive log2FC is found means that there is an upregulation in the condition B of that circRNA.

Type ?getDeseqRes for more information about the arguments of the function and its example.

```
# Compare condition B Vs A
# If you set projectCirc as your working directory, then run:
deseqResBvsA <-
    getDeseqRes(
        filteredCirc,
        condition = "A-B",
        fitType = "local",
        pAdjustMethod = "BH"
    )
head(deseqResBvsA)
##                                       id       gene      log2FC    pvalue
## 1        SYCP2:-:chr20:58497514:58497445      SYCP2 -0.21872628 0.6882730
## 2 AL132709.8:+:chr14:101432017:101432103 AL132709.8 -0.23032811 0.6743554
## 3        SLC8A1:-:chr2:40657441:40655613     SLC8A1 -0.06724610 0.8141522
## 4        SLC8A1:-:chr2:40657444:40655613     SLC8A1 -0.04007647 0.8877923
## 5         LGMN:-:chr14:93207524:93200027       LGMN  0.04748208 0.8536426
## 6        EXOC6B:-:chr2:72960247:72945232     EXOC6B  0.51441043 0.1338385
##        padj        C1        C2        C3        D1        D2        D3
## 1 0.9984061 3359.6544 1895.7608 2591.0545 3555.2959 2357.5131  824.6553
## 2 0.9984061 2980.6732 1649.3448 2328.0528 3180.8546 2083.3923  661.6800
## 3 0.9984061 1858.2526 1770.9100 1654.7195 1550.8698 2088.5924 1395.0691
## 4 0.9984061 1427.4036 1278.0779 1434.9426 1226.2818 1737.2127 1056.0803
## 5 0.9984061  945.3782  637.3962  678.2037  895.1911  803.7905  635.6039
## 6 0.9984061  443.2973  292.4137  465.1235  401.5355  440.5247  902.8835
```

```
# Compare condition C Vs A
deseqResCvsA <-
    getDeseqRes(
        filteredCirc,
        condition = "A-C",
        fitType = "local",
        pAdjustMethod = "BH"
    )
head(deseqResCvsA)
##                                       id       gene      log2FC      pvalue
## 1        SYCP2:-:chr20:58497514:58497445      SYCP2  0.66419598 0.136048385
## 2 AL132709.8:+:chr14:101432017:101432103 AL132709.8  0.69952766 0.110824859
## 3        SLC8A1:-:chr2:40657441:40655613     SLC8A1  0.16723172 0.556461506
## 4        SLC8A1:-:chr2:40657444:40655613     SLC8A1  0.31640317 0.251497581
## 5         LGMN:-:chr14:93207524:93200027       LGMN -0.08792522 0.700433109
## 6        EXOC6B:-:chr2:72960247:72945232     EXOC6B  0.90322591 0.002513725
##         padj        C1        C2        C3       H1        H2        H3
## 1 0.52337347 4634.2050 2498.0706 3487.7840 7990.915 5750.6484 3099.3849
## 2 0.46971699 4111.4499 2173.3647 3133.7608 7299.574 5201.8775 2806.7483
## 3 0.88083258 2563.2172 2333.5529 2227.3959 1827.425 2908.0281 3264.3935
## 4 0.66669722 1968.9171 1684.1412 1931.5571 1588.059 2546.9774 2825.4386
## 5 0.93530126 1304.0260  839.9059  912.9209 1032.672 1014.4740  843.1993
## 6 0.03898947  611.4709  385.3176  626.0966 1427.517  754.8053  880.5799
```

Use volcanoPlot() function.

Type ?volcanoPlot for more information about the arguments of the function and its example.

```
# We set the xlim and ylim to the same values for both plots to make them
# comparable. Before setting the axis limits, you should visualize the
# plots with the default values to be able to define the correct limits.
# An error might occur due to the log10 transformation of the padj values
# (e.g. log10(0) = inf). In that case set setyLim = TRUE and specify the the
# y limit manually.
p1 <-
    volcanoPlot(
        deseqResBvsA,
        log2FC = 1,
        padj = 0.05,
        title = "DCMs Vs. Con",
        setxLim = TRUE,
        xlim = c(-8 , 7.5),
        setyLim = TRUE,
        ylim = c(0 , 4),
        gene = FALSE
    )
p2 <-
    volcanoPlot(
        deseqResCvsA,
        log2FC = 1,
        padj = 0.05,
        title = "HCMs Vs. Con",
        setxLim = TRUE,
        xlim = c(-8 , 7.5),
        setyLim = TRUE,
        ylim = c(0 , 4),
        gene = FALSE
    )
ggarrange(p1,
          p2,
          ncol = 1,
          nrow = 2)
```

![](data:image/png;base64...)

#### *getEdgerRes()*

Alternatively, the helper functions edgerRes() can also be used to identifies differentially expressed circRNAs. The latter uses the R Bioconductor package EdgeR which implement a beta-binomial model to model changes in circRNA expression. The differential expression analysis is perfomed by comparing the condition positioned forward against the condition positioned backward in the alphabet (values in the column condition of experiment.txt). E.g. if there are 2 conditions A and B then a negative log2FC means that in the conditions B there is a downregulation of the corresponding circRNA. If a positive log2FC is found means that there is an upregulation in the condition B of that circRNA.

Type ?getEdgerRes for more information about the arguments of the function and its example.

```
# Compare condition B Vs A
edgerResBvsA <-
    getEdgerRes(
        filteredCirc,
        condition = "A-B",
        normMethod = "TMM",
        pAdjustMethod = "BH"    )
head(edgerResBvsA)
```

```
# Compare condition C Vs A
edgerResCvsA <-
    getEdgerRes(
        filteredCirc,
        condition = "A-C",
        normMethod = "TMM",
        pAdjustMethod = "BH"
    )
head(edgerResCvsA)
```

### Module 6 - Map BSJ coordinates between species and genome assemblies

#### *liftBSJcoords()*

The function liftBSJCoords() maps back-spliced junction coordinates between different species and genome assemblies by using the liftOver utility from UCSC. Type data(ahChainFiles) to see all possibile options for annotationHubID E.g. if “AH14155” is specified, the hg19ToMm9.over.chain.gz will be used to convert the hg19 (Human GRCh37) coordinates to mm9 (Mouse GRCm37).

NOTE: Only back-spliced junction coordinates where the mapping was successful are reported. Back-spliced junction coordinates that could not be mapped might be not conserved between the analyzed species.

Type ?liftedBSJcoords for more information about the arguments of the function and its example.

```
liftedBSJcoords <- liftBSJcoords(filteredCirc, map = "hg19ToMm9",
                                 annotationHubID = "AH14155")
```

### Module 7 - Annotate circRNAs internal structure and flanking introns

#### *annotateBSJs()*

The function annotateBSJs() annotates circRNAs internal structure and the flanking introns. The genomic features are extracted from the user provided gene annotation. We first define the circRNA parental transcript as a linear transcript whose exon coordinates overlap with that of the detected back-spliced junctions and then the features are extracted from the selected transcript. Since the coordinates of the detected back-spliced junctions might not exactly correspond to annotated exonic coordinates, the match is performed considering the back-spliced junction coordinates minus the last number. For example if the coordinate is 1225359, then 122535 is used to detect the exon of the gene. As default, in situations where genes have multiple transcripts whose exons align to the back-spliced junction coordinates, the transcript that will produce the longest sequence (exon only) will be selected. Alternatively, the transcript to be used can be specified in transcripts.txt. The output data frame will have the following columns:

* id: unique identifier.
* gene: represents the gene from which the circRNA arises.
* allTranscripts: are all transcripts of a circRNA’s host gene which exon coordinates overlap with the detected back-spliced junction coordinates.
* transcript: as default, this is the transcript producing the longest sequence and whose exon coordinates overlap with the detected back-spliced junction coordinates. The transcript reported in this column is used in the downstream analysis.
* totExons: total number of exons in the selected transcript (reported in the column transcript)
* strand: is the strand from which the gene is transcribed.
* chrom: is the chromosome from which the circRNA is derived.
* startUpIntron: is the 5’ coordinate of the intron immediately upstream the acceptor site in the selected transcript.
* endUpIntron: is the 3’ coordinate of the intron immediately upstream the acceptor site in the selected transcript.
* startUpBSE: is the 5’ coordinate of upstream back-spliced exon in the selected transcript. This corresponds with the back-spliced junction / acceptor site.
* endUpBSE: is the 3’ coordinate of the upstream back-spliced exon in the selected transcript.
* startDownBSE: is the 5’ coordinate of downstream back-spliced exon in the selected transcript.
* endDownBSE: is the 3’ coordinate of downstream back-spliced exon in the selected transcript. This corresponds with the back-spliced junction / donor site.
* startDownIntron: is the 5’ coordinate of the intron immediately downstream the donor site in the selected transcript.
* endDownIntron: is the 3’ coordinate of the intron immediately downstream the donor site in the selected transcript.
* exNumUpBSE: is the position of the upstream back-spliced exon in the selected transcript (e.g. if it is the 1st, the 2nd etc).
* exNumDownBSE: is the position of the downstream back-spliced exon in the selected transcript (e.g. if it is the 1st, the 2nd etc).
* numOfExons: is the total number of exons in the between the back-spliced junctions.
* lenUpIntron: is the length (nt) of the intron upstream the acceptor site in the selected transcript.
* lenUpBSE: is the length (nt) of the upstream back-spliced exon in the selected transcript.
* lenDownBSE: is the length (nt) of the downstream back-spliced exon in the selected transcript.
* lenDownIntron: is the length (nt) of the intron downstream the donor site in the selected transcript.
* meanLengthBSEs: is the mean lenght (nt) of the back-spliced exons.
* meanLengthIntrons: is the mean lenght (nt) of the introns flanking the detected back-spliced junctions.
* lenCircRNA: is the length (nt) of the circRNA. This is given by the length of the exons in between the back-spliced junctions, including the back-spliced exons.

NOTE:

NA values in the table can mean:

* the back-spliced exons are the first or the last within a transcript, so the introns in these cases are not present.
* the back-spliced junctions do not match with any exon coordinates reported in the annotation file. It is important to use the same annotation file (\*.gtf file) used during the read mapping procedure since the same gene can be differently annotated by the existing annotation databases (Zhao and Zhang 2015).

Type ?annotateBSJs for more information about the arguments of the function and its example.

```
# If you want to analysis specific transcripts report them in transcripts.txt (optional).
# If transcripts.txt is not present in your working directory specify pathToTranscripts.
# As default transcripts.txt is searched in the wd.

# As an example of the 1458 filtered circRNAs we annotate only the firt 30
# circRNAs
annotatedBSJs <- annotateBSJs(filteredCirc[1:30,], gtf, isRandom = FALSE)
head(annotatedBSJs)
##                                       id       gene
## 1        SYCP2:-:chr20:58497514:58497445      SYCP2
## 2 AL132709.8:+:chr14:101432017:101432103 AL132709.8
## 3        SLC8A1:-:chr2:40657441:40655613     SLC8A1
## 4        SLC8A1:-:chr2:40657444:40655613     SLC8A1
## 5         LGMN:-:chr14:93207524:93200027       LGMN
## 6        EXOC6B:-:chr2:72960247:72945232     EXOC6B
##                                                                                                allTranscripts
## 1                                     ENST00000357552.3,ENST00000371001.2,ENST00000446834.1,ENST00000425931.1
## 2                                                                                           ENST00000423708.3
## 3 ENST00000406785.2,ENST00000542756.1,ENST00000403092.1,ENST00000405901.3,ENST00000402441.1,ENST00000405269.1
## 4 ENST00000406785.2,ENST00000542756.1,ENST00000403092.1,ENST00000405901.3,ENST00000402441.1,ENST00000405269.1
## 5                                                                                           ENST00000554080.1
## 6                                                       ENST00000272427.6,ENST00000410104.1,ENST00000410112.2
##          transcript totExons strand chrom startUpIntron endUpIntron startUpBSE
## 1 ENST00000357552.3       45      - chr20      58507116    58497515   58497514
## 2 ENST00000423708.3        2      + chr14     101427582   101432016  101432017
## 3 ENST00000406785.2        8      -  chr2      40679043    40657445   40657444
## 4 ENST00000406785.2        8      -  chr2      40679043    40657445   40657444
## 5 ENST00000554080.1        5      - chr14      93214833    93207525   93207524
## 6 ENST00000272427.6       22      -  chr2      72968432    72960248   72960247
##    endUpBSE startDownBSE endDownBSE startDownIntron endDownIntron exNumUpBSE
## 1  58497445     58497514   58497445        58497444      58496509          3
## 2 101432103    101432017  101432103              NA            NA          2
## 3  40655613     40657444   40655613        40655612      40404996          2
## 4  40655613     40657444   40655613        40655612      40404996          2
## 5  93207407     93200155   93200027        93200026      93199161          2
## 6  72960200     72945436   72945232        72945231      72802798          3
##   exNumDownBSE numOfExons lenUpIntron lenUpBSE lenDownBSE lenDownIntron
## 1            3          1        9601       69         69           935
## 2            2          1        4434       86         86          <NA>
## 3            2          1       21598     1831       1831        250616
## 4            2          1       21598     1831       1831        250616
## 5            3          2        7308      117        128           865
## 6            6          4        8184       47        204        142433
##   meanLengthBSEs meanLengthIntrons lenCircRNA
## 1             69              5268         70
## 2             86              4434         87
## 3           1831            136107       1832
## 4           1831            136107       1832
## 5          122.5            4086.5        247
## 6          125.5           75308.5        390
```

### Module 8 - Generate random BSJs

#### *getRandomBSJunctions()*

The function getRandomBSJunctions() retrieves random back-spliced junctions from the user genome annotation. Two random back-spliced exons are selected from each of the n randomly selected transcripts, and the back-spliced junction coordinates reported in the final data frame. The frequency of single exon circRNAs can also be given as argument. If f = 10, 10% of the of the back-spliced junctions belong to single exons. Randomly selected back-spliced junctions can be used as background data set for structural and functional analysis.

Type ?getRandomBSJunctions for more information about the arguments of the function and its example.

```
# First find frequency of single exon circRNAs
f <-
    sum((annotatedBSJs$exNumUpBSE == 1 |
            annotatedBSJs$exNumDownBSE == 1) ,
        na.rm = TRUE) / (nrow(annotatedBSJs) * 2)

# Retrieve random back-spliced junctions
randomBSJunctions <-
    getRandomBSJunctions(gtf, n = nrow(annotatedBSJs), f = f, setSeed = 123)
head(randomBSJunctions)
##                                  id    gene strand chrom startUpBSE endDownBSE
## 1   SLC8A1:-:chr2:40657420:40342393  SLC8A1      -  chr2   40657420   40342393
## 2   FLNA:-:chrX:153583048:153582398    FLNA      -  chrX  153583048  153582398
## 3   EXOC6B:-:chr2:72742883:72742172  EXOC6B      -  chr2   72742883   72742172
## 4 N4BP2L2:-:chr13:33112929:33091625 N4BP2L2      - chr13   33112929   33091625
## 5  PICALM:-:chr11:85779987:85733410  PICALM      - chr11   85779987   85733410
## 6    LGMN:-:chr14:93179179:93178004    LGMN      - chr14   93179179   93178004
```

Annotate randomly selected back-spliced junctions.

```
annotatedRBSJs <- annotateBSJs(randomBSJunctions, gtf, isRandom = TRUE)
```

Use the plot functions to plot all the features of the annotated back-spliced-junctions.

Type ?plotLenIntrons ?plotLenBSEs ?plotHostGenes ?plotExBetweenBSEs ?plotExPosition ?plotTotExons for more information about the arguments of the functions and their examples.

```
# annotatedBSJs act as foreground data set
# annotatedRBSJs act as background data set

# Length of flanking introns
p1 <- plotLenIntrons(
    annotatedBSJs,
    annotatedRBSJs,
    title = "Length flanking introns",
    df1Name = "predicted",
    df2Name = "random",
    setyLim = TRUE,
    ylim = c(0,7)
)

# Length of back-splided exons
p2 <- plotLenBSEs(
    annotatedBSJs,
    annotatedRBSJs,
    title = "Length back-splided exons",
    df1Name = "predicted",
    df2Name = "random",
    setyLim = TRUE,
    ylim = c(0,7)
)

# No. of circRNAs produced from the host genes
p3 <-
    plotHostGenes(annotatedBSJs, title = "# CircRNAs produced from host genes")

# No. of exons in between the back-spliced junctions
p4 <-
    plotExBetweenBSEs(annotatedBSJs, title = "# Exons between back-spliced junctions")

# Position of back-spliced exons within the host transcripts
p5 <-
    plotExPosition(annotatedBSJs,
        n = 1,
        title = "Position back-spliced exons in the transcripts")

# Total no. of exons within the host transcripts
p6 <-
    plotTotExons(annotatedBSJs, title = " Total number of exons in the host transcripts")

# Combine plots
ggarrange(p1,
    p2,
    p3,
    p4,
    p5,
    p6,
    ncol = 2,
    nrow = 3)
```

![\label{fig:figs} Comparison of structural features extracted from the subset of 1458 filtered  back-spliced junctions compared to an equal number of randomly generated back-spliced junctions.](data:image/png;base64...)

Comparison of structural features extracted from the subset of 1458 filtered back-spliced junctions compared to an equal number of randomly generated back-spliced junctions.

### **Retrieve target sequences**

Downstream screenings can be perfomed on one or multiple circRNAs (e.g differentially expressed circRNAs or circRNAs arising from the same host genes). We selected ALPK2 circRNA for further downstream screenings.

```
# Select ALPK2:-:chr18:56247780:56246046 circRNA
annotatedCirc <-
annotatedBSJs[annotatedBSJs$id == "ALPK2:-:chr18:56247780:56246046", ]

# As background data set we used all the remaining 1457 filered circRNAs.
# Alternatively the subset of randomly generated back-spliced junctions can be used.
annotatedBackgroundCircs <-
annotatedBSJs[which(annotatedBSJs$id != "ALPK2:-:chr18:56247780:56246046"), ]
```

CircRNA sequences, back-spliced junction sequences only or sequences flanking the back-spliced junctions can be analyze The sequences are retrieved from UCSC database. Default query sequence corresponds to the positive strand of the DNA (5’->3’). For all the circRNAs arising from genes located on the negative strand, the sequences are complemented and subsequently reversed since the reference direction is 5’->3’. Sequences are only retrieved for back-spliced junctions that overlap with exon boundaries of at least one transcript (see annotateBSJs()).

```
# All the sequences will be retrieved from the BSgenome package which contains
# the serquences of the genome of interest
if (!requireNamespace("BSgenome.Hsapiens.UCSC.hg19", quietly = TRUE)){
  BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")
}

# Get genome
genome <- BSgenome::getBSgenome("BSgenome.Hsapiens.UCSC.hg19")
```

### Module 9 - Retrieve internal circRNA sequences

#### *getCircSeqs()*

The function getCircSeqs() retrieves the internal circRNA sequences. By default, the circRNA sequences are the sequences of all the exons between the back-spliced-junctions. The exon sequences are retrieved and then concatenated together to recreate the circRNA sequence. To recreate the back-spliced junction sequence 50 nucleotides are taken from the 5’ head and attached at the 3’ tail of each circRNA sequence.

Type ?getCircSeqs for more information about the arguments of the function and its example.

```
# Foreground target sequences
targetsFTS_circ <-
getCircSeqs(annotatedCirc, gtf, genome)

# Background target sequences
targetsBTS_circ <-
getCircSeqs(annotatedBackgroundCircs, gtf, genome)
```

The output is a list of 1 data frame containing the the following columns:

* id: unique identifier.
* gene: represents the gene from which the circRNA arises.
* transcript: transcript whose exon coordinates overlap with the detected back-spliced junction coordinate and used in the downstream analysis.
* strand: is the strand from which the gene is transcribed.
* chrom: is the chromosome from which the circRNA is derived.
* startGR: is the 5’ coordinate of the genomic range from which the sequence are extracted.
* endGR: is the 3’ coordinate of the genomic range from which the sequence are extracted.
* length: length of the extracted sequences. The circRNA sequences reported in the output file (column seq) are longer than the predicted length (column lenght), due to the 50 nucleotides attached at the 3’ tail to recreate the back-spliced junction.
* seq: sequence used in the downstream analysis.
* type: type of sequences retrieved. In this case circ stands for circRNA.

### Module 10 - Retrieve BSJ sequences

#### *getSeqsAcrossBSJs()*

The function getSeqsAcrossBSJs() can be used to retrieve the sequences across the back-spliced junctions. A total of 11 nucleotides from each side of the back-spliced junction are taken and concatenated together.

Type ?getSeqsAcrossBSJs for more information about the arguments of the function and its example.

```
# Foreground target sequences
targetsFTS_bsj <-
    getSeqsAcrossBSJs(annotatedCirc, gtf, genome)

# Background target sequences
targetsBTS_bsj <-
getCircSeqs(annotatedBackgroundCircs, gtf, genome)
```

The output is a list of 1 data frame containing the the following columns:

* id: unique identifier.
* gene: represents the gene from which the circRNA arises.
* transcript: transcript whose exon coordinates overlap with the detected back-spliced junction coordinate and used in the downstream analysis.
* strand: is the strand from which the gene is transcribed.
* chrom: is the chromosome from which the circRNA is derived.
* startGR: is the 5’ coordinate of the genomic range from which the sequence are extracted.
* endGR: is the 3’ coordinate of the genomic range from which the sequence are extracted.
* length: length of the extracted sequences. For the back-spliced junctions this will be 22 nucleotides.
* seq: sequence used in the downstream analysis.
* type: type of sequences retrieved. In this case bsj stands back-spliced junctions.

### Module 11 - Retrieve sequences flanking the BSJs

#### *getSeqsFromGRs()*

The function getSeqsFromGRs() includes 3 modules to retrieve the 3 types of sequences: i) sequences of the introns flanking back-spliced junctions, ii) sequences from a user-defined genomic window surrounding the back-spliced junctions and iii) sequences of the back-spliced exons. In detail, if type = “fi” the sequences of the introns flanking the back-spliced exons are retrieved. If type = “ie” the sequences are retrieved from the genomic window defined by using the values given in input to lIntron and lExon. If type = “bse” the sequences of the back-spliced exons will be extracted.

Type ?getSeqsFromGRs for more information about the arguments of the function and its example.

```
# Foreground target sequences
targetsFTS_gr <-
    getSeqsFromGRs(
        annotatedCirc,
        genome,
        lIntron = 200,
        lExon = 9,
        type = "ie"
        )
# Background target sequences.
targetsBTS_gr <-
    getSeqsFromGRs(
        annotatedBackgroundCircs,
        genome,
        lIntron = 200,
        lExon = 9,
        type = "ie")
```

The output is a list. Each element of the list is a dataframe with the following columns:

* id: unique identifier.
* gene: represents the gene from which the circRNA arises.
* transcript: transcript whose exon coordinates overlap with the detected back-spliced junction coordinate and used in the downstream analysis.
* strand: is the strand from which the gene is transcribed.
* chrom: is the chromosome from which the circRNA is derived.
* startGR: is the 5’ coordinate of the genomic range from which the sequence are extracted.
* endGR: is the 3’ coordinate of the genomic range from which the sequence are extracted.
* length: length of the extracted sequences.
* seq: sequence used in the downstream analysis.
* type: type of sequences retrieved. See type argument of function getSeqsFromGRs(). If type = “fi” the sequences derive from introns flanking the back-spliced exons If type = “ie” the sequences derive from the genomic window defined by using the values given in input to lIntron and lExon. If type = “bse” the sequences derive from back-spliced exons.

### **Screen target sequences**

### Module 12 - Screen target sequences for RBP/de Novo motifs

#### *getMotifs()*

The function getMotifs() scans the target sequences from module 9-11 for the presence of recurrent motifs of a specific length defined in input. Briefly, we first compute all possible motifs of a given length (defined by the argument width of the function), and then the target sequences are scanned for the presence of those motifs. Also overlapping motifs are counted. The identified motifs can subsequently be matched with motifs of known RNA Binding Proteins (RBPs) deposited in the ATtRACT or MEME database. A motif identified in target sequences is selected if it matches with or it is part (as substring) of any RBP motifs deposited in the database. It is possible to specify whether to report only motifs matching with RBPs or unknown motifs. By setting rbp = TRUE, only motifs matching with known RBP motifs are reported. By setting reverse = TRUE, all the RBP motifs in the ATtRACT or MEME database and custom motifs reported in motifs.txt are reversed and analyzed together with the direct motifs as they are reported in the databases and motifs.txt. Location of the selected motifs is also reported. This corresponds to the start position of the motif within the sequence (1-index based). If RBP analysis is performed on BSJ sequences only motifs crossing the back-spliced junctions with at least one nucleotide are reported. E.g. by setting width = 6, the BSJ sequences retrieved using module 10 are trimmed so that only 5 nucleotides are left at each side of the BSJ. If width = 7, then 6 nucleotides are left at each side of the BSJ etc.

NOTE:

It might be that the URL of the databases from which the RBP motifs are retrieved can not be reached, in that case a message will be printed and only motifs reported in the motifs.txt will be used in the analysis.

Type ?getMotifs for more information about the arguments of the function and its example.

```
# If you want to analysis also custom motifs report them in motifs.txt (optional).
# If motifs.txt is not present in your working directory specify pathToMotifs.
# As default motifs.txt is searched in the wd.

# E.g. in motifs.txt we added RBM20 consensus motif since it is not present in
# the ATtRACT database.

# Find motifs in the foreground target sequences
motifsFTS_gr <-
    getMotifs(targetsFTS_gr,
              width = 6,
              database = 'ATtRACT',
              species = "Hsapiens",
              rbp = TRUE,
              reverse = FALSE)
# Find motifs in the background target sequences
motifsBTS_gr <-
    getMotifs(targetsBTS_gr,
              width = 6,
              database = 'ATtRACT',
              species = "Hsapiens",
              rbp = TRUE,
              reverse = FALSE)
```

The output is a list. Each element of the list has 4 elements.

* The first element (targets) is a dataframe containing the information of the target sequences. Columns are: id, gene, transcript, strand, chrom, startGR, endGR, length, seq, type. See above for a description of the column names.
* The second element (counts) is a dataframe containing the number of motifs found in the target sequences. Each column corresponds to a motif.
* The third element (locations) is a dataframe containing the locations of the motifs. Each column corresponds to a motif.
* The fourth element (motifs) is a dataframe containing the sequences of the motifs and the corresponding RBP.

#### *mergeMotifs()*

The function mergeMotifs() groups all the motifs recognized by the same RBP and report the total counts.

Type ?mergeMotifs for more information about the arguments of the function and its example.

```
mergedMotifsFTS_gr <- mergeMotifs(motifsFTS_gr)
mergedMotifsBTS_gr <- mergeMotifs(motifsBTS_gr)
```

Retrieve and plot log2FC and counts of the motifs found in the target sequences (e.g. background and foreground). If the number or the length of the target sequences is different then the counts should be normalized. Normalization can be done using the number or the total length of the target sequences (suggested).

Type ?plotMotifs for more information about the arguments of the function and its example.

```
# Plot log2FC and normalized counts

# Normalize using the number of target sequences. You can do this normalization if you
# analyzed the same number of target sequences and extracted the same number of
# nucleotides from the latter.

# Alternatively you can use the length of the target sequences.
# If you are analyzing the flanking upstream and downstream sequences then normalize
# using the length of the latters.E.g.:
# nf1 = sum(targetsFTS_gr$upGR$length, na.rm = T)+sum(targetsFTS_gr$downGR$length, na.rm = T)
# nf2 = sum(targetsBTS_gr$upGR$length, na.rm = T)+sum(targetsBTS_gr$downGR$length, na.rm = T)

# If you are analyzing the circRNA sequences then normalize using the length of
# the latter. E.g.:
# nf1 = sum(targetsFTS_circ$circ$length, na.rm = T)
# nf2 = sum(targetsBTS_circ$circ$length, na.rm = T)

# If you are analyzing the BSJ then normalize using the length of the latter. E.g.:
# nf1 = sum(targetsFTS_bsj$bsj$length, na.rm = T)
# nf2 = sum(targetsBTS_bsj$bsj$length, na.rm = T)

p <-
    plotMotifs(
        mergedMotifsFTS_gr,
        mergedMotifsBTS_gr,
        nf1 = sum(targetsFTS_gr$upGR$length, na.rm = T)+sum(targetsFTS_gr$upGR$length, na.rm = T) ,
        nf2 = sum(targetsBTS_gr$upGR$length, na.rm = T)+sum(targetsBTS_gr$upGR$length, na.rm = T),
        log2FC = 1,
        removeNegLog2FC = TRUE,
        df1Name = "circALPK2",
        df2Name = "Other circRNAs",
        angle = 45
    )
ggarrange(p[[1]],
          p[[2]],
          labels = c("", ""),
          ncol = 2,
          nrow = 1)
```

![\label{fig:figs} Bar chart showing the log2FC (cut-off = 1) and the normalized counts of the RBP motifs found in the region flanking the predicted back-spliced junction of circALPK2 compared to the remaining subset of 1457 filtered circRNAs.](data:image/png;base64...)

Bar chart showing the log2FC (cut-off = 1) and the normalized counts of the RBP motifs found in the region flanking the predicted back-spliced junction of circALPK2 compared to the remaining subset of 1457 filtered circRNAs.

```
# Type p[[3]] to get the table
head(p[[3]])
```

The data frame contains the following columns:

* foreground: number of motifs found in the foreground target sequences (e.g. predicted circRNAs).
* background: number of motifs found in the background target sequences (e.g. randomly generated circRNAs).
* foregroundNorm: number of motifs found in the foreground target sequences (+1) divided by the number (or length) of sequences analyzed.
* backgroundNorm: number of motifs found in background target sequences (+1) divided by the number (or length) of sequences analyzed.
* log2FC: log2 fold change calculated in this way (foregroundNorm)/(backgroundNorm).
* motifF: motifs of the corresponding RBP found in the foreground sequences.
* motifB: motifs of the corresponding RBP found in the background sequences.

NOTE:

To avoid infinity as a value for fold change, 1 was added to number of occurences of each motif found in the foreground and background target sequences before the normalization.

It is also possible to search for RBP motifs and unknown motifs in circRNA sequences and back-spliced junction sequences. For this purpose the target sequences have to be retrieved and then the functions getMotifs() and mergeMotifs() have to be run, as described above.

### Module 13 - Screen circRNA sequences for miRNA binding sites

#### *getMiRsites()*

The function getMirSites() searches miRNA binding sites within circRNA sequences. Briefly, circRNAprofiler queries the miRBase database and retrieves the miRNA sequences which are subsequently reversed (3’->5’). Each circRNA sequence is then scanned using a sliding window of 1, for the presence of putative matches with the miRNA seed sequence. For each iteration, the number of total matches (canonical Watson-Crick (WC) + non-canonical matches), continuous canonical WC matches and non-canonical matches between the 2 given sequences (miRNA seed region and miRNA seed region binding sites) are reported. circRNAprofiler compares the 2 sequences without gap and by introducing a gap in each position of one of the 2 sequences at the time to find a better alignment. A WC match occurs when adenosine (A) pairs with uracil (U)and guanine (G) pairs with cytosine (C). A perfect seed match has no gaps in alignment within the WC matching. A non-canonical match occurs when a G matches with U. A mismatch occurs when there is a gap in one of the two aligned sequences (asymmetric mismatch or buldge) or in the following cases (symmetric mismatch): A-G or A-C or U-C. Once the alignment is performed and the number of matches collected, miRNA seed region binding sites are filtered based on the input settings and reported in the final output. Of those binding sites, additional features are also reported. These features are the number of matches found between the target sequences and the central and supplementary regions of the miRNA. Information about the nucleotide at position 1 (t1), that is the nucleotide in the target sequence that matches with the nucleotide number 1 of the miRNA sequence. Finally, the percentage of AU nucleotides around the miRNA seed region binding sites is reported. The output is a list of data frames where each data frame contains the information relative to one circRNA. The following columns are present:

* miRseqRev: miRNA sequence used in the analysis; e.g. 3’GAUUCGGUGGUACACUUUGGUC5’; GUGG: compensatory region (13-16); UACA: central region (9-12); CUUUGGU: seed (8-2).
* counts: is the number of miRNA seed region binding sites found in the target sequence.
* totMatchesInSeed: is the number of total matches (canonical WC + non-canonical matches) found between the miRNA seed region and the miRNA seed region binding site in the target sequence. The maximun number of possible matches is 7.
* cwcMatchesInSeed: is the number of continuous WC matches found between the miRNA seed region and the miRNA seed region binding site in the target sequence.
* seedLocation: is the location of the miRNA seed region binding site in the target sequence. E.g. if the reported number is 20 it means that the nucleotide at position 20 in the target sequence (1-index based) matches with the nucleotide number 8 of the miRNA. From 21 to 26 one can find the rest of the seed sequence. For the central region one has to look from position 16 to 19 and for the compensatory region from position 12 to 15 of the target sequence.
* t1: is the nucleotide in the target sequence that matches with nucleotide number 1 (C5’) of the miRNA sequence.
* totMatchesInCentral: is the number of total matches (canonical WC + non-canonical matches) found between the miRNA central region and the sequence upstream the miRNA seed region binding site in the target sequence (e.g. position 16 to 19). The maximun number of possible matches is 4.
* cwcMatchesInCentral: is the number of continuous WC matches found between the miRNA central region and the sequence upstream the miRNA seed region binding site in the target sequence (e.g. position 16 to 19).
* totMatchesInCompensatory: is the number of total matches found between the miRNA compensatory region and the sequence upstream the miRNA seed region binding site in the target sequence (e.g. position 12 to 15). The maximun number of possible matches is 4.
* cwcMatchesInCompensatory: is the number of continuous WC matches found between the miRNA compensatory region and the region upstream the miRNA seed region binding site in the target sequence (e.g. position 12 to 15).
* localAUcontent: is the percentage of AU nucleotides in the 10 nucleotides upstream and downstream the miRNA seed region binding site in the target sequence.

How to interpret the results? The user can select stringency criteria for miRNA binding prediction. For example by setting the function arguments totalMatches = 7 and maxNonCanonicalMatches = 1, one can retrieve only miRNA seed region binding sites with a number of total matches with the miRNA seed region equal to 7 of which only 1 can be a non-canonical match. In this case after running the analysis, totMatchesInSeed must be 7, if cwcMatchesInSeed is 4mer it means that there are 7 matches between the miRNA seed region binding site in the target sequence and the miRNA seed region, with 1 non-canonical match in the middle of alignment, that is: there are 4 continuous WC matches (4mer), 1 non-canonical match and 2 continuous WC matches, for a total of 7.

Furthemore, for the selected site, let’s assume that for the central and compensatory region, the maximum number of matches found with the target sequence is 4 for both of them. In this case if totMatchesInCentral is 4 but cwcMatchesInCentral is 3 it means that there are 3 continuous WC matches with 1 non-canonical match, for a total of 4. Alternatively if totMatchesInCentral is 3 but cwcMatchesInCentral is 2 it means that there are 2 continuous WC matches, 1 non-canonical match for a total of 3 and 1 gap. The same rule is valid for totMatchesInCompensatory and cwcMatchesInCompensatory.

The miRNA analysis starts at position 30 of the circRNA sequence to allow the analysis of the complementary and 3’ supplementary region of the miRNA that have to be aligned with the region located backwards the selected miRNA seed region binding site. The 30 nucleotides skipped in the initial phase are analyzed in the final phase together with the back-spliced junction. The computational time increases with the number of sequences and miRNAs to analyze. To reduce false positives and computational time we suggest making a selection on miRNAs, e.g.  use only miRNAs expressed in the tissues of interest.

Th run time to analyze 1 circRNA sequence of length ~1700 nt for the presence of 360 miRs, is ~4h 20m.

NOTE:

It might be that the URL of miRBase database from which the miR sequences are retrieved can not be reached, in that case an error message will be printed and the analysis will stop. To proceed with the analysis set miRBaseLatestRelease to FALSE. If FALSE is specified then a file named mature.fa containing fasta format sequences of all mature miRNA sequences previously downloaded by the user from miRBase must be present in the working directory (e.g. projectCirc). The mature.fa will be read automatically by the module and used to extract the needed miR sequences.

Type ?getMiRsites for more information about the arguments of the function and its example.

```
# If you want to analysis only a subset of miRs, then specify the miR ids in
# miRs.txt (optional).
# If miRs.txt is not present in your working directory specify pathToMiRs.
# As default miRs.txt is searched in the wd.
miRsites <-
    getMiRsites(
        targetsFTS_circ,
        miRspeciesCode = "hsa",
        miRBaseLatestRelease = TRUE,
        totalMatches = 6,
        maxNonCanonicalMatches = 1
    )
```

#### *rearrageMiRres()*

The function rearrangeMirRes() rearranges the results of the getMiRsites() function. Each element of the list contains the miR results relative to one circRNA. For each circRNA only miRNAs for which at least 1 miRNA binding site is found are reported.

```
rearragedMiRres <- rearrangeMiRres(miRsites)
```

Store results in an excel file

```
# If multiple circRNAs have been analyzed for the presence of miR binding sites
# the following code can store the predictions for each circRNA in a
# different sheet of an xlsx file for a better user consultation.
i <- 1
j <- 1
while (i <= (length(rearragedMiRres))) {
    write.xlsx2(
        rearragedMiRres[[i]][[1]],
        "miRsites_TM6_NCM1.xlsx",
        paste("sheet", j, sep = ""),
        append = TRUE
    )
    j <- j + 1
    write.xlsx2(
        rearragedMiRres[[i]][[2]],
        "miRsites_TM6_NCM1.xlsx",
        paste("sheet", j, sep = ""),
        append = TRUE
    )
    i <- i + 1
    j <- j + 1
}
```

The function plotMir() can be used to visualize the miR results of 1 circRNA at the time. By setting id = 1 the the miR results of the first element of the list rearragedMiRres are plotted.

Type ?plotMiR for more information about the arguments of the function and its example.

```
# Plot miRNA analysis results

p <- plotMiR(rearragedMiRres,
             n = 40,
             color = "blue",
             miRid = TRUE,
             id = 1)
p
```

### **Annotate target sequences**

### Module 14 - Annotate GWAS SNPs

#### *annotateSNPsGWAS()*

The function annotateSNPsGWAS() can be used to annotate the GWAS SNPs located in the regions flanking the back-spliced junctions of each circRNA. SNPs information including the corresponding genomic coordinates are retrieved from the GWAs catalog database. The genomic coordinates of the GWAS SNPs are overlapped with the genomic coordinates of the target sequences. This is possible only for the human genome. An empty list is returned if none overlapping SNPs are found.

Type ?annotateSNPsGWAS for more information about the arguments of the function and its example.

```
snpsGWAS <-
    annotateSNPsGWAS(targetsFTS_gr, assembly = "hg19", makeCurrent = TRUE)
```

### Module 15 - Annotate repetitive elements

#### *annotateRepeats()*

The function annotateRepeats() annotates repetitive elements located in the region flanking the back-spliced junctions of each circRNA. Briefly, the genomic coordinates of repetitive elements in the RepeatMasker database are overlapped with the genomic coordinates of the target sequences. If complementary = TRUE, only back-spliced junctions of circRNAs of which flanking introns contain complementary repeats (repeats belonging to a same family but located on opposite strands) are reported in the final output. Repetitive elements are provided by AnnotationHub storage which collected repeats from RepeatMasker database. Type data(ahRepeatMasker) to see all possibile options for annotationHubID. If “AH5122” is specified, repetitve elements from Homo sapiens, genome hg19 will be downloaded and annotated. An empty list is returned if none overlapping repeats are found.

Type ?annotateRepeats for more information about the arguments of the function and its example.

```
repeats <-
    annotateRepeats(targetsFTS_gr, annotationHubID = "AH5122", complementary = TRUE)
```

## Support

We work hard to ensure that circRNAprofiler is a powerful tool empowering your research. However, no software is free of bugs and issues, therefore we would love to get feedback from our users.

## Citation

If you find this code useful in your research, please cite:

Aufiero, S., Reckman, Y.J., Tijsen, A.J. et al. circRNAprofiler: an R-based computational framework for the downstream analysis of circular RNAs. BMC Bioinformatics 21, 164 (2020). <https://doi.org/10.1186/s12859-020-3500-3>

## Acknowledgement

We thank Engr. Dario Zarro and the member of the YP group for helpful discussion.

## Note

```
sessionInfo()
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
## [1] stats4    grid      stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
##  [3] rtracklayer_1.70.0                BiocIO_1.20.0
##  [5] Biostrings_2.78.0                 XVector_0.50.0
##  [7] GenomicRanges_1.62.0              Seqinfo_1.0.0
##  [9] IRanges_2.44.0                    S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0               generics_0.1.4
## [13] gridExtra_2.3                     VennDiagram_1.7.3
## [15] futile.logger_1.4.3               ggpubr_0.6.2
## [17] ggplot2_4.0.0                     circRNAprofiler_1.24.0
## [19] knitr_1.50
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              GenomicFeatures_1.62.0
##   [5] farver_2.1.2                rmarkdown_2.30
##   [7] vctrs_0.6.5                 memoise_2.0.1
##   [9] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [11] rstatix_0.7.3               htmltools_0.5.8.1
##  [13] S4Arrays_1.10.0             lambda.r_1.2.4
##  [15] AnnotationHub_4.0.0         curl_7.0.0
##  [17] broom_1.0.10                SparseArray_1.10.0
##  [19] Formula_1.2-5               sass_0.4.10
##  [21] bslib_0.9.0                 plyr_1.8.9
##  [23] httr2_1.2.1                 futile.options_1.0.1
##  [25] cachem_1.1.0                GenomicAlignments_1.46.0
##  [27] lifecycle_1.0.4             pkgconfig_2.0.3
##  [29] Matrix_1.7-4                R6_2.6.1
##  [31] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [33] digest_0.6.37               AnnotationDbi_1.72.0
##  [35] DESeq2_1.50.0               RSQLite_2.4.3
##  [37] labeling_0.4.3              filelock_1.0.3
##  [39] httr_1.4.7                  abind_1.4-8
##  [41] compiler_4.5.1              bit64_4.6.0-1
##  [43] withr_3.0.2                 S7_0.2.0
##  [45] backports_1.5.0             BiocParallel_1.44.0
##  [47] carData_3.0-5               DBI_1.2.3
##  [49] R.utils_2.13.0              ggsignif_0.6.4
##  [51] MASS_7.3-65                 rappdirs_0.3.3
##  [53] DelayedArray_0.36.0         rjson_0.2.23
##  [55] tools_4.5.1                 R.oo_1.27.1
##  [57] glue_1.8.0                  restfulr_0.0.16
##  [59] reshape2_1.4.4              ade4_1.7-23
##  [61] seqinr_4.2-36               gtable_0.3.6
##  [63] tzdb_0.5.0                  R.methodsS3_1.8.2
##  [65] tidyr_1.3.1                 data.table_1.17.8
##  [67] hms_1.1.4                   car_3.1-3
##  [69] gwascat_2.42.0              BiocVersion_3.22.0
##  [71] pillar_1.11.1               stringr_1.5.2
##  [73] limma_3.66.0                splines_4.5.1
##  [75] dplyr_1.1.4                 BiocFileCache_3.0.0
##  [77] lattice_0.22-7              survival_3.8-3
##  [79] bit_4.6.0                   universalmotif_1.28.0
##  [81] tidyselect_1.2.1            locfit_1.5-9.12
##  [83] edgeR_4.8.0                 SummarizedExperiment_1.40.0
##  [85] snpStats_1.60.0             xfun_0.53
##  [87] Biobase_2.70.0              statmod_1.5.1
##  [89] matrixStats_1.5.0           stringi_1.8.7
##  [91] UCSC.utils_1.6.0            yaml_2.3.10
##  [93] evaluate_1.0.5              codetools_0.2-20
##  [95] cigarillo_1.0.0             tibble_3.3.0
##  [97] BiocManager_1.30.26         cli_3.6.5
##  [99] jquerylib_0.1.4             dichromat_2.0-0.1
## [101] Rcpp_1.1.0                  GenomeInfoDb_1.46.0
## [103] dbplyr_2.5.1                png_0.1-8
## [105] XML_3.99-0.19               parallel_4.5.1
## [107] readr_2.1.5                 blob_1.2.4
## [109] bitops_1.0-9                VariantAnnotation_1.56.0
## [111] scales_1.4.0                purrr_1.1.0
## [113] crayon_1.5.3                rlang_1.1.6
## [115] cowplot_1.2.0               formatR_1.14
## [117] KEGGREST_1.50.0
```

## References

Giudice, Girolamo, Fatima Sanchez-Cabo, Carlos Torroja, and Enrique Lara-Pezzi. 2016. “ATtRACT-a Database of RNA-Binding Proteins and Associated Motifs.” *Database: The Journal of Biological Databases and Curation* 2016. <https://doi.org/10.1093/database/baw035>.

Griffiths-Jones, Sam, Russell J. Grocock, Stijn van Dongen, Alex Bateman, and Anton J. Enright. 2006. “miRBase: microRNA Sequences, Targets and Gene Nomenclature.” *Nucleic Acids Research* 34 (Database issue): D140–D144. <https://doi.org/10.1093/nar/gkj112>.

Khan, Mohsin A. F., Yolan J. Reckman, Simona Aufiero, Maarten M. G. van den Hoogenhof, Ingeborg van der Made, Abdelaziz Beqqali, Dave R. Koolbergen, et al. 2016. “RBM20 Regulates Circular RNA Production from the Titin Gene.” *Circulation Research* 119 (9): 996–1003. <https://doi.org/10.1161/CIRCRESAHA.116.309568>.

MacArthur, Jacqueline, Emily Bowler, Maria Cerezo, Laurent Gil, Peggy Hall, Emma Hastings, Heather Junkins, et al. 2017. “The New NHGRI-EBI Catalog of Published Genome-Wide Association Studies (GWAS Catalog).” *Nucleic Acids Research* 45 (Database issue): D896–D901. <https://doi.org/10.1093/nar/gkw1133>.

Zhao, Shanrong, and Baohong Zhang. 2015. “A Comprehensive Evaluation of Ensembl, RefSeq, and UCSC Annotations in the Context of RNA-Seq Read Mapping and Gene Quantification.” *BMC Genomics* 16 (1). <https://doi.org/10.1186/s12864-015-1308-8>.