# Code example from 'epiNEM' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(message=FALSE)
fig.cap1 <- "Toy example result for a double mutant (A,B) and one modulator
(C)."
fig.cap2 <- "Distribution of inferred logics for each double knock-out."
fig.cap3 <- "Ranked modulators for one double knock-out."
fig.cap4 <- "Perfect binary effects matrix for each logic."
fig.cap5 <- ""
fig.cap6 <- "Global results for the van Wageningen data set. See the help pages
of plot.epiScreen() and HeatmapOP() for additional parameters."
fig.cap7 <- "Results for one double knock-out of the van Wageningen data set.
See ?plot.epiScreen for further parameters."
fig.cap8 <- "Global result for the Sameith data set."
fig.cap9 <- "Example for one knock-out of the Sameith data set."
fig.cap10 <- "Density of the string-db interaction scores (van Wageningen).
Background (turqoise) and inferred by epiNEM (pink)."
fig.cap11 <- "Density of the string-dbinteraction scores (Sameith). Baackground
(turqoise) and inferred by epiNEM (pink)."
fig.cap12 <- "Density plot for graph-based GO similarity score
(van Wageningen)."
fig.cap13 <- "Density plot for graph-based GO similarity score (Sameith)."
fig.cap14 <- "Enrichment of van Wageningen modulators by KEGG pathways.
Colors refer to false discovery rates. NAs are colored in grey."
fig.cap15 <- "Enrichment of Sameith modulators by KEGG pathways. Colors
refer to false discovery rates. NAs are colored in grey."
fig.cap16 <- "Effect reporter KEGG pathway enrichment (van Wageningen).
Colors refer to false discovery rates. NAs are colored in grey."
fig.cap17 <- "Effect reporter KEGG pathway enrichment (Sameith). Colors
refer to false discovery rates. NAs are colored in grey."

## -----------------------------------------------------------------------------
library(epiNEM)

## -----------------------------------------------------------------------------
data <- matrix(sample(c(0,1), 100*4, replace = TRUE), 100, 4)
colnames(data) <- c("A", "A.B", "B", "C")
rownames(data) <- paste("E", 1:100, sep = "_")
print(head(data))
res <- epiNEM(data, method = "exhaustive")

## ----fig.width = 7, fig.height = 7, fig.cap=fig.cap1--------------------------
plot(res)

## -----------------------------------------------------------------------------
data <- matrix(sample(c(0,1), 100*9, replace = TRUE), 100, 9)
colnames(data) <- c("A.B", "A.C", "B.C", "A", "B", "C", "D", "E", "G")
rownames(data) <- paste("E", 1:100, sep = "_")
res <- epiScreen(data)

## ----fig.width = 4, fig.height = 4, fig.cap = fig.cap2------------------------
plot(res)

## ----fig.width = 5, fig.height = 4, fig.cap = fig.cap3------------------------
plot(res, global = FALSE, ind = 1)

## ----warning=FALSE, fig.width = 9, fig.height=5, fig.cap = fig.cap4-----------
epiAnno()

## -----------------------------------------------------------------------------
data(sim)

## ----fig.width = 7, fig.height = 7, fig.cap = "Simulation results."-----------
plot(sim)

## ----fig.width = 8, fig.height = 4, fig.cap = fig.cap6------------------------
data(wagscreen)

doubles <- wagscreen$doubles

dataWag <- wagscreen$dataWag

## clean up the results:

if (length(grep("fus3|ptp2.ptc2", wagscreen$doubles)) > 0) {
    wagscreen$doubles <- wagscreen$doubles[-grep("fus3|ptp2.ptc2",
                                                 wagscreen$doubles)]
    
    wagscreen$dataWag <- wagscreen$dataWag[, -grep("fus3|ptp2.ptc2",
                                                   colnames(wagscreen$dataWag))]
    
    wagscreen$ll <- wagscreen$ll[, -grep("fus3|ptp2.ptc2",
                                         colnames(wagscreen$ll))]
    
    wagscreen$logic <- wagscreen$logic[, -grep("fus3|ptp2.ptc2",
                                               colnames(wagscreen$logic))]
}

plot(wagscreen, xrot = 45, borderwidth = 0)

## ----fig.width = 8, fig.height = 4, fig.cap = fig.cap7------------------------
plot(wagscreen, global = FALSE, ind = 3, cexGene = 0.7, cexLegend = 0.9,
     off = 0.2)

