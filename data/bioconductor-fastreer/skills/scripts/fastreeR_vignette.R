# Code example from 'fastreeR_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    warning = FALSE,
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("fastreeR")

## ----eval=TRUE, message=FALSE-------------------------------------------------
options(java.parameters="-Xmx1G")
unloadNamespace("fastreeR")
library(fastreeR)
library(utils)
library(ape)
library(stats)
library(grid)
library(BiocFileCache)
library(ggtree)

## ----eval=TRUE----------------------------------------------------------------
bfc <- BiocFileCache::BiocFileCache(ask = FALSE)
tempVcfUrl <-
    paste0("https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/",
        "1000_genomes_project/release/20190312_biallelic_SNV_and_INDEL/",
        "supporting/related_samples/",
        "ALL.chrX.shapeit2_integrated_snvindels_v2a_related_samples_27022019.",
        "GRCh38.phased.vcf.gz")
tempVcf <- BiocFileCache::bfcquery(bfc,field = "rname", "tempVcf")$rpath[1]
if(is.na(tempVcf) || is.null(tempVcf)) {
    tryCatch(
    { tempVcf <- BiocFileCache::bfcadd(bfc,"tempVcf",fpath=tempVcfUrl)[[1]]
    },
    error=function(cond) {
        tempVcf <- system.file("extdata", "samples.vcf.gz", package="fastreeR")
    },
    warning=function(cond) {
        tempVcf <- system.file("extdata", "samples.vcf.gz", package="fastreeR")
    }
    )
}
if(!file.exists(tempVcf) ||  file.size(tempVcf) == 0L) {
    tempVcf <- system.file("extdata", "samples.vcf.gz", package="fastreeR")
}

## ----eval=TRUE----------------------------------------------------------------
tempFastasUrls <- c(
    #Mycobacterium liflandii
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Mycobacterium_liflandii/latest_assembly_versions/",
        "GCF_000026445.2_ASM2644v2/GCF_000026445.2_ASM2644v2_genomic.fna.gz"),
    #Pelobacter propionicus
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Pelobacter_propionicus/latest_assembly_versions/",
        "GCF_000015045.1_ASM1504v1/GCF_000015045.1_ASM1504v1_genomic.fna.gz"),
    #Rickettsia prowazekii
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Rickettsia_prowazekii/latest_assembly_versions/",
        "GCF_000022785.1_ASM2278v1/GCF_000022785.1_ASM2278v1_genomic.fna.gz"),
    #Salmonella enterica
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Salmonella_enterica/reference/",
        "GCF_000006945.2_ASM694v2/GCF_000006945.2_ASM694v2_genomic.fna.gz"),
    #Staphylococcus aureus
    paste0("https://ftp.ncbi.nih.gov/genomes/refseq/bacteria/",
        "Staphylococcus_aureus/reference/",
        "GCF_000013425.1_ASM1342v1/GCF_000013425.1_ASM1342v1_genomic.fna.gz")
)
tempFastas <- list()
for (i in seq(1,5)) {
    tempFastas[[i]] <- BiocFileCache::bfcquery(bfc,field = "rname", 
                                                paste0("temp_fasta",i))$rpath[1]
    if(is.na(tempFastas[[i]])) {
        tryCatch(
        { tempFastas[[i]] <- 
            BiocFileCache::bfcadd(bfc, paste0("temp_fasta",i), 
                                                fpath=tempFastasUrls[i])[[1]]
        },
        error=function(cond) {
            tempFastas <- system.file("extdata", "samples.fasta.gz", 
                                                        package="fastreeR")
            break
        },
        warning=function(cond) {
            tempFastas <- system.file("extdata", "samples.fasta.gz", 
                                                        package="fastreeR")
            break
        }
        )
    }
    if(!file.exists(tempFastas[[i]])) {
        tempFastas <- system.file("extdata", "samples.fasta.gz", 
                                                        package="fastreeR")
        break
    }
    if(file.size(tempFastas[[i]]) == 0L) {
        tempFastas <- system.file("extdata", "samples.fasta.gz", 
                                                        package="fastreeR")
        break
    }
}

## ----echo=TRUE, fig.cap="Sample statistics from vcf file", fig.wide=TRUE------
myVcfIstats <- fastreeR::vcf2istats(inputFile = tempVcf)
plot(myVcfIstats[,7:9])

## ----eval=TRUE----------------------------------------------------------------
myVcfDist <- fastreeR::vcf2dist(inputFile = tempVcf, threads = 1)

## ----echo=TRUE, fig.cap="Histogram of distances from vcf file", fig.wide=TRUE----
graphics::hist(myVcfDist, breaks = 100, main=NULL, 
                                xlab = "Distance", xlim = c(0,max(myVcfDist)))

## ----echo=TRUE, fig.cap="Tree from vcf with fastreeR", fig.wide=TRUE----------
myVcfTree <- fastreeR::dist2tree(inputDist = myVcfDist)
plot(ape::read.tree(text = myVcfTree), direction = "down", cex = 0.3)
ape::add.scale.bar()
ape::axisPhylo(side = 2)

## ----echo=TRUE, fig.cap="Tree from vcf with fastreeR", fig.wide=TRUE----------
myVcfTree <- fastreeR::vcf2tree(inputFile = tempVcf, threads = 1)
plot(ape::read.tree(text = myVcfTree), direction = "down", cex = 0.3)
ape::add.scale.bar()
ape::axisPhylo(side = 2)

