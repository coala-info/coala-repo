# Code example from 'Pi_vignettes' vignette. See references/ for full tutorial.

## ----setup, include=FALSE--------------------------------------------------
knitr::opts_chunk$set(collapse=TRUE, comment=">")
knitr::opts_chunk$set(dpi=300)
knitr::opts_chunk$set(cache=FALSE)
knitr::opts_chunk$set(echo=TRUE)
knitr::opts_chunk$set(warning=FALSE)
knitr::opts_chunk$set(message=FALSE)
knitr::opts_chunk$set(fig_cap="yes")
knitr::opts_chunk$set(eval=FALSE)

## ---- eval=FALSE, echo=FALSE-----------------------------------------------
#  cd ~/Sites/XGR
#  ################################################
#  R
#  #devtools::install_github(c("Bioconductor/BiocStyle"))
#  #rmarkdown::render("now.Pi_vignettes.Rmd", BiocStyle::html_document(toc=TRUE,toc_depth=2,number_sections=TRUE,hightlight="default",toc_float=FALSE))
#  #rmarkdown::render("now.Pi_vignettes.Rmd", BiocStyle::html_document2(toc=TRUE,toc_depth=2,number_sections=TRUE,theme="journal", hightlight="monochrome",toc_float=TRUE,code_folding="hide"))
#  rmarkdown::render("now.Pi_vignettes.Rmd", BiocStyle::html_document(toc=TRUE,toc_depth=2,number_sections=TRUE,theme="journal", hightlight="monochrome",toc_float=TRUE,code_folding="hide"))
#  #knitr::purl("now.Pi_vignettes.Rmd")
#  q('no')
#  ################################################
#  scp now.Pi_vignettes.html galahad.well.ox.ac.uk:/var/www/Pi/Pi_vignettes.html
#  scp now.Pi_vignettes.Rmd galahad.well.ox.ac.uk:/var/www/Pi/Pi_vignettes.Rmd

## ----eval=FALSE------------------------------------------------------------
#  source("http://bioconductor.org/biocLite.R")
#  # to use the latest version of Bioconductor, upgrade it: biocLite("BiocUpgrade")
#  biocLite("Pi")

## ----eval=FALSE, echo=TRUE-------------------------------------------------
#  # first, install the dependant packages (the stable version)
#  source("http://bioconductor.org/biocLite.R")
#  biocLite(c("XGR","devtools"), siteRepos=c("http://cran.r-project.org"))
#  
#  # then, install the `Pi` package and its dependency (the latest version)
#  library(devtools)
#  install_github(c("hfang-bristol/XGR", "hfang-bristol/Pi"))

## ----fig.width=3, fig.height=3, fig.align="center", echo=FALSE, eval=TRUE----
library(png)
library(grid)
img <- readPNG("saved.Pi.workflow.png")
grid.raster(img)

## ----fig.width=4, fig.height=2, fig.align="center", echo=FALSE, eval=TRUE----
library(png)
library(grid)
img <- readPNG("saved.Pi.functions.png")
grid.raster(img)

## ---- eval=TRUE, echo=FALSE------------------------------------------------
net <- list()
net[['STRING_high']] <- c('STRING', 'Functional interactions (with high confidence scores>=700)', 'STRING_high')
net[['STRING_medium']] <- c('STRING', 'Functional interactions (with medium confidence scores>=400)', 'STRING_medium')
net[['PCommonsUN_high']] <- c('Pathway Commons', 'Physical/undirect interactions (with references & >=2 sources)', 'PCommonsUN_high')
net[['PCommonsUN_medium']] <- c('Pathway Commons', 'Physical/undirect interactions (with references & >=1 sources)', 'PCommonsUN_medium')
net[['PCommonsDN_high']] <- c('Pathway Commons', 'Pathway/direct interactions (with references & >=2 sources)', 'PCommonsDN_high')
net[['PCommonsDN_medium']] <- c('Pathway Commons', 'Pathway/direct interactions (with references & >=1 sources)', 'PCommonsDN_medium')
df_net <- do.call(rbind, net)
colnames(df_net) <- c('Database', 'Interaction (type and quality)', 'Code')
knitr::kable(df_net[,c(3,2,1)], caption="", row.names=FALSE)

## ---- eval=TRUE, echo=FALSE------------------------------------------------
pop <- list()
pop[['AFR']] <- c('1000 Genomes Project', 'African', 'AFR')
pop[['AMR']] <- c('1000 Genomes Project', 'Admixed American', 'AMR')
pop[['EAS']] <- c('1000 Genomes Project', 'East Asian', 'EAS')
pop[['EUR']] <- c('1000 Genomes Project', 'European', 'EUR')
pop[['SAS']] <- c('1000 Genomes Project', 'South Asian', 'SAS')
df_pop <- do.call(rbind, pop)
colnames(df_pop) <- c('Project', 'Population', 'Code')
knitr::kable(df_pop[,c(3,2,1)], caption="", row.names=FALSE)