## ----fig.width = 10, fig.height = 6, fig.cap = fig.cap8-----------------------
data(samscreen)

doubles <- samscreen$doubles

dataSam <- samscreen$dataSam

plot(samscreen, xrot = 45, cexCol = 0.6, borderwidth = 0)

## ----fig.width = 8, fig.height = 4, fig.cap = fig.cap9------------------------
plot(samscreen, global = FALSE, ind = 23, cexGene = 0.7, cexLegend = 0.9,
     off = 0.2)

## ----fig.width = 8, fig.height = 5, fig.cap = fig.cap10-----------------------
library(STRINGdb)

## get_STRING_species(version="10", species_name=NULL)[26, ] # 4932

string_db <- STRINGdb$new( version="11", species=4932, score_threshold=0,
                          input_directory="")
data(wageningen_string)

string.scores <- wageningen_string$string.scores
string.names <- wageningen_string$string.names

tmp <- string_db$get_interactions(
    string_db$mp(unique(unlist(strsplit(colnames(dataWag), "\\.")))))

stsc <- unlist(string.scores)

denspval <- wilcox.test(stsc, unlist(tmp$combined_score),
                        alternative = "greater")$p.value

for (i in 100:1) {

    if (denspval < 10^(-i)) {

        denspval <- paste("< ", 10^(-i), sep = "")

    } 

}

plot(density(stsc), col = "#00000000",
     ylim = c(0, max(c(max(density(stsc)$y),
                       max(density(unlist(tmp$combined_score))$y)))),
     main = paste("van Wageningen String-db interaction scores", sep = ""),
     xlab = "",
     cex.main = 1.5)
polygon(density(stsc), col = "#ff000066")

legend("topright", legend=paste("p-value", denspval, " "), cex = 1.5)

mtext = mtext("A", side = 3, line = 1, outer = FALSE, cex = 3, adj = 0,
              at = par("usr")[1] - (par("usr")[2]-par("usr")[1])*0.1)

lines(density(unlist(tmp$combined_score)), col = "#00000000")
polygon(density(unlist(tmp$combined_score)), col = "#00ffff66")

data(sameith_string)

string.scores2 <- sameith_string$string.scores2
string.names2 <- sameith_string$string.names2

tmp <- string_db$get_interactions(
    string_db$mp(unique(unlist(strsplit(colnames(dataSam), "\\.")))))

stsc <- unlist(string.scores2)

denspval <- wilcox.test(stsc, unlist(tmp$combined_score),
                        alternative = "greater")$p.value

for (i in 100:1) {

    if (denspval < 10^(-i)) {

        denspval <- paste("< ", 10^(-i), sep = "")

    } 

}

plot(density(stsc), col = "#00000000",
     ylim = c(0, max(c(max(density(stsc)$y),
                       max(density(unlist(tmp$combined_score))$y)))),
     main = paste("Sameith String-db interaction scores", sp = ""),
     xlab = "",
     cex.main = 1.5)
polygon(density(stsc), col = "#ff000066")

legend("topright", legend=paste("p-value", denspval, " "), cex = 1.5)

mtext = mtext("B", side = 3, line = 1, outer = FALSE, cex = 3, adj = 0,
              at = par("usr")[1] - (par("usr")[2]-par("usr")[1])*0.1)

lines(density(unlist(tmp$combined_score)), col = "#00000000")
polygon(density(unlist(tmp$combined_score)), col = "#00ffff66")

## ----fig.width = 8, fig.height = 5, fig.cap = fig.cap12-----------------------
data(wageningen_GO)

GOepi <- wageningen_GO$epi
GOall <- wageningen_GO$all

denspval <- wilcox.test(GOepi, GOall, alternative = "greater")$p.value

for (i in 100:1) {
    if (i <= 2) {
        for (j in 1:9) {
            if (denspval < j*10^(-i)) {
                denspval <- paste("< ", j*10^(-i), sep = "")
            }
        }
    } else {
        if (denspval < 10^(-i)) {
            denspval <- paste("< ", 10^(-i), sep = "")
        }
    }
}

plot(density(GOepi), col = "#00000000",
     ylim = c(0, max(c(max(density(GOepi)$y),
                       max(density(unlist(GOall))$y)))),
     main = "van Wageningen Go similarity scores",
     xlab = "",
     cex.main = 1.5)
polygon(density(GOepi), col = "#ff000066")

