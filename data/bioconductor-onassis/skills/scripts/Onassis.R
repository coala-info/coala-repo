# Code example from 'Onassis' vignette. See references/ for full tutorial.

## ----imports, echo=FALSE,eval=TRUE, message=FALSE, warning=FALSE-----------
library(Onassis)
library(DT)
library(gplots)
library(org.Hs.eg.db)
library(kableExtra)

## ----installing_onassis, echo=TRUE, eval=FALSE-----------------------------
#  source("https://bioconductor.org/biocLite.R")
#  biocLite("Onassis")

## ----load_onasssis, echo=TRUE, eval=TRUE-----------------------------------
library(Onassis)

## ----connectTodb, echo=TRUE,eval=FALSE-------------------------------------
#  
#  require('GEOmetadb')
#  
#  ## Running this function might take some time if the database (6.8GB) has to be downloaded.
#  geo_con <- connectToGEODB(download=TRUE)
#  
#  #Showing the experiment types available in GEO
#  experiments <- experiment_types(geo_con)
#  
#  #Showing the organism types available in GEO
#  species <- organism_types(geo_con)
#  
#  #Retrieving Human gene expression metadata, knowing the GEO platform identifier, e.g. the Affymetrix Human Genome U133 Plus 2.0 Array
#  expression <- getGEOMetadata(geo_con, experiment_type='Expression profiling by array', gpl='GPL570')
#  
#  #Retrieving the metadata associated to experiment type "Methylation profiling by high througput sequencing"
#  meth_metadata <- getGEOMetadata(geo_con, experiment_type='Methylation profiling by high throughput sequencing', organism = 'Homo sapiens')

## ----experimentTypesshow, echo=FALSE, eval=TRUE----------------------------
experiments <- readRDS(system.file('extdata', 'vignette_data', 'experiment_types.rds', package='Onassis'))

knitr::kable(as.data.frame(experiments[1:10]), col.names = c('experiments')) %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "300px", height = "200px")

## ----speciesShow, echo=FALSE,eval=TRUE-------------------------------------
species <- readRDS(system.file('extdata', 'vignette_data', 'organisms.rds', package='Onassis'))
knitr::kable(as.data.frame(species[1:10]), col.names=c('species')) %>%
              kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "300px", height = "200px")

## ----loadgeoMetadata, echo=TRUE, eval=TRUE---------------------------------
meth_metadata <- readRDS(system.file('extdata', 'vignette_data', 'GEOmethylation.rds', package='Onassis'))

## ----printmeta, echo=FALSE,eval=TRUE---------------------------------------

methylation_tmp <- meth_metadata
methylation_tmp$experiment_summary <- sapply(methylation_tmp$experiment_summary, function(x) substr(x, 1, 50))
knitr::kable(methylation_tmp[1:10,], 
              caption = 'GEOmetadb metadata for Methylation profiling by high throughput sequencing (only the first 10 entries are shown).') %>%
              kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "300px")


## ----connectSRA, echo=TRUE,eval=FALSE--------------------------------------
#  # Optional download of SRAdb and connection to the corresponding sqlite file
#  require(SRAdb)
#  sqliteFileName <- '/pathto/SRAdb.sqlite'
#  sra_con <- dbConnect(SQLite(), sqliteFileName)
#  
#  # Query for the ChIP-Seq experiments contained in GEO for human samples
#  library_strategy <- 'ChIP-Seq' #ChIP-Seq data
#  library_source='GENOMIC'
#  taxon_id=9606 #Human samples
#  center_name='GEO' #Data from GEO
#  
#  # Query to the sample table
#  samples_query <- paste0("select sample_accession, description, sample_attribute, sample_url_link from sample where taxon_id='", taxon_id, "' and sample_accession IS NOT NULL", " and center_name='", center_name, "'"  )
#  
#  samples_df <- dbGetQuery(sra_con, samples_query)
#  samples <- unique(as.character(as.vector(samples_df[, 1])))
#  
#  experiment_query <- paste0("select experiment_accession, center_name, title, sample_accession, sample_name, experiment_alias, library_strategy, library_layout, experiment_url_link, experiment_attribute from experiment where library_strategy='", library_strategy, "'" , " and library_source ='", library_source,"' ", " and center_name='", center_name, "'" )
#  experiment_df <- dbGetQuery(sra_con, experiment_query)
#  
#  #Merging the columns from the sample and the experiment table
#  experiment_df <- merge(experiment_df, samples_df, by = "sample_accession")
#  
#  # Replacing the '_' character with white spaces
#  experiment_df$sample_name <- sapply(experiment_df$sample_name, function(value) {gsub("_", " ", value)})
#  experiment_df$experiment_alias <- sapply(experiment_df$experiment_alias, function(value) {gsub("_", " ", value)})
#  
#  sra_chip_seq <- experiment_df