## ---- eval=TRUE, echo=FALSE------------------------------------------------
obo <- list()
obo[['DO']] <- c('Disease', 'Disease Ontology', 'DO')
obo[['GOMF']] <- c('Function', 'Gene Ontology Molecular Function', 'GOMF')
obo[['GOBP']] <- c('Function', 'Gene Ontology Biological Process', 'GOBP')
obo[['GOCC']] <- c('Function', 'Gene Ontology Cellular Component', 'GOCC')
obo[['HPPA']] <- c('Phenotype', 'Human Phenotype Phenotypic Abnormality', 'HPPA')
obo[['HPMI']] <- c('Phenotype', 'Human Phenotype Mode of Inheritance', 'HPMI')
obo[['HPCM']] <- c('Phenotype', 'Human Phenotype Clinical Modifier', 'HPCM')
obo[['HPMA']] <- c('Phenotype', 'Human Phenotype Mortality Aging', 'HPMA')
obo[['MP']] <- c('Phenotype', 'Mammalian/Mouse Phenotype', 'MP')
obo[['DGIdb']] <- c('Druggable', 'DGI druggable gene categories', 'DGIdb')
obo[['SF']] <- c('Structural domain', 'SCOP domain superfamilies', 'SF')
obo[['Pfam']] <- c('Structural domain', 'Pfam domain families', 'Pfam')
obo[['PS2']] <- c('Evolution', 'phylostratific age information (our ancestors)', 'PS2')
obo[['MsigdbH']] <- c('Hallmark (MsigDB)', 'Hallmark gene sets', 'MsigdbH')
obo[['MsigdbC1']] <- c('Cytogenetics (MsigDB)', 'Chromosome and cytogenetic band positional gene sets', 'MsigdbC1')
obo[['MsigdbC2CGP']] <- c('Perturbation (MsigDB)', 'Chemical and genetic perturbation gene sets', 'MsigdbC2CGP')
obo[['MsigdbC2CPall']] <- c('Pathways (MsigDB)', 'All pathway gene sets', 'MsigdbC2CPall')
obo[['MsigdbC2CP']] <- c('Pathways (MsigDB)', 'Canonical pathway gene sets', 'MsigdbC2CP')
obo[['MsigdbC2KEGG']] <- c('Pathways (MsigDB)', 'KEGG pathway gene sets', 'MsigdbC2KEGG')
obo[['MsigdbC2REACTOME']] <- c('Pathways (MsigDB)', 'Reactome pathway gene sets', 'MsigdbC2REACTOME')
obo[['MsigdbC2BIOCARTA']] <- c('Pathways (MsigDB)', 'BioCarta pathway gene sets', 'MsigdbC2BIOCARTA')
obo[['MsigdbC3TFT']] <- c('TF targets (MsigDB)', 'Transcription factor target gene sets', 'MsigdbC3TFT')
obo[['MsigdbC3MIR']] <- c('microRNA targets (MsigDB)', 'microRNA target gene sets', 'MsigdbC3MIR')
obo[['MsigdbC4CGN']] <- c('Cancer (MsigDB)', 'Cancer gene neighborhood gene sets', 'MsigdbC4CGN')
obo[['MsigdbC4CM']] <- c('Cancer (MsigDB)', 'Cancer module gene sets', 'MsigdbC4CM')
obo[['MsigdbC5BP']] <- c('Function (MsigDB)', 'GO biological process gene sets', 'MsigdbC5BP')
obo[['MsigdbC5MF']] <- c('Function (MsigDB)', 'GO molecular function gene sets', 'MsigdbC5MF')
obo[['MsigdbC5CC']] <- c('Function (MsigDB)', 'GO cellular component gene sets', 'MsigdbC5CC')
obo[['MsigdbC6']] <- c('Oncology (MsigDB)', 'Oncogenic signature gene sets', 'MsigdbC6')
obo[['MsigdbC7']] <- c('Immunology (MsigDB)', 'Immunologic signature gene sets', 'MsigdbC7')
df_obo <- do.call(rbind, obo)
colnames(df_obo) <- c('Category', 'Ontology', 'Code')
knitr::kable(df_obo[,c(3,2,1)], caption="", row.names=FALSE)

## ---- eval=TRUE, include=TRUE----------------------------------------------
library(Pi)

# optionally, specify the local location of built-in RData
# by default:
RData.location <- "http://galahad.well.ox.ac.uk/bigdata"

## ---- eval=TRUE, echo=FALSE------------------------------------------------
# This intends to use the local version of data
RData.location <- "~/Sites/SVN/github/bigdata_dev"

## ---- eval=TRUE------------------------------------------------------------
data.file <- "http://galahad.well.ox.ac.uk/bigdata/Spondyloarthritis.txt"
data <- read.delim(data.file, header=TRUE, stringsAsFactors=FALSE)

## ---- eval=TRUE, echo=FALSE------------------------------------------------
knitr::kable(data[1:15,], digits=200, caption="", row.names=FALSE)

