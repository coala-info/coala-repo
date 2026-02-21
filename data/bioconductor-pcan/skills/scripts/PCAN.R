# Code example from 'PCAN' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(PCAN)
## Some functions can be parallelized.
## They use the bpmapply function from the BiocParallel library.
## Follow instructions provided in the BiocParallel manual to
## configure your parallelization backend.
## options(MulticoreParam=quote(MulticoreParam(workers=4)))

## ----echo=FALSE---------------------------------------------------------------
data(traitDef, package="PCAN")
disId <- "612285"
disName <- traitDef[
    which(traitDef$id==disId & traitDef$db=="OMIM"),
    "name"
]

## ----echo=FALSE, results='asis'-----------------------------------------------
data(hpByTrait, hpDef, package="PCAN")
hpOfInterest <- hpByTrait[
    which(hpByTrait$id==disId & hpByTrait$db=="OMIM"),
    "hp"
]
knitr::kable(
    hpDef[match(hpOfInterest, hpDef$id),],
    row.names=FALSE,
    col.names=c("HP", "Name")
)

## ----echo=FALSE---------------------------------------------------------------
data(geneDef, package="PCAN")
genId <- "57545"
genSymb <- geneDef[
    match(genId, geneDef$entrez),
    "symbol"
]

## -----------------------------------------------------------------------------
data(geneByTrait, package="PCAN")
head(geneByTrait, n=3)
dim(geneByTrait)

## -----------------------------------------------------------------------------
data(traitDef, package="PCAN")
head(traitDef, n=3)

## -----------------------------------------------------------------------------
data(geneDef, package="PCAN")
head(geneDef, n=3)

## -----------------------------------------------------------------------------
geneByTrait <- geneByTrait[
    which(geneByTrait$id!=disId | geneByTrait$entrez!=genId),
]
dim(geneByTrait)

## -----------------------------------------------------------------------------
data(hpByTrait, package="PCAN")
head(hpByTrait, n=3)

## -----------------------------------------------------------------------------
data(hpDef, package="PCAN")
head(hpDef, n=3)

## -----------------------------------------------------------------------------
data(hp_descendants, hp_ancestors, package="PCAN")
lapply(head(hp_descendants, n=3), head)
lapply(head(hp_ancestors, n=3), head)

## ----echo=FALSE---------------------------------------------------------------
rootHpName <- "Phenotypic abnormality"
rootHpId <- hpDef$id[which(hpDef$name==rootHpName)]

## -----------------------------------------------------------------------------
geneByHp <- unique(merge(
    geneByTrait,
    hpByTrait,
    by="id"
)[,c("entrez", "hp")])
head(geneByHp, n=3)

## -----------------------------------------------------------------------------
genDis <- traitDef[
    match(
        geneByTrait[which(geneByTrait$entrez==genId), "id"],
        traitDef$id
    ),
]
genDis

genHpDef <- hpDef[
    match(
        geneByHp[which(geneByHp$entrez==genId), "hp"],
        hpDef$id
    ),
]
genHp <- genHpDef$id
dim(genHpDef)
head(genHpDef)

## -----------------------------------------------------------------------------
genHpDef[which(genHpDef$id %in% hpOfInterest),]

## -----------------------------------------------------------------------------
info <- unstack(geneByHp, entrez~hp)
ic <- computeHpIC(info, hp_descendants)

## ----echo=FALSE---------------------------------------------------------------
hist(
    ic,
    breaks=100, col="grey",
    main="Distribution of Information Content",
    xlab="IC base on genes associated to HP"
)

## -----------------------------------------------------------------------------
hp1 <- "HP:0000518"
hp2 <- "HP:0030084"
hpDef[which(hpDef$id %in% c(hp1, hp2)), 1:2]
calcHpSim(hp1, hp2, IC=ic, ancestors=hp_ancestors)

## -----------------------------------------------------------------------------
hp1 <- "HP:0002119"
hp2 <- "HP:0001305"
hpDef[which(hpDef$id %in% c(hp1, hp2)), 1:2]
calcHpSim(hp1, hp2, IC=ic, ancestors=hp_ancestors)

## -----------------------------------------------------------------------------
compMat <- compareHPSets(
    hpSet1=genHp, hpSet2=hpOfInterest,
    IC=ic,
    ancestors=hp_ancestors,
    method="Resnik",
    BPPARAM=SerialParam()
)
dim(compMat)
head(compMat)

## -----------------------------------------------------------------------------
hpSetCompSummary(compMat, method="bma", direction="symSim")