legend("topleft", legend=paste("p-value", denspval, "   "), cex = 1.5)

mtext = mtext("C", side = 3, line = 1, outer = FALSE, cex = 3, adj = 0,
              at = par("usr")[1] - (par("usr")[2]-par("usr")[1])*0.1)

lines(density(unlist(GOall)), col = "#00000000")
polygon(density(unlist(GOall)), col = "#00ffff66")

## ----fig.width = 8, fig.height = 5, fig.cap = fig.cap13-----------------------
data(sameith_GO)

GOepi2 <- sameith_GO$epi
GOall2 <- sameith_GO$all

denspval <- wilcox.test(GOepi2, GOall2, alternative = "greater")$p.value

for (i in 100:1) {
    if (i <= 2) {
        for (j in 1:9) {
            if (denspval < j*10^(-i)) {
                denspval <- paste("< ", j*10^(-i), sep = "")
            }
        }
    } else {
        if (denspval < 10^(-i)) {
            denspval <- paste("< ", 10^(-i), sep = "")
        }
    }
}

plot(density(GOepi2), col = "#00000000",
     ylim = c(0, max(c(max(density(GOepi2)$y),
                       max(density(unlist(GOall2))$y)))),
     main = "Sameith Go similarity scores",
     xlab = "",
     cex.main = 1.5)
polygon(density(GOepi2), col = "#ff000066")

legend("topleft", legend=paste("p-value", denspval, "   "), cex = 1.5)

mtext = mtext("D", side = 3, line = 1, outer = FALSE, cex = 3, adj = 0,
              at = par("usr")[1] - (par("usr")[2]-par("usr")[1])*0.1)

lines(density(unlist(GOall2)), col = "#00000000")
polygon(density(unlist(GOall2)), col = "#00ffff66")

## ----fig.width = 8, fig.height = 5, fig.cap = fig.cap14-----------------------
data(wageningen_GO)

golist <- wageningen_GO$golist

goterms <- character()

for (i in 1:length(golist)) {

    if (i %in% c(5,8)) { next() }

    goterms <- c(goterms,
                 golist[[i]]$term_description[which(golist[[i]]$pvalue_fdr
                                                    < 1)])

}

gomat <- matrix(NA, length(unique(goterms)), ncol(wagscreen$ll))

rownames(gomat) <- sort(unique(goterms))
colnames(gomat) <- colnames(wagscreen$ll)

for (i in 1:ncol(wagscreen$ll)) {

    gotmp <- golist[[i]]
    gotmp <- gotmp[order(gotmp$term_description), ]

    gomat[which(rownames(gomat) %in% golist[[i]]$term_description), i] <-
        golist[[i]][which(golist[[i]]$term_description %in% rownames(gomat)), 4]

}

if (nrow(gomat) > 20) {
    rownames(gomat) <- NULL
}

HeatmapOP(gomat,
          bordercol = "transparent",
          main = "", sub = "",
          xrot = 45, col = "RdYlBu", breaks = 100)

## ----fig.width = 12, fig.height = 3, fig.cap = fig.cap15----------------------
data(sameith_GO)

golist2 <- sameith_GO$golist

goterms <- character()

for (i in 1:length(golist2)) {

    goterms <-
        c(goterms,
          golist2[[i]]$term_description[which(golist2[[i]]$pvalue_fdr < 0.1)])

}

gomat <- matrix(NA, length(unique(goterms)), ncol(samscreen$ll))

rownames(gomat) <- sort(unique(goterms))
colnames(gomat) <- colnames(samscreen$ll)

for (i in 1:ncol(samscreen$ll)) {

    gotmp <- golist2[[i]]
    gotmp <- gotmp[order(gotmp$term_description), ]

    gomat[which(rownames(gomat) %in% golist2[[i]]$term_description), i] <-
        golist2[[i]][which(golist2[[i]]$term_description %in%
                           rownames(gomat)), 4]

}

if (nrow(gomat) > 20) {
    rownames(gomat) <- NULL
}

colnames(gomat) <- tolower(colnames(gomat))

HeatmapOP(gomat,
          bordercol = "transparent",
          main = "", sub = "",
          xrot = 45, cexCol = 0.5, col = "RdYlBu", breaks = 100)

## ----fig.height = 7, fig.width = 14, fig.cap = fig.cap16----------------------
gos <- unique(wageningen_GO$gos)

egenego <- wageningen_GO$egenego

