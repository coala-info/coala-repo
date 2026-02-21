# Code example from 'FamAgg' vignette. See references/ for full tutorial.

## ----echo = FALSE, results = "hide"-------------------------------------------
isWindows <- .Platform$OS.type != "unix"
library(FamAgg)
library(BiocStyle)

## ----libraries, warning = FALSE, message = FALSE------------------------------
library(FamAgg)

data(minnbreast)
## Subsetting to only few families of the whole data set.
mbsub <- minnbreast[minnbreast$famid %in% 4:14, ]
mbped <- mbsub[, c("famid", "id", "fatherid", "motherid", "sex")]
## Renaming column names.
colnames(mbped) <- c("family", "id", "father", "mother", "sex")
## Defining the optional argument age.
endage <- mbsub$endage
names(endage) <- mbsub$id
## Create the object.
fad <- FAData(pedigree = mbped, age = endage)

## ----access-data--------------------------------------------------------------
## Use the pedigree method to access the full pedigree
## data.frame,
head(pedigree(fad))

## or access individual columns using $.
## The ID of the father (0 representing "founders"):
head(fad$father)
## Mother:
head(fad$mother)
## Sex:
head(fad$sex)

## We can also access the age of each individual, if
## provided.
head(age(fad))

## ----family-------------------------------------------------------------------
## Extract the pedigree information from family "4"...
nrow(family(fad, family = 4))

head(family(fad, family = 4))

## ...which is the same as extracting the family pedigree
## for an individual of this family.
head(family(fad, id = 3))

## Note that IDs are internally always converted to character,
## thus, using id=3 and id="3" return the same information.
head(family(fad, id = "3"))

## ----subsetting---------------------------------------------------------------
## Subset the object to a single family.
fam4 <- fad[fad$family == "4", ]
table(fam4$family)

## ----plotPed, message=FALSE, fig.align='center', warning = FALSE--------------
switchPlotfun("ks2paint")
## By supplying device="plot", we specify that we wish to visualize the
## pedigree in an R plot. This is the default for "ks2paint", anyway.
plotPed(fad, id = 3, device = "plot")

## ----buildPed, message = FALSE------------------------------------------------
## Build the pedigree for individual 3.
fullPed <- buildPed(fad, id = "3")
nrow(fullPed)

## ----buildPed-prune, message = FALSE------------------------------------------
## Find the subpedigree for individuals 21, 22 and 17.
buildPed(fad, id = c(21, 22, 17), prune = TRUE)

## ----plotPed-3ids, message=FALSE, fig.align='center', warning = FALSE---------
plotPed(fad, id = c(21, 22, 17), prune = TRUE)

## ----plotPed-family-14, message=FALSE, fig.align='center', warning = FALSE----
plotPed(fad, family = "14", cex = 0.4)

## ----buildPed-for-individual, message = FALSE---------------------------------
## Check if we have individual 26064 from the second branch in the pedigree
## of individual 440.
any(buildPed(fad, id = "440")$id == "26064")

## What for the pedigree of 447?
any(buildPed(fad, id = "447")$id == "26064")

## ----findFounders, message = FALSE--------------------------------------------
## Find founders for family 4.
findFounders(fad, "4")

## ----getCommonAncestors, message = FALSE--------------------------------------
## Find the closest common ancestor.
getCommonAncestor(fad, id = c(21, 22, 17))

## ----getChildren-and-others, message = FALSE----------------------------------
## Get the children of ID 4.
getChildren(fad, id = "4", max.generations = 1)

## Get the offsprings.
getChildren(fad, id = "4")

## Get all ancestors.
getAncestors(fad, id = "4")

## Get the siblings.
getSiblings(fad, id = c("4"))

## ----affected-founders, message = FALSE---------------------------------------
## Add the trait information to the FAData object.
cancer <- mbsub$cancer
names(cancer) <- as.character(mbsub$id)
trait(fad) <- cancer

## Identify the affected founders.
## First all affected individuals.
affIds <- affectedIndividuals(fad)
## Identify founders for each family.
founders <- lapply(unique(fad$family), function(z){
    return(findFounders(fad, family = z))
})
names(founders) <- unique(fad$family)

## Track the affected founder.
affFounders <- lapply(founders, function(z){
    return(z[z %in% affIds])
})
## Interestingly, not all founders are affected! It seems in some cases
## parents of the affected participants in the screening phase have also
## been included.
affFounders <- affFounders[unlist(lapply(affFounders, length)) > 0]

## The number of families analyzed.
length(founders)

## The number of families with affected founder.
length(affFounders)


## ----affected-for-founders, message = FALSE-----------------------------------
kin2affFounders <- shareKinship(fad, unlist(affFounders))

