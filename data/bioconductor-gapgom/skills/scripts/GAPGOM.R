# Code example from 'GAPGOM' vignette. See references/ for full tutorial.

## ----setup, include = FALSE----------------------------------------------
library(knitr)
library(kableExtra)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  error = FALSE
)
library(GAPGOM)

## ----eval=F--------------------------------------------------------------
#  ### NEEDED (depends, suggests)
#  
#  if (!requireNamespace("BiocManager"))
#      install.packages("BiocManager")
#  BiocManager::install("GAPGOM", dependencies = TRUE)

## ----f5, eval=FALSE------------------------------------------------------
#  # download the fantom5 data file
#  fantom_file <- fantom_download("./", organism = "mouse",
#                                 noprompt = TRUE) # saves filename
#  # load the file (use fantom_file variable if doing all at once)
#  ft5 <- fantom_load_raw("./mm9.cage_peak_phase1and2combined_tpm_ann.osc.txt",
#  verbose = TRUE)
#  # remove first two rows from fantom5 data (these are seperate statistis,
#  # we just need expressionvalues)
#  ft5$df <- ft5$df[3:nrow(ft5$df),]
#  
#  # convert the raw fantom table to an ExpressionSet
#  expset <- fantom_to_expset(ft5, verbose = TRUE)

## ----randvals------------------------------------------------------------
# select x random IDs
x_entries <- 1000

go_data <- GAPGOM::set_go_data("human", "BP", computeIC = FALSE)
random_ids <- unique(sample(go_data@geneAnno$ENTREZID, x_entries)) # and only keep 
# uniques

# make general dataframe. 
expressions <- data.frame(random_ids)
colnames(expressions) <- "ENTREZID"
expressions$ID

# n expression values depending on the amount of unique IDs that are present
expressionvalues <- abs(rnorm(length(random_ids)*6))*x_entries
expressions[,2:7] <- expressionvalues
head(expressions)

## ----expset--------------------------------------------------------------
expression_matrix <- as.matrix(expressions[,2:ncol(expressions)])
rownames(expression_matrix) <- expressions$ENTREZID
featuredat <- as.data.frame(expressions$ENTREZID) # And everything else besides expressionvalues (preferably you don't even need to include the IDs themselves here!)
rownames(featuredat) <- expressions$ENTREZID # because they will be the rownames anyway.
expset <- ExpressionSet(expression_matrix, 
                        featureData = new("AnnotatedDataFrame", 
                        data=featuredat))

# To see how it is structured;
head(expset)
head(assayData(expset)[["exprs"]]) # where expressionvalues are stored.
head(pData(featureData(expset))) # where other information is stored.

## ----lncRNApred----------------------------------------------------------
# Example with default dataset, take a look at the data documentation
# to fully grasp what's going on with the making of the filter etc. (Biobase 
# ExpressionSet)
 
# keep everything that is a protein coding gene (for annotation)
filter_vector <- fData(GAPGOM::expset)[(
  fData(GAPGOM::expset)$GeneType=="protein_coding"),]$GeneID
# set gid and run.
gid <- "ENSG00000228630"

result <- GAPGOM::expression_prediction(gid, 
                                        GAPGOM::expset, 
                                        "human", 
                                        "BP",
                                        id_translation_df = 
                                          GAPGOM::id_translation_df,
                                        id_select_vector = filter_vector,
                                        method = "combine", 
                                        verbose = TRUE, filter_pvals = TRUE)
kable(result) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")

## ----lncrnapredscoreonly-------------------------------------------------
# Example with default dataset, take a look at the data documentation
# to fully grasp what's going on with making of the filter etc. (Biobase 
# ExpressionSet)

# set an artbitrary gene you want to find similarities for. (5th row in this
# case)
gid <- "ENSG00000228630"
result <- GAPGOM::expression_semantic_scoring(gid, 
                                              GAPGOM::expset)
kable(result[1:100,]) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")

## ----TopoICSim-----------------------------------------------------------
result <- GAPGOM::topo_ic_sim_genes("human", "MF", "218", "501",
                                   progress_bar = FALSE)
kable(result$AllGoPairs) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")
result$GeneSim
# genelist mode
list1 <- c("126133","221","218","216","8854","220","219","160428","224",
"222","8659","501","64577","223","217","4329","10840","7915","5832")
# ONLY A PART OF THE GENELIST IS USED BECAUSE OF R CHECK TIME CONTRAINTS
result <- GAPGOM::topo_ic_sim_genes("human", "MF", list1[1:3], list1[1:3], 
                              progress_bar = FALSE)
kable(result$AllGoPairs) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")
kable(result$GeneSim) %>% kable_styling() %>% scroll_box(width = "100%", height = "500px")
mean(result$GeneSim)

## ------------------------------------------------------------------------
custom <- list(cus1=c("GO:0016787", "GO:0042802", "GO:0005524"))
result <- GAPGOM::topo_ic_sim_genes("human", "MF", "218", "501",
  custom_genes1 = custom, drop = NULL, verbose = TRUE, progress_bar = FALSE)
result

## ------------------------------------------------------------------------
sessionInfo()

