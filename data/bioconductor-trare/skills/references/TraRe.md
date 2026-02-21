# TraRe: Identification of conditions dependant Gene Regulatory Networks

Jesús de la Fuente, Mikel Hernaez and Charles Blatti

#### 19 May 2021

#### Abstract

*TraRe* (Transcriptional Rewiring) is an R package which contains the necessary tools to carry out: Identification of module-based gene regulatory networks (GRNs); score-based classification of these modules via a rewiring test; visualization of rewired modules to analyze condition-based GRN deregulation and drop out genes recovering via cliques methodology. For each tool, an html report can be generated containing useful information about the generated GRN and statistical data about the performed tests. These tools have been developed considering sequenced data (RNA-Seq).

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 LINKER : Generating Gene Regulatory Networks](#linker-generating-gene-regulatory-networks)
  + [3.1 Overview of the proposed method](#overview-of-the-proposed-method)
  + [3.2 Running LINKER in TraRe](#running-linker-in-trare)
* [4 Rewiring GRN modules](#rewiring-grn-modules)
  + [4.1 Overview of Rewiring method](#overview-of-rewiring-method)
  + [4.2 How to run rewiring on TraRe](#how-to-run-rewiring-on-trare)
* [5 Visualization of GRN](#visualization-of-grn)
  + [5.1 Overview](#overview)
  + [5.2 Plot GRN in TraRe](#plot-grn-in-trare)
* [6 Cliques method and results](#cliques-method-and-results)
  + [6.1 Overview](#overview-1)
* [7 Generate file in TraRe](#generate-file-in-trare)

# 1 Installation

TraRe can be currently installed from Bioconductor:

```
 if (!requireNamespace("BiocManager"))
 install.packages("BiocManager")
 BiocManager::install("TraRe")
```

# 2 Introduction

To fully understand how TraRe works, we will go through
each tool it contains:

* *LINKER*, a module-based method manner of inferring GRNs.
* *Rewiring*, for selecting important modules from *LINKER* subject to a phenotype condition.
* Visualization,for graphically displaying generated GRN from previous process.
* Results, excel generation of useful information about drivers to targets relations from
  previous GRN.

Along with every step description and explanation, we will be working with a subset of the Stand Up To Cancer (SU2C) clinical trial dataset containing 1.2k genes (\(\approx\) 200 transcription factors or driver
genes) and 121 samples from metasatic castration resistant prostate cancer patients. Patients were divided into two groups depending on the treatment:
Abiraterone (ABI) and ABI/ENZA (ARSI). For the phenotype dependent *Rewiring*, we will be
focusing on only ARSI patients (35 samples). The pathway we will follow is:

* Run *LINKER* using the available gene expression matrix (GEM), 1149 genes and 121 samples, to generate all possible modules (GRN).
* Run *Rewiring* test selecting the sample’s (ARSI) phenotype (35 samples) to extract *LINKER* modules which expression can be separated very well according to the selected phenotype. Selected modules will be scored based on a hypergeometric test.
* Run Visualization, generating GRN graphs of how the regulation process may change depending on the phenotype condition. (This step is included at the end of the previous one).
* Run Results, that generates an excel containing information about the driver-target relationships from the previously generated GRN graphs, and a brief summary that may be useful for biological validation of GRN. (This step is also included at the end of *Rewiring*).

##Data

The dataset we are working with is located at TraRe’s package folder. The complete SU2C dataset
contains about 13000 genes, but we will be using this subset in order to fulfill the space
requirements of the package. We consider important to use a real dataset for a proper understanding
of TraRe’s results.

TraRe mainly require three types of gene-related files:

* Gene expression matrix: We will be working with a
  log-applied and MRM-normalized gene expression matrix, lognorm\_est\_counts.
* Gene info dataframe: As information about transcription factors is required
  for these methods, we will use a dataframe containing a boolean variable with
  this information. ‘1’s for the driver genes, ’0’s for the non-driver genes. This variable
  will be called ’regulator’.
* Phenotype dataframe: As our GRN are phenotype dependant, this file will indicate whether samples
  are Responders ‘R’ or NonResponders ‘NR’.

# 3 LINKER : Generating Gene Regulatory Networks

## 3.1 Overview of the proposed method

The aim of the proposed method is to find relatively small networks
that link few regulatory (or driver) genes with a similarly regulated
set of genes, also known as the target genes.
In order to build such networks, the method is divided into two
phases. During Phase I the method generates K modules of similarly
expressed genes and then associates each module to a few regulators.

Due to the non-convex nature of the problem, we perform
B runs of this step using a different set of samples (sub-sampling
without replacement) with a different random initialization in order
to explore more broadly the set of potentially valid modules. Thus, at
the end of this step the method has generated
K \* B modules of similarly regulated genes, each of them with their
associated regulators. During Phase II the
proposed method generates, for each module, a bipartite graph that links the individual target genes to their associated regulators.

Note that if no combination of regulators represents
accurately the expression profile of a given target gene, that gene is
removed from the graph. This scenario arises when the target gene
in question was an outlier in the corresponding module.

## 3.2 Running LINKER in TraRe

*LINKER* generates, from an initial RNA-Seq dataset where drivers (Transcription Factors) and targets genes are provided, GRN modules in three different forms: as raw results, from the Phase I output modules; as modules from the Phase II output modules and in the form of bipartite graphs, where drivers and targets relationships are defined. Here we include all the parameters and their description. For more information, please refer to the help section of `LINKER_run()`.

* **lognorm\_est\_counts** Matrix of log-normalized estimated counts of the gene expression data (Nr Genes x Nr samples).
* **nassay** if SummarizedExperiment object is passed as input to lognorm\_est\_counts, name of the
  assay containing the desired matrix. Default: 0
* **regulator** if SummarizedExperiment object is passed as input to lognorm\_est\_counts, name of the
  rowData() variable to build target\_filtered\_idx and regulator\_filtered\_idx. This variable must be one
  for driver genes and zero for target genes. If not specified, target and regulator indexes must be provided.
* **target\_filtered\_idx** Index array of the target genes on the lognorm\_est\_counts matrix.
* **regulator\_filtered\_idx** Index array of the regulatory genes on the lognorm\_est\_counts matrix.
* **link\_mode** Chosen method(s) to link module eigengenes to regulators. The available options are
  “VBSR”, “LASSOmin”, “LASSO1se” and “LM”. By default, all methods are chosen.
* **graph\_mode** Chosen method(s) to generate the edges in the bipartite graph. The available options
  are “VBSR”, “LASSOmin”, “LASSO1se” and “LM”. By default, all methods are chosen.
* **module\_rep** Method selected for use. Default set to MEAN.
* **NrModules** Number of modules that are a *priori* to be found (note that the final number of modules
  discovered may differ from this value). By default, 100 modules.
* **corrClustNrIter** output from preparedata(). By default, 100.
* **Nr\_bootstraps** Number of bootstrap of Phase I. By default, 10.
* **FDR** The False Discovery Rate correction used for the enrichment analysis. By default, 0.05.
* **NrCores** Number of computer cores for the parallel parts of the method. Note that the parallelization
  is NOT initialized in any of the functions. By default, 2.

We now run *LINKER* method below. This is the first step from
the pathway, running *LINKER* using the complete gene expression
matrix to generate all possible GRN.

```
# For this example, we are going to join 70 drivers and 1079 targets from our package's folder.

lognorm_est_counts <- utils::read.delim(paste0(system.file("extdata",package="TraRe"),
                                               '/VignetteFiles/expression_rewiring_vignette.txt'))
lognorm_est_counts <- as.matrix(lognorm_est_counts)

# Here we have two options: we can create the index and pass them to run LINKER method or
# we can work with Summarized experiments.
# In order to create index, in this example regulators are placed in the first 200 positions.

R <- 70
P <- 1079

regulator_filtered_idx <- seq_len(R)
target_filtered_idx <- R+seq(P)

# If a SummarizedExperiment is desired to be provided,
# the expression matrix should be saved as an assay and
# gene info should be located in SummarizedExperiment::rowData().
# From this object, target and regulators indexes will be automatically
# generated.

geneinfo <- utils::read.delim(paste0(system.file("extdata",package="TraRe"),
               '/geneinfo_rewiring_example.txt'),row.names = 1)

# We have to make sure geneinfo and lognorm
# have same rows (same genes).

geneinfo <- geneinfo[rownames(lognorm_est_counts),,drop=FALSE]

# Now we can generate the SE object.
SeObject <- SummarizedExperiment::SummarizedExperiment(assays = list(counts = lognorm_est_counts),
                                                       rowData = geneinfo)

# We recommend VBSR.
# For the sake of time, we will be running only 1 bootstrap, but the following results
# will show a 10 bootstraps LINKER run.

#Regular expression matrix
#linkeroutput <- LINKER_run(lognorm_est_counts = lognorm_est_counts,
#                           target_filtered_idx = target_filtered_idx,
#                           regulator_filtered_idx = regulator_filtered_idx,link_mode="VBSR",
#                           graph_mode="VBSR",NrModules=100,Nr_bootstraps=1)

#SummarizedExperiment
linkeroutput <- LINKER_run(lognorm_est_counts = SeObject,link_mode="VBSR",
                           graph_mode="VBSR",NrModules=100,Nr_bootstraps=1)
## Bootstrap 1, NrModules 68:
## [1]  3.8970588 15.8676471  0.6345257  0.4625640  0.3827713  0.4544457  0.4617469
## Link modes completed!
## Graphs computed!
```

*LINKER* also provides a way of generating a single GRN from specified list of driver and target genes. This eases the task of analyzing relationships between drivers and targets by constraining all the provided genes to a single GRN. Normally, this task is done when we have previously confirm all these genes belong to one GRN. The way we do this is by running the *Rewiring* method, that will be explained in the next section. Find below the necessary parameters and descriptions of `NET_run()`.

* **lognorm\_est\_counts** Matrix of log-normalized estimated counts of the gene expression
  data (Nr Genes x Nr samples)
* **target\_filtered\_idx** Index of the target genes on the lognorm\_est\_counts matrix.
* **regulator\_filtered\_idx** Index of the regulatory genes on the lognorm\_est\_counts matrix.
* **graph\_mode** Chosen method(s) to generate the edges in the bipartite graph. The available options are “VBSR”,
  “LASSOmin”, “LASSO1se” and “LM”. By default, all methods are chosen.
* **FDR** The False Discovery Rate correction used for the enrichment analysis. By default, 0.05.
* **NrCores** Number of computer cores for the parallel parts of the method. Note that
  the parallelization is NOT initialized in any of the functions. By default, 3.

In order to run the single GRN generation, there is a particular function that works very similar to the main *LINKER* one. Here is an example, which is also in the help section of `NET_run()`.

```
# Assume we have run the rewiring method and we have discovered a rewired module.
# After we have selected the drivers and targets from that modules, we can build
# a single GRN to study it separately.

# Imagine our rewired module consists of 200 driver genes and 1000 target genes.
# We will be using same lognorm_est_counts we have already generated

# Same as before, we can provide indexes or built a SummarizedExperiment and pass it to NET_run()
# We will be using same indexes we have already generated.

# As SeObject has been already generated, we can directly provide it to NET_run()
# Here we rewind that, if not SummarizedExperiment is passed, lognorm_est_counts will
# be the expression matrix, and target_filtered_idx and regulator_filtered_idx wil be
# the ones we have just generated for the example.

# Again, we recommend VBSR

#Regular expression matrix
#graph <- NET_run(lognorm_est_counts = lognorm_est_counts,
#                 target_filtered_idx = target_filtered_idx,
#                 regulator_filtered_idx = regulator_filtered_idx,
#                 graph_mode="VBSR")

#SummarizedExperiment
graph <- NET_run(lognorm_est_counts = SeObject,graph_mode="VBSR")
## Graphs for (VBSR) computed!
```

Note that this step is included in the *Rewiring* method.

# 4 Rewiring GRN modules

## 4.1 Overview of Rewiring method

* *Rewiring* step performs a permutation test over a certain condition to infer if that condition is producing any deregulation on our generated GRN. Bootstrapping plays an important role, as the non-convex nature of these biological events makes necessary to ensure that a certain behavior is repeated across bootstraps, and to confirm this event does not come from a particular realization. As bootstrapping has been performed in *LINKER*, this step will take advantage of it and will try to group highly scored modules, to infer GRNs with similar behavior across bootstraps. It will output a folder containing :
* A correlation matrix in the form of a heatmap (sorted by hierarchical clustering to ease interpretation), containing similar highly scored modules.
* A dendogram containing the relationships between modules, which have been used to sort the heatmap.
* A 3-graph plot, containing GRN within all samples and within sample’s phenotype (R-NR).
* A report containing statistical information about the module’s GRN, driver genes, target genes, pvalues, etc.

## 4.2 How to run rewiring on TraRe

In order to run *Rewiring* test, *Trare* provides two functions: the `preparerewiring()` function and the `runrewiring()` function. The first one requires:

* **name**: Desired name of the folder which is generated. The chosen
  threshold will be `paste()` to the name folder.
* **linker\_output\_p**: Output file from linker function path.
* **lognorm\_est\_counts\_p**: Lognorm counts of the gene expression matrix path.
* **SEObject\_p**: SummarizedExperiment objects path.
* **gene\_info\_p**: path of a two-column file containing genes and ‘regulator’ boolean variable.
* **phenotype\_p**: path of a two-column file containing used samples and Responder or No Responder ‘Class’ (NR,R).
* **nassays**: name of assays in case SummarizedObject is provided.
* **final\_signif\_thresh**: Significance threshold for the rewiring method. The lower the threshold, the more restrictive the method.
* **regulator\_info\_col\_name**: Column name of the gene\_info\_p. By default, ‘regulator’

There are also other parameters that will remain by default. Please take
a look at the `preparerewiring()` function for more information. We now generate
the `preparerewiring()` output.

Note that here we will include the previously generated *LINKER’s* output.
These files can be found in TraRe’s package folder.

```
# In order to prepare the rewiring, we can provide individual file paths:
lognorm_est_counts_p <- paste0(system.file("extdata",package="TraRe"),
               '/VignetteFiles/expression_rewiring_vignette.txt')

gene_info_p <- paste0(system.file("extdata",package="TraRe"),
               '/geneinfo_rewiring_example.txt')

linker_output_p <-  paste0(system.file("extdata",package="TraRe"),
               '/VignetteFiles/linker_output_vignette.rds')

phenotype_p <- paste0(system.file("extdata",package="TraRe"),
               '/phenotype_rewiring_example.txt')

# Or we can provide a SummarizedExperiment containing expression matrix,
# gene info (as rowData) and phenotype info (colData) plus the linker output.

# We are going to reload geneinfo, this time having old geneinfo rownames
# as a new column, as preparerewiring will place that column into rownames,
# so we dont have to use the row.names=1 in the read.delim

geneinfo <- utils::read.delim(gene_info_p)

# We again make sure they have same features (genes)
geneinfo <- geneinfo[geneinfo$uniq_isos%in%rownames(lognorm_est_counts),]

# We also load phenotype
phenotype<- utils::read.delim(phenotype_p)

# select only samples from the phenotype file.
lognorm_est_counts <- lognorm_est_counts[,phenotype$Sample.ID]

PrepareSEObject <- SummarizedExperiment::SummarizedExperiment(assays=list(counts=lognorm_est_counts),
                                                              rowData = geneinfo,
                                                              colData = phenotype)

# This file is stored in the VignettesFiles TraRe's package folder.
PrepareSEObject_p <- paste0(system.file("extdata",package="TraRe"),
               '/VignetteFiles/SEObject.rds')

# We can now generate the prepare rewiring file:
# With individual paths

#prepared <- preparerewiring(name="Vignette",linker_output_p = linker_output_p,
#                           lognorm_est_counts_p = lognorm_est_counts_p,gene_info_p = gene_info_p,
#                           phenotype_p=phenotype_p,final_signif_thresh=0.01)

# or with a SummarizedExperiment object

prepared <- preparerewiring(name="Vignette",linker_output_p = linker_output_p,
                           SEObject_p = PrepareSEObject_p,final_signif_thresh=0.01)
## Expression Matrix Size: (1149,35)
## Gene Info Table Size: (1149,2)
## NumGenes Kept: 1149
## NumRegs and NumTargs: [70,1079]
## Phenotype Table Size: (35,2)
##
## Sample Names: [MO_1084.Tumor|PRAD.01115550.Tumor.SM.A4KNI|SC_9050.Tumor|TP_2078_Tumor
## PROS12319B.SU2C.06115116.Tumor.SM.4W2NB|MO_1410.Tumor|SC_9175_T
## PROS01448.6115251.Tumor.SM.67ES6|SC_9057.Tumor|MO_1241.Tumor
## PROS01448.1115161.Tumor.SM.5SGU1|TP_2060.TM|SC_9183_T
## MO_1336.TM|TP_2081_T|PRAD.01115549.Tumor.SM.A4KNH
## MO_1176.Tumor|MO_1179.Tumor|MO_1510_T
## PRAD.01115468.Tumor.SM.6B2KE|SC_9129_Tumor|PM158.TM
## SC_9137_Tumor|PRAD.6115594.0.Tumor.SM.B2XRW|PROS01448.6115234.Tumor.SM.67ERX
## SC_9083.TM|PRAD.6115590.0.Tumor.SM.B2XRS|SC_9080.TM
## PROS01448.6115235.Tumor.SM.67ERY|PRAD.06115124.Tumor.SM.7LGU1|MO_1184.Tumor
## MO_1192.Tumor|PROS01448.6115247.Tumor.SM.67ES2|SC_9043.Tumor|PM14.TM]
##
## Number of samples: 35
## Filtered exp matrix: (1149,35)
## Class Per Counts: (20,15)

# NOTE: The reason why we are working with paths instead of files is that
# rewiring is allowed to compare more than 1 dataset, so it is easier
# to provide a vector of paths than a complex structure of files.

# This is, we can provide , for instance, a vector of 2 SummarizedExperiments
# that will be compared. SEObject_p <- c(SEObject1,SEObject2)..
#                        linker_output_p <- c(linker_output_p_1,linker_output_p_2)
```

In order to run `runrewiring()`, we just call `runrewiring(prepared)`. It will create a folder on the specified output path with an html report containing the hierarchical clustering of the rewired modules, these in the form of a heatmap and a report containing statistical information about the performed test.

![Rewiring Dendogram](data:image/png;base64...)
As shown in the heatmap, there a is a clear **Super Module** (SM). For a SM to exist
there are some requirements that have to be fulfilled. First, these modules should contain genes whose expression can be separated very well using the ARSI phenotype.
Second, they have shown similar behavior across bootstraps, with a score
given by its hypergeometrical test. Therefore, there is a SM and its formed by `c(298,945,698,619,795,156,63,214,563)` modules.

![Rewiring Hierarchical Clustering](data:image/png;base64...)

Rewiring Hierarchical Clustering

In the figure above the Hierarchical Clustering applied shows how the SM
we are talking about has been selected. The current implementation of *Rewiring*
method pulls away the first SM it finds and generates all the graph objects
and figures we are showing in the next section.

# 5 Visualization of GRN

## 5.1 Overview

This tool provides a graphical way of detecting condition-dependent GRN deregulation on the selected rewired modules. Once we have selected a cluster of modules which behave similar across bootstraps, we can constraint them to form a single GRN using `NET_Run()` and plot these GRN, filtering by samples we want to evaluate according to the phenotype condition.

## 5.2 Plot GRN in TraRe

We provide two ways of building the layout for the plot, depending on the choice of a t.test to be evaluated over the generated GRN, to sort target genes prior to plot the established relationship between these and drivers. On the one hand, `return_layout()` generates a regular layout in which there is no t.test, and target genes are sorted randomly in a line. On the other hand, `return_layout_phenotype()` performs a target gene level t.test which has as null hypothesis if samples separated by the selected condition are not deferentially expressed. From this analysis, the z-score is used to sort target genes and plot them describing a curve when using `plot_igraph()` function.

```
# Assume we have run the rewiring method and the `NET_run()` method to generate the
# igraph object. We are going to generate and plot both layouts for the example.
# We are going to generate all the files we need except for the igraph object, which
# is included as an example file in this package.

# We load the igraph object that we generated from the `NET_run()` example.
# Note: the igraph object is inside the list `NET_run()` generates.

graph <- readRDS(paste0(system.file("extdata",package="TraRe"),
               '/VignetteFiles/graph_netrun_vignette.rds'))
graph <- graph$graphs$VBSR

# We first generate the normal layout for the plot.
# We need the drivers and target names.

lognorm_est_counts <- utils::read.delim(paste0(system.file("extdata",package="TraRe"),
                                        '/VignetteFiles/expression_rewiring_vignette.txt'))

drivers <- lognorm_est_counts[seq(70),]
targets <- lognorm_est_counts[70+seq(1079),]

# Note that the generated graph may not have the same drivers and targets we used
# for generating it, so we will extract those genes and check in the gene_info file
# if they are drivers or targets.

geneinfo <- utils::read.delim(paste0(system.file("extdata",package="TraRe"),
                                    '/geneinfo_rewiring_example.txt'))

R<-intersect(geneinfo[geneinfo$regulator==1,1],names(igraph::V(graph)))
P<-intersect(geneinfo[geneinfo$regulator==0,1],names(igraph::V(graph)))

drivers_n <- rownames(drivers[R,])
targets_n <- rownames(targets[P,])

# As for this example we are working at gene level (we do not have transcripts inside genes),
# we wont need namehash parameter (see param `namehash`)

normal_layout <- return_layout(drivers_n,targets_n)

# We need to separate our expression matrix by a binary phenotype.
# This is what the clinical file is used for.

gnames <- c(drivers_n,targets_n)
expmat <-rbind(drivers,targets)

clinic <- utils::read.delim(paste0(system.file("extdata",package="TraRe"),
                            '/phenotype_rewiring_example.txt'))

expmat_R <- expmat[,clinic$Sample.ID[clinic$Class=='R']]
expmat_NR <- expmat[,clinic$Sample.ID[clinic$Class=='NR']]

# We now generate the phenotype layout and the `varfile` we need for this layout.
# (I leave here a way to generate)

varfile <- t(as.matrix(sapply(gnames,
           function(x) c(stats::t.test(expmat_R[x,],expmat_NR[x,])$statistic,
           if(x%in%drivers_n) 1 else 0))))

colnames(varfile)<-c("t-stat","is-regulator")

phenotype_layout <- return_layout_phenotype(drivers_n,targets_n,varfile)

plot_igraph(graph,mytitle="Normal Layout",titlecol="black",mylayout=normal_layout)
```

![](data:image/png;base64...)

```
plot_igraph(graph,mytitle="Phenotype Layout",titlecol="black",mylayout=phenotype_layout)
```

![](data:image/png;base64...)

For further information, please refer to the help file of `plot_functions()`.
Note that this method is included in the *Rewiring* test; the generation
of the graph objects depending on the phenotype is automated. Here we include
the figures generated from the *Rewiring* step. This figures will be located in the
folder generated by `runrewiring()`.

![Rewiring Hierarchical Clustering](data:image/png;base64...)

Rewiring Hierarchical Clustering

# 6 Cliques method and results

## 6.1 Overview

* *Cliques:* From the chosen individual GRN, an excel file is generated containing drivers-targets relationships and cliques. The way *LINKER* works may lead TFs to be dropped out during the fitting process in the presence of highly correlated TFs whose roles in the GRN are very similar. Due to this, we propose a method based on cliques (Fully Connected Networks) to recover these dropped driver genes.

From all previous analyses, we provide an informative way of looking at the generated GRN, the relationships they have within the network, easing a possible biological validation in *silico* analysis afterward.

# 7 Generate file in TraRe

The `html_from_graph()` function takes as input two paths and a boolean variable,
specifying if desirable to include cliques in the summary of the generated excel. If so,
arguments from `generatecliques()` are required, but only the drivers expression matrix is
mandatory, the rest of them have default values.

* **gpath**: path to the graph object (‘refinedsumm.rds’). (RDS format required)
* **wpath**: writing path, where the excel file will be saved. (Default: temp directory)
* **user\_mode**: boolean indicating if this function is called from user or internaly. (Default: TRUE)
* **cliquesbool**: indicating if cliques method should be added to the summary table. (Default: TRUE)
* **…**: every argument you should pass to generatecliques() in case cliquesbool is TRUE.

```
## For this example, we are going to use a generated 'refinedsumm.rds' from the su2c dataset
## (see vignette of TraRe for more information), which is at the external data folder
## of this package.

gpath <- paste0(system.file("extdata",package="TraRe"),
                       '/refinedsumm.rds')

## We are going to use 1k driver genes from the TraRe's installation folder.
## For more information about generatecliques() please check the corresponding help page.

dataset<- readRDS(paste0(system.file("extdata",package="TraRe"),
                       '/tfs_linker_example_eg.rds'))

# As we have mentioned, by default it will write a 'grnsumm.xlsx' file to the temporary directory.

html_from_graph(gpath=gpath,dataset=dataset)
## Preparing data
## Generating graph
## Generating groups of highly correlated genes and singleton communities
## Creating the matrix
## Selecting method
## Generate Datasets
```

We here include a brief example in order to finish the analysis for the SU2C prostate cancer
dataset. After generating the plots where a possible deregulation from one phenotype to other
may be appreciated, we can extract more specific driver to target information.

![Html Generation](data:image/png;base64...)

Html Generation