## -----------------------------------------------------------------------------
## Compute semantic similarity between HP of interest and all HP terms
## This step is time consumming and can be parallelized.
## Use the BPPARAM parameter to specify your own 
## back-end with appropriate number of workers.
hpGeneResnik <- compareHPSets(
    hpSet1=names(ic), hpSet2=hpOfInterest,
    IC=ic,
    ancestors=hp_ancestors,
    method="Resnik",
    BPPARAM=SerialParam()
)
## Group the results by gene
hpByGene <- unstack(geneByHp, hp~entrez)
hpMatByGene <- lapply(
    hpByGene,
    function(x){
        hpGeneResnik[x, , drop=FALSE]
    }
)
## Compute the corresponding scores
resnSss <- unlist(lapply(
    hpMatByGene,
    hpSetCompSummary,
    method="bma", direction="symSim"
))
## Get the score of the gene candidate
candScore <- resnSss[genId]
candScore

## -----------------------------------------------------------------------------
candRank <- sum(resnSss >= candScore)
candRank
candRelRank <- candRank/length(resnSss)
candRelRank

## ----echo=FALSE---------------------------------------------------------------
hist(
    resnSss,
    breaks=100, col="grey",
    ylim=c(0,300),
    xlab=expression(Sim[sym]),
    ylab="Number of genes",
    main=paste(
        "Distribution of symmetric semantic similarity scores\nfor all the",
        length(resnSss), "genes"
    )
)
polygon(
    x=c(candScore, 10, 10, candScore),
    y=c(-10, -10, 1000, 1000),
    border="#BE0000",
    col="#BE000080",
    lwd=3
)
text(
    x=candScore, y=mean(par()$usr[3:4]),
    paste0(
        candRank, " genes (",
        signif(candRank*100/length(resnSss), 2), "%)\n",
        "show a symmetric semantic\n",
        "similarity score greater than\n",
        "the gene candidate for\n",
        "for the HPs under focus."
    ),
    pos=4,
    cex=0.6
)

## -----------------------------------------------------------------------------
data(hsEntrezByRPath, rPath, package="PCAN")
head(rPath, n=3)
lapply(head(hsEntrezByRPath, 3), head)

## -----------------------------------------------------------------------------
data(hqStrNw, package="PCAN")
head(hqStrNw, n=3)

## -----------------------------------------------------------------------------
candPath <- names(hsEntrezByRPath)[which(unlist(lapply(
    hsEntrezByRPath,
    function(x) genId %in% x
)))]
rPath[which(rPath$Pathway %in% candPath),]

## -----------------------------------------------------------------------------
rPathRes <- hpGeneListComp(
    geneList=hsEntrezByRPath[[candPath]],
    ssMatByGene = hpMatByGene,
    geneSSScore = resnSss
)

## -----------------------------------------------------------------------------
length(rPathRes$scores)
sum(!is.na(rPathRes$scores))

## ----echo=FALSE---------------------------------------------------------------
hist(
    resnSss,
    breaks=100, col="grey",
    ylim=c(0,5),
    xlab=expression(Sim[sym]),
    ylab="Density",
    main=paste(
        "Distribution of symmetric semantic similarity scores\nfor all the",
        length(resnSss), "genes"
    ),
    probability=TRUE
)
toAdd <- hist(
    rPathRes$scores,
    breaks=100,
    plot=FALSE
)
for(i in 1:length(toAdd$density)){
    polygon(
        x=toAdd$breaks[c(i, i+1, i+1, i)],
        y=c(0, 0, rep(toAdd$density[i], 2)),
        col="#BE000040",
        border="#800000FF"
    )
}
legend(
    "topright",
    paste0(
        "Genes belonging to the ", candPath," pathway:\n'",
        rPath[which(rPath$Pathway %in% candPath),"Pathway_name"],
        "'\nand with a symmetric semantic similarity score (",
        sum(!is.na(rPathRes$scores)),
        "/",
        length(rPathRes$scores),
        ")\n",
        "p-value: ", signif(rPathRes$p.value, 2)
    ),
    pch=15,
    col="#BE000040",
    bty="n",
    cex=0.6
)