## ----readCHIP, echo=TRUE, eval=TRUE----------------------------------------
sra_chip_seq <- readRDS(system.file('extdata', 'vignette_data', 'GEO_human_chip.rds',  package='Onassis'))

## ----printchromatinIP, echo=FALSE,eval=TRUE--------------------------------

knitr::kable(head(sra_chip_seq, 10), rownames=FALSE, 
  caption = 'Metadata of ChIP-seq human samples obtained from SRAdb (first 10 entries)') %>%
              kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "300px")


## ----createSampleAndTargetDict, echo=TRUE,eval=TRUE, message=FALSE---------
# If a Conceptmapper dictionary is already available the dictType CMDICT can be specified and the corresponding file loaded
sample_dict <- CMdictionary(inputFileOrDb=system.file('extdata', 'cmDict-sample.cs.xml', package = 'Onassis'), dictType = 'CMDICT')

#Creation of a dictionary from the file sample.cs.obo available in OnassisJavaLibs
obo <- system.file('extdata', 'sample.cs.obo', package='OnassisJavaLibs')

sample_dict <- CMdictionary(inputFileOrDb=obo, outputDir=getwd(), synonymType='ALL')

# Creation of a dictionary for human genes/proteins. This requires org.Hs.eg.db to be installed
require(org.Hs.eg.db)
targets <- CMdictionary(dictType='TARGET', inputFileOrDb = 'org.Hs.eg.db', synonymType='EXACT')

## ----settingOptions, echo=TRUE,eval=TRUE-----------------------------------

#Creating a CMoptions object and showing hte default parameters 
opts <- CMoptions()  
show(opts)

## ----listCombinations, echo=TRUE, eval=TRUE--------------------------------
combinations <- listCMOptions()

## ----setsynonymtype, echo=TRUE, eval=TRUE----------------------------------
myopts <- CMoptions(SynonymType='EXACT_ONLY')
myopts

## ----changeparameter, echo=TRUE, eval=TRUE---------------------------------
#Changing the SearchStrategy parameter
SearchStrategy(myopts) <- 'SKIP_ANY_MATCH_ALLOW_OVERLAP'
myopts

## ----EntityFinder, echo=TRUE, eval=TRUE, results='hide', message=FALSE, warning=FALSE----
sra_chip_seq <- readRDS(system.file('extdata', 'vignette_data', 'GEO_human_chip.rds',  package='Onassis'))
chipseq_dict_annot <- EntityFinder(sra_chip_seq[1:50, c('experiment_accession', 'title', 'experiment_attribute', 'sample_attribute', 'description')], dictionary=sample_dict, options=myopts)

## ----showchipresults, echo=FALSE, eval=TRUE, message=FALSE-----------------

knitr::kable(head(chipseq_dict_annot, 20), rownames=FALSE, 
  caption = 'Annotating the metadata of DNA methylation sequencing experiments with a dictionary including CL (Cell line) and UBERON ontologies') %>% kable_styling() %>%
  scroll_box(width = "80%", height = "400px")

## ----filtering_out_terms, echo=TRUE, eval=TRUE, message=FALSE--------------
chipseq_dict_annot <- filterTerms(chipseq_dict_annot, c('cell', 'tissue'))

## ----showchipresults_filtered, echo=FALSE, eval=TRUE, message=FALSE--------

knitr::kable(head(chipseq_dict_annot, 20), rownames=FALSE, 
  caption = 'Filtered Annotations') %>% kable_styling() %>%
  scroll_box(width = "80%", height = "400px")