## ----eval=TRUE, fig.cap="Tree from vcf with fastreeR and bootstrap support (ape)", fig.wide=TRUE----
# Calculate a tree with a small number of bootstrap replicates (adjust as needed)
bt_reps <- 10
myBootTree <- fastreeR::vcf2tree(inputFile = tempVcf, threads = 1, bootstrap = bt_reps)

# Parse with ape and inspect bootstrap support (stored in node.label)
tr <- ape::read.tree(text = myBootTree)
# robust parse: remove anything but digits and dot, then as.numeric
raw_lbls <- tr$node.label
node_support <- if (!is.null(raw_lbls)) {
  # turn "", NA or non-numeric into NA
  s <- gsub("[^0-9.]", "", raw_lbls)
  s[s == ""] <- NA
  as.numeric(s)
} else {
  numeric(0)
}
print(head(tr$node.label))
plot(tr, direction = "down", cex = 0.3)
if (length(node_support) > 0) {
  # round and show as integers, place without frames
  ape::nodelabels(text = round(node_support, 0),
                  cex = 0.7,
                  frame = "none",
                  adj = c(-0.2, 0.5))      # adjust to move labels slightly off-node

  # optional: color labels by support
  cols <- ifelse(node_support >= 90, "black",
                 ifelse(node_support >= 70, "orange", "red"))
  ape::nodelabels(text = round(node_support, 0), cex = 0.7, frame = "none", col = cols)
  
  # colour the branch behind each internal node
  bgcols <- ifelse(node_support >= 90, "lightgreen",
                   ifelse(node_support >= 70, "khaki", "lightpink"))
  ape::nodelabels(text = round(node_support, 0), cex = 0.7, frame = "circle", bg = bgcols, col = "black")
}

## ----eval=TRUE, fig.cap="Tree from vcf with fastreeR and bootstrap support (ggtree)", fig.wide=TRUE----
  # internal node numbers are Ntip+1 : Ntip+Nnode
  ntips <- ape::Ntip(tr)
  nints <- ape::Nnode(tr)
  internal_nodes <- (ntips + 1):(ntips + nints)

  df_nodes <- data.frame(node = internal_nodes, support = node_support)

  # Create categorical support classes for coloring and define colors
  df_nodes$category <- cut(df_nodes$support,
                           breaks = c(-Inf, 69, 89, Inf),
                           labels = c("weak", "moderate", "strong"))

  fills <- c(strong = "lightgreen", moderate = "khaki", weak = "lightpink")
  cols <- c(strong = "black", moderate = "orange", weak = "red")

  p <- ggtree(tr) + geom_tiplab(size = 2)

  # Attach node support data to the tree plotting data and add colored points + labels
  p <- p %<+% df_nodes +
      ggtree::geom_point2(aes(subset = !isTip, fill = category), shape = 21,
                          color = "black", size = 3, show.legend = FALSE) +
      ggtree::geom_text2(aes(subset = !isTip, label = round(support, 0)),
                          hjust = -0.2, size = 2, show.legend = FALSE) +
      scale_fill_manual(values = fills)

  print(p)

## ----eval=FALSE---------------------------------------------------------------
# # set JVM max heap to 2GB before loading fastreeR
# options(java.parameters = '-Xmx2G')
# library(fastreeR)

## ----echo=TRUE, fig.cap="Tree from vcf with stats::hclust", fig.wide=TRUE-----
myVcfTreeStats <- stats::hclust(myVcfDist)
plot(myVcfTreeStats, ann = FALSE, cex = 0.3)

## ----eval=TRUE----------------------------------------------------------------
myVcfClust <- fastreeR::dist2clusters(inputDist = myVcfDist, cutHeight = 0.067)
if (length(myVcfClust) > 1) {
    tree <- myVcfClust[[1]]
    clusters <- myVcfClust[[2]]
    tree
    clusters
}

## ----eval=TRUE----------------------------------------------------------------
myFastaDist <- fastreeR::fasta2dist(tempFastas, kmer = 6)

## ----eval=FALSE---------------------------------------------------------------
# myFastaDist <- fastreeR::fasta2dist(
#     system.file("extdata", "samples.fasta.gz", package="fastreeR"), kmer = 6)

## ----echo=TRUE, fig.cap="Histogram of distances from fasta file",fig.wide=TRUE----
graphics::hist(myFastaDist, breaks = 100, main=NULL, 
                                xlab="Distance", xlim = c(0,max(myFastaDist)))

## ----echo=TRUE, fig.cap="Tree from fasta with fastreeR", fig.wide=TRUE--------
myFastaTree <- fastreeR::dist2tree(inputDist = myFastaDist)
plot(ape::read.tree(text = myFastaTree), direction = "down", cex = 0.3)
ape::add.scale.bar()
ape::axisPhylo(side = 2)

## ----echo=TRUE, fig.cap="Tree from fasta with stats::hclust", fig.wide=TRUE----
myFastaTreeStats <- stats::hclust(myFastaDist)
plot(myFastaTreeStats, ann = FALSE, cex = 0.3)

## ----setup--------------------------------------------------------------------
utils::sessionInfo()

