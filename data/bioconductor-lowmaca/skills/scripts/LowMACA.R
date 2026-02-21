# Code example from 'LowMACA' vignette. See references/ for full tutorial.

## ---- echo=TRUE , eval=FALSE , results="hide" , message=FALSE , warning=FALSE----
#  #Given a LowMACA object 'lm'
#  lm <- newLowMACA(genes=c("TP53" , "TP63" , "TP73"))
#  lmParams(lm)$clustal_cmd <- "/your/path/to/clustalo"

## ---- echo=TRUE , eval=TRUE,results="hide" , message=FALSE , warning=FALSE----
library(LowMACA)
#User Input
Genes <- c("ADNP","ALX1","ALX4","ARGFX","CDX4","CRX"
        ,"CUX1","CUX2","DBX2","DLX5","DMBX1","DRGX"
        ,"DUXA","ESX1","EVX2","HDX","HLX","HNF1A"
    	  ,"HOXA1","HOXA2","HOXA3","HOXA5","HOXB1","HOXB3"
			  ,"HOXD3","ISL1","ISX","LHX8")
Pfam <- "PF00046"

## ---- echo=TRUE------------------------------------------------------------
#Construct the object
lm <- newLowMACA(genes=Genes, pfam=Pfam)
str(lm , max.level=3)

## ---- echo=TRUE------------------------------------------------------------
#See default parameters
lmParams(lm)
#Change some parameters
#Accept sequences even with no mutations
lmParams(lm)$min_mutation_number <- 0
#Changing selected tumor types
#Check the available tumor types in cBioPortal
available_tumor_types <- showTumorType()
head(available_tumor_types)
#Select melanoma, stomach adenocarcinoma, uterine cancer, lung adenocarcinoma, 
#lung squamous cell carcinoma, colon rectum adenocarcinoma and breast cancer
lmParams(lm)$tumor_type <- c("skcm" , "stad" , "ucec" , "luad" 
	, "lusc" , "coadread" , "brca")

## ---- fourthchunk, echo=TRUE , eval=TRUE-----------------------------------
lm <- alignSequences(lm)

## ---- fourthchunkBis, echo=TRUE , eval=TRUE  , message=FALSE , warning=FALSE----
lm <- alignSequences(lm , mail="lowmaca@gmail.com")

## ---- fifthchunck, echo=TRUE, eval=TRUE------------------------------------
#Access to the slot alignment
myAlignment <- lmAlignment(lm)
str(myAlignment , max.level=2 , vec.len=2)

## ---- sixthchunk, echo=TRUE , eval=TRUE------------------------------------
lm <- getMutations(lm)
lm <- mapMutations(lm)

## ---- seventhchunk2, echo=TRUE,eval=TRUE-----------------------------------
#Access to the slot mutations
myMutations <- lmMutations(lm)
str(myMutations , vec.len=3 , max.level=1)

## ---- seventhchunk, echo=TRUE,eval=TRUE------------------------------------
myMutationFreqs <- myMutations$freq
#Showing the first genes
myMutationFreqs[ , 1:10]

## ---- eighthchunk, echo=TRUE , eval=FALSE , message=FALSE , warning=FALSE----
#  #Local Installation of clustalo
#  lm <- setup(lm)
#  #Web Service
#  lm <- setup(lm , mail="lowmaca@gmail.com")

## ---- ninthchunk_pre , echo=TRUE , eval=TRUE-------------------------------
#Reuse the downloaded data as a toy example
myOwnData <- myMutations$data
#How myOwnData should look like for the argument repos
str(myMutations$data , vec.len=1)
#Read the mutation data repository instead of using cgdsr package
#Following the process step by step
lm <- getMutations(lm , repos=myOwnData)
#Setup in one shot
lm <- setup(lm , repos=myOwnData)

## ---- tenthchunk, echo=TRUE , eval=TRUE------------------------------------
lm <- entropy(lm)
#Global Score
myEntropy <- lmEntropy(lm)
str(myEntropy)
#Per position score
head(myAlignment$df)

## ---- eleventhchunk, echo=TRUE---------------------------------------------
significant_muts <- lfm(lm)
#Display original mutations that formed significant clusters (column Multiple_Aln_pos)
head(significant_muts)
#What are the genes mutated in position 4 in the consensus?
genes_mutated_in_pos4 <- significant_muts[ significant_muts$Multiple_Aln_pos==4 , 'Gene_Symbol']

## ---- eleventh_2chunck , echo=TRUE-----------------------------------------
sort(table(genes_mutated_in_pos4))

## ---- echo=TRUE, eval=TRUE, results="hide"---------------------------------
bpAll(lm)

## ----  echo=TRUE, eval=TRUE, results="hide"--------------------------------
lmPlot(lm)

## ---- protterChunk, echo=TRUE, eval=TRUE, message=FALSE, warning=FALSE-----
#This plot is saved as a png image
protter(lm , filename="homeobox.png")

## ---- out.width = "400px" , echo=FALSE , eval=TRUE-------------------------
knitr::include_graphics("homeobox.png")

## ---- allPfamAnalysis, eval=TRUE-------------------------------------------
#Load Homeobox example
data(lmObj)
#Extract the data inside the object as a toy example
myData <- lmMutations(lmObj)$data
#Run allPfamAnalysis on every mutations
significant_muts <- allPfamAnalysis(repos=myData)
#Show the result of alignment based analysis
head(significant_muts$AlignedSequence)
#Show all the genes that harbor significant mutations
unique(significant_muts$AlignedSequence$Gene_Symbol)
#Show the result of the Single Gene based analysis
head(significant_muts$SingleSequence)
#Show all the genes that harbor significant mutations
unique(significant_muts$SingleSequence$Gene_Symbol)

## ---- summary, eval=FALSE , echo=TRUE--------------------------------------
#  library(LowMACA)
#  Genes <- c("ADNP","ALX1","ALX4","ARGFX","CDX4","CRX"
#  			,"CUX1","CUX2","DBX2","DLX5","DMBX1","DRGX"
#  			,"DUXA","ESX1","EVX2","HDX","HLX","HNF1A"
#  			,"HOXA1","HOXA2","HOXA3","HOXA5","HOXB1","HOXB3"
#  			,"HOXD3","ISL1","ISX","LHX8")
#  Pfam <- "PF00046"
#  lm <- newLowMACA(genes=Genes , pfam=Pfam)
#  lmParams(lm)$tumor_type <- c("skcm" , "stad" , "ucec" , "luad"
#  	, "lusc" , "coadread" , "brca")
#  lmParams(lm)$min_mutation_number <- 0
#  lm <- setup(lm , mail="lowmaca@gmail.com")
#  lm <- entropy(lm)
#  lfm(lm)
#  bpAll(lm)
#  lmPlot(lm)
#  protter(lm)

## ---- info,echo=TRUE-------------------------------------------------------
sessionInfo()