## ----annotateGenes, echo=TRUE, eval=TRUE, results='hide', message=FALSE, warning=FALSE----
#Finding the TARGET entities
target_entities <- EntityFinder(input=sra_chip_seq[1:50, c('experiment_accession', 'title', 'experiment_attribute', 'sample_attribute', 'description')], options = myopts, dictionary=targets)

## ----printKable, echo=FALSE, eval=TRUE-------------------------------------
knitr::kable(head(target_entities, 20), 
  caption = 'Annotations of ChIP-seq test metadata obtained from SRAdb and stored into files with the TARGETs (genes and histone variants)') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----similarity, echo=TRUE, eval=TRUE, message=FALSE-----------------------
#Instantiating the Similarity
similarities <- listSimilarities()

## ----computing measures, echo=TRUE, eval=TRUE, message=FALSE---------------

#Retrieving URLS of concepts
found_terms <- as.character(unique(chipseq_dict_annot$term_url))

# Creating a dataframe with all possible couples of terms and adding a column to store the similarity
pairwise_results <- t(combn(found_terms, 2))
pairwise_results <- cbind(pairwise_results, rep(0, nrow(pairwise_results)))

# Similarity computation for each couple of terms
for(i in 1:nrow(pairwise_results)){
	pairwise_results[i, 3] <- Similarity(obo, pairwise_results[i,1], pairwise_results[i, 2])
}
colnames(pairwise_results) <- c('term1', 'term2', 'value')  

# Adding the term names from the annotation table to the comparison results 
pairwise_results <- merge(pairwise_results, chipseq_dict_annot[, c('term_url', 'term_name')], by.x='term2', by.y='term_url')
colnames(pairwise_results)[length(colnames(pairwise_results))] <- 'term2_name'
pairwise_results <- merge(pairwise_results, chipseq_dict_annot[, c('term_url', 'term_name')], by.x='term1', by.y='term_url')
colnames(pairwise_results)[length(colnames(pairwise_results))] <- 'term1_name'
pairwise_results <- unique(pairwise_results)
# Reordering the columns
pairwise_results <- pairwise_results[, c('term1', 'term1_name', 'term2', 'term2_name', "value")]

## ----showSim, echo=FALSE, eval=TRUE----------------------------------------
knitr::kable(pairwise_results,  
  caption = 'Pairwise similarities of cell type terms annotating the ChIP-seq metadata') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----groupwise_measures, echo=TRUE, eval=TRUE, message=FALSE---------------

oboprefix <- 'http://purl.obolibrary.org/obo/'
Similarity(obo, paste0(oboprefix, c('CL_0000055', 'CL_0000066')) , paste0(oboprefix, c('CL_0000542', 'CL_0000236')))

## ----groupwise_measures_2, echo=TRUE, eval=TRUE, message=FALSE-------------
Similarity(obo, paste0(oboprefix, c('CL_0000055', 'CL_0000236' ,'CL_0000236')), paste0(oboprefix, c('CL_0000542', 'CL_0000066')))

## ----samples_similarity, echo=TRUE, eval=TRUE, message=FALSE, fig.height=14, fig.width=16----

# Extracting all the couples of samples 
annotated_samples <- as.character(as.vector(unique(chipseq_dict_annot$sample_id)))

samples_couples <- t(combn(annotated_samples, 2))

# Computing the samples semantic similarity 
similarity_results <- apply(samples_couples, 1, function(couple_of_samples){
	Similarity(obo, couple_of_samples[1], couple_of_samples[2], chipseq_dict_annot)
})


#Creating a matrix to store the results of the similarity between samples
similarity_matrix <- matrix(0, nrow=length(annotated_samples), ncol=length(annotated_samples))
rownames(similarity_matrix) <- colnames(similarity_matrix) <- annotated_samples

# Filling the matrix with similarity values 
similarity_matrix[lower.tri(similarity_matrix, diag=FALSE)] <- similarity_results
similarity_matrix <- t(similarity_matrix)
similarity_matrix[lower.tri(similarity_matrix, diag=FALSE)] <- similarity_results 
# Setting the diagonal to 1
diag(similarity_matrix) <- 1

