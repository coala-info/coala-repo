# Code example from 'RCAS.vignette' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(warning = FALSE, message = FALSE, eval = TRUE, fig.width = 7, fig.height = 4.2)

## ----load_libraries, results='hide'-------------------------------------------
library(RCAS)

## ----sample_data--------------------------------------------------------------
library(RCAS)
data(queryRegions) #sample queryRegions in BED format()
data(gff)          #sample GFF file

## ----RCAS_import_data, eval = FALSE-------------------------------------------
# queryRegions <- importBed(filePath = <path to BED file>, sampleN = 10000)
# gff <- importGtf(filePath = <path to GTF file>)

## ----queryGFF-----------------------------------------------------------------
overlaps <- as.data.table(queryGff(queryRegions = queryRegions, gffData = gff))

## ----query_gene_types---------------------------------------------------------
biotype_col <- grep('gene_biotype', colnames(overlaps), value = T)
df <- overlaps[,length(unique(queryIndex)), by = biotype_col]
colnames(df) <- c("feature", "count")
df$percent <- round(df$count / length(queryRegions) * 100, 1)
df <- df[order(count, decreasing = TRUE)]
ggplot2::ggplot(df, aes(x = reorder(feature, -percent), y = percent)) + 
  geom_bar(stat = 'identity', aes(fill = feature)) + 
  geom_label(aes(y = percent + 0.5), label = df$count) + 
  labs(x = 'transcript feature', y = paste0('percent overlap (n = ', length(queryRegions), ')')) + 
  theme_bw(base_size = 14) + 
  theme(axis.text.x = element_text(angle = 90))

## ----getTxdbFeatures----------------------------------------------------------
txdbFeatures <- getTxdbFeaturesFromGRanges(gff)

## ----summarizeQueryRegions----------------------------------------------------
summary <- summarizeQueryRegions(queryRegions = queryRegions, 
                                 txdbFeatures = txdbFeatures)

df <- data.frame(summary)
df$percent <- round((df$count / length(queryRegions)), 3) * 100
df$feature <- rownames(df)
ggplot2::ggplot(df, aes(x = reorder(feature, -percent), y = percent)) + 
  geom_bar(stat = 'identity', aes(fill = feature)) + 
  geom_label(aes(y = percent + 3), label = df$count) + 
  labs(x = 'transcript feature', y = paste0('percent overlap (n = ', length(queryRegions), ')')) + 
  theme_bw(base_size = 14) + 
  theme(axis.text.x = element_text(angle = 90))

## ----getTargetedGenesTable----------------------------------------------------
dt <- getTargetedGenesTable(queryRegions = queryRegions, 
                           txdbFeatures = txdbFeatures)
dt <- dt[order(transcripts, decreasing = TRUE)]

knitr::kable(dt[1:10,])

## ----transcriptBoundaryCoverage-----------------------------------------------
cvgF <- getFeatureBoundaryCoverage(queryRegions = queryRegions, 
                                   featureCoords = txdbFeatures$transcripts, 
                                   flankSize = 1000, 
                                   boundaryType = 'fiveprime', 
                                   sampleN = 10000)
cvgT <- getFeatureBoundaryCoverage(queryRegions = queryRegions, 
                                   featureCoords = txdbFeatures$transcripts, 
                                   flankSize = 1000, 
                                   boundaryType = 'threeprime', 
                                   sampleN = 10000)

cvgF$boundary <- 'fiveprime'
cvgT$boundary <- 'threeprime'

df <- rbind(cvgF, cvgT)

ggplot2::ggplot(df, aes(x = bases, y = meanCoverage)) + 
  geom_ribbon(fill = 'lightgreen', 
              aes(ymin = meanCoverage - standardError * 1.96, 
                  ymax = meanCoverage + standardError * 1.96)) + 
 geom_line(color = 'black') + 
 facet_grid( ~ boundary) + theme_bw(base_size = 14) 


## ----coverageprofilelist, fig.height=6----------------------------------------
cvgList <- calculateCoverageProfileList(queryRegions = queryRegions, 
                                       targetRegionsList = txdbFeatures, 
                                       sampleN = 10000)

ggplot2::ggplot(cvgList, aes(x = bins, y = meanCoverage)) + 
  geom_ribbon(fill = 'lightgreen', 
              aes(ymin = meanCoverage - standardError * 1.96, 
                  ymax = meanCoverage + standardError * 1.96)) + 
 geom_line(color = 'black') + theme_bw(base_size = 14) +
 facet_wrap( ~ feature, ncol = 3) 

## ----motif_analysis-----------------------------------------------------------
motifResults <- runMotifDiscovery(queryRegions = queryRegions, 
                           resizeN = 15, sampleN = 10000,
                           genomeVersion = 'hg19', motifWidth = 6,
                           motifN = 1, nCores = 1)

seqLogo::seqLogo(getPWM(motifResults$matches_query[[1]]))

## ----motif_analysis_table-----------------------------------------------------
summary <- getMotifSummaryTable(motifResults)
knitr::kable(summary)

## ----GO analysis--------------------------------------------------------------
targetedGenes <- unique(overlaps$gene_id)

res <- RCAS::findEnrichedFunctions(targetGenes = targetedGenes, species = 'hsapiens')
res <- res[order(res$p_value),]
resGO <- res[grep('GO:BP', res$source),]
knitr::kable(subset(resGO[1:10,], select = c('p_value', 'term_name', 'source')))

