# Code example from 'dagLogo' vignette. See references/ for full tutorial.

## ----echo=FALSE, results='hide', warning=FALSE, message=FALSE-----------------
suppressPackageStartupMessages({
    library(dagLogo)
    library(biomaRt)
    library(UniProt.ws)
    library(motifStack)
    library(Biostrings)
    library(grDevices)
    })

## -----------------------------------------------------------------------------
library(dagLogo)

## ----fetchSequences1, results='hide'------------------------------------------
##just in case biomaRt server does not response
if (interactive())
{
    try({
            mart <- useMart("ensembl")
            fly_mart <-
            useDataset(mart = mart, dataset = "dmelanogaster_gene_ensembl")
            dat <- read.csv(system.file("extdata", "dagLogoTestData.csv",
                                        package = "dagLogo"))
            seq <- fetchSequence(IDs = as.character(dat$entrez_geneid),
                                 anchorPos = as.character(dat$NCBI_site),
                                 mart = fly_mart,
                                 upstreamOffset = 7,
                                 downstreamOffset = 7)
            head(seq@peptides)
   })
}

## ----fetchSequences2, results='hide'------------------------------------------
if (interactive())
{
    try({
            mart <- useMart("ensembl")
            fly_mart <-
            useDataset(mart = mart, dataset = "dmelanogaster_gene_ensembl")
            dat <- read.csv(system.file("extdata", "dagLogoTestData.csv",
                                        package = "dagLogo"))
            seq <- fetchSequence(IDs = as.character(dat$entrez_geneid),
                                 anchorAA = "*",
                                 anchorPos = as.character(dat$peptide),
                                 mart = fly_mart,
                                 upstreamOffset = 7,
                                 downstreamOffset = 7)
            head(seq@peptides)
    })
}

## ----fetchSequences3, results='hide'------------------------------------------
if(interactive()){
    try({
            dat <- read.csv(system.file("extdata", "peptides4dagLogo.csv",
                                package = "dagLogo"))
            ## cleanup the data
            dat <- unique(cleanPeptides(dat, anchors = "s"))
            
            mart <- useMart("ensembl")
            human_mart <-
            useDataset(mart = mart, dataset = "hsapiens_gene_ensembl")
            seq <- fetchSequence(IDs = toupper(as.character(dat$symbol)),
                                type = "hgnc_symbol",
                                anchorAA = "s",
                                anchorPos = as.character(dat$peptides),
                                mart = human_mart,
                                upstreamOffset = 7,
                                downstreamOffset = 7)
            head(seq@peptides)
    })
}

## ----fetchSequences4----------------------------------------------------------
if(interactive()){
    dat <- read.csv(system.file("extdata", "peptides4dagLogo.csv",
                package="dagLogo"))
    dat <- unique(cleanPeptides(dat, anchors = c("s", "t")))
    mart <- useMart("ensembl", "hsapiens_gene_ensembl")
    seq <- fetchSequence(toupper(as.character(dat$symbol)), 
                         type="hgnc_symbol",
                         anchorAA=as.character(dat$anchor),
                         anchorPos=as.character(dat$peptides), 
                         mart=mart, 
                         upstreamOffset=7, 
                         downstreamOffset=7)
    head(seq@peptides)
}

## ----formatSequence, results='hide'-------------------------------------------
dat <- unlist(read.delim(system.file("extdata", "grB.txt", package = "dagLogo"),
                        header = F, as.is = TRUE))
##prepare proteome from a fasta file, 
##the fastq file is subset of human proteome for this vignette. 
proteome <- prepareProteome(fasta = system.file("extdata",
                                                "HUMAN.fasta",
                                                package = "dagLogo"), 
                            species = "Homo sapiens")
##prepare an object of dagPeptides
seq <- formatSequence(seq = dat, proteome = proteome, upstreamOffset = 14,
                      downstreamOffset = 15)

## ----prepareProteome0---------------------------------------------------------
if(interactive()){
    proteome <- prepareProteome("UniProt", species = "Homo sapiens")
}

## ----buildBackgroundModel-----------------------------------------------------
bg_fisher <- buildBackgroundModel(seq, background = "wholeProteome", 
                                  proteome = proteome, testType = "fisher")
bg_ztest <- buildBackgroundModel(seq, background = "wholeProteome", 
                                 proteome = proteome, testType = "ztest")

## ----testDAU------------------------------------------------------------------
## no grouping
t0 <- testDAU(seq, dagBackground = bg_ztest)

## grouping based on chemical properties of AAs.
t1 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest,
              groupingScheme = "chemistry_property_Mahler_group")

## grouping based on the charge of AAs.
t2 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest, 
              groupingScheme = "charge_group")

## grouping based on the consensus similarity.
t3 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest, 
              groupingScheme = "consensus_similarity_SF_group")

## grouping based on the hydrophobicity. 
t4 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest, 
              groupingScheme = "hydrophobicity_KD")

## In addition, dagLogo allows users to use their own grouping 
## Scheme. The following example shows how to supply a customized 
## scheme. Please note that the user-supplied grouping is named 
## as "custom_group" internally.
## Add a grouping scheme based on the level 3 of BLOSUM50
color = c(LVIMC = "#33FF00", AGSTP = "#CCFF00",
          FYW = '#00FF66', EDNQKRH = "#FF0066")
symbol = c(LVIMC = "L", AGSTP = "A", FYW = "F", EDNQKRH = "E")
group = list(
    LVIMC = c("L", "V", "I", "M", "C"), 
    AGSTP = c("A", "G", "S", "T", "P"),
    FYW = c("F", "Y", "W"),
    EDNQKRH = c("E", "D", "N", "Q", "K", "R", "H"))
addScheme(color = color, symbol = symbol, group = group) 
t5 <- testDAU(dagPeptides = seq, dagBackground = bg_ztest, 
              groupingScheme = "custom_group")

## ----dagHeatmap,fig.cap="DAG heatmap",fig.width=8,fig.height=6----------------
##Plot a heatmap to show the results
dagHeatmap(t0) 

## ----dagLogo0,fig.cap="ungrouped results",fig.width=8,fig.height=6------------
## dagLogo showing differentially used AAs without grouping
dagLogo(t0) 

## ----dagLogo1,fig.cap="classic grouping",fig.width=8,fig.height=6-------------
## dagLogo showing AA grouped based on properties of individual a amino acid.
dagLogo(t1, groupingSymbol = getGroupingSymbol(t1@group), legend = TRUE)

## ----dagLogo2,fig.cap="grouped on charge",fig.width=8,fig.height=6------------
## grouped on the basis of charge.
dagLogo(t2, groupingSymbol = getGroupingSymbol(t2@group), legend = TRUE)

## ----dagLogo3,fig.cap="grouped on chemical property",fig.width=8,fig.height=6----
## grouped on the basis of consensus similarity.
dagLogo(t3, groupingSymbol = getGroupingSymbol(t3@group), legend = TRUE)

## ----dagLogo4,fig.cap="grouped on hydrophobicity",fig.width=8,fig.height=6----
## grouped on the basis of hydrophobicity.
dagLogo(t4, groupingSymbol = getGroupingSymbol(t4@group), legend = TRUE)

## ----sessionInfo, echo=TRUE---------------------------------------------------
sessionInfo()