gomat <- array(NA, c(length(gos), nrow(wagscreen$ll), ncol(wagscreen$ll)))

rownames(gomat) <- sort(gos)

colnames(gomat) <- rownames(wagscreen$ll)

dimnames(gomat)[[3]] <- colnames(wagscreen$ll)

for (i in 1:length(wagscreen$targets)) {
    if (length(wagscreen$targets[[i]]) == 0) { next() }
    for (j in 1:length(wagscreen$targets[[i]])) {
        if (dim(egenego[[i]][[j]])[1] > 0) {
            gomat[which(rownames(gomat) %in%
                        egenego[[i]][[j]]$term_description),
                  which(dimnames(gomat)[[2]] %in%
                        names(wagscreen$targets[[i]])[j]), i] <-
                egenego[[i]][[j]]$pvalue_fdr[
                                     order(egenego[[i]][[j]]$term_description)]
        }
    }
}

gomat <- apply(gomat, c(1,2), mean, na.rm = TRUE)

gomat <- gomat[order(apply(gomat, 1, function(x)
    return(sum(is.na(x) == FALSE)))), ]

gomat <- gomat[, rev(order(apply(gomat, 2, function(x)
    return(sum(is.na(x) == FALSE)))))]

gomat <- gomat[, which(apply(gomat, 2,
                             function(x) return(any(is.na(x) == FALSE))))]

HeatmapOP(gomat, xrot = 45, Colv = FALSE, Rowv = FALSE,
          col = "RdYlBu", main = "", sub = "", breaks = 100)

## ----fig.height = 9, fig.width = 16, fig.cap = fig.cap17----------------------
gos2 <- unique(sameith_GO$gos)

egenego2 <- sameith_GO$egenego

gomat <- array(NA, c(length(gos2), nrow(samscreen$ll), ncol(samscreen$ll)))

rownames(gomat) <- sort(gos2)

colnames(gomat) <- rownames(samscreen$ll)

dimnames(gomat)[[3]] <- colnames(samscreen$ll)

for (i in 1:length(samscreen$targets)) {
    if (length(samscreen$targets[[i]]) == 0) { next() }
    for (j in 1:length(samscreen$targets[[i]])) {
        if (dim(egenego2[[i]][[j]])[1] > 0) {
            gomat[which(rownames(gomat) %in%
                        egenego2[[i]][[j]]$term_description),
                  which(dimnames(gomat)[[2]] %in%
                        names(samscreen$targets[[i]])[j]), i] <-
                egenego2[[i]][[j]]$pvalue_fdr[
                                      order(
                                          egenego2[[i]][[j]]$term_description)]
        }
    }
}

gomat <- apply(gomat, c(1,2), mean, na.rm = TRUE)

gomat <- gomat[order(apply(gomat, 1, function(x)
    return(sum(is.na(x) == FALSE)))), ]

gomat <- gomat[, rev(order(apply(gomat, 2, function(x)
    return(sum(is.na(x) == FALSE)))))]

gomat <- gomat[, which(apply(gomat, 2,
                             function(x) return(any(is.na(x) == FALSE))))]

colnames(gomat) <- tolower(colnames(gomat))

HeatmapOP(gomat, xrot = 45, Colv = FALSE, Rowv = FALSE,
          col = "RdYlBu", main = "", sub = "", breaks = 100)

