# Code example from 'coexnet' vignette. See references/ for full tutorial.

## ------------------------------------------------------------------------
library(coexnet)

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Downloading the microarray raw data from GSE8216 study
#  # The accession number of the microarray chip related with this study is GPL2025
#  
#  getInfo(GSE = "GSE8216", GPL = "GPL2025",directory = ".")
#  
#  # Shows the actual path file with the folder, its GSE number and the .soft file
#  
#  dir()
#  

## ----eval=FALSE----------------------------------------------------------
#  
#  # Reading some GSM samples from GSE4773 study, the folder with the
#  # GSM files are called GSE1234.
#  
#  affy <- getAffy(GSE = "GSE1234",directory = system.file("extdata",package = "coexnet"))
#  affy
#  

## ----eval=FALSE----------------------------------------------------------
#  
#  # The variable affy doesn't have the CDF (Chip Definition File) information.
#  # You can include this information modifying the AffyBatch object afterwards.
#  
#  affy@cdfName <- "HG-U133_Plus_2"
#  

## ------------------------------------------------------------------------

# Create the table with the match between probesets and IDs.

gene_table <- geneSymbol(GPL = "GPL2025",directory = system.file("extdata",package = "coexnet"))

head(gene_table)


## ------------------------------------------------------------------------

# The created table have NA and empty IDs information.
# We can delete this unuseful information.

# Deletion of IDs with NA information

gene_na <- na.omit(gene_table)

# Deletion of empty IDs

final_table <- gene_na[gene_na$ID != "",]

head(final_table)


## ---- eval=FALSE---------------------------------------------------------
#  
#  # Loading gata
#  
#  if (require(affydata)) {
#    data(Dilution)
#  }
#  
#  # Loading table with probeset and gene/ID information
#  
#  data("info")
#  
#  # Calculating the expression matrix with rma
#  
#  rma <- exprMat(affy = Dilution,genes = info,NormalizeMethod = "rma",
#  SummaryMethod = "median",BatchCorrect = FALSE)
#  head(rma)

## ------------------------------------------------------------------------

# Simulated expression data

n <- 200
m <- 20

# The vector with treatment samples and control samples

t <- c(rep(0,10),rep(1,10))

# Calculating the expression values normalized

mat <- as.matrix(rexp(n, rate = 1))
norm <- t(apply(mat, 1, function(nm) rnorm(m, mean=nm, sd=1)))

# Calculating the coefficient of variation to case samples

case <- cofVar(expData = norm,complete = FALSE,treatment = t,type = "case")
head(case)

# Creating the boxplot to coefficient of variation results

boxplot(case$cv)

# Extracting the number of atipic data

length(boxplot.stats(case$cv)$out)


## ------------------------------------------------------------------------

# Calculating the coefficient of variation to whole matrix

complete <- cofVar(norm)
head(complete)

# Creating the boxplot to coefficient of variation results

boxplot(complete$cv)

# Extracting the number of atipic data

length(boxplot.stats(complete$cv)$out)


## ---- eval=FALSE---------------------------------------------------------
#  
#  # Creating a matrix with 200 genes and 20 samples
#  
#  n <- 200
#  m <- 20
#  
#  # The vector with treatment samples and control samples
#  
#  t <- c(rep(0,10),rep(1,10))
#  
#  # Calculating the expression values normalized
#  
#  mat <- as.matrix(rexp(n, rate = 1))
#  norm <- t(apply(mat, 1, function(nm) rnorm(m, mean=nm, sd=1)))
#  
#  # Running the function using the two approaches
#  
#  sam <- difExprs(expData = norm,treatment = t,fdr = 0.2,DifferentialMethod = "sam")
#  head(sam)

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Loading data
#  
#  pathfile <- system.file("extdata","expression_example.txt",package = "coexnet")
#  data <- read.table(pathfile,stringsAsFactors = FALSE)
#  
#  # Finding threshold value
#  
#  cor_pearson <- findThreshold(expData = data,method = "correlation")
#  cor_pearson
#  

## ------------------------------------------------------------------------

# Loading data

pathfile <- system.file("extdata","expression_example.txt",package = "coexnet")
data <- read.table(pathfile,stringsAsFactors = FALSE)
 
# Building the network
 
cor_pearson <- createNet(expData = data,threshold = 0.7,method = "correlation")
plot(cor_pearson)

## ---- eval=FALSE---------------------------------------------------------
#  
#  # Creating a vector with identifiers
#  
#  ID <- c("FN1","HAMP","ILK","MIF","NME1","PROCR","RAC1","RBBP7",
#  "TMEM176A","TUBG1","UBC","VKORC1")
#  
#  # Creating the PPI network
#  
#  ppi <- ppiNet(molecularIDs = ID,evidence = c("neighborhood","coexpression","experiments"))
#  plot(ppi)

## ------------------------------------------------------------------------
# Creating a PPI network from external data

ppi <- ppiNet(file = system.file("extdata","ppi.txt",package = "coexnet"))
plot(ppi)

## ------------------------------------------------------------------------

# Loading data
 
data("net1")
data("net2")
 
# Obtaining Common Connection Patterns

ccp <- CCP(net1,net2)
plot(ccp)

## ------------------------------------------------------------------------

# Loading data

data("net1")
data("net2")

# Obtain shared components
 
share <- sharedComponents(net1,net2)
share