# Pasting the annotations to the sample identifiers
samples_legend <- aggregate(term_name ~ sample_id, chipseq_dict_annot, function(aggregation) paste(unique(aggregation), collapse=',' ))
rownames(similarity_matrix) <- paste0(rownames(similarity_matrix), ' (', samples_legend[match(rownames(similarity_matrix), samples_legend$sample_id), c('term_name')], ')')

# Showing a heatmap of the similarity between samples
heatmap.2(similarity_matrix, density.info = "none", trace="none", main='Samples\n semantic\n similarity', margins=c(12,50), cexRow = 2, cexCol = 2, keysize = 0.5)

## ----load_h3k27ac, echo=TRUE, eval=TRUE------------------------------------
h3k27ac_chip <- readRDS(system.file('extdata', 'vignette_data', 'h3k27ac_metadata.rds',  package='Onassis'))

## ----onassis_class_usage, echo=TRUE, eval=TRUE, results='hide', message=FALSE, warning=FALSE----
cell_annotations <- annotate(h3k27ac_chip, 'OBO', obo, FindAllMatches='YES' )

## ----show_onassis_annotations, echo=TRUE, eval=TRUE------------------------
cell_entities <- entities(cell_annotations) 

## ----cellentities, echo=FALSE, eval=TRUE-----------------------------------
knitr::kable(cell_entities[sample(nrow(cell_entities), 10),], 
  caption = ' Semantic sets of ontology concepts (entities) associated to each sample, stored in the entities slot of the Onassis object') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----term_filtering, echo=TRUE, eval=TRUE----------------------------------
filtered_cells <- filterconcepts(cell_annotations, c('cell', 'tissue'))

## ----showingfiltentities, echo=FALSE, eval=TRUE----------------------------
knitr::kable(entities(filtered_cells), 
  caption = 'Entities in filtered Onassis object') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----similarity_of_samples, echo=TRUE, eval=TRUE---------------------------
filtered_cells <- sim(filtered_cells)

## ----collapsing_similarities, echo=TRUE, eval=TRUE, message=FALSE, results='hide', fig.width=6, fig.height=6----
collapsed_cells <- Onassis::collapse(filtered_cells, 0.9)

## ----collapsedcellstable, echo=FALSE, eval=TRUE----------------------------
knitr::kable(entities(collapsed_cells), 
  caption = ' Collapsed Entities in filtered Onassis object') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----show_collapsed_entities, echo=TRUE, eval=TRUE, fig.height=11, fig.width=11----
heatmap.2(simil(collapsed_cells), density.info = "none", trace="none", margins=c(36, 36), cexRow = 1.5, cexCol = 1.5, keysize=0.5)

## ----creating_disease_annotations, echo=TRUE, eval=TRUE, message=FALSE, results='hide'----
obo2 <- system.file('extdata', 'sample.do.obo', package='OnassisJavaLibs')
disease_annotations <- annotate(h3k27ac_chip, 'OBO',obo2, disease=TRUE )

## ----diseases, echo=FALSE, eval=TRUE---------------------------------------
knitr::kable(entities(disease_annotations), 
  caption = ' Disease entities') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----merging_onassis_entities, echo=TRUE, eval=TRUE, message=FALSE---------
cell_disease_onassis <- mergeonassis(collapsed_cells, disease_annotations)

## ----showingmergedentities, echo=FALSE, eval=TRUE--------------------------
knitr::kable(entities(cell_disease_onassis), 
  caption = ' Cell and disease entities') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----loading_score_matrix, echo=TRUE, eval=TRUE----------------------------
score_matrix <- readRDS(system.file('extdata', 'vignette_data', 'score_matrix.rds', package='Onassis'))

## ----compare_tissues_by_col, echo=TRUE, eval=TRUE, silent=TRUE, message=FALSE----

cell_comparisons_by_col <- compare(collapsed_cells, score_matrix=as.matrix(score_matrix), by='col', fun_name='wilcox.test')

matrix_of_p_values <- matrix(NA, nrow=nrow(cell_comparisons_by_col), ncol=ncol(cell_comparisons_by_col))
for(i in 1:nrow(cell_comparisons_by_col)){
	for(j in 1:nrow(cell_comparisons_by_col)){
	 result_list <- cell_comparisons_by_col[i,j][[1]]
	 matrix_of_p_values[i, j] <- result_list[2]
	}
}
colnames(matrix_of_p_values) <- rownames(matrix_of_p_values) <- colnames(cell_comparisons_by_col)