## How many of these are affected?
sum(kin2affFounders %in% affIds)

## How many affected are not related to an affected founder?
sum(!(affIds %in% kin2affFounders))


## ----shareKinship, message = FALSE--------------------------------------------
## Get all individuals sharing kinship with individual 4.
shareKinship(fad, id = "4")

## ----shareKinshipRm, message = FALSE------------------------------------------
## Get all individuals sharing kinship with individual 4, but only with kinship
## higher than 0.125 (exclude first cousins, grand children, great grand
## parents etc, i.e. everybody with kinship 0.125 or lower)
shareKinship(fad, id = "4", rmKinship = 0.125)

## ----estimageGenerations, message = FALSE-------------------------------------
## Estimate generation levels for all families.
estimateGenerations(fad)[1:3]

## ----generationsFrom, message = FALSE-----------------------------------------
gens <- generationsFrom(fad, id = "4")

## ----plotPed-with-generations, message=FALSE, fig.align='center', warning = FALSE----
plotPed(fad, family = 4, label2 = gens)

## ----set-trait, results='hide', message=FALSE---------------------------------
## Extract the cancer trait information.
tcancer <- mbsub$cancer
names(tcancer) <- mbsub$id
## Set the trait.
trait(fad) <- tcancer


## ----affectedIndividuals, message = FALSE-------------------------------------
## Extract the trait information.
head(trait(fad))

## We can also extract the IDs of the affected individuals.
head(affectedIndividuals(fad))

## Or the IDs of the phenotyped individuals.
head(phenotypedIndividuals(fad))

## ----plotPed-with-trait, message=FALSE, fig.align='center', warning = FALSE----
## Plotting the pedigree for family "9".
plotPed(fad, family = "9")

## ----plotPed-trait-highlight, message=FALSE, fig.align='center', warning = FALSE----
## Plotting the pedigree for family "9".
plotPed(fad, family = "9", highlight.ids = list(a = c("185", "201", "198"),
						b = c("193")))

## ----ped2graph, message = FALSE-----------------------------------------------
## Transform the full pedigree to a graph.
fullGraph <- ped2graph(pedigree(fad))

## In addition, build the graph for a single family.
singleFam <- ped2graph(family(fad, family=4))

## ----plot-igraph, fig.align='center', message = FALSE, fig.cap = "Pedigrees represented as graphs."----
## Build the layout.
plot(fullGraph)
lay <- layout_(singleFam, on_grid())
plot(singleFam, layout = lay)

## ----connectedSubgraph, message = FALSE---------------------------------------
subgr <- connectedSubgraph(singleFam, nodes = c("7", "8", "27", "17"))

## ----plot-subgraph, subgraph-plot, fig.align='center'-------------------------
## Plot the graph.
plot(subgr)
## Similar to buildPed/plotPed with prune=TRUE.
plotPed(fad, id=c("7", "8", "17", "27"), prune=TRUE)

## ----import, message=FALSE----------------------------------------------------
## Import a "ped" file.
pedFile <- system.file("txt/minnbreastsub.ped.gz", package = "FamAgg")
## Quick glance at the file.
readLines(pedFile, n = 1)
fad <- FAData(pedFile)

head(pedigree(fad))


## ----import-generic, message=FALSE--------------------------------------------
## Create the FAData by reading data from a txt file.
pedFile <- system.file("txt/minnbreastsub.txt", package = "FamAgg")
fad <- FAData(pedigree = pedFile, header = TRUE, id.col = "id",
	      family.col = "famid", father.col = "fatherid",
	      mother.col = "motherid")


## ----export-------------------------------------------------------------------
tmpF <- tempfile()

## Subset the pedigree to family 4
fam4 <- fad[fad$family == 4, ]

## Export data in ped format.
export(fam4, tmpF, format = "ped")

## ----famagg-setup, warning=TRUE, message=FALSE--------------------------------
library(FamAgg)
set.seed(18011977)
data(minnbreast)
## Subset the dataset to reduce processing time.
mbsub <- minnbreast[minnbreast$famid %in% c(4:100, 173, 432), ]
## Uncomment the line below to use the whole dataset instead.
## mbsub <- minnbreast

## Define the number of simulations we perform.
## nsim <- 10000
nsim <- 1000

mbped <- mbsub[, c("famid", "id", "fatherid", "motherid", "sex")]
## Renaming column names.
colnames(mbped) <- c("family", "id", "father", "mother", "sex")
## Create the FAData object.
fad <- FAData(pedigree = mbped)

## Define the trait.
tcancer <- mbsub$cancer
names(tcancer) <- as.character(mbsub$id)