## -----------------------------------------------------------------------------
pathSss <- rPathRes$scores[which(!is.na(rPathRes$scores))]
names(pathSss) <- geneDef[match(names(pathSss), geneDef$entrez), "symbol"]
par(mar=c(7.1, 4.1, 4.1, 2.1))
barplot(
    sort(pathSss),
    las=2,
    ylab=expression(Sim[sym]),
    main=rPath[which(rPath$Pathway %in% candPath),"Pathway_name"]
)
p <- c(0.25, 0.5, 0.75, 0.95)
abline(
    h=quantile(resnSss, probs=p),
    col="#BE0000",
    lty=c(2, 1, 2, 2),
    lwd=c(2, 2, 2, 1)
)
text(
    rep(0,4),
    quantile(resnSss, probs=p),
    p,
    pos=3,
    offset=0,
    col="#BE0000",
    cex=0.6
)
legend(
    "topleft",
    paste0(
        "Quantiles of the distribution of symmetric semantic similarity\n",
        "scores for all the genes."
    ),
    lty=1,
    col="#BE0000",
    cex=0.6
)

## -----------------------------------------------------------------------------
geneLabels <- geneDef$symbol[which(!duplicated(geneDef$entrez))]
names(geneLabels) <- geneDef$entrez[which(!duplicated(geneDef$entrez))]
hpLabels <- hpDef$name
names(hpLabels) <- hpDef$id
hpGeneHeatmap(
    rPathRes,
    genesOfInterest=genId,
    geneLabels=geneLabels,
    hpLabels=hpLabels,
    clustByGene=TRUE,
    clustByHp=TRUE,
    palFun=colorRampPalette(c("white", "red")),
    goiCol="blue",
    main=rPath[which(rPath$Pathway %in% candPath),"Pathway_name"]
)

## -----------------------------------------------------------------------------
neighbors <- unique(c(
    hqStrNw$gene1[which(hqStrNw$gene2==genId)],
    hqStrNw$gene2[which(hqStrNw$gene1==genId)],
    genId
))
neighRes <- hpGeneListComp(
    geneList=neighbors,
    ssMatByGene = hpMatByGene,
    geneSSScore = resnSss
)

## ----echo=FALSE---------------------------------------------------------------
hist(
    resnSss,
    breaks=100, col="grey",
    ylim=c(0,10),
    xlab=expression(Sim[sym]),
    ylab="Density",
    main=paste(
        "Distribution of symmetric semantic similarity scores\nfor all the",
        length(resnSss), "genes"
    ),
    probability=TRUE
)
toAdd <- hist(
    neighRes$scores,
    breaks=100,
    plot=FALSE
)
for(i in 1:length(toAdd$density)){
    polygon(
        x=toAdd$breaks[c(i, i+1, i+1, i)],
        y=c(0, 0, rep(toAdd$density[i], 2)),
        col="#BE000040",
        border="#800000FF"
    )
}
legend(
    "topright",
    paste0(
        "Genes interacting with ",
        geneDef[which(geneDef$entrez==genId),"symbol"],
        " (", genId, ")",
        "\nand with a symmetric semantic similarity score (",
        sum(!is.na(neighRes$scores)),
        "/",
        length(neighRes$scores),
        ")\n",
        "p-value: ", signif(neighRes$p.value, 2)
    ),
    pch=15,
    col="#BE000040",
    bty="n",
    cex=0.6
)

## ----echo=FALSE---------------------------------------------------------------
neighSss <- neighRes$scores[which(!is.na(neighRes$scores))]
names(neighSss) <- geneDef[match(names(neighSss), geneDef$entrez), "symbol"]
opar <- par(mar=c(7.1, 4.1, 4.1, 2.1))
barplot(
    sort(neighSss),
    las=2,
    ylab=expression(Sim[sym]),
    main=paste0(
        "Genes interacting with ",
        geneDef[which(geneDef$entrez==genId),"symbol"],
        " (", genId, ")"
    )
)
p <- c(0.25, 0.5, 0.75, 0.95)
abline(
    h=quantile(resnSss, probs=p),
    col="#BE0000",
    lty=c(2, 1, 2, 2),
    lwd=c(2, 2, 2, 1)
)
text(
    rep(0,4),
    quantile(resnSss, probs=p),
    p,
    pos=3,
    offset=0,
    col="#BE0000",
    cex=0.6
)
legend(
    "topleft",
    paste0(
        "Quantiles of the distribution of symmetric semantic similarity\n",
        "scores for all the genes."
    ),
    lty=1,
    col="#BE0000",
    cex=0.6
)

## ----echo=FALSE---------------------------------------------------------------
hpGeneHeatmap(
    neighRes,
    genesOfInterest=genId,
    geneLabels=geneLabels,
    hpLabels=hpLabels,
    clustByGene=TRUE,
    clustByHp=TRUE,
    palFun=colorRampPalette(c("white", "red")),
    goiCol="blue",
    main=rPath[which(rPath$Pathway %in% candPath),"Pathway_name"]
)

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

