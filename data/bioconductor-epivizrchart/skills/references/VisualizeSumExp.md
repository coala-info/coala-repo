# Visualizing `RangeSummarizedExperiment` objects Shiny Apps using epivizrChart

Jayaram Kancherla, Hector Corrada Bravo

#### 2025-10-29

In this vignette, we will build a shiny app to visualize `RangeSummarizedExperiment` using epivizrChart. Since epiviz visualization library is built upon the web components framework, it can be integrated with most frameworks that support HTML.

Sample data sets to use for the vignette.

```
data(sumexp)
```

We create an Environment element which visualizes genome wide data. We then visualize `cancer` and `normal` values from the `SummarizedExperiment` object.

```
epivizEnv <- epivizEnv(interactive = TRUE)
scatterplot <- epivizEnv$plot(sumexp, datasource_name="sumExp", columns=c("cancer", "normal"))
```

After looking at the genomic wide data, if you are interested in further exploring a specific region of the genome, We can create a navigation element linked to that genomic location. We can plot additional annotation/data charts/tracks in this region.

```
epivizNav <- epivizNav(chr="chr11", start=118000000, end=121000000, parent=epivizEnv, interactive = TRUE)

genes_track <- epivizNav$add_genome(Homo.sapiens, datasource_name="genes")
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
# region_scatterplot <- epivizNav$plot(sumexp, datasource_name="sumExp", columns=c( "cancer", "normal"))
region_linetrack <- epivizNav$plot(sumexp, datasource_name="sumExp", columns=c( "cancer", "normal"), chart="LineTrack")
```

Finally, we can embed these components in a Shiny App.

```
app <- shinyApp(
  ui=fluidPage(
    uiOutput("epivizChart")
  ),
  server=function(input, output, session) {

    output$epivizChart <- renderUI({
      epivizEnv$render_component(shiny=TRUE)
    })

    epivizEnv$register_shiny_handler(session)
  }
)

app
```