## ----eval=FALSE---------------------------------------------------------------
# ###### simulation:
# 
# ## install_github("MartinFXP/B-NEM"); library(bnem)
# 
# library(nem)
# 
# library(minet)
# 
# library(pcalg)
# 
# runs <- 100
# 
# noiselvls <- c(0.01, 0.025, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5)
# 
# random <- list(FPrate = 0.1, FNrate = noiselvls,
#                single = 4, double = 1, reporters = 100, replicates = 3)
# 
# do <- c("n", "p", "a", "e", "b")
# 
# maxTime <- FALSE
# 
# forcelogic <- TRUE
# 
# epinemsearch <- "greedy"
# 
# nIterations <- 3
# 
# bnemsearch <- "genetic"
# 
# simresults <- SimEpiNEM(runs, do, random, maxTime, forcelogic,
# epinemsearch, bnemsearch, nIterations)
# 
# sim <- simresults
# 
# ###### yeast van Wageningen et al.:
# 
# file <- paste("http://www.holstegelab.nl/",
#               "publications/sv/signaling_redundancy/downloads/DataS1.txt",
#               sep = "")
# 
# data <- read.delim(file)
# 
# dataM <- data[-(1), (1+(1:(324/2))*2)]
# 
# dataP <- data[-(1), (2+(1:(324/2))*2)]
# 
# data[, 2] <- as.character(data[, 2])
# 
# rndup <- which(duplicated(data[, 2]) == TRUE)
# 
# data[rndup, 2] <- paste(data[rndup, 2], "_dup", sep = "")
# 
# rownames(dataM) <- rownames(dataP) <- data[2:nrow(data), 2]
# 
# dataM <- dataM[-1, ]
# 
# dataP <- dataP[-1, ]
# 
# dataM <- apply(dataM, c(1,2), as.numeric)
# 
# dataP <- apply(dataP, c(1,2), as.numeric)
# 
# dataBin <- dataM
# 
# sig <- 0.05
# 
# cutoff <- log2(1.7)
# 
# dataBin[which(dataP < sig & dataP > 0 & abs(dataM) >= cutoff)] <- 1
# 
# dataBin[which(dataP >= sig | dataP == 0 | abs(dataM) < cutoff)] <- 0
# 
# dataBin <- dataBin[-which(apply(dataBin, 1, max) == 0), ]
# 
# dataBinWag <- dataBin
# 
# colnames(dataBin) <- gsub(".del.vs..wt", "", colnames(dataBin))
# 
# colnames(dataBin) <- gsub(".del", "", colnames(dataBin))
# 
# doubles <- colnames(dataBin)[grep("\\.", colnames(dataBin))]
# 
# if (length(grep("vs", doubles)) > 0) {
#     doubles <- sort(doubles[-grep("vs", doubles)])
# } else { doubles <- sort(doubles) }
# 
# doubles.genes <- unique(unlist(strsplit(doubles, "\\.")))
# 
# if (length(grep("\\.", colnames(dataBin))) > 0) {
#     singles <- colnames(dataBin)[-grep("\\.", colnames(dataBin))]
# } else { singles <- sort(singles) }
# 
# singles <- unique(sort(singles))
# 
# wagscreen <- epiScreen(dataBin[, -grep("fus3\\.|ptp2.ptc2", colnames(dataBin))])
# 
# wagscreen$dataWag <- dataBin[, -grep("fus3.|ptp2.ptc2", colnames(dataBin))]
# 
# ###### yeast Sameith et al.:
# 
# file <- paste("http://www.holstegelab.nl/",
#               "publications/GSTF_geneticinteractions/",
#               "downloads/del_mutants_limma.txt", sep = "")
# 
# data <- read.delim(file)
# 
# data <- apply(data, c(1,2), as.character)
# 
# dataM <- data[-1, which(data[1, ] %in% "M")]
# 
# dataM <- apply(dataM, c(1,2), as.numeric)
# 
# dataP <- data[-1, which(data[1, ] %in% "p.value")]
# 
# dataP <- apply(dataP, c(1,2), as.numeric)
# 
# rownames(dataM) <- rownames(dataP) <- data[2:nrow(data), 1]
# 
# dataBin <- dataM
# 
# sig <- 0.01
# 
# cutoff <- log2(1.5)
# 
# dataBin[which(dataP < sig & dataP > 0 & abs(dataM) >= cutoff)] <- 1
# 
# dataBin[which(dataP >= sig | dataP == 0 | abs(dataM) < cutoff)] <- 0
# 
# dataBin <- dataBin[-which(apply(dataBin, 1, max) == 0), ]
# 
# colnames(dataBin) <- gsub("\\.\\.\\.", "\\.", colnames(dataBin))
# 
# doubles <- colnames(dataBin)[grep("\\.", colnames(dataBin))]
# 
# if (length(grep("vs", doubles)) > 0) {
#     doubles <- sort(doubles[-grep("vs", doubles)])
# } else { doubles <- sort(doubles) }
# 
# doubles.genes <- unique(unlist(strsplit(doubles, "\\.")))
# 
# if (length(grep("\\.", colnames(dataBin))) > 0) {
#     singles <- colnames(dataBin)[-grep("\\.", colnames(dataBin))]
# } else { singles <- sort(singles) }
# 
# singles <- unique(sort(singles))
# 
# samscreen <- epiScreen(dataBin)
# 
# samscreen$dataSam <- dataBin
# 
# ## String-db interaction scores:
# 
# library(STRINGdb)
# 
# get_STRING_species(version="10", species_name=NULL)[26, ] # 4932
# 
# string_db <- STRINGdb$new( version="10", species=4932, score_threshold=0,
#                           input_directory="")
# 
# llmat <- wagscreen$ll
# 
# logicmat <- wagscreen$logic
# 
# string.scores <- list()
# 
# string.names <- character()
# 
# for (i in 1:ncol(llmat)) {
#     if (sum(!(llmat[, i] %in% c(0,-Inf))) > 0) {
#         top30 <- llmat[, i]
#         top30[which(top30 == 0)] <- -Inf
#         top30 <- top30[which(!(llmat[, i] %in% c(0,-Inf)))]
#         top30 <- top30[order(top30,decreasing = TRUE)[1:min(30, sum(!(llmat[, i]
#             %in% c(0,-Inf))))]]
# 
#         doubles <- unlist(strsplit(colnames(llmat)[i], "\\."))
# 
#         for (j in names(top30)) {
#             tmp <- string_db$get_interactions(string_db$mp(c(doubles[1], j)))
#             string.scores <- c(string.scores, tmp$combined_score)
#             string.names <- c(string.names, paste(sort(c(doubles[1], j)),
#                                                   collapse = "_"))
#             tmp <- string_db$get_interactions(string_db$mp(c(doubles[2], j)))
#             string.scores <- c(string.scores, tmp$combined_score)
#             string.names <- c(string.names, paste(sort(c(doubles[2], j)),
#                                                   collapse = "_"))
#         }
# 
#     } else {
#         next()
#     }
# }
# 
# 
# llmat <- samscreen$ll
# 
# logicmat <- samscreen$logic
# 
# string.scores2 <- list()
# 
# string.names2 <- character()
# 
# for (i in 1:ncol(llmat)) {
# 
#     if (sum(!(llmat[, i] %in% c(0,-Inf))) > 0) {
#         top30 <- llmat[, i]
#         top30[which(top30 == 0)] <- -Inf
#         top30 <- top30[which(!(llmat[, i] %in% c(0,-Inf)))]
#         top30 <- top30[order(top30, decreasing = TRUE)
#                        [1:min(30, sum(!(llmat[, i] %in% c(0,-Inf))))]]
# 
#         doubles <- unlist(strsplit(colnames(llmat)[i], "\\."))
# 
#         for (j in names(top30)) {
#             tmp <- string_db$get_interactions(string_db$mp(c(doubles[1], j)))
#             string.scores2 <- c(string.scores2, tmp$combined_score)
#             string.names2 <- c(string.names2, paste(sort(c(doubles[1], j)),
#                                                     collapse = "_"))
#             tmp <- string_db$get_interactions(string_db$mp(c(doubles[2], j)))
#             string.scores2 <- c(string.scores2, tmp$combined_score)
#             string.names2 <- c(string.names2, paste(sort(c(doubles[2], j)),
#                                                     collapse = "_"))
#         }
# 
#     } else {
#         next()
#     }
# 
# }
# 
# ## graph based GO similarity scores:
# 
# library(GOSemSim)
# library(AnnotationHub)
# library(org.Sc.sgd.db)
# 
# ystGO <- godata("org.Sc.sgd.db", ont = "BP",
#                 keytype = keytypes(org.Sc.sgd.db)[11], computeIC = FALSE)
# 
# ## van Wageningen et al.:
# 
# GOepi <- numeric()
# 
# for (i in 1:ncol(wagscreen$ll)) {
#     if (i %in% grep("fus3|ptp2.ptc2", colnames(wagscreen$ll))) { next() }
#     pair <- toupper(unlist(strsplit(colnames(wagscreen$ll)[i], "\\.")))
#     for (j in which(!is.infinite(wagscreen$ll[, i]) == TRUE &
#                     wagscreen$ll[, i] != 0)) {
#         tmp <- clusterSim(pair, toupper(rownames(wagscreen$ll)[j]),
#                        semData = ystGO, combine = "max")
#         if (!is.na(tmp[1])) {
#             GOepi <- c(GOepi, tmp)
#         }
#     }
# }
# 
# GOall <- numeric()
# 
# for (i in colnames(wagscreen$ll)) {
#     pair <- toupper(unlist(strsplit(i, "\\.")))
#     for (j in rownames(wagscreen$ll)) {
#         tmp <- clusterSim(pair, toupper(j), semData = ystGO, combine = "max")
#         if (!is.na(tmp[1])) {
#             GOall <- c(GOall, tmp)
#         }
#     }
# }
# 
# ## Sameith et al.:
# 
# GOepi2 <- numeric()
# 
# for (i in 1:ncol(samscreen$ll)) {
#     if (i %in% grep("fus3|ptp2.ptc2", colnames(samscreen$ll))) { next() }
#     pair <- toupper(unlist(strsplit(colnames(samscreen$ll)[i], "\\.")))
#     for (j in which(!is.infinite(samscreen$ll[, i]) == TRUE &
#                     samscreen$ll[, i] != 0)) {
#         tmp <- clusterSim(pair, toupper(rownames(samscreen$ll)[j]),
#                        semData = ystGO, combine = "max")
#         if (!is.na(tmp[1])) {
#             GOepi2 <- c(GOepi2, tmp)
#         }
#     }
# }
# 
# GOall2 <- numeric()
# 
# for (i in colnames(samscreen$ll)) {
#     pair <- toupper(unlist(strsplit(i, "\\.")))
#     for (j in rownames(samscreen$ll)) {
#         tmp <- clusterSim(pair, toupper(j), semData = ystGO, combine = "max")
#         if (!is.na(tmp[1])) {
#             GOall2 <- c(GOall2, tmp)
#         }
#     }
# }
# 
# ###### Go enrichment analysis:
# 
# ## van Wageningen et al.:
# 
# string_db$set_background(
#     string_db$mp(unique(c(unlist(strsplit(colnames(wagscreen$ll), "\\.")),
#                           rownames(wagscreen$ll)))))
# 
# golist <- list()
# 
# for (i in 1:ncol(wagscreen$ll)) {
#     golist[[i]] <- string_db$get_enrichment(string_db$mp(unique(
#         c(unlist(strsplit(colnames(wagscreen$ll)[i], "\\.")),
#           rownames(wagscreen$ll)[which(!(wagscreen$logic[, i] %in%
#                                          c("NOINFO", "NOEPI")))]))),
#         category = "KEGG", methodMT = "fdr", iea = TRUE)
# }
# 
# string_db$set_background(string_db$mp(rownames(wagscreen$dataWag)))
# 
# egenego <- list()
# 
# gos <- character()
# 
# for (i in 1:length(wagscreen$targets)) {
#     egenego[[i]] <- list()
#     if (length(wagscreen$targets[[i]]) == 0) { next() }
#     for (j in 1:length(wagscreen$targets[[i]])) {
#         egenego[[i]][[j]] <- string_db$get_enrichment(
#             string_db$mp(wagscreen$targets[[i]][[j]]),
#             category = "KEGG", methodMT = "fdr", iea = TRUE)
#         if (dim(egenego[[i]][[j]])[1] > 0) {
#             gos <- c(gos, egenego[[i]][[j]]$term_description)
#         }
#     }
# }
# ## Sameith et al.:
# 
# string_db$set_background(string_db$mp(unique(c(unlist(
#     strsplit(colnames(samscreen$ll), "\\.")), rownames(samscreen$ll)))))
# 
# golist2 <- list()
# 
# for (i in 1:ncol(samscreen$ll)) {
#     golist2[[i]] <- string_db$get_enrichment(string_db$mp(
#         unique(c(unlist(strsplit(colnames(samscreen$ll)[i], "\\.")),
#                  rownames(samscreen$ll)
#                  [which(!(samscreen$logic[, i] %in% c("NOINFO", "NOEPI")))]))),
#         category = "KEGG", methodMT = "fdr", iea = TRUE)
# }
# 
# string_db$set_background(string_db$mp(rownames(samscreen$dataWag)))
# 
# egenego2 <- list()
# 
# gos2 <- character()
# 
# for (i in 1:length(samscreen$targets)) {
#     egenego2[[i]] <- list()
#     if (length(samscreen$targets[[i]]) == 0) { next() }
#     for (j in 1:length(samscreen$targets[[i]])) {
#         egenego2[[i]][[j]] <- string_db$get_enrichment(
#             string_db$mp(samscreen$targets[[i]][[j]]),
#             category = "KEGG", methodMT = "fdr", iea = TRUE)
#         if (dim(egenego2[[i]][[j]])[1] > 0) {
#             gos2 <- c(gos2, egenego2[[i]][[j]]$term_description)
#         }
#     }
# }

## -----------------------------------------------------------------------------
sessionInfo()