## ----show_p_values_of_t_test, echo=TRUE, eval=TRUE, fig.height=11, fig.width=11----
heatmap.2(-log10(matrix_of_p_values), density.info = "none", trace="none", main='Changes in\n H3K27ac signal \nin promoter regions', margins=c(36,36), cexRow = 1.5, cexCol = 1.5, keysize=1)

## ----compare_tissues, echo=TRUE, eval=TRUE, message=FALSE, silent=TRUE, waring=FALSE----
cell_comparisons <- compare(collapsed_cells, score_matrix=as.matrix(score_matrix), by='row', fun_name='wilcox.test', fun_args=list(exact=FALSE))

# Extraction of p-values less than 0.1
significant_features <- matrix(0, nrow=nrow(cell_comparisons), ncol=ncol(cell_comparisons))
colnames(significant_features) <- rownames(significant_features) <- rownames(cell_comparisons)
for(i in 1:nrow(cell_comparisons)){
	for(j in 1:nrow(cell_comparisons)){
	 result_list <- cell_comparisons[i,j][[1]]
	 significant_features[i, j] <- length(which(result_list[,2]<=0.1))
	}
}

## ----significantRegions, echo=FALSE, eval=TRUE-----------------------------
knitr::kable(significant_features, 
  caption = ' Number of promoter regions with p.value <=0.1') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----compare_diseases, echo=TRUE, eval=TRUE, message=FALSE, silent=TRUE----

disease_comparisons <- compare(cell_disease_onassis, score_matrix=as.matrix(score_matrix), by='row', fun_name='wilcox.test', fun_args=list(exact=FALSE))


## ----show_disease_semantic_comparisons, echo=TRUE, eval=TRUE---------------
rownames(disease_comparisons$`breast [8], mammary gland epithelial cell [2], gland [1] (11)`)

## ----show_breast_cancer, echo=TRUE, eval=TRUE------------------------------
selprom <- (disease_comparisons$`breast [8], mammary gland epithelial cell [2], gland [1] (11)`[2,1][[1]])
selprom <- selprom[is.finite(selprom[,2]),]
head(selprom)

## ----compute_table_of_significant_regions, echo=TRUE, eval=TRUE------------
disease_matrix <- disease_comparisons[[1]]

# Extracting significant p-values
significant_features <- matrix(0, nrow=nrow(disease_matrix), ncol=ncol(disease_matrix))
colnames(significant_features) <- rownames(significant_features) <- rownames(disease_matrix)
for(i in 1:nrow(disease_matrix)){
	for(j in 1:nrow(disease_matrix)){
	 result_list <- disease_matrix[i,j][[1]]
	 significant_features[i, j] <- length(which(result_list[,2]<=0.1))
	}
}


## ----showingsignificantregions2, echo=FALSE, eval=TRUE---------------------
knitr::kable(significant_features, 
  caption = ' Number of promoter regions with p.value <= 0.1 ') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----score_comparison, echo=T, eval=T, message=F---------------------------

personal_t <- function(x, y){
		if(is.matrix(x))
			x <- apply(x, 1, mean)
		if(is.matrix(y))
			y <- apply(y, 1, mean)
		signal_to_noise_statistic <- abs(mean(x) - mean(y)) / (sd(x) + sd(y))
		return(list(statistic=signal_to_noise_statistic, p.value=NA))
}

disease_comparisons <- compare(cell_disease_onassis, score_matrix=as.matrix(score_matrix), by='col', fun_name='personal_t')

## ----performances, echo=FALSE, eval=TRUE-----------------------------------
performances_table <- readRDS(system.file('extdata', 'vignette_data', 'performances.rds', package='Onassis'))

## ----showingperformances, echo=FALSE, eval=TRUE----------------------------
knitr::kable(performances_table, 
  caption = ' Onassis performances ') %>% kable_styling(bootstrap_options = c("striped"), position="center") %>%
  scroll_box(width = "80%", height = "400px")

## ----sessionInfo(), echo=FALSE, eval=TRUE----------------------------------
sessionInfo()

