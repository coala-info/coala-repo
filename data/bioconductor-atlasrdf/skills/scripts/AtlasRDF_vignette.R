# Code example from 'AtlasRDF_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'AtlasRDF_vignette.Rnw'

###################################################
### code chunk number 1: AtlasRDF_vignette.Rnw:32-33
###################################################
library("AtlasRDF")


###################################################
### code chunk number 2: AtlasRDF_vignette.Rnw:46-50 (eval = FALSE)
###################################################
## 
## termhits <- searchForEFOTerms("type II diabetes")
## 
## print(termhits)


###################################################
### code chunk number 3: AtlasRDF_vignette.Rnw:59-63 (eval = FALSE)
###################################################
## 
## efomappings <- getOntologyMappings("<http://purl.bioontology.org/ontology/SNOMEDCT/44054006>")
## 
## print(efomappings)


###################################################
### code chunk number 4: AtlasRDF_vignette.Rnw:73-79 (eval = FALSE)
###################################################
## humanURI <- getTaxonURI("human")
## 
## typeIIgenelist <- getSpeciesSpecificEnsemblGenesForExFactor("<http://www.ebi.ac.uk/efo/EFO_0001360>", humanURI)
## 
## head(typeIIgenelist)
## 


###################################################
### code chunk number 5: AtlasRDF_vignette.Rnw:92-96 (eval = FALSE)
###################################################
## #this will take a little while to run so we comment out for the vignette
## pathways <- getRankedPathwaysForGeneIds(typeIIgenelist[,3])
## head(pathways)
## 


###################################################
### code chunk number 6: AtlasRDF_vignette.Rnw:103-104 (eval = FALSE)
###################################################
## pathways[1]


###################################################
### code chunk number 7: AtlasRDF_vignette.Rnw:114-119 (eval = FALSE)
###################################################
## #if you have run the previous steps you can extract the pathway uri from the pathways list using
## #pathways[[1]]@pathwayuri
## #for convenience we will name the pathway
## genes <- getGenesForPathwayURI("<http://identifiers.org/reactome/REACT_12627.3>")
## 


###################################################
### code chunk number 8: AtlasRDF_vignette.Rnw:135-139 (eval = FALSE)
###################################################
## #human_genelist_bg
## load("human/human_gene_list.RData")
## #human_factor_counts
## load("human/human_factor_counts.RData")


###################################################
### code chunk number 9: AtlasRDF_vignette.Rnw:144-146
###################################################
###do enrichment
#transcription_pathway_enrichment <- doFishersEnrichment(genes, human_genelist_bg, human_factor_counts)


###################################################
### code chunk number 10: AtlasRDF_vignette.Rnw:152-153
###################################################
data(transcription_pathway_enrichment)


###################################################
### code chunk number 11: AtlasRDF_vignette.Rnw:158-159
###################################################
vizgraph <- vizPvalues(transcription_pathway_enrichment, "0.00005")


###################################################
### code chunk number 12: AtlasRDF_vignette.Rnw:169-170
###################################################
filteredgenes <- includeOnlySubclasses("efo:EFO_0000408", transcription_pathway_enrichment)


###################################################
### code chunk number 13: AtlasRDF_vignette.Rnw:176-178
###################################################
sortedset <- orderEnrichmentResults(filteredgenes)
vizgraph <- vizPvalues(sortedset[1:20], 0.000001)


###################################################
### code chunk number 14: AtlasRDF_vignette.Rnw:184-185
###################################################
sortedset[1]


###################################################
### code chunk number 15: AtlasRDF_vignette.Rnw:195-199 (eval = FALSE)
###################################################
## #get experiments for first enriched gene
## experiments <- getExperimentIdsForGeneURI(sortedset[[1]]@enrichedgenes[1])
## #look at first 5 experiment IDs
## experiments[1:5]


