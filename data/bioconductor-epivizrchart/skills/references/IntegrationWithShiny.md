# Visualizing genomic data in Shiny Apps using epivizrChart

Jayaram Kancherla, Hector Corrada Bravo

#### 2025-10-29

In this vignette, we will build a shiny app to visualize genomic data using epivizrChart. Since epiviz visualization library is built upon the web components framework, it can be integrated with most frameworks that support HTML.

Sample data sets to use for the vignette.

```
data(cgi_gr)
data(bcode_eset)
```

First we will create an epiviz Navigation component to render a visualization in a specific genomic region. We will set `interactive=TRUE` so that the components can communicate with the shiny server to get data for the plots/tracks. We will then visualize the data objects we loaded earlier.

```
epivizNav <- epivizNav(chr="chr11", start=118000000, end=121000000, interactive=TRUE)
genes_track <- epivizNav$add_genome(Homo.sapiens)
```

```
## creating gene annotation (it may take a bit)
```

```
##   24 genes were dropped because they have exons located on both strands of the
##   same reference sequence or on more than one reference sequence, so cannot be
##   represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
##   object, or use suppressMessages() to suppress this message.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
blocks_track <- epivizNav$plot(cgi_gr, datasource_name="CpG_Islands")
means_track <- epivizNav$plot(bcode_eset, datasource_name="Gene Expression Barcode", chart="HeatmapPlot")
```

```
## Loading required package: hgu133plus2.db
```

```
##
```

```
## 'select()' returned 1:many mapping between keys and columns
```

We will create an R/BioConductor file object for the file we would like to visualize. We currently support BedFiles, BamFiles and BigWigFiles.

```
file1 <- Rsamtools::BamFile("http://1000genomes.s3.amazonaws.com/phase3/data/HG01879/alignment/HG01879.mapped.ILLUMINA.bwa.ACB.low_coverage.20120522.bam")
file2 <- rtracklayer::BEDFile("https://s3.amazonaws.com/igv.broadinstitute.org/annotations/hg19/genes/refGene.hg19.bed.gz")

epiviz_igv <- epivizNav$plot(
                file1,
                datasource_name = "genes2")
```

A basic shiny app would be to render the visualization components inside a container. For this we will create a `div` on the ui that will contain the epiviz components. On the server function, we will use the render function to generate the HTML. Navigation elements implement the usual genome browser interactions (pan, zoom, location input and gene name search) and these interactions generate data requests that are sent to the shiny server. We include `shiny=TRUE` so that the components can send data requests to the shiny sever and call the `register_shiny_handler` function to add callbacks and observe for session events.

```
app <- shinyApp(
  ui=fluidPage(
    uiOutput("epivizChart")
  ),
  server=function(input, output, session) {

    output$epivizChart <- renderUI({
      epivizNav$render_component(shiny=TRUE)
    })

    # register for shiny events to manage data requests from UI
    epivizNav$register_shiny_handler(session)
  }
)

app
```

In this example. we will include an additional genomic region text box. If the user updates the location in this text box, it triggers an event that will revisualize the epiviz components to the new genomic region.

```
app <- shinyApp(
  ui=fluidPage(
    textInput('gene_loc', 'Enter Genomic Location (example: chr11:119000000 - 120000000', "chr11:118000000-121000000"),
    uiOutput("epivizChart")
  ),
  server=function(input, output, session) {

    renderEpiviz <- function() {
      output$epivizChart <- renderUI({
        epivizNav$render_component(shiny=TRUE)
      })
    }

    observeEvent(input$gene_loc, {
      loc <- input$gene_loc
      if(loc != "") {
        chr_split <- strsplit(loc, ":")
        chr <- chr_split[[1]][1]
        range_split <- strsplit(chr_split[[1]][2], "-")

        epivizNav$navigate(chr = chr,
                           start = strtoi(range_split[[1]][1]),
                           end = strtoi(range_split[[1]][2]))
      }
      renderEpiviz()
    })

    epivizNav$register_shiny_handler(session)
  }
)

app
```