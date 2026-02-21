# Code example from 'TraRe' vignette. See references/ for full tutorial.

## ----LoadFunctions, echo=FALSE, message=FALSE, warning=FALSE, results='hide'----
library(knitr)
opts_chunk$set(error = FALSE)
library(TraRe)

## ----style, echo = FALSE, results = 'asis'------------------------------------
##BiocStyle::markdown()

## ---- eval=FALSE--------------------------------------------------------------
#  
#   if (!requireNamespace("BiocManager"))
#   install.packages("BiocManager")
#   BiocManager::install("TraRe")
#  

## ---- eval=TRUE, warning=FALSE, collapse=TRUE---------------------------------

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


## ----eval=TRUE,warning=FALSE,collapse=TRUE------------------------------------

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



## ---- eval=TRUE, warning=FALSE, collapse=TRUE---------------------------------


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

# NOTE: The reason why we are working with paths instead of files is that
# rewiring is allowed to compare more than 1 dataset, so it is easier 
# to provide a vector of paths than a complex structure of files.

# This is, we can provide , for instance, a vector of 2 SummarizedExperiments
# that will be compared. SEObject_p <- c(SEObject1,SEObject2)..
#                        linker_output_p <- c(linker_output_p_1,linker_output_p_2) 



## ----eval=TRUE,warning=FALSE,collapse=TRUE------------------------------------

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
plot_igraph(graph,mytitle="Phenotype Layout",titlecol="black",mylayout=phenotype_layout)
    


## ----eval=TRUE,warning=FALSE,collapse=TRUE------------------------------------

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


