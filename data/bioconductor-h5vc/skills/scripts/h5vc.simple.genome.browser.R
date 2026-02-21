# Code example from 'h5vc.simple.genome.browser' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# library(shiny)
# shinyUI(pageWithSidebar(
#   # Application title
#   headerPanel("Simple Genome Browser"),
#   # Sidebar with a slider inputs and selection boxes
#   sidebarPanel(
#     sliderInput("windowsize",
#                 "Windowsize:",
#                 min = 10,
#                 max = 200,
#                 value = 50,
#                 step = 5),
#     uiOutput("chromSelect"),
#     uiOutput("genomicPositionSelect")
#   ),
#   # Show a plot of the region
#   mainPanel(
#     plotOutput("mismatchPlot", height=800)
#   )
# ))

## ----eval=FALSE---------------------------------------------------------------
# library(shiny)
# library(h5vc)
# library(rhdf5)
# tallyFile <- "yeast.hfs5"
# study <- "/yeast"
# h5ls( tallyFile )
# chromosomes  <- h5ls( tallyFile )
# chromlengths <- as.numeric(subset( chromosomes, otype == "H5I_DATASET" & name == "Reference" )$dim)
# chromosomes  <- subset( chromosomes, otype == "H5I_GROUP" & name != "yeast" )$name
# names(chromlengths) = chromosomes
# 
# # Define server logic required to generate and plot a random distribution
# shinyServer(function(input, output) {
# 
#   output$chromSelect <- renderUI({
#     selectInput( "chrom", "Chromosome", choices = c("I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","XIII","XIV","XV","XVI", "Mito"))
#   })
# 
#   output$genomicPositionSelect <- renderUI({
#     sliderInput( "gpos", "Genomic Position:", min = 10, max = chromlengths[input$chrom] - 10, value = 200 )
#   })
# 
#   group <- reactive({ paste( study, input$chrom, sep="/" ) })
# 
#   sampleData <- reactive({ sd = getSampleData( tallyFile, group() ); sd$Sample = c("YB210","s288c"); sd })
# 
#   pos <- reactive({
#     min( max( input$windowsize + 1, input$gpos ), chromlengths[input$chrom] - input$windowsize - 1 )
#   })
# 
#   data <- reactive({
#     h5dapply(
#       tallyFile,
#       group(),
#       blocksize = input$windowsize*3,
#       names = c("Coverages","Counts","Deletions"),
#       range = c( max( pos() - input$windowsize, 0 ), min( pos() + input$windowsize, chromlengths[input$chrom] )  )
#     )[[1]]
# 
#   })
# 
#   output$mismatchPlot <- renderPlot({
#     p = mismatchPlot(
#       data(),
#       sampleData(),
#       samples = c("s288c","YB210"),
#       input$windowsize,
#       pos()
#       )
#     print(p)
#   })
# })

## ----eval=FALSE---------------------------------------------------------------
# library(rhdf5)
# library(h5vc)
# setwd("~/ShinyApps/Yeast")
# tallyFile <- "yeast.hfs5"
# study <- "/yeast"
# h5ls( tallyFile )
# chromosomes <- h5ls( tallyFile )
# chromosomes <- subset( chromosomes, otype == "H5I_GROUP" & name != "yeast" )$name
# variantCalls <- list()
# for( chrom in chromosomes ){
#   group <- paste( study, chrom, sep = "/" )
#   sdat <- getSampleData( tallyFile, group )
#   sdat$Group <- "yeast"
#   variantCalls[[chrom]] <- h5dapply(
#     filename = tallyFile,
#     group = group,
#     blocksize = 100000,
#     FUN = callVariantsPairedFancy,
#     sampledata = sdat,
#     cl = vcConfParams( returnDataPoints = TRUE, minStrandAltSupport = 4 ),
#     names = c( "Counts", "Coverages", "Reference" ),
#     verbose = TRUE
#   )
# }
# for( chrom in chromosomes ){
#   variantCalls[[chrom]] <- do.call( rbind, variantCalls[[chrom]] )
# }
# variantCalls <- do.call( rbind, variantCalls )
# rownames(variantCalls) = NULL
# variantCalls$Support = variantCalls$caseCountFwd + variantCalls$caseCountRev
# variantCalls$Coverage = variantCalls$caseCoverageFwd + variantCalls$caseCoverageRev
# variantCalls$AF = variantCalls$Support / variantCalls$Coverage
# save( variantCalls, file = "yeast.variants.RDa" )