## ----gif, warning=FALSE, message=FALSE----------------------------------------
## Calculate the genealogical index of familiality.
gi <- genealogicalIndexTest(fad, trait = tcancer,
			    traitName = "cancer", nsim = nsim)

## Display the result.
result(gi)

## ----gif-2, warning=FALSE, eval=FALSE-----------------------------------------
# ## Calculate the genealogical index of familiality using random sampling from
# ## a sex matched control set.
# giSexMatch <- genealogicalIndexTest(fad, trait = tcancer,
# 				    traitName = "cancer", nsim = nsim,
# 				    controlSetMethod = "getSexMatched")
# 
# ## Use an external vector to perform the matching.
# ## The results are essentially identical.
# giExtMatch <- genealogicalIndexTest(fad, trait = tcancer,
# 				    traitName = "cancer", nsim = nsim,
# 				    controlSetMethod = "getExternalMatched",
# 				    match.using = fad$sex)

## ----gif-3, message=FALSE-----------------------------------------------------
## Evaluate the proportion of male and femal cases.
table(gi$sex[affectedIndividuals(gi)])

## We can use the gender information to perform stratified sampling, i.e.
## in each permutation a random set of 3 male and 15 females will be selected.
giStrata <- genealogicalIndexTest(fad, trait = tcancer,
				  traitName = "cancer", nsim = nsim,
				  strata = fad$sex)

result(giStrata)

## ----gif-4-plot, mbreast-genealogical-index-result, message=FALSE, warning=FALSE, fig.align='center'----
## Plot the result.
plotRes(giStrata)

## ----gif-gap, message=FALSE---------------------------------------------------
library(gap)

## Adding the trait information, so the extracted pedigree data.frame will
## also contain a column "affected" with that information.
trait(fad) <- tcancer

## Extract the pedigree and re-format it for the gif function.
pedi <- pedigree(fad)
## Remove singletons.
pedi <- removeSingletons(pedi)
pedi[is.na(pedi$father), "father"] <- 0
pedi[is.na(pedi$mother), "mother"] <- 0

## Identify the affected individuals.
affIds <- as.numeric(pedi$id[which(pedi$affected == 1)])

## Execute the gif method contained in the gap package.
gifRes <- gif(pedi[, c("id", "father", "mother")], affIds)

## Calculate the GIF using FamAgg's genealogicalIndexTest.
gifT <- genealogicalIndexTest(fad, trait = tcancer, nsim = 100)

## Comparing the results:
all.equal( result(gifT)$genealogical_index,  gifRes[[1]] )

## ----gif-5, message=FALSE, warning=FALSE--------------------------------------
## Perform the analysis (no strata etc) separately for each family.
giFam <- genealogicalIndexTest(fad, trait = tcancer, nsim = nsim,
			       perFamilyTest = TRUE,
			       traitName = "Cancer")

## Display the result from the analysis.
head(result(giFam))

## ----fir-1, warning=FALSE, message = FALSE------------------------------------
## Estimate the risk for each individual using the familial incidence
## rate method. We use the "endage" provided in the Minnesota Breast Cancer
## Record as a measure for time at risk.
fr <- familialIncidenceRate(fad, trait = tcancer, timeAtRisk = mbsub$endage)


## ----fir-2, mbreast-mean-fr-per-family, message=FALSE, warning=FALSE, fig.align='center'----
## Split the FIR by family and average the values within each.
frFam <- split(fr, f = fad$family)
frFamAvg <- lapply(frFam, mean, na.rm = TRUE)

## Sort and plot the averages.
frFamAvg <- sort(unlist(frFamAvg), decreasing = TRUE)
plot(frFamAvg, type = "h", xaxt = "n", xlab = "", ylab = "mean FIR",
     main = "Per family averaged familial incidence rate")
axis(side = 1, las = 2, at = 1:length(frFamAvg), label = names(frFamAvg))


## ----fir-3, warning=FALSE, message=FALSE--------------------------------------
## Estimate the risk for each individual using the familial incidence
## rate method. We use the endage provided in the Minnesota Breast Cancer
## Record as a measure for time at risk.
frTest <- familialIncidenceRateTest(fad, trait = tcancer,
				    traitName = "cancer",
				    timeAtRisk = mbsub$endage,
				    nsim = nsim)


## ----fir-4--------------------------------------------------------------------
head(familialIncidenceRate(frTest))
head(frTest$fir)


## ----fir-5--------------------------------------------------------------------
head(result(frTest))


## ----fir-6--------------------------------------------------------------------
frRes <- result(frTest)
frSig <- frRes[which(frRes$padj < 0.05), ]