## ---- eval=TRUE, include=TRUE, echo=TRUE-----------------------------------
include.LD <- 'EUR'
LD.r2 <- 0.8
LD.customised <- NULL
significance.threshold <- 5e-8
distance.max <- 50000
decay.kernel <- "rapid"
decay.exponent <- 2
include.eQTL <- c("JKscience_TS2A","JKscience_TS2B","JKscience_TS3A","JKng_bcell","JKng_mono","JKnc_neutro", "GTEx_V4_Whole_Blood")
eQTL.customised <- NULL
include.HiC <- c("Monocytes","Neutrophils","Total_B_cells")
GR.SNP <- "dbSNP_GWAS"
GR.Gene <- "UCSC_knownGene"
cdf.function <- "empirical"
relative.importance <- c(1/3, 1/3, 1/3)
scoring.scheme <- 'max'
network <- "STRING_high"
network.customised <- NULL
weighted <- FALSE
normalise <- "laplacian"
normalise.affinity.matrix <- "none"
restart <- 0.75
parallel <- TRUE
multicores <- NULL
verbose <- TRUE

## ---- results="hide"-------------------------------------------------------
#  pNode <- xPierSNPs(data, include.LD=include.LD, LD.r2=LD.r2, significance.threshold=significance.threshold, distance.max=distance.max, decay.kernel=decay.kernel, decay.exponent=decay.exponent, include.eQTL=include.eQTL, include.HiC=include.HiC, GR.SNP=GR.SNP, GR.Gene=GR.Gene, cdf.function=cdf.function, scoring.scheme=scoring.scheme, network=network, restart=restart, RData.location=RData.location)

## ---- results="hide"-------------------------------------------------------
#  write.table(pNode$priority, file="Genes_priority.txt", sep="\t", row.names=FALSE)

## ---- fig.width=10, fig.height=5, echo=TRUE--------------------------------
#  mp <- xPierManhattan(pNode, top=40, y.scale="sqrt", RData.location=RData.location)
#  print(mp)

## ---- eval=FALSE, echo=FALSE-----------------------------------------------
#  png(file="saved.Pi.gene_manhattan.png", height=480, width=480*2.2, res=96*1.3)
#  print(mp)
#  dev.off()

## ----fig.width=4, fig.height=2, fig.align="center", echo=FALSE, eval=TRUE----
library(png)
library(grid)
img <- readPNG("saved.Pi.gene_manhattan.png")
grid.raster(img)

## ---- results="hide"-------------------------------------------------------
#  eTerm <- xPierPathways(pNode, priority.top=100, ontology="MsigdbC2CPall", RData.location=RData.location)
#  eTerm_nonred <- xEnrichConciser(eTerm)
#  
#  # view the top pathways/terms
#  xEnrichViewer(eTerm_nonred)
#  
#  # save results to a file `Pathways_priority.nonredundant.txt`
#  Pathways_nonred <- xEnrichViewer(eTerm_nonred, top_num=length(eTerm_nonred$adjp), sortBy="fdr", details=TRUE)
#  output <- data.frame(term=rownames(Pathways_nonred), Pathways_nonred)
#  write.table(output, file="Pathways_priority.nonredundant.txt", sep="\t", row.names=FALSE)

## ---- fig.width=10, fig.height=5, echo=TRUE--------------------------------
#  bp <- xEnrichBarplot(eTerm_nonred, top_num="auto", displayBy="fdr", FDR.cutoff=1e-3, wrap.width=50, signature=FALSE)
#  bp

## ---- eval=FALSE, echo=FALSE-----------------------------------------------
#  png(file="saved.Pi.pathway_barplot.png", height=360, width=360*3, res=96)
#  print(bp)
#  dev.off()

## ----fig.width=6, fig.height=3, fig.align="center", echo=FALSE, eval=TRUE----
library(png)
library(grid)
img <- readPNG("saved.Pi.pathway_barplot.png")
grid.raster(img)

## ---- cache=FALSE----------------------------------------------------------
#  # find maximum-scoring gene network with the desired node number=50
#  g <- xPierSubnet(pNode, priority.quantite=0.1, subnet.size=50, RData.location=RData.location)

## ---- fig.width=6, fig.height=6, echo=TRUE---------------------------------
#  pattern <- as.numeric(V(g)$priority)
#  zmax <- ceiling(quantile(pattern,0.75)*1000)/1000
#  xVisNet(g, pattern=pattern, vertex.shape="sphere", colormap="yr", newpage=FALSE, edge.arrow.size=0.3, vertex.label.color="blue", vertex.label.dist=0.35, vertex.label.font=2, zlim=c(0,zmax), signature=FALSE)

## ---- eval=FALSE, cache=FALSE, echo=FALSE----------------------------------
#  png(file="saved.Pi.network_vis.png", height=480*2, width=480*2, res=96*1.5)
#  xVisNet(g, pattern=pattern, vertex.shape="sphere", colormap="yr", newpage=FALSE, vertex.label.color="blue", vertex.label.dist=0.35, vertex.label.font=2, zlim=c(0,zmax), signature=FALSE)
#  dev.off()

## ----fig.width=2, fig.height=2, fig.align="center", echo=FALSE, eval=TRUE----
library(png)
library(grid)
img <- readPNG("saved.Pi.network_vis.png")
grid.raster(img)

## ----sessionInfo, echo=FALSE, eval=TRUE------------------------------------
sessionInfo()

