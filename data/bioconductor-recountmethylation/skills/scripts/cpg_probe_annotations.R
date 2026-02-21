# Code example from 'cpg_probe_annotations' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
libv <- c("minfi", "minfiData", "minfiDataEPIC", "ggplot2")
sapply(libv, library, character.only = TRUE)

## -----------------------------------------------------------------------------
rg <- get(data("RGsetEx"))
man <- as.data.frame(getAnnotation(rg))
colnames(man)

## -----------------------------------------------------------------------------
rg.epic <- get(data("RGsetEPIC"))
man.epic <- as.data.frame(getAnnotation(rg.epic))
colnames(man.epic)

## -----------------------------------------------------------------------------
getSnpInfo(rg)

## -----------------------------------------------------------------------------
gm <- preprocessRaw(rg) # make MethylSet
gms <- mapToGenome(gm) # make GenomicMethylSet
gmsf <- dropLociWithSnps(gms) # filter probes with SNPs

## -----------------------------------------------------------------------------
as.data.frame(table(man$UCSC_RefGene_Name==""))

## -----------------------------------------------------------------------------
gene.str <- "ARID1A" # common gene name
gene.patt <- paste0("(^|;)", gene.str, "($|;)") # regex pattern
which.gene <- which(grepl(gene.patt, man$UCSC_RefGene_Name)) # gene filter
manf <- man[which.gene,]
dim(manf)

## -----------------------------------------------------------------------------
gene.regionv <- unlist(strsplit(man$UCSC_RefGene_Group, ";"))

## -----------------------------------------------------------------------------
unique(gene.regionv)

## -----------------------------------------------------------------------------
df <- as.data.frame(table(gene.regionv)) # get group frequencies
ggplot(df, aes(x = gene.regionv, y = Freq, fill = gene.regionv)) + theme_bw() +
  geom_bar( stat = "identity") + xlab("Gene group") + ylab("Num. probes") +
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1))

## -----------------------------------------------------------------------------
# make pattern: "(^|;)5'UTR($|;)|(^|;)TSS1500($|;)|(^|;)TSS200($|;)"
prom.catv <- c("5'UTR", "TSS1500", "TSS200")
prom.patt <- paste0("(^|;)", prom.catv, "($|;)", collapse = "|")
# use regex to detect promoter-mapping probes
man$promoter <- ifelse(grepl(prom.patt, man$UCSC_RefGene_Group),
                       TRUE, FALSE)
as.data.frame(table(man$promoter))

## -----------------------------------------------------------------------------
# make pattern: "(^|;)Body($|;)|(^|;)3'UTR($|;)"
body.catv <- c("Body", "3'UTR")
body.patt <- paste0("(^|;)", body.catv, "($|;)", collapse = "|")
# use regex to detect body-mapping probes
man$gene_body <- ifelse(grepl(body.patt, man$UCSC_RefGene_Group),
                       TRUE, FALSE)
table(man$gene_body)

## ----eval = FALSE-------------------------------------------------------------
# dfp <- as.data.frame(table(man$gene_body, man$promoter))
# dfp$region <- c("intergenic", "body-only", "promoter-only", "body-and-promoter")
# ggplot(dfp, aes(x = region, y = Freq, fill = region)) + theme_bw() +
#   geom_bar( stat = "identity") + xlab("Gene region") + ylab("Num. probes") +
#   theme(legend.position = "none",
#         axis.text.x = element_text(angle = 45, hjust = 1))

## -----------------------------------------------------------------------------
unique(man$Relation_to_Island)

## ----eval = FALSE-------------------------------------------------------------
# dfp <- as.data.frame(table(man$Relation_to_Island))
# ggplot(dfp, aes(x = Var1, y = Freq, fill = Var1)) + theme_bw() +
#   geom_bar(stat = "identity") + xlab("Relation_to_Island") + ylab("Num. probes") +
#   theme(legend.position = "none",
#         axis.text.x = element_text(angle = 45, hjust = 1))

## -----------------------------------------------------------------------------
dfp <- as.data.frame(table(man$Relation_to_Island, man$UCSC_RefGene_Name==""))
dfp$region <- paste0(dfp$Var1," ; ", c(rep("genic", 6), rep("intergenic", 6)))
ggplot(dfp, aes(x = region, y = Freq, fill = Var1)) + theme_bw() +
  geom_bar(stat = "identity") + xlab("Relation_to_Island;Genic_status") + 
  ylab("Num. probes") +
  theme(legend.position = "none", 
        axis.text.x = element_text(angle = 45, hjust = 1))