## Split by family.
frFam <- split(frSig, frSig$family)
frRes <- data.frame(family = names(frFam),
		    no_sign_fir = unlist(lapply(frFam, nrow)))
## Determine the number of phenotyped and affected individuals per family.
noPheNAff <- sapply(names(frFam), function(z){
    fam <- family(frTest, family = z)
    return(c(no_pheno = sum(!is.na(fam$affected)),
	     no_aff = length(which(fam$affected == 1))
	     ))
})
frRes <- cbind(frRes, t(noPheNAff))

## Display the number of phenotyped and affected individuals as well as
## the number of individuals within the families with a significant FIR.
frRes[order(frRes[, "no_sign_fir"], decreasing = TRUE), ]

## ----kinsum-1, message = FALSE------------------------------------------------
## Perform the kinship sum test.
kinSum <- kinshipSumTest(fad, trait = tcancer, traitName = "cancer",
			 nsim = nsim, strata = fad$sex)
head(result(kinSum))


## ----kinsum-2, message = FALSE------------------------------------------------
## Extract the IDs of the individuals with significant kinship. By default,
## the raw p-values are adjusted for multiple hypothesis testing using the
## method from Benjamini and Hochberg.
kinSumRes <- result(kinSum)
kinSumIds <- as.character(kinSumRes[kinSumRes$padj < 0.1, "affected_id"])

## From which families are these?
table(kinSumRes[kinSumIds, "family"])

## ----kinsum-3, mbreast-family-432-FIR-compared-to-others, message=FALSE, warning=FALSE, fig.align='center'----
## Get the familial ratio of the significant in this family, of all in
## this family, and of all others.
famId <- kinSumRes[1, "family"]

## Extract the family.
fam <- family(kinSum, family = famId)

## Stratify individuals in affected/unaffected.
strat <- rep("All, unaff.", length(kinSum$id))
strat[which(kinSum$affected > 0)] <- "All, aff."
strat[kinSum$id %in% fam$id] <- paste0("Fam ", famId, ", unaff.")
strat[kinSum$id %in% fam$id[which(fam$affected > 0)]] <-
    paste0("Fam ",famId,", aff.")

famData <- data.frame(fr = fr, group = strat)
boxplot(fr~group, data = famData, na.rm = TRUE, ylab = "FIR",
	col = rep(c("#FBB4AE", "#B3CDE3"), 2))


## ----kinsum-4, mbreast-family-432-affected, message=FALSE, warning=FALSE, fig.align='center'----
## Plot the pedigree for the family of the selected individual removing
## all individuals that were not phenotypes.
plotPed(kinSum, id = kinSumIds[1], cex = 0.3, only.phenotyped = TRUE)



## ----kinsum-5, mbreast-family-432-affecte-res, message=FALSE, warning=FALSE, fig.align='center'----
plotRes(kinSum, id = kinSumIds[1])

## ----kingroup-1, message=FALSE------------------------------------------------
## Calculate the kinship test.
kinGroup <- kinshipGroupTest(fad, trait = tcancer,
			     traitName = "cancer",
			     nsim = nsim, strata = fad$sex)
head(result(kinGroup))


## ----kingroup-2, message = FALSE----------------------------------------------
kinGroupRes <- result(kinGroup)
## Create a data.frame with the summarized results.
resTab <- data.frame(total_families = length(unique(kinGroup$family)),
		     ratio_sign = length(unique(
			 kinGroupRes[kinGroupRes$ratio_padj < 0.05, "family"]
		     )),
		     kinship_sign = length(unique(
			 kinGroupRes[kinGroupRes$kinship_padj < 0.05, "family"]
		     ))
		     )
resTab

## ----kingroup-3, mbreast-family-432-affecte-res-kinship, message=FALSE, warning=FALSE, fig.align='center'----
plotPed(kinGroup, id = kinGroupRes[kinGroupRes$family == "432",
				   "group_id"][1],
	prune = TRUE, label1 = fr)

## ----bintest-1, message = FALSE-----------------------------------------------
binRes <- binomialTest(fad, trait = tcancer, traitName = "Cancer")

binResTab <- result(binRes)
head(binResTab)

## ----bintest-2, message = FALSE-----------------------------------------------
## Set the trait status to NA for all male individuals.
tcancer[fad$sex == "M" | is.na(fad$sex)] <- NA

## Perform the test providing also the population probability
binRes <- binomialTest(fad, trait = tcancer, prob = 1/8)

binResTab <- result(binRes)
head(binResTab)

## ----bintest-3, message = FALSE, fig.align = "center", fig.pos = "h!"---------
plotPed(binRes, family = 173)