## ----eval=FALSE---------------------------------------------------------------
# library(shiny)
# shinyUI(pageWithSidebar(
# 
#   # Application title
#   headerPanel("Simple Variant Browser - Yeast Strains Example"),
# 
#   # Sidebar with a slider inputs and selection boxes
#   sidebarPanel(
#     sliderInput("windowsize",
#                 "Windowsize:",
#                 min = 10,
#                 max = 200,
#                 value = 50,
#                 step = 5),
#     uiOutput("chromSelect"),
#     sliderInput("af",
#                 "Allele Frequency:",
#                 min = 0,
#                 max = 1,
#                 value = c(0.1,1.0),
#                 step = 0.01),
#     sliderInput( "minSupport",
#                  "Minimum Support",
#                  min = 2,
#                  max = 200,
#                  value = 2),
#     sliderInput( "minCoverage",
#                  "Minimum Coverage",
#                  min = 10,
#                  max = 500,
#                  value = 50,
#                  step = 5),
#     uiOutput("variantSelect"),
#     textOutput("diag")
#   ),
# 
#   # Show a plot of the region
#   mainPanel(
#     tabsetPanel(
#       tabPanel( title = "Region Mismatch Plot", plotOutput("mismatchPlot", height=800) ),
#       tabPanel( title = "Variant Table", tableOutput("variantTable") ),
#       tabPanel( title = "Variant Summary Plots", plotOutput("afHist") )
#     )
#   )
# ))

## ----eval=FALSE---------------------------------------------------------------
# library(shiny)
# library(h5vc)
# library(rhdf5)
# library(ggplot2)
# library(grid)
# 
# tallyFile <- "yeast.hfs5"
# study <- "/yeast"
# h5ls( tallyFile )
# chromosomes  = h5ls( tallyFile )
# chromlengths = as.numeric(subset( chromosomes, otype == "H5I_DATASET" & name == "Reference" )$dim)
# chromosomes  = subset( chromosomes, otype == "H5I_GROUP" & name != "yeast" )$name
# names(chromlengths) = chromosomes
# 
# load(file="yeast.variants.RDa")
# variantCalls$start <- variantCalls$start + 1 #fixing difference in counting 0-based vs. 1-based
# variantCalls$end <- variantCalls$end + 1
# # Define server logic required to generate and plot a random distribution
# shinyServer(function(input, output) {
# 
#   output$chromSelect <- renderUI({
#     selectInput( "chrom", "Chromosome", choices = c("I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","XIII","XIV","XV","XVI", "Mito"))
#   })
# 
#   group <- reactive({ paste( study, input$chrom, sep="/" ) })
# 
#   sampleData <- reactive({ sd = getSampleData( tallyFile, group() ); sd$Sample = c("YB210","s288c"); sd })
# 
#   variants <- reactive({
#     subset( variantCalls, seqnames == input$chrom & AF >= input$af[1] & AF <= input$af[2] & Support >= input$minSupport & Coverage >= input$minCoverage )
#   })
# 
#   output$variantSelect <- renderUI({
#     tmp = seq(nrow(variants()))
#     names(tmp) =  paste( variants()$start, " - ", variants()$refAllele, "/", variants()$altAllele, sep="" )
#     selectInput( "var", "Variant:", choices = tmp )
#   })
# 
#   pos <- reactive({
#     variants()$start[as.numeric(input$var)]
#   })
# 
#   data <- reactive({
#     if( nrow(variants()) > 0 ){
#       h5dapply(
#         filename = tallyFile,
#         group = group(),
#         blocksize = input$windowsize*3,
#         names = c("Coverages","Counts","Deletions"),
#         range = c( max( pos() - input$windowsize, 0 ), min( pos() + input$windowsize, chromlengths[input$chrom] )  )
#       )[[1]]
#     }else{
#       NULL
#     }
#   })
# 
#   output$mismatchPlot <- renderPlot({
#     if( nrow(variants()) > 0 ){
#       p = mismatchPlot(
#         data(),
#         sampleData(),
#         samples = c("s288c","YB210"),
#         input$windowsize,
#         pos()
#       )
#       print(p)
#     }
#   })
# 
#   output$variantTable <- renderTable({
#     variants()[,c("seqnames", "start", "refAllele", "altAllele", "AF", "Support", "Coverage")]
#   })
# 
#   output$afHist = renderPlot({
#     hist( variants()$AF, breaks = seq(0,1,0.01) )
#   })
# 
# })

