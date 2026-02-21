# rTRM: an R package for the identification of transcription regulatory modules (TRMs)

Diego Diez1\*

1Immunology Frontier Research Center, Osaka University

\*diego10ruiz@gmail.com

#### 30 October 2025

#### Package

rTRM 1.48.0

# Contents

* [1 Introduction](#introduction)
* [2 Minimal example](#minimal-example)
* [3 Introduction to the rTRM package](#introduction-to-the-rtrm-package)
  + [3.1 Database](#database)
  + [3.2 Interactome data](#interactome-data)
  + [3.3 Using PSICQUIC package to obtain protein-protein interactions](#using-psicquic-package-to-obtain-protein-protein-interactions)
* [4 Case study: TRM associated with Sox2 in embryonic stem cells (ESCs)](#case-study-trm-associated-with-sox2-in-embryonic-stem-cells-escs)
* [5 A complete workflow in R](#a-complete-workflow-in-r)
* [6 Ploting parameters](#ploting-parameters)
* [7 Citation](#citation)
* [8 Session Information](#session-information)
* [References](#references)

# 1 Introduction

Transcription factors (TFs) bind to short motifs in the DNA and regulate the expression of target genes in a cell type and time dependent fashion. TFs do so by cooperating with other TFs in what it is called Transcriptional Regulatory Modules (TRMs). These TRMs contain different TFs and form a combinatorial code that explains TF specificity. We have implemented a method for the identification of TRMs that integrates information about binding locations from a single ChIP-seq experiment, computational estimation of TF binding, gene expression and protein-protein interaction (PPI) data (Diez, Hutchins, and Miranda-Saavedra [2014](#ref-diez2014)); see workflow figure). rTRM implements the methods required for the integration of PPI information (step 4 in workflow). To do so, rTRM tries to identify TFs that are bound to a target TF (the one with experimental evidence- i.e. ChIP-seq data) either directly or through a bridge protein. This package has been used to identify cell-type independent and dependent TRMs associated with Stat3 functions (Hutchins et al. [2013](#ref-hutchins2013)). Also, it has been used to identify TRMs in embryonic and hematopoietic stem cells as part of the publication presenting the methodology (Diez, Hutchins, and Miranda-Saavedra [2014](#ref-diez2014)). Here we present the basic capabilities of rTRM with a naive example, a case study showing the identification of Sox2 related TRM in ESCs as performed in the paper describing rTRM (Diez, Hutchins, and Miranda-Saavedra [2014](#ref-diez2014)), and a complete workflow in R using the *[PWMEnrich](https://bioconductor.org/packages/3.22/PWMEnrich)* package for the motif enrichment step.

Figure 1: Workflow for the identification of TRMs
Steps 1-3 can be performed with standard Bioconductor approaches. rTRM implements a method to perform step 4.

# 2 Minimal example

In this minimal example a dummy network is search to identify TRMs focused around a target node, *N6*, with query nodes being *N7*, *N12* and *N28*. By default *findTRM* find nodes separated a max distance of 0 (i.e. nodes directly connected). We change this with parameter `max.bridge = 1`. Because node *N28* is separated by two other nodes from the target node *N6*, it is not included in the predicted TRM. By default `findTRM` returns an object of class igraph, which can be used with `plotTRM`, `plotTRMlegend` and other rTRM functions. However, it is possible to directly obtain a *graphNEL* object (from the *Bioconductor* package *[graph](https://bioconductor.org/packages/3.22/graph)*), setting `type = graphNEL`. Of course it is possible to also use the `igraph.to.graphNEL` function in the *[igraph](https://bioconductor.org/packages/3.22/igraph)* package to transform an *igraph* object into a *graphNEL* object.

```
# load the rTRM package
library(rTRM)

# load network example.
load(system.file(package = "rTRM", "extra/example.rda"))

# plot network
plot(g, vertex.size = 20, vertex.label.cex = .8, layout = layout.graphopt)
```

```
## This graph was created by an old(er) igraph version.
## ℹ Call `igraph::upgrade_graph()` on it to use with the current igraph version.
## For now we convert it on the fly...
```

![Identification of a TRM 1from a test network (left). In the resulting TRM (right) dark blue indicates the target node light blue are query nodes and white nodes are bridge nodes](data:image/png;base64...)

Figure 2: Identification of a TRM 1from a test network (left)
In the resulting TRM (right) dark blue indicates the target node light blue are query nodes and white nodes are bridge nodes

```
# define target and query nodes:
target <- "N6"
query <- c("N7", "N12", "N28")

# find TRM:
s <- findTRM(g, target = target, query = query, method = "nsa", max.bridge = 1)
```

```
## removing: 4 nodes out of 8 [keeping 4 nodes]
```

```
# annotate nodes:
V(s)$color <- "white"
V(s)[ name %in% query]$color <- "steelblue2"
V(s)[ name %in% target]$color <- "steelblue4"

# plot:
plot(s,vertex.size=20,vertex.label.cex=.8)
```

![Identification of a TRM 1from a test network (left). In the resulting TRM (right) dark blue indicates the target node light blue are query nodes and white nodes are bridge nodes](data:image/png;base64...)

Figure 3: Identification of a TRM 1from a test network (left)
In the resulting TRM (right) dark blue indicates the target node light blue are query nodes and white nodes are bridge nodes

# 3 Introduction to the rTRM package

rTRM relies on a series of optimizations. For example in the publication we used PWMs for vertebrate species compiled from different sources. This assumes the binding specificities of TFs will be conserved on all these species. Recent comparison between mouse and human PWMs suggests that this is the case for most TFs Jolma et al. ([2013](#ref-jolma2013)). rTRM also relies on protein-protein interaction data, and so provides utilities to download data from the BioGRID database (see below). As some of these functionalities are further integrated with existing *Bioconductor* functionality they may be defunct in the future.

## 3.1 Database

Information about TFs, including Position Specific Weight (PWMs) matrices, mapping to Entrez Gene identifiers, orthologs in mouse and human and other annotations are stored as a SQLite database. rTRM provides a basic API for accessing the data. Below there are some examples.

To obtain PWMs:

```
pwm <- getMatrices()
head(pwm, 1)
```

```
## $MA0009.1
##      1     2 3 4 5 6 7    8     9 10    11
## A 0.05 0.025 1 0 0 0 0 0.00 0.025  1 0.775
## C 0.70 0.025 0 0 0 0 0 0.05 0.175  0 0.125
## G 0.20 0.000 0 1 1 0 1 0.00 0.700  0 0.000
## T 0.05 0.950 0 0 0 1 0 0.95 0.100  0 0.100
```

To get annotations:

```
ann <- getAnnotations()
head(ann)
```

```
##   row_names   pwm_id   symbol                    family domain binding source
## 1         1 MA0009.1        T                         T        monomer jaspar
## 2         2 MA0059.1 MYC::MAX          Helix-Loop-Helix          dimer jaspar
## 3         3 MA0146.1      Zfx BetaBetaAlpha-zinc finger        monomer jaspar
## 4         4 MA0132.1     Pdx1                     Homeo        monomer jaspar
## 5         5 MA0162.1     Egr1 BetaBetaAlpha-zinc finger        monomer jaspar
## 6         6 MA0093.1     USF1          Helix-Loop-Helix        monomer jaspar
##   note
## 1 2010
## 2 2010
## 3 2010
## 4 2010
## 5 2010
## 6 2010
```

To get map of TFs to genes:

```
map <- getMaps()
head(map)
```

```
##   row_names   pwm_id entrezgene organism
## 1         1 MA0009.1      20997    mouse
## 2         2 MA0059.1       4609    human
## 3         3 MA0059.1       4149    human
## 4         4 MA0146.1      22764    mouse
## 5         5 MA0132.1      18609    mouse
## 6         6 MA0162.1      13653    mouse
```

To get map of TFs to ortholog genes:

```
o <- getOrthologs(organism = "mouse")
head(o)
```

```
##   row_names entrezgene organism map_entrezgene map_organism
## 1       775      20997    mouse          20997        mouse
## 2       776       4609    human         107771        mouse
## 3       777       4149    human          17187        mouse
## 4       778      22764    mouse          22764        mouse
## 5       779      18609    mouse          18609        mouse
## 6       780      13653    mouse          13653        mouse
```

It is possible to map motif ids to entrezgene ids in the target organism (only between human and mouse). This is useful when all the information about existing PWMs is desired, as some TF binding affinities have only been studied in one organism.

```
getOrthologFromMatrix("MA0009.1", organism="human")
```

```
## [1] "6862"
```

```
getOrthologFromMatrix("MA0009.1", organism="mouse")
```

```
## [1] "20997"
```

## 3.2 Interactome data

rTRM requires information about protein-protein interactions (PPIs) for its predictions and includes interactome (PPI network) data from the BioGRID database (**???**). Currently mouse and human interactomes are supported. The networks are provided as an *igraph* object. To access the data use:

```
# check statistics about the network.
biogrid_mm()
```

```
## Mouse PPI network data of class igraph
```

```
## This graph was created by an old(er) igraph version.
## ℹ Call `igraph::upgrade_graph()` on it to use with the current igraph version.
## For now we convert it on the fly...
## Number of nodes: 5315
##
## Number of edges: 11695
##
## Source: The BioGRID (http://www.thebiogrid.org)
##
## Release: 3.4.128
##
## Downloaded: 2015-09-17
##
## Use data(biogrid_mm) to load it
```

```
# load mouse PPI network:
data(biogrid_mm)
```

The amount of available PPI data increases rapidly so it is desirable to have a way to access the newest data conveniently. rTRM includes support for direct download and processing of PPI data from the BioGRID database. The PPI network is stored as an *igraph* object that can be readily used with rTRM or stored for later use. Below there is an example of the BioGRID database update procedure.

```
# obtain dataset.
db <- getBiogridData() # retrieves latest release.
# db = getBiogridData("3.2.96") # to get a specific release.

# check release:
db$release
db$data

# process PPI data for different organisms (currently supported human and mouse):
biogrid_hs <- processBiogrid(db, org = "human")
biogrid_mm <- processBiogrid(db, org = "mouse")
```

PPI data from other databases could be used as long as it is formatted as an *igraph* object with the *name* attribute containing entrezgene identifiers and the *label* attribute containing the symbol.

## 3.3 Using PSICQUIC package to obtain protein-protein interactions

One possibility available from *Bioconductor* is to use the package *[PSICQUIC](https://bioconductor.org/packages/3.22/PSICQUIC)* to obtain PPI data. *[PSICQUIC](https://bioconductor.org/packages/3.22/PSICQUIC)* provides access to different databases of PPIs, including BioGRID and STRINGS, and databases of cellular networks like KEGG or Reactome. For example, to obtain the human BioGRID data (NOTE: named BioGrid in PSICQUIC):

```
library(PSICQUIC)
psicquic <- PSICQUIC()
providers(psicquic)

# obtain BioGrid human PPIs (as data.frame):
tbl <- interactions(psicquic, species="9606",provider="BioGrid")

# the target and source node information needs to be polished (i.e. must be Entrez gene id only)
biogrid_hs <- data.frame(source=tbl$A,target=tbl$B)
biogrid_hs$source <- sub(".*locuslink:(.*)\\|BIOGRID:.*","\\1", biogrid_hs$source)
biogrid_hs$target <- sub(".*locuslink:(.*)\\|BIOGRID:.*","\\1", biogrid_hs$target)

# create graph.
library(igraph)
biogrid_hs <- graph.data.frame(biogrid_hs,directed=FALSE)
biogrid_hs <- simplify(biogrid_hs)

# annotate with symbols.
library(org.Hs.eg.db)
V(biogrid_hs)$label <- select(org.Hs.eg.db,keys=V(biogrid_hs)$name,columns=c("SYMBOL"))$SYMBOL
```

# 4 Case study: TRM associated with Sox2 in embryonic stem cells (ESCs)

Sox2 is a TF involved in the determination and maintainance of pluripotency in embryonic stem cells (ESCs). Sox2 forms a transcriptional regulatory module with Nanog and Pou5f1 (Oct4), and together determine ESCs phenotype. Other TFs important to this process are Erssb and Klf4. In this case study we want to identify TRMs associated with Sox2. ChIP-seq data for Sox2 was obtained from Chen et al. ([2008](#ref-chen2008)) and motif enrichment analysis performed with HOMER Heinz et al. ([2010](#ref-heinz2010)), followed by matching against our library of PWMs using TOMTOM Gupta et al. ([2007](#ref-gupta2007)). The starting dataset is the TOMTOM output file with the motifs enriched in the Sox2 binding regions.

```
# read motif enrichment results.
motif_file <- system.file("extra/sox2_motif_list.rda", package = "rTRM")
load(motif_file)
length(motif_list)
```

```
## [1] 177
```

```
head(motif_list)
```

```
## [1] "MA0039.2" "MA0071.1" "MA0075.1" "MA0077.1" "MA0078.1" "MA0112.2"
```

First, we read the motifs and convert them into gene identifiers (i.e. Entrez Gene identifier). To do this we use the function `getOrthologFromMatrix`, which takes a list of motif identifiers and the target organism as parameters. The function returns a list with the Entrez Gene ids.

```
# get the corresponding gene.
tfs_list <- getOrthologFromMatrix(motif_list, organism = "mouse")
tfs_list <- unique(unlist(tfs_list, use.names = FALSE))
length(tfs_list)
```

```
## [1] 98
```

```
head(tfs_list)
```

```
## [1] "18609" "20682" "13983" "20665" "18291" "18227"
```

Next, we need a list of genes expressed in ESC. For this, the dataset was obtained from GEO (GSE27708; Ho et al. ([2011](#ref-ho2011))) and processed using the custom CDFs from the BrainArray project Dai et al. ([2005](#ref-dai2005)) and the `rma` function from the package *[affy](https://bioconductor.org/packages/3.22/affy)* Gautier et al. ([2004](#ref-gautier2004)). Genes not expressed were filtered by removing all genes with log2 expression < 5 in all samples.

```
# load expression data.
eg_esc_file <- system.file("extra/ESC-expressed.txt", package = "rTRM")
eg_esc <- scan(eg_esc_file, what = "")
length(eg_esc)
```

```
## [1] 8734
```

```
head(eg_esc)
```

```
## [1] "100008567" "100017"    "100019"    "100037258" "100038489" "100039781"
```

```
tfs_list_esc <- tfs_list[tfs_list %in% eg_esc]
length(tfs_list_esc)
```

```
## [1] 22
```

```
head(tfs_list_esc)
```

```
## [1] "26380" "18999" "20674" "16600" "26379" "13984"
```

Next, we load the PPI network and filter out potential degree outliers and proteins not expressed in the paired expression data.

```
# load and process PPI data.
biogrid_mm()
```

```
## Mouse PPI network data of class igraph
```

```
## This graph was created by an old(er) igraph version.
## ℹ Call `igraph::upgrade_graph()` on it to use with the current igraph version.
## For now we convert it on the fly...
## Number of nodes: 5315
##
## Number of edges: 11695
##
## Source: The BioGRID (http://www.thebiogrid.org)
##
## Release: 3.4.128
##
## Downloaded: 2015-09-17
##
## Use data(biogrid_mm) to load it
```

```
data(biogrid_mm)
ppi <- biogrid_mm
vcount(ppi)
```

```
## This graph was created by an old(er) igraph version.
## ℹ Call `igraph::upgrade_graph()` on it to use with the current igraph version.
## For now we convert it on the fly...
```

```
## [1] 5315
```

```
ecount(ppi)
```

```
## [1] 11695
```

```
# remove outliers.
f <- c("Ubc", "Sumo1", "Sumo2", "Sumo3")
f <- select(org.Mm.eg.db, keys = f, columns = "ENTREZID", keytype = "SYMBOL")$ENTREZID
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
f
```

```
## [1] "22190"  "22218"  "170930" "20610"
```

```
ppi <- removeVertices(ppi, f)
vcount(ppi)
```

```
## [1] 4984
```

```
ecount(ppi)
```

```
## [1] 11081
```

```
# filter by expression.
ppi_esc <- induced.subgraph(ppi, V(ppi)[ name %in% eg_esc ])
```

```
## Warning: `induced.subgraph()` was deprecated in igraph 2.0.0.
## ℹ Please use `induced_subgraph()` instead.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
vcount(ppi_esc)
```

```
## [1] 3109
```

```
ecount(ppi_esc)
```

```
## [1] 4889
```

```
# ensure a single component.
ppi_esc <- getLargestComp(ppi_esc)
vcount(ppi_esc)
```

```
## [1] 2576
```

```
ecount(ppi_esc)
```

```
## [1] 4851
```

To identify TRMs we define a target TF (the one the ChIP-seq data comes from) and some query TFs (the ones with enriched binding sites in the neighborhood of the target TF).

```
# define target.
target <- select(org.Mm.eg.db,keys="Sox2",columns="ENTREZID",keytype="SYMBOL")$ENTREZID
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
target
```

```
## [1] "20674"
```

```
# find TRM.
s <- findTRM(ppi_esc, target, tfs_list_esc, method = "nsa", max.bridge = 1)
```

```
## 11 query nodes NOT FOUND in network-- removed
```

```
## removing: 320 nodes out of 328 [keeping 8 nodes]
```

```
vcount(s)
```

```
## [1] 8
```

```
ecount(s)
```

```
## [1] 15
```

Finally, we layout the network using a customized concentric layout and plot the network and the legend.

```
# generate layout (order by cluster, then label)
cl <- getConcentricList(s, target, tfs_list_esc)
l <- layout.concentric(s, cl, order = "label")

# plot TRM.
plotTRM(s, layout = l, vertex.cex = 15, label.cex = .8)
```

![Sox2 specific TRM in ESCs.](data:image/png;base64...)

Figure 4: Sox2 specific TRM in ESCs

```
plotTRMlegend(s, title = "ESC Sox2 TRM", cex = .8)
```

![Sox2 specific TRM in ESCs.](data:image/png;base64...)

Figure 5: Sox2 specific TRM in ESCs

# 5 A complete workflow in R

In this section we will identify Sox2 TRMs using a workflow performed completely in R. For this the MotifDb package will be used to obtain the information about PWMs, and PWMEnrich package for identifying enriched motifs. PWMEnrich requires the computation of background models and the enrichment analysis *per se*, which are computational intensive. Therefore these steps were not run during the compilation of this vignette.

The first step is to retrieve a set of PWMs. Here we will use the *[MotifDb](https://bioconductor.org/packages/3.22/MotifDb)* package available in *Bioconductor*. We will use only mouse PWMs (i.e. PWMs for the target organism). It could be possible to use matrices from other species but then the user has to obtain the orthologs in the target organism (e.g. using `getOrthologsFromBiomart` in rTRM or using the *[Biomart](https://bioconductor.org/packages/3.22/Biomart)* package directly).

```
library(rTRM)
library(BSgenome.Mmusculus.UCSC.mm8.masked) # Sox2 peaks found against mm8
```

```
## Loading required package: BSgenome
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: Biostrings
```

```
## Loading required package: XVector
```

```
##
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
##
##     strsplit
```

```
## Loading required package: BiocIO
```

```
## Loading required package: rtracklayer
```

```
##
## Attaching package: 'rtracklayer'
```

```
## The following object is masked from 'package:igraph':
##
##     blocks
```

```
## Loading required package: BSgenome.Mmusculus.UCSC.mm8
```

```
library(PWMEnrich)
registerCoresPWMEnrich(1) # register number of cores for parallelization in PWMEnrich
library(MotifDb)
```

```
## See system.file("LICENSE", package="MotifDb") for use restrictions.
```

```
# select mouse PWMs:
sel.mm <- values(MotifDb)$organism %in% c("Mmusculus")
pwm.mm <- MotifDb[sel.mm]
```

The matrices need to be passed as counts, that is the PFM need to be converted to counts. The easiest way is to multiply by 100 and round the results. We also need to convert it to integer.

```
# generate logn background model of PWMs:
p <- as.list(pwm.mm)
p <- lapply(p, function(x) round(x * 100))
p <- lapply(p, function(x) t(apply(x, 1, as.integer)))
```

With the PFMs we compute the background model using the makeBackground() function from the PWMEnrich package, which returns the corresponding PWMs. This requires a list with the PFMs as counts, the organisms to obtain the sequences to compute the background and the type of background model (here “logn” model is used).

```
pwm_logn <- makeBackground(p, Mmusculus, type = "logn")
```

Next we read the peak information from the Sox2 Chip-seq data. This is the original coordinates obtained from Chen et al. ([2008](#ref-chen2008)), which were obtained for Mus musculus (mm8) genome. The function getSequencesFromGenome() is an utility wrapper to getSeq() that facilitates appending a label to the sequences’ ids. PWMEnrich requires sequences the same size or longer to the motifs so we check what is the largest motif and filter the sequences accordingly.

```
sox2_bed <- read.table(system.file("extra/ESC_Sox2_peaks.txt", package = "rTRM"))

colnames(sox2_bed) <- c("chr", "start", "end")

sox2_seq <- getSequencesFromGenome(sox2_bed, Mmusculus, append.id="Sox2")

# PWMEnrich throws an error if the sequences are shorter than the motifs so we filter those sequences.
min.width <- max(sapply(p, ncol))
sox2_seq_filter <- sox2_seq[width(sox2_seq) >= min.width]
```

Next, enrichment is computed with the sequences and the PWMs with the background model as parameters.

```
# find enrichment:
sox2_enr <- motifEnrichment(sox2_seq_filter, pwms=pwm_logn, group.only=TRUE)
```

Next, retrieve the enriched motifs by choosing an appropriate cutoff. Here a raw.score of > 5 is used. Then, using the annotations in the MotifDb dataset, we can obtain the Entrezgene ids associated with the enriched TF motifs.

```
res <- groupReport(sox2_enr)

plot(density(res$raw.score),main="",log="x",xlab="log(raw.score)")
```

```
## Warning in xy.coords(x, y, xlabel, ylabel, log): 2 x values <= 0 omitted from
## logarithmic plot
```

```
abline(v=log2(5),col="red")
mtext(text="log2(5)",at=log2(5),side=3,cex=.8,col="red")
```

![Density of log2(raw.score) for group. The selected cutoff is indicated with a red line.](data:image/png;base64...)

Figure 6: Density of log2(raw.score) for group
The selected cutoff is indicated with a red line.

```
res.gene <- unique(values(MotifDb[res$id[res$raw.score > 5]])$geneId)
res.gene <- unique(na.omit(res.gene))
```

Then proceed with the same steps as in the Use Case example shown in the previous section. The resulting TRM is similar (~85% of edges shared) to the one in the Use Case, which used HOMER for motif enrichment. Differences may be to different approaches to determine the background. HOMER uses random sets of sequences with similar composition to the ChIP-seq peaks provided to generate the background. For PWMEnrich we generated a background using promoter sequences, defined as 2000 bp upstream of the transcription start site (TSS) of all genes in the genome. Generally, using different strategies for enrichment will tend to produce slightly different TRMs.

```
data(biogrid_mm)
ppi <- biogrid_mm
vcount(ppi)
```

```
## This graph was created by an old(er) igraph version.
## ℹ Call `igraph::upgrade_graph()` on it to use with the current igraph version.
## For now we convert it on the fly...
```

```
## [1] 5315
```

```
ecount(ppi)
```

```
## [1] 11695
```

```
f <- c("Ubc", "Sumo1", "Sumo2", "Sumo3")
f <- select(org.Mm.eg.db,keys=f,columns="ENTREZID",keytype="SYMBOL")$ENTREZID
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
ppi <- removeVertices(ppi, f)
vcount(ppi)
```

```
## [1] 4984
```

```
ecount(ppi)
```

```
## [1] 11081
```

```
# filter by expression.
eg_esc <- scan(system.file("extra/ESC-expressed.txt", package = "rTRM"), what = "")
ppi_esc <- induced.subgraph(ppi, V(ppi)[ name %in% eg_esc ])
vcount(ppi_esc)
```

```
## [1] 3109
```

```
ecount(ppi_esc)
```

```
## [1] 4889
```

```
# ensure a single component.
ppi_esc <- getLargestComp(ppi_esc)
vcount(ppi_esc)
```

```
## [1] 2576
```

```
ecount(ppi_esc)
```

```
## [1] 4851
```

```
sox2.gene <- select(org.Mm.eg.db,keys="Sox2",columns="ENTREZID",keytype="SYMBOL")$ENTREZID
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
sox2_trm <- findTRM(ppi_esc, target=sox2.gene, query = res.gene)
```

```
## 18 query nodes NOT FOUND in network-- removed
## removing: 346 nodes out of 357 [keeping 11 nodes]
```

```
cl <- getConcentricList(sox2_trm, t=sox2.gene,e=res.gene)
l <- layout.concentric(sox2_trm, concentric=cl, order="label")
plotTRM(sox2_trm, layout = l, vertex.cex = 15, label.cex = .8)
```

![Sox2 TRM identified using PWMEnrich for the motif enrichment.](data:image/png;base64...)

Figure 7: Sox2 TRM identified using PWMEnrich for the motif enrichment

```
plotTRMlegend(sox2_trm, title = "ESC Sox2 TRM", cex = .8)
```

![Sox2 TRM identified using PWMEnrich for the motif enrichment.](data:image/png;base64...)

Figure 8: Sox2 TRM identified using PWMEnrich for the motif enrichment

We next compare the similarity between the TRM identified using motifs enriched as identified with HOMER and those identified with PWMEnrich. As shown in the heatmap, both methods return similar results.

```
m <- getSimilarityMatrix(list(PWMEnrich = sox2_trm, HOMER = s))
m
```

```
##           PWMEnrich     HOMER
## PWMEnrich 100.00000  83.33333
## HOMER      83.33333 100.00000
```

```
d <- as.data.frame.table(m)
g <- ggplot(d, aes(x = Var1, y = Var2, fill = Freq)) +
  geom_tile() +
  scale_fill_gradient2(
    limit = c(0, 100),
    low = "white",
    mid = "darkblue",
    high = "orange",
    guide = guide_legend("similarity", reverse = TRUE),
    midpoint = 50
  ) +
  labs(x = NULL, y = NULL) +
  theme(aspect.ratio = 1,
        axis.text.x = element_text(
          angle = 90,
          vjust = .5,
          hjust = 1
        ))
```

# 6 Ploting parameters

The most important parameter determining the appearance of your network will be the layout. When networks contain many nodes and edges are difficult to interpret. rTRM implements two igraph layouts that try improve the visualization and interpretation of the identified TRMs. The layout *layout.concentric* is a circular layout with multiple concentric layers that places the target TFs in the center, the enriched (or query) TFs in the outer circle and the bridge TFs in the middle circle. Another layut is *layout.arc* that tries to mimic the layout presented in the rTRM description (Fig. 1). In this case all nodes are plotted in a liner layout, with the targets in the center, and the enriched (query) nodes at each side. Those enriched nodes connected directly to any of the target nodes are placed in the left side. Those connected through a bridge node are placed in the right side, with the bridge node placed in between. The following figure compares the concentric layout obtained in the previous section with a layout using the *layout.arc* function.

```
plotTRM(sox2_trm, layout = l, vertex.cex = 15, label.cex = .7)
```

![Sox2 TRM obtained with PWMEnrich workflow and layout.concentric is shown in the left. Same TRM with layout.arc is shown in the right.](data:image/png;base64...)

Figure 9: Sox2 TRM obtained with PWMEnrich workflow and layout.concentric is shown in the left
Same TRM with layout.arc is shown in the right.

```
l=layout.arc(sox2_trm,target=sox2.gene,query=res.gene)
plotTRM(sox2_trm, layout=l,vertex.cex=15,label.cex=.7)
```

![Sox2 TRM obtained with PWMEnrich workflow and layout.concentric is shown in the left. Same TRM with layout.arc is shown in the right.](data:image/png;base64...)

Figure 10: Sox2 TRM obtained with PWMEnrich workflow and layout.concentric is shown in the left
Same TRM with layout.arc is shown in the right.

# 7 Citation

If you use *[rTRM](https://bioconductor.org/packages/3.22/rTRM)* in your research please include the following reference:

```
citation(package = "rTRM")
```

```
## To cite rTRM in publications use:
##
##   Diego Diez, Andrew P. Hutchins and Diego Miranda-Saavedra. Systematic
##   identification of transcriptional regulatory modules from
##   protein-protein interaction networks. Nucleic Acids Research, 2014.
##   42 (1) e6.
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     title = {Systematic identification of transcriptional regulatory modules from protein-protein interaction networks},
##     author = {Diego Diez and Andrew P. Hutchins and Diego Miranda-Saavedra},
##     year = {2014},
##     journal = {Nucleic Acids Research},
##     volume = {42},
##     number = {1},
##     pages = {e6-e6},
##     doi = {10.1093/nar/gkt913},
##   }
```

# 8 Session Information

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] MotifDb_1.52.0
##  [2] PWMEnrich_4.46.0
##  [3] BSgenome.Mmusculus.UCSC.mm8.masked_1.3.99
##  [4] BSgenome.Mmusculus.UCSC.mm8_1.4.0
##  [5] BSgenome_1.78.0
##  [6] rtracklayer_1.70.0
##  [7] BiocIO_1.20.0
##  [8] Biostrings_2.78.0
##  [9] XVector_0.50.0
## [10] GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0
## [12] org.Mm.eg.db_3.22.0
## [13] AnnotationDbi_1.72.0
## [14] IRanges_2.44.0
## [15] S4Vectors_0.48.0
## [16] Biobase_2.70.0
## [17] BiocGenerics_0.56.0
## [18] generics_0.1.4
## [19] rTRM_1.48.0
## [20] igraph_2.2.1
## [21] knitr_1.50
## [22] ggplot2_4.0.0
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                blob_1.2.4
##  [5] S7_0.2.0                    bitops_1.0-9
##  [7] fastmap_1.2.0               RCurl_1.98-1.17
##  [9] GenomicAlignments_1.46.0    XML_3.99-0.19
## [11] digest_0.6.37               lifecycle_1.0.4
## [13] KEGGREST_1.50.0             gdata_3.0.1
## [15] RSQLite_2.4.3               magrittr_2.0.4
## [17] compiler_4.5.1              rlang_1.1.6
## [19] sass_0.4.10                 tools_4.5.1
## [21] yaml_2.3.10                 data.table_1.17.8
## [23] S4Arrays_1.10.0             bit_4.6.0
## [25] curl_7.0.0                  splitstackshape_1.4.8
## [27] DelayedArray_0.36.0         RColorBrewer_1.1-3
## [29] abind_1.4-8                 BiocParallel_1.44.0
## [31] withr_3.0.2                 grid_4.5.1
## [33] gtools_3.9.5                scales_1.4.0
## [35] dichromat_2.0-0.1           tinytex_0.57
## [37] SummarizedExperiment_1.40.0 cli_3.6.5
## [39] rmarkdown_2.30              crayon_1.5.3
## [41] httr_1.4.7                  rjson_0.2.23
## [43] DBI_1.2.3                   cachem_1.1.0
## [45] parallel_4.5.1              BiocManager_1.30.26
## [47] restfulr_0.0.16             matrixStats_1.5.0
## [49] vctrs_0.6.5                 Matrix_1.7-4
## [51] jsonlite_2.0.0              bookdown_0.45
## [53] bit64_4.6.0-1               seqLogo_1.76.0
## [55] magick_2.9.0                evd_2.3-7.1
## [57] jquerylib_0.1.4             glue_1.8.0
## [59] codetools_0.2-20            gtable_0.3.6
## [61] tibble_3.3.0                pillar_1.11.1
## [63] htmltools_0.5.8.1           R6_2.6.1
## [65] evaluate_1.0.5              lattice_0.22-7
## [67] png_0.1-8                   Rsamtools_2.26.0
## [69] cigarillo_1.0.0             memoise_2.0.1
## [71] bslib_0.9.0                 Rcpp_1.1.0
## [73] SparseArray_1.10.0          xfun_0.53
## [75] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```

# References

Chen, Xi, Han Xu, Ping Yuan, Fang Fang, Mikael Huss, Vinsensius B. Vega, Eleanor Wong, et al. 2008. “Integration of External Signaling Pathways with the Core Transcriptional Network in Embryonic Stem Cells.” *Cell* 133 (6): 1106–17. <https://doi.org/10.1016/j.cell.2008.04.043>.

Dai, Manhong, Pinglang Wang, Andrew D. Boyd, Georgi Kostov, Brian Athey, Edward G. Jones, William E. Bunney, et al. 2005. “Evolving gene/transcript definitions significantly alter the interpretation of GeneChip data.” *Nucleic Acids Research* 33 (20): e175–e175. <https://doi.org/10.1093/nar/gni179>.

Diez, Diego, Andrew Paul Hutchins, and Diego Miranda-Saavedra. 2014. “Systematic identification of transcriptional regulatory modules from protein–protein interaction networks.” *Nucleic Acids Research* 42 (1): e6–e6. <https://doi.org/10.1093/nar/gkt913>.

Gautier, Laurent, Leslie Cope, Benjamin M. Bolstad, and Rafael A. Irizarry. 2004. “affy—analysis of Affymetrix GeneChip data at the probe level.” *Bioinformatics* 20 (3): 307–15. <https://doi.org/10.1093/bioinformatics/btg405>.

Gupta, Shobhit, John A Stamatoyannopoulos, Timothy L Bailey, and William Stafford Noble. 2007. “Quantifying similarity between motifs.” *Genome Biology* 8 (2): R24. <https://doi.org/10.1186/gb-2007-8-2-r24>.

Heinz, Sven, Christopher Benner, Nathanael Spann, Eric Bertolino, Yin C. Lin, Peter Laslo, Jason X. Cheng, Cornelis Murre, Harinder Singh, and Christopher K. Glass. 2010. “Simple Combinations of Lineage-Determining Transcription Factors Prime cis-Regulatory Elements Required for Macrophage and B Cell Identities.” *Molecular Cell* 38 (4): 576–89. <https://doi.org/10.1016/j.molcel.2010.05.004>.

Ho, Lena, Erik L. Miller, Jehnna L. Ronan, Wen Qi Ho, Raja Jothi, and Gerald R. Crabtree. 2011. “esBAF facilitates pluripotency by conditioning the genome for LIF/STAT3 signalling and by regulating polycomb function.” *Nature Cell Biology* 13 (8): 903–13. <https://doi.org/10.1038/ncb2285>.

Hutchins, Andrew Paul, Diego Diez, Yoshiko Takahashi, Shandar Ahmad, Ralf Jauch, Michel Lucien Tremblay, and Diego Miranda-Saavedra. 2013. “Distinct transcriptional regulatory modules underlie STAT3’s cell type-independent and cell type-specific functions.” *Nucleic Acids Research* 41 (4): 2155–70. <https://doi.org/10.1093/nar/gks1300>.

Jolma, Arttu, Jian Yan, Thomas Whitington, Jarkko Toivonen, Kazuhiro R. Nitta, Pasi Rastas, Ekaterina Morgunova, et al. 2013. “DNA-Binding Specificities of Human Transcription Factors.” *Cell* 152 (1-2): 327–39. <https://doi.org/10.1016/j.cell.2012.12.009>.