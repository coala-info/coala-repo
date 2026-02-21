# Code example from 'IntegrationWithShiny' vignette. See references/ for full tutorial.

## ----setup, eval=TRUE, include=FALSE------------------------------------------
library(epivizrChart)
library(shiny)
library(Homo.sapiens)
library(Rsamtools)
library(rtracklayer)

## -----------------------------------------------------------------------------
data(cgi_gr)
data(bcode_eset)

## -----------------------------------------------------------------------------
epivizNav <- epivizNav(chr="chr11", start=118000000, end=121000000, interactive=TRUE)
genes_track <- epivizNav$add_genome(Homo.sapiens)
blocks_track <- epivizNav$plot(cgi_gr, datasource_name="CpG_Islands")
means_track <- epivizNav$plot(bcode_eset, datasource_name="Gene Expression Barcode", chart="HeatmapPlot")

## -----------------------------------------------------------------------------
file1 <- Rsamtools::BamFile("http://1000genomes.s3.amazonaws.com/phase3/data/HG01879/alignment/HG01879.mapped.ILLUMINA.bwa.ACB.low_coverage.20120522.bam")
file2 <- rtracklayer::BEDFile("https://s3.amazonaws.com/igv.broadinstitute.org/annotations/hg19/genes/refGene.hg19.bed.gz")

epiviz_igv <- epivizNav$plot(
                file1,
                datasource_name = "genes2")

## ----eval=FALSE---------------------------------------------------------------
# app <- shinyApp(
#   ui=fluidPage(
#     uiOutput("epivizChart")
#   ),
#   server=function(input, output, session) {
# 
#     output$epivizChart <- renderUI({
#       epivizNav$render_component(shiny=TRUE)
#     })
# 
#     # register for shiny events to manage data requests from UI
#     epivizNav$register_shiny_handler(session)
#   }
# )
# 
# app
# 

## ----eval=FALSE---------------------------------------------------------------
# app <- shinyApp(
#   ui=fluidPage(
#     textInput('gene_loc', 'Enter Genomic Location (example: chr11:119000000 - 120000000', "chr11:118000000-121000000"),
#     uiOutput("epivizChart")
#   ),
#   server=function(input, output, session) {
# 
#     renderEpiviz <- function() {
#       output$epivizChart <- renderUI({
#         epivizNav$render_component(shiny=TRUE)
#       })
#     }
# 
#     observeEvent(input$gene_loc, {
#       loc <- input$gene_loc
#       if(loc != "") {
#         chr_split <- strsplit(loc, ":")
#         chr <- chr_split[[1]][1]
#         range_split <- strsplit(chr_split[[1]][2], "-")
# 
#         epivizNav$navigate(chr = chr,
#                            start = strtoi(range_split[[1]][1]),
#                            end = strtoi(range_split[[1]][2]))
#       }
#       renderEpiviz()
#     })
# 
#     epivizNav$register_shiny_handler(session)
#   }
# )
# 
# app
# 

